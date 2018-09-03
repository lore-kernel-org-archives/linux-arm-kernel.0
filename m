From: michal.simek@xilinx.com (Michal Simek)
Date: Mon,  3 Sep 2018 15:10:56 +0200
Subject: [PATCH v3 08/10] serial: uartps: Change logic how console_port is
 setup
In-Reply-To: <cover.1535980253.git.michal.simek@xilinx.com>
References: <cover.1535980253.git.michal.simek@xilinx.com>
Message-ID: <c1bcd6cf73ac60b0ae66cbb3fe859de39ef9df9e.1535980253.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Change logic how console_port is setup by using CON_ENABLED flag
instead of index. There will be unique cdns_uart_console() structures
that's why code can't use id for console_port assignment.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

Changes in v3:
- New patch in series

Changes in v2: None

 drivers/tty/serial/xilinx_uartps.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index 61087233f411..0e578c0a8ce0 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -1532,7 +1532,7 @@ static int cdns_uart_probe(struct platform_device *pdev)
 	 * If register_console() don't assign value, then console_port pointer
 	 * is cleanup.
 	 */
-	if (cdns_uart_uart_driver.cons->index == -1)
+	if (!console_port)
 		console_port = port;
 #endif
 
@@ -1545,7 +1545,8 @@ static int cdns_uart_probe(struct platform_device *pdev)
 
 #ifdef CONFIG_SERIAL_XILINX_PS_UART_CONSOLE
 	/* This is not port which is used for console that's why clean it up */
-	if (cdns_uart_uart_driver.cons->index == -1)
+	if (console_port == port &&
+	    !(cdns_uart_uart_driver.cons->flags & CON_ENABLED))
 		console_port = NULL;
 #endif
 
@@ -1594,6 +1595,12 @@ static int cdns_uart_remove(struct platform_device *pdev)
 	pm_runtime_disable(&pdev->dev);
 	pm_runtime_set_suspended(&pdev->dev);
 	pm_runtime_dont_use_autosuspend(&pdev->dev);
+
+#ifdef CONFIG_SERIAL_XILINX_PS_UART_CONSOLE
+	if (console_port == port)
+		console_port = NULL;
+#endif
+
 	if (!--instances)
 		uart_unregister_driver(cdns_uart_data->cdns_uart_driver);
 	return rc;
-- 
1.9.1
