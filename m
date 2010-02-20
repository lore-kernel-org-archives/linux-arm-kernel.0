From: mfuzzey@gmail.com (Martin Fuzzey)
Date: Sat, 20 Feb 2010 16:32:14 +0100
Subject: [PATCH 3/3] PCMCIA: Add support for freescale MX2/3 SoCs
In-Reply-To: <20100220153200.19692.70098.stgit@srv002.fuzzey.net>
References: <20100220153200.19692.70098.stgit@srv002.fuzzey.net>
Message-ID: <20100220153214.19692.72946.stgit@srv002.fuzzey.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



Signed-off-by: Martin Fuzzey <mfuzzey@gmail.com>

---

 drivers/pcmcia/Kconfig      |    7 
 drivers/pcmcia/Makefile     |    1 
 drivers/pcmcia/mxc_pcmcia.c |  710 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 718 insertions(+), 0 deletions(-)
 create mode 100644 drivers/pcmcia/mxc_pcmcia.c

diff --git a/drivers/pcmcia/Kconfig b/drivers/pcmcia/Kconfig
index 9f3adbd..373a898 100644
--- a/drivers/pcmcia/Kconfig
+++ b/drivers/pcmcia/Kconfig
@@ -298,4 +298,11 @@ config PCCARD_NONSTATIC
 config PCCARD_IODYN
 	bool
 
+config PCMCIA_MXC
+	tristate "Freescale MXC PCMCIA Driver"
+	depends on PCMCIA && ARCH_MXC
+	select PCMCIA_SOC_COMMON
+	help
+	  Say Y here to support the integrated PCMCIA in the freescale MXC SoCs.
+
 endif	# PCCARD
diff --git a/drivers/pcmcia/Makefile b/drivers/pcmcia/Makefile
index 83ff802..3791193 100644
--- a/drivers/pcmcia/Makefile
+++ b/drivers/pcmcia/Makefile
@@ -35,6 +35,7 @@ obj-$(CONFIG_OMAP_CF)				+= omap_cf.o
 obj-$(CONFIG_BFIN_CFPCMCIA)			+= bfin_cf_pcmcia.o
 obj-$(CONFIG_AT91_CF)				+= at91_cf.o
 obj-$(CONFIG_ELECTRA_CF)			+= electra_cf.o
+obj-$(CONFIG_PCMCIA_MXC)		+=  mxc_pcmcia.o
 
 au1x00_ss-y					+= au1000_generic.o
 au1x00_ss-$(CONFIG_MIPS_PB1000)			+= au1000_pb1x00.o
