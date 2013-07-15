From: gsi@denx.de (Gerhard Sittig)
Date: Mon, 15 Jul 2013 23:46:01 +0200
Subject: [PATCH v1 15/24] serial: mpc512x: OF clock lookup, use the 'mclk' name
In-Reply-To: <1373914074-20889-1-git-send-email-gsi@denx.de>
References: <1373914074-20889-1-git-send-email-gsi@denx.de>
Message-ID: <1373924770-22599-1-git-send-email-gsi@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

with device tree based clock lookup, the MCLK name no longer
depends on the PSC index

Signed-off-by: Gerhard Sittig <gsi@denx.de>
---
 drivers/tty/serial/mpc52xx_uart.c |    8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/mpc52xx_uart.c b/drivers/tty/serial/mpc52xx_uart.c
index 53c1093..221fb89 100644
--- a/drivers/tty/serial/mpc52xx_uart.c
+++ b/drivers/tty/serial/mpc52xx_uart.c
@@ -619,21 +619,17 @@ static irqreturn_t mpc512x_psc_handle_irq(struct uart_port *port)
 static int mpc512x_psc_clock(struct uart_port *port, int enable)
 {
 	struct clk *psc_clk;
-	int psc_num;
-	char clk_name[10];
 
 	if (uart_console(port))
 		return 0;
 
-	psc_num = (port->mapbase & 0xf00) >> 8;
-	snprintf(clk_name, sizeof(clk_name), "psc%d_mclk", psc_num);
-	psc_clk = clk_get(port->dev, clk_name);
+	psc_clk = clk_get(port->dev, "mclk");
 	if (IS_ERR(psc_clk)) {
 		dev_err(port->dev, "Failed to get PSC clock entry!\n");
 		return -ENODEV;
 	}
 
-	dev_dbg(port->dev, "%s %sable\n", clk_name, enable ? "en" : "dis");
+	dev_dbg(port->dev, "mclk %sable\n", enable ? "en" : "dis");
 
 	if (enable)
 		clk_prepare_enable(psc_clk);
-- 
1.7.10.4
