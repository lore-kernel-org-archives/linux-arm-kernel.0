From: gsi@denx.de (Gerhard Sittig)
Date: Tue,  6 Aug 2013 22:44:01 +0200
Subject: [PATCH v4 21/31] serial: mpc512x: switch to CCF names in clock lookup
In-Reply-To: <1375821851-31609-1-git-send-email-gsi@denx.de>
References: <1374495298-22019-1-git-send-email-gsi@denx.de>
 <1375821851-31609-1-git-send-email-gsi@denx.de>
Message-ID: <1375821851-31609-22-git-send-email-gsi@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

after device tree based clock lookup became available, the peripheral
driver need no longer construct clock names which include the PSC index,
remove the "psc%d_mclk" template and unconditionally use 'mclk'

acquire and release the 'ipg' clock for register access as well

Signed-off-by: Gerhard Sittig <gsi@denx.de>
---
 drivers/tty/serial/mpc52xx_uart.c |   45 ++++++++++++++++++++++++++++++++-----
 1 file changed, 40 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/mpc52xx_uart.c b/drivers/tty/serial/mpc52xx_uart.c
index 5be1df3..f4d2b70 100644
--- a/drivers/tty/serial/mpc52xx_uart.c
+++ b/drivers/tty/serial/mpc52xx_uart.c
@@ -618,30 +618,58 @@ static irqreturn_t mpc512x_psc_handle_irq(struct uart_port *port)
 	return IRQ_NONE;
 }
 
+static struct clk *psc_ipg_clk[MPC52xx_PSC_MAXNUM];
 static struct clk *psc_mclk_clk[MPC52xx_PSC_MAXNUM];
 
 /* called from within the .request_port() callback (allocation) */
 static int mpc512x_psc_alloc_clock(struct uart_port *port)
 {
 	int psc_num;
-	char clk_name[16];
 	struct clk *clk;
 	int err;
 
 	psc_num = (port->mapbase & 0xf00) >> 8;
-	snprintf(clk_name, sizeof(clk_name), "psc%d_mclk", psc_num);
-	clk = devm_clk_get(port->dev, clk_name);
+
+	clk = devm_clk_get(port->dev, "ipg");
+	if (IS_ERR(clk)) {
+		dev_err(port->dev, "Failed to get IPG clock!\n");
+		err = PTR_ERR(clk);
+		goto out_err;
+	}
+	err = clk_prepare_enable(clk);
+	if (err) {
+		dev_err(port->dev, "Failed to enable IPG clock!\n");
+		goto out_err;
+	}
+	psc_ipg_clk[psc_num] = clk;
+
+	clk = devm_clk_get(port->dev, "mclk");
 	if (IS_ERR(clk)) {
 		dev_err(port->dev, "Failed to get MCLK!\n");
-		return PTR_ERR(clk);
+		err = PTR_ERR(clk);
+		goto out_err;
 	}
 	err = clk_prepare_enable(clk);
 	if (err) {
 		dev_err(port->dev, "Failed to enable MCLK!\n");
-		return err;
+		goto out_err;
 	}
 	psc_mclk_clk[psc_num] = clk;
+
 	return 0;
+
+out_err:
+	clk = psc_mclk_clk[psc_num];
+	if (clk) {
+		clk_disable_unprepare(clk);
+		psc_mclk_clk[psc_num] = NULL;
+	}
+	clk = psc_ipg_clk[psc_num];
+	if (clk) {
+		clk_disable_unprepare(clk);
+		psc_ipg_clk[psc_num] = NULL;
+	}
+	return err;
 }
 
 /* called from within the .release_port() callback (release) */
@@ -651,11 +679,18 @@ static void mpc512x_psc_relse_clock(struct uart_port *port)
 	struct clk *clk;
 
 	psc_num = (port->mapbase & 0xf00) >> 8;
+
 	clk = psc_mclk_clk[psc_num];
 	if (clk) {
 		clk_disable_unprepare(clk);
 		psc_mclk_clk[psc_num] = NULL;
 	}
+
+	clk = psc_ipg_clk[psc_num];
+	if (clk) {
+		clk_disable_unprepare(clk);
+		psc_ipg_clk[psc_num] = NULL;
+	}
 }
 
 /* implementation of the .clock() callback (enable/disable) */
-- 
1.7.10.4
