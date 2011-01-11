From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 11 Jan 2011 16:09:04 +0100
Subject: [PATCH 1/2] serial: Add auart driver for i.MX23/28
In-Reply-To: <1294758545-9445-1-git-send-email-s.hauer@pengutronix.de>
References: <1294758545-9445-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1294758545-9445-2-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/serial/Kconfig     |   15 +
 drivers/serial/Makefile    |    1 +
 drivers/serial/mxs-auart.c |  763 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 779 insertions(+), 0 deletions(-)
 create mode 100644 drivers/serial/mxs-auart.c

diff --git a/drivers/serial/Kconfig b/drivers/serial/Kconfig
index ec3c214..de37fe5 100644
--- a/drivers/serial/Kconfig
+++ b/drivers/serial/Kconfig
@@ -1657,4 +1657,19 @@ config SERIAL_PCH_UART
 	  This driver is for PCH(Platform controller Hub) UART of Intel EG20T
 	  which is an IOH(Input/Output Hub) for x86 embedded processor.
 	  Enabling PCH_DMA, this PCH UART works as DMA mode.
+
+config SERIAL_MXS_AUART
+	depends on ARCH_MXS
+	tristate "i.MXS AUART support"
+	select SERIAL_CORE
+	help
+	  This driver supports the i.MX AUART port.
+
+config SERIAL_MXS_AUART_CONSOLE
+	bool "i.MXS AUART console support"
+	depends on SERIAL_MXS_AUART=y
+	select SERIAL_CORE_CONSOLE
+	help
+	  Enable a i.MXS AUART port to be the system console.
+
 endmenu
diff --git a/drivers/serial/Makefile b/drivers/serial/Makefile
index 8ea92e9..c855071 100644
--- a/drivers/serial/Makefile
+++ b/drivers/serial/Makefile
@@ -92,3 +92,4 @@ obj-$(CONFIG_SERIAL_MRST_MAX3110)	+= mrst_max3110.o
 obj-$(CONFIG_SERIAL_MFD_HSU)	+= mfd.o
 obj-$(CONFIG_SERIAL_IFX6X60)  	+= ifx6x60.o
 obj-$(CONFIG_SERIAL_PCH_UART)	+= pch_uart.o
