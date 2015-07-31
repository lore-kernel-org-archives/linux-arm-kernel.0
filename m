From: david@protonic.nl (David Jander)
Date: Fri, 31 Jul 2015 13:59:13 +0200
Subject: [PATCH V3] tty: serial: imx.c: Reset UART before activating interrupts
Message-ID: <1438343953-31679-1-git-send-email-david@protonic.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If the UART has been in use before this driver was loaded, IRQs might be
active and get fired as soon as we set the handler, which will crash
in the spin_lock_irqsave(&sport->port.lock, flags) because port.lock is
not initialized until the port is added at the end of probe.

Signed-off-by: David Jander <david@protonic.nl>
---

Changes from V2:
 - Also enable clk_ipg since it is not entirely clear if it is needed or not.

Changes from V1:
 - Enable peripheral clock before attempting reset.

 drivers/tty/serial/imx.c | 42 +++++++++++++++++++++++++++++++++---------
 1 file changed, 33 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 54fdc78..1eebc44 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -1093,10 +1093,23 @@ static void imx_disable_dma(struct imx_port *sport)
 /* half the RX buffer size */
 #define CTSTL 16
 
+static inline void imx_reset(struct imx_port *sport)
+{
+	int i = 100;
+	unsigned long temp;
+
+	temp = readl(sport->port.membase + UCR2);
+	temp &= ~UCR2_SRST;
+	writel(temp, sport->port.membase + UCR2);
+
+	while (!(readl(sport->port.membase + UCR2) & UCR2_SRST) && (--i > 0))
+		udelay(1);
+}
+
 static int imx_startup(struct uart_port *port)
 {
 	struct imx_port *sport = (struct imx_port *)port;
-	int retval, i;
+	int retval;
 	unsigned long flags, temp;
 
 	retval = clk_prepare_enable(sport->clk_per);
@@ -1123,14 +1136,7 @@ static int imx_startup(struct uart_port *port)
 
 	spin_lock_irqsave(&sport->port.lock, flags);
 	/* Reset fifo's and state machines */
-	i = 100;
-
-	temp = readl(sport->port.membase + UCR2);
-	temp &= ~UCR2_SRST;
-	writel(temp, sport->port.membase + UCR2);
-
-	while (!(readl(sport->port.membase + UCR2) & UCR2_SRST) && (--i > 0))
-		udelay(1);
+	imx_reset(sport);
 
 	/*
 	 * Finally, clear and enable interrupts
@@ -1957,6 +1963,24 @@ static int serial_imx_probe(struct platform_device *pdev)
 	sport->port.uartclk = clk_get_rate(sport->clk_per);
 
 	/*
+	 * Perform a complete reset of the UART device. Needed if we don't
+	 * come straight out of reset.
+	 */
+	ret = clk_prepare_enable(sport->clk_per);
+	if (ret)
+		return ret;
+	ret = clk_prepare_enable(sport->clk_ipg);
+	if (ret) {
+		clk_disable_unprepare(sport->clk_per);
+		return ret;
+	}
+	writel(0, sport->port.membase + UCR2);
+	writel(0, sport->port.membase + UCR1);
+	imx_reset(sport);
+	clk_disable_unprepare(sport->clk_ipg);
+	clk_disable_unprepare(sport->clk_per);
+
+	/*
 	 * Allocate the IRQ(s) i.MX1 has three interrupts whereas later
 	 * chips only have one interrupt.
 	 */
-- 
2.1.4
