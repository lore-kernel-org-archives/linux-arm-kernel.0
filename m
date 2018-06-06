From: michal.simek@xilinx.com (Michal Simek)
Date: Wed,  6 Jun 2018 14:41:35 +0200
Subject: [RFC PATCH v2 2/6] serial: uartps: Move register to probe based on
 run time detection
In-Reply-To: <cover.1528288895.git.michal.simek@xilinx.com>
References: <cover.1528288895.git.michal.simek@xilinx.com>
Message-ID: <23d27f8b80e1cdad278f272f98e50e5bd8e5cfbb.1528288895.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Find out the highest serial alias and allocate that amount of
structures/minor numbers to be able to handle all of them.
Origin setting that there are two prealocated CDNS_UART_NR_PORTS is kept
there.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

Changes in v2:
- Remove nr field logic

Discussed here: https://patchwork.kernel.org/patch/9738445/

The same solution is done in pl011 driver.

---
 drivers/tty/serial/xilinx_uartps.c | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index 5f116f3ecd4a..e24382f58dea 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -1438,6 +1438,14 @@ static int cdns_uart_probe(struct platform_device *pdev)
 	if (!port)
 		return -ENOMEM;
 
+	if (!cdns_uart_uart_driver.state) {
+		rc = uart_register_driver(&cdns_uart_uart_driver);
+		if (rc < 0) {
+			dev_err(&pdev->dev, "Failed to register driver\n");
+			return rc;
+		}
+	}
+
 	match = of_match_node(cdns_uart_of_match, pdev->dev.of_node);
 	if (match && match->data) {
 		const struct cdns_platform_data *data = match->data;
@@ -1617,28 +1625,14 @@ static int cdns_uart_remove(struct platform_device *pdev)
 
 static int __init cdns_uart_init(void)
 {
-	int retval = 0;
-
-	/* Register the cdns_uart driver with the serial core */
-	retval = uart_register_driver(&cdns_uart_uart_driver);
-	if (retval)
-		return retval;
-
 	/* Register the platform driver */
-	retval = platform_driver_register(&cdns_uart_platform_driver);
-	if (retval)
-		uart_unregister_driver(&cdns_uart_uart_driver);
-
-	return retval;
+	return platform_driver_register(&cdns_uart_platform_driver);
 }
 
 static void __exit cdns_uart_exit(void)
 {
 	/* Unregister the platform driver */
 	platform_driver_unregister(&cdns_uart_platform_driver);
-
-	/* Unregister the cdns_uart driver */
-	uart_unregister_driver(&cdns_uart_uart_driver);
 }
 
 arch_initcall(cdns_uart_init);
-- 
1.9.1