+obj-$(CONFIG_SERIAL_MXS_AUART) += mxs-auart.o
diff --git a/drivers/serial/mxs-auart.c b/drivers/serial/mxs-auart.c
new file mode 100644
index 0000000..dd437ea
--- /dev/null
+++ b/drivers/serial/mxs-auart.c
@@ -0,0 +1,763 @@
+/*
+ * Application UART driver for hardware found on
+ * Sigmatel STMP37XX/STMP378X and
+ * Freescale i.MX23/28
+ *
+ * Author: dmitry pervushin <dimka@embeddedalley.com>
+ *
+ * Copyright 2010 Sascha Hauer <s.hauer@pengutronix.de>
+ * Copyright 2008-2010 Freescale Semiconductor, Inc.
+ * Copyright 2008 Embedded Alley Solutions, Inc All Rights Reserved.
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+#include <linux/kernel.h>
+#include <linux/device.h>
+#include <linux/errno.h>
+#include <linux/init.h>
+#include <linux/console.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/wait.h>
+#include <linux/tty.h>
+#include <linux/tty_driver.h>
+#include <linux/tty_flip.h>
+#include <linux/serial.h>
+#include <linux/serial_core.h>
+#include <linux/platform_device.h>
+#include <linux/device.h>
+#include <linux/clk.h>
+#include <linux/delay.h>
+
+#include <asm/cacheflush.h>
+#include <mach/mx28.h>
+
+#define MXS_AUART_PORTS 5
+
+#define UARTAPP_CTRL0				0x00000000
+#define UARTAPP_CTRL0_SET			0x00000004
+#define UARTAPP_CTRL0_CLR			0x00000008
+#define UARTAPP_CTRL0_TOG			0x0000000c
+#define UARTAPP_CTRL1				0x00000010
+#define UARTAPP_CTRL1_SET			0x00000014
+#define UARTAPP_CTRL1_CLR			0x00000018
+#define UARTAPP_CTRL1_TOG			0x0000001c
+#define UARTAPP_CTRL2				0x00000020
+#define UARTAPP_CTRL2_SET			0x00000024
+#define UARTAPP_CTRL2_CLR			0x00000028
+#define UARTAPP_CTRL2_TOG			0x0000002c
+#define UARTAPP_LINECTRL			0x00000030
+#define UARTAPP_LINECTRL_SET			0x00000034
+#define UARTAPP_LINECTRL_CLR			0x00000038
+#define UARTAPP_LINECTRL_TOG			0x0000003c
+#define UARTAPP_LINECTRL2			0x00000040
+#define UARTAPP_LINECTRL2_SET			0x00000044
+#define UARTAPP_LINECTRL2_CLR			0x00000048
+#define UARTAPP_LINECTRL2_TOG			0x0000004c
+#define UARTAPP_INTR				0x00000050
+#define UARTAPP_INTR_SET			0x00000054
+#define UARTAPP_INTR_CLR			0x00000058
+#define UARTAPP_INTR_TOG			0x0000005c
+#define UARTAPP_DATA				0x00000060
+#define UARTAPP_STAT				0x00000070
+#define UARTAPP_DEBUG				0x00000080
+#define UARTAPP_VERSION				0x00000090
+#define UARTAPP_AUTOBAUD			0x000000a0
+
+#define BM_UARTAPP_CTRL0_SFTRST			(1 << 31)
+#define BM_UARTAPP_CTRL0_CLKGATE		(1 << 30)
+
+
+#define BM_UARTAPP_CTRL2_CTSEN			(1 << 15)
+#define BM_UARTAPP_CTRL2_RTS			(1 << 11)
+#define BM_UARTAPP_CTRL2_RXE			(1 << 9)
+#define BM_UARTAPP_CTRL2_TXE			(1 << 8)
+#define BM_UARTAPP_CTRL2_UARTEN			(1 << 0)
+
+#define BP_UARTAPP_LINECTRL_BAUD_DIVINT		16
+#define BM_UARTAPP_LINECTRL_BAUD_DIVINT		0xffff0000
+#define BF_UARTAPP_LINECTRL_BAUD_DIVINT(v)	(((v) & 0xffff) << 16)
+#define BP_UARTAPP_LINECTRL_BAUD_DIVFRAC	8
+#define BM_UARTAPP_LINECTRL_BAUD_DIVFRAC	0x00003f00
+#define BF_UARTAPP_LINECTRL_BAUD_DIVFRAC(v)	(((v) & 0x3f) << 8)
+#define BP_UARTAPP_LINECTRL_WLEN		5
+#define BM_UARTAPP_LINECTRL_WLEN		0x00000060
+#define BF_UARTAPP_LINECTRL_WLEN(v)		(((v) & 0x3) << 5)
+#define BM_UARTAPP_LINECTRL_FEN			(1 << 4)
+#define BM_UARTAPP_LINECTRL_STP2		(1 << 3)
+#define BM_UARTAPP_LINECTRL_EPS			(1 << 2)
+#define BM_UARTAPP_LINECTRL_PEN			(1 << 1)
+#define BM_UARTAPP_LINECTRL_BRK			(1 << 0)
+
+#define BM_UARTAPP_INTR_RTIEN			(1 << 22)
+#define BM_UARTAPP_INTR_TXIEN			(1 << 21)
+#define BM_UARTAPP_INTR_RXIEN			(1 << 20)
+#define BM_UARTAPP_INTR_CTSMIEN			(1 << 17)
+#define BM_UARTAPP_INTR_RTIS			(1 << 6)
+#define BM_UARTAPP_INTR_TXIS			(1 << 5)
+#define BM_UARTAPP_INTR_RXIS			(1 << 4)
+#define BM_UARTAPP_INTR_CTSMIS			(1 << 1)
+
+#define BM_UARTAPP_STAT_BUSY			(1 << 29)
+#define BM_UARTAPP_STAT_CTS			(1 << 28)
+#define BM_UARTAPP_STAT_TXFE			(1 << 27)
+#define BM_UARTAPP_STAT_TXFF			(1 << 25)
+#define BM_UARTAPP_STAT_RXFE			(1 << 24)
+#define BM_UARTAPP_STAT_OERR			(1 << 19)
+#define BM_UARTAPP_STAT_BERR			(1 << 18)
+#define BM_UARTAPP_STAT_PERR			(1 << 17)
+#define BM_UARTAPP_STAT_FERR			(1 << 16)
+
+#define MXS_AUART_MAJOR	242
+#define MXS_AUART_RX_THRESHOLD 16
+
+static struct uart_driver auart_driver;
+
+struct mxs_auart_port {
+	struct uart_port port;
+
+	unsigned int flags;
+	unsigned int ctrl;
+
+	unsigned int irq;
+
+	struct clk *clk;
+	struct device *dev;
+};
+
+static void mxs_auart_stop_tx(struct uart_port *u);
+
+#define to_auart_port(u) container_of(u, struct mxs_auart_port, port)
+
+static inline void mxs_auart_tx_chars(struct mxs_auart_port *s)
+{
+	struct circ_buf *xmit = &s->port.state->xmit;
+
+	while (!(readl(s->port.membase + UARTAPP_STAT) &
+		 BM_UARTAPP_STAT_TXFF)) {
+		if (s->port.x_char) {
+			writel(s->port.x_char,
+				     s->port.membase + UARTAPP_DATA);
+			s->port.x_char = 0;
+			continue;
+		}
+		if (!uart_circ_empty(xmit) && !uart_tx_stopped(&s->port)) {
+			writel(xmit->buf[xmit->tail],
+				     s->port.membase + UARTAPP_DATA);
+			xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
+			if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
+				uart_write_wakeup(&s->port);
+		} else
+			break;
+	}
+	if (uart_circ_empty(&(s->port.state->xmit)))
+		writel(BM_UARTAPP_INTR_TXIEN,
+			     s->port.membase + UARTAPP_INTR_CLR);
+	else
+		writel(BM_UARTAPP_INTR_TXIEN,
+			     s->port.membase + UARTAPP_INTR_SET);
+
+	if (uart_tx_stopped(&s->port))
+		mxs_auart_stop_tx(&s->port);
+}
+
+static inline unsigned int
+mxs_auart_rx_char(struct mxs_auart_port *s, unsigned int stat, u8 c)
+{
+	int flag;
+
+	flag = TTY_NORMAL;
+	if (stat & BM_UARTAPP_STAT_BERR) {
+		stat &= ~BM_UARTAPP_STAT_BERR;
+		s->port.icount.brk++;
+		if (uart_handle_break(&s->port))
+			return stat;
+		flag = TTY_BREAK;
+	} else if (stat & BM_UARTAPP_STAT_PERR) {
+		stat &= ~BM_UARTAPP_STAT_PERR;
+		s->port.icount.parity++;
+		flag = TTY_PARITY;
+	} else if (stat & BM_UARTAPP_STAT_FERR) {
+		stat &= ~BM_UARTAPP_STAT_FERR;
+		s->port.icount.frame++;
+		flag = TTY_FRAME;
+	}
+
+	if (stat & BM_UARTAPP_STAT_OERR)
+		s->port.icount.overrun++;
+
+	if (uart_handle_sysrq_char(&s->port, c))
+		return stat;
+
+	uart_insert_char(&s->port, stat, BM_UARTAPP_STAT_OERR, c, flag);
+
+	return stat;
+}
+
+static void mxs_auart_rx_chars(struct mxs_auart_port *s)
+{
+	u8 c;
+	struct tty_struct *tty = s->port.state->port.tty;
+	u32 stat = 0;
+
+	for (;;) {
+		stat = readl(s->port.membase + UARTAPP_STAT);
+		if (stat & BM_UARTAPP_STAT_RXFE)
+			break;
+		c = readl(s->port.membase + UARTAPP_DATA);
+		stat = mxs_auart_rx_char(s, stat, c);
+		writel(stat, s->port.membase + UARTAPP_STAT);
+	}
+
+	writel(stat, s->port.membase + UARTAPP_STAT);
+	tty_flip_buffer_push(tty);
+}
+
+static int mxs_auart_request_port(struct uart_port *u)
+{
+	return 0;
+}
+
+static int mxs_auart_verify_port(struct uart_port *u,
+				    struct serial_struct *ser)
+{
+	if (u->type != PORT_UNKNOWN && u->type != PORT_IMX)
+		return -EINVAL;
+	return 0;
+}
+
+static void mxs_auart_config_port(struct uart_port *u, int flags)
+{
+}
+
+static const char *mxs_auart_type(struct uart_port *u)
+{
+	struct mxs_auart_port *s = to_auart_port(u);
+
+	return dev_name(s->dev);
+}
+
+static void mxs_auart_release_port(struct uart_port *u)
+{
+}
+
+static void mxs_auart_set_mctrl(struct uart_port *u, unsigned mctrl)
+{
+	struct mxs_auart_port *s = to_auart_port(u);
+
+	u32 ctrl = readl(u->membase + UARTAPP_CTRL2);
+
+	ctrl &= ~BM_UARTAPP_CTRL2_RTS;
+	if (mctrl & TIOCM_RTS)
+		ctrl |= BM_UARTAPP_CTRL2_RTS;
+	s->ctrl = mctrl;
+	writel(ctrl, u->membase + UARTAPP_CTRL2);
+}
+
+static u32 mxs_auart_get_mctrl(struct uart_port *u)
+{
+	struct mxs_auart_port *s = to_auart_port(u);
+	u32 stat = readl(u->membase + UARTAPP_STAT);
+	int ctrl2 = readl(u->membase + UARTAPP_CTRL2);
+	u32 mctrl = s->ctrl;
+
+	mctrl &= ~TIOCM_CTS;
+	if (stat & BM_UARTAPP_STAT_CTS)
+		mctrl |= TIOCM_CTS;
+
+	if (ctrl2 & BM_UARTAPP_CTRL2_RTS)
+		mctrl |= TIOCM_RTS;
+
+	return mctrl;
+}
+
+static void mxs_auart_settermios(struct uart_port *u,
+				 struct ktermios *termios,
+				 struct ktermios *old)
+{
+	u32 bm, ctrl, ctrl2, div;
+	unsigned int cflag, baud;
+
+	cflag = termios->c_cflag;
+
+	ctrl = BM_UARTAPP_LINECTRL_FEN;
+	ctrl2 = readl(u->membase + UARTAPP_CTRL2);
+
+	/* byte size */
+	switch (cflag & CSIZE) {
+	case CS5:
+		bm = 0;
+		break;
+	case CS6:
+		bm = 1;
+		break;
+	case CS7:
+		bm = 2;
+		break;
+	case CS8:
+		bm = 3;
+		break;
+	default:
+		return;
+	}
+
+	ctrl |= BF_UARTAPP_LINECTRL_WLEN(bm);
+
+	/* parity */
+	if (cflag & PARENB) {
+		ctrl |= BM_UARTAPP_LINECTRL_PEN;
+		if ((cflag & PARODD) == 0)
+			ctrl |= BM_UARTAPP_LINECTRL_EPS;
+	}
+
+	/* figure out the stop bits requested */
+	if (cflag & CSTOPB)
+		ctrl |= BM_UARTAPP_LINECTRL_STP2;
+
+	/* figure out the hardware flow control settings */
+	if (cflag & CRTSCTS)
+		ctrl2 |= BM_UARTAPP_CTRL2_CTSEN;
+	else
+		ctrl2 &= ~BM_UARTAPP_CTRL2_CTSEN;
+
+	/* set baud rate */
+	baud = uart_get_baud_rate(u, termios, old, 0, u->uartclk);
+	div = u->uartclk * 32 / baud;
+	ctrl |= BF_UARTAPP_LINECTRL_BAUD_DIVFRAC(div & 0x3F);
+	ctrl |= BF_UARTAPP_LINECTRL_BAUD_DIVINT(div >> 6);
+
+	if ((cflag & CREAD) != 0)
+		ctrl2 |= BM_UARTAPP_CTRL2_RXE;
+
+	writel(ctrl, u->membase + UARTAPP_LINECTRL);
+	writel(ctrl2, u->membase + UARTAPP_CTRL2);
+}
+
+static irqreturn_t mxs_auart_irq_handle(int irq, void *context)
+{
+	u32 istatus, istat;
+	struct mxs_auart_port *s = context;
+	u32 stat = readl(s->port.membase + UARTAPP_STAT);
+
+	istatus = istat = readl(s->port.membase + UARTAPP_INTR);
+
+	if (istat & BM_UARTAPP_INTR_CTSMIS) {
+		uart_handle_cts_change(&s->port, stat & BM_UARTAPP_STAT_CTS);
+		writel(BM_UARTAPP_INTR_CTSMIS,
+				s->port.membase + UARTAPP_INTR_CLR);
+		istat &= ~BM_UARTAPP_INTR_CTSMIS;
+	}
+
+	if (istat & (BM_UARTAPP_INTR_RTIS | BM_UARTAPP_INTR_RXIS)) {
+		mxs_auart_rx_chars(s);
+		istat &= ~(BM_UARTAPP_INTR_RTIS | BM_UARTAPP_INTR_RXIS);
+	}
+
+	if (istat & BM_UARTAPP_INTR_TXIS) {
+		mxs_auart_tx_chars(s);
+		istat &= ~BM_UARTAPP_INTR_TXIS;
+	}
+
+	writel(istatus & (BM_UARTAPP_INTR_RTIS
+		| BM_UARTAPP_INTR_TXIS
+		| BM_UARTAPP_INTR_RXIS
+		| BM_UARTAPP_INTR_CTSMIS),
+			s->port.membase + UARTAPP_INTR_CLR);
+
+	return IRQ_HANDLED;
+}
+
+static void mxs_auart_reset(struct uart_port *u)
+{
+	int i;
+	unsigned int reg;
+
+	writel(BM_UARTAPP_CTRL0_SFTRST,
+		     u->membase + UARTAPP_CTRL0_CLR);
+
+	for (i = 0; i < 10000; i++) {
+		reg = readl(u->membase + UARTAPP_CTRL0);
+		if (!(reg & BM_UARTAPP_CTRL0_SFTRST))
+			break;
+		udelay(3);
+	}
+
+	writel(BM_UARTAPP_CTRL0_CLKGATE,
+		     u->membase + UARTAPP_CTRL0_CLR);
+}
+
+static int mxs_auart_startup(struct uart_port *u)
+{
+	struct mxs_auart_port *s = to_auart_port(u);
+
+	clk_enable(s->clk);
+
+	writel(BM_UARTAPP_CTRL2_UARTEN,
+		     s->port.membase + UARTAPP_CTRL2_SET);
+
+	writel(BM_UARTAPP_INTR_RXIEN | BM_UARTAPP_INTR_RTIEN,
+		     s->port.membase + UARTAPP_INTR);
+
+	writel(BM_UARTAPP_INTR_CTSMIEN,
+		     s->port.membase + UARTAPP_INTR_SET);
+
+	/*
+	 * Enable fifo so all four bytes of a DMA word are written to
+	 * output (otherwise, only the LSB is written, ie. 1 in 4 bytes)
+	 */
+	writel(BM_UARTAPP_LINECTRL_FEN,
+		     s->port.membase + UARTAPP_LINECTRL_SET);
+
+	return 0;
+}
+
+static void mxs_auart_shutdown(struct uart_port *u)
+{
+	struct mxs_auart_port *s = to_auart_port(u);
+
+	writel(BM_UARTAPP_CTRL0_SFTRST,
+		     s->port.membase + UARTAPP_CTRL0_SET);
+
+	writel(BM_UARTAPP_INTR_RXIEN | BM_UARTAPP_INTR_RTIEN |
+			BM_UARTAPP_INTR_CTSMIEN,
+			s->port.membase + UARTAPP_INTR_CLR);
+
+	clk_disable(s->clk);
+}
+
+static unsigned int mxs_auart_tx_empty(struct uart_port *u)
+{
+	if (readl(u->membase + UARTAPP_STAT) & BM_UARTAPP_STAT_TXFE)
+		return TIOCSER_TEMT;
+	else
+		return 0;
+}
+
+static void mxs_auart_start_tx(struct uart_port *u)
+{
+	struct mxs_auart_port *s = to_auart_port(u);
+
+	/* enable transmitter */
+	writel(BM_UARTAPP_CTRL2_TXE, u->membase + UARTAPP_CTRL2_SET);
+
+	mxs_auart_tx_chars(s);
+}
+
+static void mxs_auart_stop_tx(struct uart_port *u)
+{
+	writel(BM_UARTAPP_CTRL2_TXE, u->membase + UARTAPP_CTRL2_CLR);
+}
+
+static void mxs_auart_stop_rx(struct uart_port *u)
+{
+	writel(BM_UARTAPP_CTRL2_RXE, u->membase + UARTAPP_CTRL2_CLR);
+}
+
+static void mxs_auart_break_ctl(struct uart_port *u, int ctl)
+{
+	if (ctl)
+		writel(BM_UARTAPP_LINECTRL_BRK,
+			     u->membase + UARTAPP_LINECTRL_SET);
+	else
+		writel(BM_UARTAPP_LINECTRL_BRK,
+			     u->membase + UARTAPP_LINECTRL_CLR);
+}
+
+static void mxs_auart_enable_ms(struct uart_port *port)
+{
+	/* just empty */
+}
+
+static struct uart_ops mxs_auart_ops = {
+	.tx_empty       = mxs_auart_tx_empty,
+	.start_tx       = mxs_auart_start_tx,
+	.stop_tx	= mxs_auart_stop_tx,
+	.stop_rx	= mxs_auart_stop_rx,
+	.enable_ms      = mxs_auart_enable_ms,
+	.break_ctl      = mxs_auart_break_ctl,
+	.set_mctrl	= mxs_auart_set_mctrl,
+	.get_mctrl      = mxs_auart_get_mctrl,
+	.startup	= mxs_auart_startup,
+	.shutdown       = mxs_auart_shutdown,
+	.set_termios    = mxs_auart_settermios,
+	.type	   	= mxs_auart_type,
+	.release_port   = mxs_auart_release_port,
+	.request_port   = mxs_auart_request_port,
+	.config_port    = mxs_auart_config_port,
+	.verify_port    = mxs_auart_verify_port,
+};
+
+static struct mxs_auart_port *auart_port[MXS_AUART_PORTS];
+
+#ifdef CONFIG_SERIAL_MXS_AUART_CONSOLE
+static void mxs_auart_console_putchar(struct uart_port *port, int ch)
+{
+	unsigned int status;
+
+	do {
+		status = readl(port->membase + UARTAPP_STAT);
+	} while (status & BM_UARTAPP_STAT_TXFF);
+	writel(ch, port->membase + UARTAPP_DATA);
+}
+
+static void
+auart_console_write(struct console *co, const char *str, unsigned int count)
+{
+	struct mxs_auart_port *s;
+	struct uart_port *port;
+	unsigned int status, old_cr;
+
+	if (co->index >	MXS_AUART_PORTS || co->index < 0)
+		return;
+
+	s = auart_port[co->index];
+	port = &s->port;
+
+	clk_enable(s->clk);
+
+	/* First save the CR then disable the interrupts */
+	old_cr = readl(port->membase + UARTAPP_CTRL2);
+	writel(BM_UARTAPP_CTRL2_UARTEN | BM_UARTAPP_CTRL2_TXE,
+		     port->membase + UARTAPP_CTRL2_SET);
+
+	uart_console_write(port, str, count, mxs_auart_console_putchar);
+
+	/*
+	 * Finally, wait for transmitter to become empty
+	 * and restore the TCR
+	 */
+	do {
+		status = readl(port->membase + UARTAPP_STAT);
+	} while (status & BM_UARTAPP_STAT_BUSY);
+
+	writel(old_cr, port->membase + UARTAPP_CTRL2);
+
+	clk_disable(s->clk);
+}
+
+static void __init
+auart_console_get_options(struct uart_port *port, int *baud,
+			  int *parity, int *bits)
+{
+	if (readl(port->membase + UARTAPP_CTRL2)
+				& BM_UARTAPP_CTRL2_UARTEN) {
+		unsigned int lcr_h, quot;
+		lcr_h = readl(port->membase + UARTAPP_LINECTRL);
+
+		*parity = 'n';
+		if (lcr_h & BM_UARTAPP_LINECTRL_PEN) {
+			if (lcr_h & BM_UARTAPP_LINECTRL_EPS)
+				*parity = 'e';
+			else
+				*parity = 'o';
+		}
+
+		if ((lcr_h & BM_UARTAPP_LINECTRL_WLEN)
+				== BF_UARTAPP_LINECTRL_WLEN(2))
+			*bits = 7;
+		else
+			*bits = 8;
+
+		quot = (((readl(port->membase + UARTAPP_LINECTRL)
+				& BM_UARTAPP_LINECTRL_BAUD_DIVINT))
+				    >> (BP_UARTAPP_LINECTRL_BAUD_DIVINT - 6))
+			| (((readl(port->membase + UARTAPP_LINECTRL)
+				& BM_UARTAPP_LINECTRL_BAUD_DIVFRAC))
+					>> BP_UARTAPP_LINECTRL_BAUD_DIVFRAC);
+		if (quot == 0)
+			quot = 1;
+		*baud = (port->uartclk << 2) / quot;
+	}
+}
+
+static int __init
+auart_console_setup(struct console *co, char *options)
+{
+	struct mxs_auart_port *s;
+	int baud = 9600;
+	int bits = 8;
+	int parity = 'n';
+	int flow = 'n';
+	int ret;
+
+	/*
+	 * Check whether an invalid uart number has been specified, and
+	 * if so, search for the first available port that does have
+	 * console support.
+	 */
+	if (co->index == -1 || co->index >= ARRAY_SIZE(auart_port))
+		co->index = 0;
+	s = auart_port[co->index];
+	if (!s)
+		return -ENODEV;
+
+	clk_enable(s->clk);
+
+	if (options)
+		uart_parse_options(options, &baud, &parity, &bits, &flow);
+	else
+		auart_console_get_options(&s->port, &baud, &parity, &bits);
+
+	ret = uart_set_options(&s->port, co, baud, parity, bits, flow);
+
+	clk_disable(s->clk);
+
+	return ret;
+}
+
+static struct console auart_console = {
+	.name		= "ttyAPP",
+	.write		= auart_console_write,
+	.device		= uart_console_device,
+	.setup		= auart_console_setup,
+	.flags		= CON_PRINTBUFFER,
+	.index		= -1,
+	.data		= &auart_driver,
+};
+#endif
+
+static struct uart_driver auart_driver = {
+	.owner		= THIS_MODULE,
+	.driver_name	= "ttyAPP",
+	.dev_name	= "ttyAPP",
+	.major		= 0,
+	.minor		= 0,
+	.nr		= MXS_AUART_PORTS,
+#ifdef CONFIG_SERIAL_MXS_AUART_CONSOLE
+	.cons =		&auart_console,
+#endif
+};
+
+static int __devinit mxs_auart_probe(struct platform_device *pdev)
+{
+	struct mxs_auart_port *s;
+	u32 version;
+	int ret = 0;
+	struct resource *r;
+
+	s = kzalloc(sizeof(struct mxs_auart_port), GFP_KERNEL);
+	if (!s) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	s->clk = clk_get(&pdev->dev, NULL);
+	if (IS_ERR(s->clk)) {
+		ret = PTR_ERR(s->clk);
+		goto out_free;
+	}
+
+	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!r) {
+		ret = -ENXIO;
+		goto out_free_clk;
+	}
+
+	s->port.mapbase = r->start;
+	s->port.membase = ioremap(r->start, resource_size(r));
+	s->port.ops = &mxs_auart_ops;
+	s->port.iotype = UPIO_MEM;
+	s->port.line = pdev->id < 0 ? 0 : pdev->id;
+	s->port.fifosize = 16;
+	s->port.uartclk = clk_get_rate(s->clk);
+	s->port.type = PORT_IMX;
+	s->port.dev = s->dev = get_device(&pdev->dev);
+
+	s->flags = 0;
+	s->ctrl = 0;
+
+	s->irq = platform_get_irq(pdev, 0);
+	s->port.irq = s->irq;
+	ret = request_irq(s->irq, mxs_auart_irq_handle, 0, dev_name(&pdev->dev), s);
+	if (ret)
+		goto out_free_clk;
+
+	platform_set_drvdata(pdev, s);
+
+	auart_port[pdev->id] = s;
+
+	mxs_auart_reset(&s->port);
+
+	ret = uart_add_one_port(&auart_driver, &s->port);
+	if (ret)
+		goto out_free_irq;
+
+	version = readl(s->port.membase + UARTAPP_VERSION);
+	dev_info(&pdev->dev, "Found APPUART %d.%d.%d\n",
+	       (version >> 24) & 0xff,
+	       (version >> 16) & 0xff, version & 0xffff);
+
+	return 0;
+
+out_free_irq:
+	auart_port[pdev->id] = NULL;
+	free_irq(s->irq, s);
+out_free_clk:
+	clk_put(s->clk);
+out_free:
+	kfree(s);
+out:
+	return ret;
+}
+
+static int __devexit mxs_auart_remove(struct platform_device *pdev)
+{
+	struct mxs_auart_port *s = platform_get_drvdata(pdev);
+
+	uart_remove_one_port(&auart_driver, &s->port);
+
+	auart_port[pdev->id] = NULL;
+
+	clk_put(s->clk);
+	free_irq(s->irq, s);
+	kfree(s);
+
+	return 0;
+}
+
+static struct platform_driver mxs_auart_driver = {
+	.probe = mxs_auart_probe,
+	.remove = __devexit_p(mxs_auart_remove),
+	.driver = {
+		.name = "mxs-auart",
+		.owner = THIS_MODULE,
+	},
+};
+
+static int __init mxs_auart_init(void)
+{
+	int r;
+
+	r = uart_register_driver(&auart_driver);
+	if (r)
+		goto out;
+
+	r = platform_driver_register(&mxs_auart_driver);
+	if (r)
+		goto out_err;
+
+	return 0;
+out_err:
+	uart_unregister_driver(&auart_driver);
+out:
+	return r;
+}
+
+static void __exit mxs_auart_exit(void)
+{
+	platform_driver_unregister(&mxs_auart_driver);
+	uart_unregister_driver(&auart_driver);
+}
+
+module_init(mxs_auart_init);
+module_exit(mxs_auart_exit);
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Freescale MXS application uart driver");
+MODULE_AUTHOR("Sascha Hauer <s.hauer@pengutronix.de>");
-- 
1.7.2.3
