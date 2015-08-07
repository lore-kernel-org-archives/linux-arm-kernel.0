From: jbe@pengutronix.de (Juergen Borleis)
Date: Fri,  7 Aug 2015 12:47:04 +0200
Subject: [PATCH v4 2/2] serial: mxs-auart: keep the AUART unit in reset state
 when not in use
In-Reply-To: <1438944424-9053-1-git-send-email-jbe@pengutronix.de>
References: <1438944424-9053-1-git-send-email-jbe@pengutronix.de>
Message-ID: <1438944424-9053-2-git-send-email-jbe@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Whenever the UART device driver gets closed from userland, the driver
disables the UART unit and then stops the clocks to save power.

The bit which disabled the UART unit is described as:

?"UART Enable. If this bit is set to 1, the UART is enabled. Data
  transmission and reception occurs for the UART signals. When the
  UART is disabled in the middle of transmission or reception, it
  completes the current character before stopping."

The important part is the "it completes the current character". Whenever
a reception is ongoing when the UART gets disabled (including the clock
off) the statemachine freezes and "remembers" this state on the next
open() when re-enabling the unit's clock.

In this case we end up receiving an additional bogus character
immediately.

The solution in this change is to switch the AUART unit into its reset
state on close() and only release it from its reset state on the next
open().

Note: when the unit is also used as system console it is always 'in use',
so we cannot reset it on close().

Signed-off-by: Juergen Borleis <jbe@pengutronix.de>
---
 drivers/tty/serial/mxs-auart.c | 46 +++++++++++++++++++++++++++++++++++-------
 1 file changed, 39 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
index 7dc87a9..8d1cd15 100644
--- a/drivers/tty/serial/mxs-auart.c
+++ b/drivers/tty/serial/mxs-auart.c
@@ -858,6 +858,30 @@ static void mxs_auart_reset_deassert(struct uart_port *u)
 	writel(AUART_CTRL0_CLKGATE, u->membase + AUART_CTRL0_CLR);
 }
 
+static void mxs_auart_reset_assert(struct uart_port *u)
+{
+	int i;
+	u32 reg;
+
+	reg = readl(u->membase + AUART_CTRL0);
+	/* if already in reset state, keep it untouched */
+	if (reg & AUART_CTRL0_SFTRST)
+		return;
+
+	writel(AUART_CTRL0_CLKGATE, u->membase + AUART_CTRL0_CLR);
+	writel(AUART_CTRL0_SFTRST, u->membase + AUART_CTRL0_SET);
+
+	for (i = 0; i < 1000; i++) {
+		reg = readl(u->membase + AUART_CTRL0);
+		/* reset is finished when the clock is gated */
+		if (reg & AUART_CTRL0_CLKGATE)
+			return;
+		udelay(10);
+	}
+
+	dev_err(u->dev, "Failed to reset the unit.");
+}
+
 static int mxs_auart_startup(struct uart_port *u)
 {
 	int ret;
@@ -867,7 +891,13 @@ static int mxs_auart_startup(struct uart_port *u)
 	if (ret)
 		return ret;
 
-	writel(AUART_CTRL0_CLKGATE, u->membase + AUART_CTRL0_CLR);
+	if (uart_console(u)) {
+		writel(AUART_CTRL0_CLKGATE, u->membase + AUART_CTRL0_CLR);
+	} else {
+		/* reset the unit to a well known state */
+		mxs_auart_reset_assert(u);
+		mxs_auart_reset_deassert(u);
+	}
 
 	writel(AUART_CTRL2_UARTEN, u->membase + AUART_CTRL2_SET);
 
@@ -899,12 +929,14 @@ static void mxs_auart_shutdown(struct uart_port *u)
 	if (auart_dma_enabled(s))
 		mxs_auart_dma_exit(s);
 
-	writel(AUART_CTRL2_UARTEN, u->membase + AUART_CTRL2_CLR);
-
-	writel(AUART_INTR_RXIEN | AUART_INTR_RTIEN | AUART_INTR_CTSMIEN,
-			u->membase + AUART_INTR_CLR);
-
-	writel(AUART_CTRL0_CLKGATE, u->membase + AUART_CTRL0_SET);
+	if (uart_console(u)) {
+		writel(AUART_CTRL2_UARTEN, u->membase + AUART_CTRL2_CLR);
+		writel(AUART_INTR_RXIEN | AUART_INTR_RTIEN | AUART_INTR_CTSMIEN,
+				u->membase + AUART_INTR_CLR);
+		writel(AUART_CTRL0_CLKGATE, u->membase + AUART_CTRL0_SET);
+	} else {
+		mxs_auart_reset_assert(u);
+	}
 
 	clk_disable_unprepare(s->clk);
 }
-- 
2.4.6
