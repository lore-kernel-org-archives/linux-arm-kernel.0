From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Thu, 19 Jun 2014 11:38:22 +0100
Subject: [PATCH v4 12/13] serial: imx: clean up imx_poll_get_char()
In-Reply-To: <1403174303-25456-1-git-send-email-daniel.thompson@linaro.org>
References: <1401961994-18033-1-git-send-email-daniel.thompson@linaro.org>
 <1403174303-25456-1-git-send-email-daniel.thompson@linaro.org>
Message-ID: <1403174303-25456-13-git-send-email-daniel.thompson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dirk Behme <dirk.behme@de.bosch.com>

Looking at the get_poll_char() function of the 8250.c serial driver,
we learn:

* poll_get_char() doesn't have to save/disable/restore the interrupt
  registers. No interrupt handling is needed in this function at all.
  Remove it.

* Don't block in case there is no data available. So instead blocking
  in the do {} while loop, just return with NO_POLL_CHAR, immediately .

Additionally, while the i.MX6 register URXD[7-0] contain the RX_DATA,
the upper bits of this register (URXD[15-10]) might contain some
control flags. To ensure that these are not returned with the data
read, just mask out URXD[7-0].

These changes fix the 'hang' working with kdb:

$ echo ttymxc3 > /sys/module/kgdboc/parameters/kgdboc
$ echo g >/proc/sysrq-trigger
[0]kdb> help
...
<hang>

Signed-off-by: Dirk Behme <dirk.behme@de.bosch.com>
Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>
Cc: linux-serial at vger.kernel.org
---
 drivers/tty/serial/imx.c | 29 ++++-------------------------
 1 file changed, 4 insertions(+), 25 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index e2f9387..25ed1d2 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -80,6 +80,7 @@
 #define URXD_FRMERR	(1<<12)
 #define URXD_BRK	(1<<11)
 #define URXD_PRERR	(1<<10)
+#define URXD_RX_DATA	(0xFF<<0)
 #define UCR1_ADEN	(1<<15) /* Auto detect interrupt */
 #define UCR1_ADBR	(1<<14) /* Auto detect baud rate */
 #define UCR1_TRDYEN	(1<<13) /* Transmitter ready interrupt enable */
@@ -1503,32 +1504,10 @@ imx_verify_port(struct uart_port *port, struct serial_struct *ser)
 #if defined(CONFIG_CONSOLE_POLL)
 static int imx_poll_get_char(struct uart_port *port)
 {
-	struct imx_port_ucrs old_ucr;
-	unsigned int status;
-	unsigned char c;
-
-	/* save control registers */
-	imx_port_ucrs_save(port, &old_ucr);
-
-	/* disable interrupts */
-	writel(UCR1_UARTEN, port->membase + UCR1);
-	writel(old_ucr.ucr2 & ~(UCR2_ATEN | UCR2_RTSEN | UCR2_ESCI),
-	       port->membase + UCR2);
-	writel(old_ucr.ucr3 & ~(UCR3_DCD | UCR3_RI | UCR3_DTREN),
-	       port->membase + UCR3);
-
-	/* poll */
-	do {
-		status = readl(port->membase + USR2);
-	} while (~status & USR2_RDR);
-
-	/* read */
-	c = readl(port->membase + URXD0);
-
-	/* restore control registers */
-	imx_port_ucrs_restore(port, &old_ucr);
+	if (!(readl(port->membase + USR2) & USR2_RDR))
+		return NO_POLL_CHAR;
 
-	return c;
+	return readl(port->membase + URXD0) & URXD_RX_DATA;
 }
 
 static void imx_poll_put_char(struct uart_port *port, unsigned char c)
-- 
1.9.3