diff --git a/drivers/pcmcia/mxc_pcmcia.c b/drivers/pcmcia/mxc_pcmcia.c
new file mode 100644
index 0000000..af05a2d
--- /dev/null
+++ b/drivers/pcmcia/mxc_pcmcia.c
@@ -0,0 +1,710 @@
+/*
+ * drivers/pcmcia/mxc_pcmica.c
+ *
+ * Driver for the PCMCIA control functionality of i.MX SoC family
+ *
+ * Copyright (C) 1999 John G. Dorsey.  All Rights Reserved.
+ * Copyright (C) 2005-2007 Freescale Semiconductor, Inc. All Rights Reserved.
+ * Copyright (C) 2009 Martin Fuzzey <mfuzzey@gmail.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/kernel.h>
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+
+#include <mach/hardware.h>
+#include "soc_common.h"
+
+
+#define PCMCIA_WINDOWS  5 /* # windows supported by hardware */
+#define ATTRIBUTE_MEMORY_WINDOW	0
+#define COMMON_MEMORY_WINDOW	1
+#define IO_WINDOW		2
+
+/* Registers */
+#define PCMCIA_PIPR	0x00	/* Input pins register */
+#define PIPR_POWERON	(1 <<  8)	/* card indicates "power on" */
+#define PIPR_RDY	(1 <<  7)	/* card is ready */
+#define PIPR_BVD2	(1 <<  6)	/* battery voltage 2/SPKR in */
+#define PIPR_BVD1	(1 <<  5)	/* battery voltage 1/STSCHG */
+#define PIPR_CD		(3 <<  3)	/* card detect 1 and 2 */
+#define PIPR_WP		(1 <<  2)	/* write protect switch enabled */
+#define PIPR_VS		(3 <<  0)	/* voltage sense bits */
+#define PIPR_VS_5V	(1 <<  0)	/* 5v */
+
+#define PCMCIA_PSCR	0x04	/* Status Changed Register */
+#define PSCR_POWC	(1 << 11)	/* power on changed */
+#define PSCR_RDYR	(1 << 10)	/* ready rising changed */
+#define PSCR_RDYF	(1 <<  9)	/* ready falling changed */
+#define PSCR_RDYH	(1 <<  8)	/* ready state */
+#define PSCR_RDYL	(1 <<  7)	/* inverted ready state */
+#define PSCR_BVDC2	(1 <<  6)	/* battery voltage 2 changed */
+#define PSCR_BVDC1	(1 <<  5)	/* battery voltage 1 changed */
+#define PSCR_CDC2 	(1 <<  4)	/* card detect 2 changed */
+#define PSCR_CDC1 	(1 <<  3)	/* card detect 1 changed */
+#define PSCR_WPC	(1 <<  2)	/* write protect changed */
+#define PSCR_VSC2	(1 <<  1)	/* voltage sense 2 changed */
+#define PSCR_VSC1	(1 <<  0)	/* voltage sense 1 changed */
+
+#define PCMCIA_PER	0x08	/* Interrupt Enable Register */
+#define PER_ERRINTEN	(1 << 12)	/* error interrupt enable */
+#define PER_POWERONEN	(1 << 11)	/* power on interrupt enable */
+#define PER_RDYRE	(1 << 10)	/* RDY/nIREQ pin rising edge */
+#define PER_RDYFE	(1 <<  9)	/* RDY/nIREQ pin falling edge */
+#define PER_RDYHE	(1 <<  8)	/* RDY/nIREQ pin high */
+#define PER_RDYLE	(1 <<  7)	/* RDY/nIREQ pin low */
+#define PER_BVDE2	(1 <<  6)	/* battery voltage 2/SPKR in */
+#define PER_BVDE1	(1 <<  5)	/* battery voltage 1/STSCHG */
+#define PER_CDE2	(1 <<  4)	/* card detect 2  */
+#define PER_CDE1	(1 <<  3)	/* card detect 1 */
+#define PER_WPE		(1 <<  2)	/* write protect */
+#define PER_VSE2	(1 <<  1)	/* voltage sense 2 */
+#define PER_VSE1	(1 <<  0)	/* voltage sense 1 */
+
+/* win: 0-4 */
+#define PCMCIA_PBR(win)	(0x0C + 4 * (win))	/* Base Register x */
+
+#define PCMCIA_POR(win)	(0x28 + 4 * (win))	/* Option Register x */
+#define POR_PV		(1 << 29)	/* set iff bank is valid */
+#define POR_WPEN	(1 << 28)	/* write protect input enable */
+#define POR_WP		(1 << 27)	/* write protected */
+
+#define POR_PRS_SHIFT	(25)
+#define POR_PRS(x)		(((x) & 0x3) << POR_PRS_SHIFT)
+#define POR_PRS_MASK		POR_PRS(3)	/* PCMCIA region select */
+#define POR_PRS_COMMON		(0)	/* values of POR_PRS field */
+#define POR_PRS_TRUE_IDE	(1)
+#define POR_PRS_ATTRIBUTE	(2)
+#define POR_PRS_IO		(3)
+
+#define POR_PPS_8	(1 << 24)	/* PCMCIA Port size =  8bits */
+#define POR_PPS_16	(0 << 24)	/* PCMCIA Port size = 16bits */
+
+#define POR_PSL_SHIFT	(17)	/* strobe length */
+#define POR_PSL(x)	(((x) & 0x7F) << POR_PSL_SHIFT)
+#define POR_PSL_MASK		POR_PSL(0x7f)
+
+#define POR_PSST_SHIFT	(11)	/* strobe setup time */
+#define POR_PSST(x)		(((x) & 0x3F) << POR_PSST_SHIFT)
+#define POR_PSST_MASK		POR_PSST(0x3f)
+
+#define POR_PSHT_SHIFT	(5)	/* strobe hold time  */
+#define POR_PSHT(x)		(((x) & 0x3F) << POR_PSHT_SHIFT)
+#define POR_PSHT_MASK		POR_PSHT(0x3f)
+
+#define POR_BSIZE_SHIFT	(0)	/* bank size */
+#define POR_BSIZE(x)		(((x) & 0x1F) << POR_BSIZE_SHIFT)
+#define POR_BSIZE_MASK		POR_BSIZE(0x1F)
+
+#define PCMCIA_POFR(win)	(0x44 + 4 * (win))	/* Offset Register x */
+
+#define PCMCIA_PGCR	0x60	/* General Control Register */
+#define PGCR_LPMEN	(1 <<  3)	/* Low power Mode Enable */
+#define PGCR_SPKREN	(1 <<  2)	/* SPKROUT routing enable */
+#define PGCR_POE	(1 <<  1)	/* Controller out enable */
+#define PGCR_RESET	(1 <<  0)	/* Card reset */
+
+#define PCMCIA_PGSR	0x64	/* General Status Register */
+#define PGSR_NWINE	(1 <<  4)	/* No Window error */
+#define PGSR_LPE	(1 <<  3)	/* Low Power error */
+#define PGSR_SE		(1 <<  2)	/* Size error */
+#define PGSR_CDE	(1 <<  1)	/* Card Detect error */
+#define PGSR_WPE	(1 <<  0)	/* Write Protect error */
+
+
+static const char skt_name[] = "pcmcia0";
+
+struct mxc_pcmcia_window {
+	unsigned size;
+	unsigned bsize; /* BSZIE value - see datasheet */
+};
+
+struct mxc_pcmcia_soc {
+	unsigned long base;	/* physical base address of card memory */
+	unsigned long addr_size; /* addressable range by pcmcia */
+	struct mxc_pcmcia_window windows[PCMCIA_WINDOWS];
+};
+
+struct mxc_pcmcia {
+	void __iomem *regs;
+	struct pcmcia_irqs irqs;
+	struct clk *clk;
+	struct mxc_pcmcia_soc *soc;
+};
+
+/* Hardcoded base address rather than PCMCIA_MEM_BASE_ADDR below
+to allow driver to work on multiple SoC types which I understand is a
+longterm objective for MXC */
+static struct mxc_pcmcia_soc mx21_soc = {
+	.base = 0xD4000000,
+	.addr_size = SZ_32K,
+	.windows = {
+		{.size = SZ_8K, .bsize = 0x0D},
+		{.size = SZ_8K, .bsize = 0x0D},
+		{.size = SZ_2K, .bsize = 0x04},
+	},
+};
+
+static struct mxc_pcmcia_soc mx27_soc = {
+	.base = 0xDC000000,
+	.addr_size = SZ_64M,
+	.windows = {
+		{.size = SZ_16M, .bsize = 0x14},
+		{.size = SZ_16M, .bsize = 0x14},
+		{.size = SZ_64K, .bsize = 0x05},
+	},
+};
+
+static struct mxc_pcmcia_soc mx3x_soc = {
+	.base = 0xBC000000,
+	.addr_size = SZ_64M,
+	.windows = {
+		{.size = SZ_16M, .bsize = 0x14},
+		{.size = SZ_16M, .bsize = 0x14},
+		{.size = SZ_64K, .bsize = 0x05},
+	},
+};
+
+static inline struct mxc_pcmcia *driver_data(struct soc_pcmcia_socket *skt)
+{
+	return skt->socket.driver_data;
+}
+
+static inline void set_register_bits(struct mxc_pcmcia *mxc_pcmcia,
+	u32 offset, u32 mask)
+{
+	void __iomem *reg = mxc_pcmcia->regs + offset;
+	writel(readl(reg) | mask, reg);
+}
+
+static inline void clear_register_bits(struct mxc_pcmcia *mxc_pcmcia,
+	u32 offset, u32 mask)
+{
+	void __iomem *reg = mxc_pcmcia->regs + offset;
+	writel(readl(reg) & ~mask, reg);
+}
+
+
+/*
+ * Set address and profile to window registers POR, POFR
+ */
+static int mxc_pcmcia_set_window(struct soc_pcmcia_socket *skt,
+	u_int card_addr, u_int window, u_int active, u32 *offset)
+{
+	u32 reg;
+	struct mxc_pcmcia *mxc_pcmcia = driver_data(skt);
+	u32 offset_mask = mxc_pcmcia->soc->windows[window].size - 1;
+	u32 bank_mask = ~offset_mask;
+
+	/* Disable the window */
+	clear_register_bits(mxc_pcmcia, PCMCIA_POR(window), POR_PV);
+
+	if ((card_addr & bank_mask) >= mxc_pcmcia->soc->addr_size) {
+		dev_err(&skt->socket.dev, "card address not supported %08X\n",
+			card_addr);
+		return -EINVAL;
+	}
+
+	/* Set POR */
+	reg = readl(mxc_pcmcia->regs + PCMCIA_POR(window));
+	reg &= ~(POR_PRS_MASK | POR_WPEN | POR_WP | POR_PPS_8);
+	reg |= POR_PPS_16;
+
+	switch (window) {
+	case IO_WINDOW:
+		reg |= POR_PRS(POR_PRS_IO);
+		break;
+
+	case ATTRIBUTE_MEMORY_WINDOW:
+		reg |= POR_PRS(POR_PRS_ATTRIBUTE);
+		break;
+
+	case COMMON_MEMORY_WINDOW:
+		reg |= POR_PRS(POR_PRS_COMMON);
+		break;
+
+	default:
+		return -EINVAL;
+
+	}
+	writel(reg, mxc_pcmcia->regs + PCMCIA_POR(window));
+
+	writel(card_addr & bank_mask, mxc_pcmcia->regs + PCMCIA_POFR(window));
+
+	/* Enable the window */
+	if (active)
+		set_register_bits(mxc_pcmcia, PCMCIA_POR(window), POR_PV);
+
+	if (offset)
+		*offset = card_addr & offset_mask;
+
+	return 0;
+}
+
+
+static int mxc_set_io_map(struct soc_pcmcia_socket *skt,
+	struct pccard_io_map *map)
+{
+	return mxc_pcmcia_set_window(
+		skt,
+		0, IO_WINDOW,
+		map->flags & MAP_ACTIVE, NULL);
+}
+
+
+static int mxc_set_mem_map(struct soc_pcmcia_socket *skt,
+	struct pccard_mem_map *map)
+{
+	int window;
+	int ret;
+	struct resource *res;
+	u32 offset;
+
+	if (map->flags & MAP_ATTRIB) {
+		window = ATTRIBUTE_MEMORY_WINDOW;
+		res = &skt->res_attr;
+	} else {
+		window = COMMON_MEMORY_WINDOW;
+		res = &skt->res_mem;
+	}
+
+	ret = mxc_pcmcia_set_window(
+		skt,
+		map->card_start,
+		window,
+		map->flags & MAP_ACTIVE,
+		&offset);
+
+	if (!ret)
+		map->static_start = res->start + offset;
+
+	return ret;
+}
+
+
+static int mxc_pcmcia_hw_init(struct soc_pcmcia_socket *skt)
+{
+	struct mxc_pcmcia *mxc_pcmcia = driver_data(skt);
+	int ret;
+	int i;
+	u32 base, bsize, offset = 0;
+
+	ret = soc_pcmcia_request_irqs(skt, &mxc_pcmcia->irqs, 1);
+	if (ret)
+		return ret;
+
+	/* configure but don't enable windows */
+	for (i = 0; i < PCMCIA_WINDOWS; i++) {
+		if (mxc_pcmcia->soc->windows[i].size) {
+			base = offset;
+			bsize = mxc_pcmcia->soc->windows[i].bsize;
+		} else {
+			base = 0;
+			bsize = 0;
+		}
+		writel(base, mxc_pcmcia->regs + PCMCIA_PBR(i));
+		writel(bsize, mxc_pcmcia->regs + PCMCIA_POR(i));
+		writel(0, mxc_pcmcia->regs + PCMCIA_POFR(i));
+		offset += mxc_pcmcia->soc->windows[i].size;
+	}
+
+	return 0;
+}
+
+
+static void mxc_pcmcia_hw_shutdown(struct soc_pcmcia_socket *skt)
+{
+	struct mxc_pcmcia *mxc_pcmcia = driver_data(skt);
+	int i;
+
+	soc_pcmcia_free_irqs(skt, &mxc_pcmcia->irqs, 1);
+
+	for (i = 0; i < PCMCIA_WINDOWS; i++) {
+		writel(0, mxc_pcmcia->regs + PCMCIA_PBR(i));
+		writel(0, mxc_pcmcia->regs + PCMCIA_POR(i));
+		writel(0, mxc_pcmcia->regs + PCMCIA_POFR(i));
+	}
+}
+
+static void
+mxc_pcmcia_socket_state(struct soc_pcmcia_socket *skt,
+				struct pcmcia_state *state)
+{
+	unsigned long pins;
+
+	pins = readl(driver_data(skt)->regs + PCMCIA_PIPR);
+	dev_dbg(&skt->socket.dev, "PIPR = 0x%08lx\n", pins);
+
+	state->ready = (pins & PIPR_RDY) ? 1 : 0;
+	state->bvd2 = (pins & PIPR_BVD2) ? 1 : 0;
+	state->bvd1 = (pins & PIPR_BVD1) ? 1 : 0;
+
+	if ((pins & PIPR_CD) == PIPR_CD)
+		skt->cs_state.csc_mask |= SS_INSERTION;
+	state->detect = (pins & PIPR_CD) ? 0 : 1;
+	state->wrprot = (pins & PIPR_WP) ? 1 : 0;
+	state->vs_3v = (pins & PIPR_VS_5V) ? 0 : 1;
+	state->vs_Xv = 0;
+}
+
+
+static void mxc_pcmcia_soft_reset(struct soc_pcmcia_socket *skt)
+{
+	struct mxc_pcmcia *mxc_pcmcia = driver_data(skt);
+
+	set_register_bits(mxc_pcmcia, PCMCIA_PGCR, PGCR_RESET);
+	msleep(2);
+
+	clear_register_bits(mxc_pcmcia, PCMCIA_PGCR, PGCR_RESET | PGCR_LPMEN);
+	set_register_bits(mxc_pcmcia, PCMCIA_PGCR, PGCR_POE);
+	msleep(2);
+	dev_dbg(&skt->socket.dev, "soft_reset:PGCR = %08x\n",
+		readl(mxc_pcmcia->regs + PCMCIA_PGCR));
+}
+
+static int
+mxc_pcmcia_configure_socket(struct soc_pcmcia_socket *skt,
+				const socket_state_t *state)
+{
+	struct mxc_pcmcia *mxc_pcmcia = driver_data(skt);
+
+	if (state->Vcc != 0 && state->Vcc != 33 && state->Vcc != 50) {
+		dev_err(&skt->socket.dev, "unrecognized Vcc %d\n", state->Vcc);
+		return -EINVAL;
+	}
+
+	dev_dbg(&skt->socket.dev, "PIPR = %x, desired Vcc = %d.%dV\n",
+		 readl(mxc_pcmcia->regs + PCMCIA_PIPR),
+		 state->Vcc / 10, state->Vcc % 10);
+
+	if (state->flags & SS_RESET) {
+		mxc_pcmcia_soft_reset(skt);
+
+		/* clean out previous tenant's trash */
+		writel(
+			PGSR_NWINE | PGSR_LPE | PGSR_SE | PGSR_CDE | PGSR_WPE,
+			mxc_pcmcia->regs + PCMCIA_PGSR);
+	}
+	/* enable interrupts if requested, else turn 'em off */
+	if (skt->socket.pci_irq)
+		writel(PER_RDYLE | PER_CDE1 | PER_CDE2,
+			mxc_pcmcia->regs + PCMCIA_PER);
+	else
+		writel(0, mxc_pcmcia->regs + PCMCIA_PER);
+
+	return 0;
+}
+
+
+/*
+ * Enable card status IRQs on (re-)initialisation.  This can
+ * be called at initialisation, power management event, or
+ * pcmcia event.
+ */
+static void mxc_pcmcia_socket_init(struct soc_pcmcia_socket *skt)
+{
+	struct mxc_pcmcia *mxc_pcmcia = driver_data(skt);
+
+	mxc_pcmcia_soft_reset(skt);
+	soc_pcmcia_enable_irqs(skt, &mxc_pcmcia->irqs, 1);
+}
+
+/*
+ * Disable card status IRQ on suspend.
+ */
+static void mxc_pcmcia_socket_suspend(struct soc_pcmcia_socket *skt)
+{
+	struct mxc_pcmcia *mxc_pcmcia = driver_data(skt);
+
+	soc_pcmcia_disable_irqs(skt, &mxc_pcmcia->irqs, 1);
+	set_register_bits(mxc_pcmcia, PCMCIA_PGCR, PGCR_LPMEN);
+}
+
+static void mxc_pcmcia_set_window_timing(struct soc_pcmcia_socket *skt,
+	u_int speed_ns, u_int window, u_int clk_ns)
+{
+	struct mxc_pcmcia *mxc_pcmcia = driver_data(skt);
+	u_int cycles = speed_ns / clk_ns;
+	u_int code = POR_PSHT(cycles) | POR_PSST(cycles) | POR_PSL(cycles + 2);
+
+	/* Disable the window */
+	clear_register_bits(mxc_pcmcia, PCMCIA_POR(window), POR_PV);
+
+	/* Clear the register first */
+	clear_register_bits(mxc_pcmcia, PCMCIA_POR(window),
+		POR_PSST_MASK | POR_PSL_MASK | POR_PSHT_MASK);
+
+	/* And then set the register */
+	set_register_bits(mxc_pcmcia, PCMCIA_POR(window), code);
+
+	/* Enable the window */
+	set_register_bits(mxc_pcmcia, PCMCIA_POR(window), POR_PV);
+}
+
+
+static int mxc_pcmcia_set_timing(struct soc_pcmcia_socket *skt)
+{
+	u_int clk_ns;
+	struct soc_pcmcia_timing timing;
+	struct mxc_pcmcia *mxc_pcmcia = driver_data(skt);
+
+	clk_ns = (1000 * 1000 * 1000) / clk_get_rate(mxc_pcmcia->clk);
+
+	soc_common_pcmcia_get_timing(skt, &timing);
+	dev_dbg(&skt->socket.dev, "timing: io %d, mem %d, attr %d clk_ns=%d\n",
+		timing.io, timing.mem, timing.attr, clk_ns);
+
+	mxc_pcmcia_set_window_timing(skt, timing.io,
+					IO_WINDOW, clk_ns);
+	mxc_pcmcia_set_window_timing(skt, timing.mem,
+					COMMON_MEMORY_WINDOW, clk_ns);
+	mxc_pcmcia_set_window_timing(skt, timing.attr,
+					ATTRIBUTE_MEMORY_WINDOW, clk_ns);
+
+	return 0;
+}
+
+
+static void mxc_pcmcia_ack_interrupt(struct soc_pcmcia_socket *skt)
+{
+	struct mxc_pcmcia *mxc_pcmcia = driver_data(skt);
+
+	writel(readl(mxc_pcmcia->regs + PCMCIA_PSCR),
+		mxc_pcmcia->regs + PCMCIA_PSCR);
+	writel(readl(mxc_pcmcia->regs + PCMCIA_PGSR),
+		mxc_pcmcia->regs + PCMCIA_PGSR);
+}
+
+static struct pcmcia_low_level mxc_pcmcia_ops = {
+	.owner = THIS_MODULE,
+	.hw_init = mxc_pcmcia_hw_init,
+	.hw_shutdown = mxc_pcmcia_hw_shutdown,
+	.socket_state = mxc_pcmcia_socket_state,
+	.configure_socket = mxc_pcmcia_configure_socket,
+
+	.socket_init = mxc_pcmcia_socket_init,
+	.socket_suspend = mxc_pcmcia_socket_suspend,
+
+	.set_timing = mxc_pcmcia_set_timing,
+	.set_io_map = mxc_set_io_map,
+	.set_mem_map = mxc_set_mem_map,
+	.ack_interrupt = mxc_pcmcia_ack_interrupt,
+};
+
+
+static void mxc_pcmcia_setup_resources(struct soc_pcmcia_socket *skt,
+	struct mxc_pcmcia_soc *soc)
+{
+	skt->res_skt.start = soc->base;
+	skt->res_skt.flags = IORESOURCE_MEM;
+
+	skt->res_attr.start = soc->base;
+	skt->res_attr.end = skt->res_attr.start +
+		soc->windows[ATTRIBUTE_MEMORY_WINDOW].size - 1;
+	skt->res_attr.name = "attribute";
+	skt->res_attr.flags = IORESOURCE_MEM;
+
+	skt->res_mem.start = skt->res_attr.end + 1;
+	skt->res_mem.end = skt->res_mem.start +
+		soc->windows[COMMON_MEMORY_WINDOW].size - 1;
+	skt->res_mem.name = "memory";
+	skt->res_mem.flags = IORESOURCE_MEM;
+
+	skt->res_io.start = skt->res_mem.end + 1;
+	skt->res_io.end = skt->res_io.start +
+		soc->windows[IO_WINDOW].size - 1;
+	skt->res_io.name = "io";
+	skt->res_io.flags = IORESOURCE_MEM | IORESOURCE_BUSY;
+
+	skt->res_skt.end = skt->res_io.end;
+
+	driver_data(skt)->soc = soc;
+}
+
+static struct mxc_pcmcia_soc *mxc_pcmcia_find_soc(void)
+{
+	if (cpu_is_mx3())
+		return &mx3x_soc;
+	if (cpu_is_mx27())
+		return &mx27_soc;
+	if (cpu_is_mx21())
+		return &mx21_soc;
+	return NULL;
+}
+
+static int __devinit mxc_drv_pcmcia_probe(struct platform_device *pdev)
+{
+	struct skt_dev_info *sinfo;
+	struct soc_pcmcia_socket *skt;
+	struct mxc_pcmcia *driver_data;
+	struct mxc_pcmcia_soc *soc;
+	struct resource *res;
+	struct pccard_io_map map;
+	int ret;
+
+	printk(KERN_INFO "mxc pcmcia driver\n");
+
+	soc = mxc_pcmcia_find_soc();
+	if (!soc) {
+		dev_err(&pdev->dev, "unsupported SoC\n");
+		return -ENODEV;
+	}
+
+	sinfo = kzalloc(sizeof(struct skt_dev_info)
+			+ sizeof(struct soc_pcmcia_socket), GFP_KERNEL);
+	if (!sinfo)
+		return -ENOMEM;
+
+	driver_data = kzalloc(sizeof(*driver_data), GFP_KERNEL);
+	if (!driver_data) {
+		ret = -ENOMEM;
+		goto failed_alloc;
+	}
+
+	sinfo->nskt = 1;
+	skt = &sinfo->skt[0];
+	skt->nr = 0;
+	skt->socket.driver_data = driver_data;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		ret = -ENXIO;
+		goto failed_regs_resource;
+	}
+
+	res = request_mem_region(res->start, resource_size(res), pdev->name);
+	if (!res) {
+		ret = -EBUSY;
+		goto failed_request_regs_mem;
+	}
+
+	driver_data->regs = ioremap(res->start, resource_size(res));
+	if (!driver_data->regs) {
+		ret = -ENOMEM;
+		goto failed_map_regs;
+	}
+
+	skt->socket.pci_irq = platform_get_irq(pdev, 0);
+	if (skt->socket.pci_irq < 0) {
+		ret = skt->socket.pci_irq;
+		goto failed_irq;
+	}
+	driver_data->irqs.irq = skt->socket.pci_irq;
+	driver_data->irqs.flags = IRQF_SHARED;
+	driver_data->irqs.str = skt_name;
+
+	driver_data->clk = clk_get(&pdev->dev, NULL);
+	if (IS_ERR(driver_data->clk)) {
+		ret = PTR_ERR(driver_data->clk);
+		goto failed_clock;
+	}
+
+	skt->res_skt.name = skt_name;
+	skt->ops = &mxc_pcmcia_ops;
+	mxc_pcmcia_setup_resources(skt, soc);
+	ret = soc_pcmcia_add_one(skt);
+	if (ret)
+		goto failed_common;
+
+	platform_set_drvdata(pdev, sinfo);
+
+	/* Core does not setup maps for io when in static mode */
+	map.map = 0;
+	map.start = 0;
+	map.stop = driver_data->soc->windows[IO_WINDOW].size - 1;
+	map.flags = MAP_ACTIVE | MAP_16BIT;
+	map.speed = 0;
+	skt->socket.ops->set_io_map(&skt->socket, &map);
+
+	return 0;
+
+failed_common:
+	clk_put(driver_data->clk);
+failed_clock:
+failed_irq:
+	iounmap(driver_data->regs);
+failed_map_regs:
+	release_mem_region(res->start, resource_size(res));
+failed_request_regs_mem:
+failed_regs_resource:
+	kfree(driver_data);
+failed_alloc:
+	kfree(sinfo);
+
+	return ret;
+}
+
+
+static int __devexit mxc_drv_pcmcia_remove(struct platform_device *pdev)
+{
+	struct skt_dev_info *sinfo = platform_get_drvdata(pdev);
+
+	if (sinfo) {
+		struct soc_pcmcia_socket *skt = &sinfo->skt[0];
+		struct mxc_pcmcia *driver_data = skt->socket.driver_data;
+		struct resource *res;
+
+		soc_pcmcia_remove_one(skt);
+		iounmap(driver_data->regs);
+		clk_put(driver_data->clk);
+
+		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+		if (res)
+			release_mem_region(res->start, resource_size(res));
+		kfree(driver_data);
+	}
+
+	kfree(sinfo);
+	return 0;
+}
+
+
+static int mxc_drv_pcmcia_suspend(struct platform_device *pdev,
+				      pm_message_t state)
+{
+	return pcmcia_socket_dev_suspend(&pdev->dev);
+}
+
+static int mxc_drv_pcmcia_resume(struct platform_device *pdev)
+{
+	return pcmcia_socket_dev_resume(&pdev->dev);
+}
+
+static struct platform_driver mxc_pcmcia_driver = {
+	.driver = {
+		.name = "mxc-pcmcia",
+		.owner	= THIS_MODULE,
+	},
+	.probe = mxc_drv_pcmcia_probe,
+	.remove = mxc_drv_pcmcia_remove,
+	.suspend = mxc_drv_pcmcia_suspend,
+	.resume = mxc_drv_pcmcia_resume,
+};
+
+static int __init mxc_pcmcia_init(void)
+{
+	return platform_driver_register(&mxc_pcmcia_driver);
+}
+
+static void __exit mxc_pcmcia_exit(void)
+{
+	platform_driver_unregister(&mxc_pcmcia_driver);
+}
+
+fs_initcall(mxc_pcmcia_init);
+module_exit(mxc_pcmcia_exit);
+
+MODULE_AUTHOR("Martin Fuzzey");
+MODULE_DESCRIPTION("MXC PCMCIA Socket Controller");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:mxc-pcmcia");
+
