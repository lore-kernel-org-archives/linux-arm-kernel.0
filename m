From: michal.simek@xilinx.com (Michal Simek)
Date: Mon,  3 Sep 2018 15:10:53 +0200
Subject: [PATCH v3 05/10] serial: uartps: Move alias reading higher in probe()
In-Reply-To: <cover.1535980253.git.michal.simek@xilinx.com>
References: <cover.1535980253.git.michal.simek@xilinx.com>
Message-ID: <56adfce565f2d743d21d80533ce20218514c7466.1535980253.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This cosmetic change is done only for having next patch much easier to
read. Moving id setup higher in probe is not affecting any usage of this
driver and it also simplify error path.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

Changes in v3: None
Changes in v2:
- new patch - it can be sent separately too

 drivers/tty/serial/xilinx_uartps.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index 5bd2b0607df6..a3e97ccb376d 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -1415,6 +1415,16 @@ static int cdns_uart_probe(struct platform_device *pdev)
 	if (!port)
 		return -ENOMEM;
 
+	/* Look for a serialN alias */
+	id = of_alias_get_id(pdev->dev.of_node, "serial");
+	if (id < 0)
+		id = 0;
+
+	if (id >= CDNS_UART_NR_PORTS) {
+		dev_err(&pdev->dev, "Cannot get uart_port structure\n");
+		return -ENODEV;
+	}
+
 	cdns_uart_data->cdns_uart_driver = &cdns_uart_uart_driver;
 
 	match = of_match_node(cdns_uart_of_match, pdev->dev.of_node);
@@ -1476,16 +1486,6 @@ static int cdns_uart_probe(struct platform_device *pdev)
 				&cdns_uart_data->clk_rate_change_nb))
 		dev_warn(&pdev->dev, "Unable to register clock notifier.\n");
 #endif
-	/* Look for a serialN alias */
-	id = of_alias_get_id(pdev->dev.of_node, "serial");
-	if (id < 0)
-		id = 0;
-
-	if (id >= CDNS_UART_NR_PORTS) {
-		dev_err(&pdev->dev, "Cannot get uart_port structure\n");
-		rc = -ENODEV;
-		goto err_out_notif_unreg;
-	}
 
 	/* At this point, we've got an empty uart_port struct, initialize it */
 	spin_lock_init(&port->lock);
@@ -1544,7 +1544,6 @@ static int cdns_uart_probe(struct platform_device *pdev)
 	pm_runtime_disable(&pdev->dev);
 	pm_runtime_set_suspended(&pdev->dev);
 	pm_runtime_dont_use_autosuspend(&pdev->dev);
-err_out_notif_unreg:
 #ifdef CONFIG_COMMON_CLK
 	clk_notifier_unregister(cdns_uart_data->uartclk,
 			&cdns_uart_data->clk_rate_change_nb);
-- 
1.9.1
