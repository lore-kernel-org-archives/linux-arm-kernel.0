From: michal.simek@xilinx.com (Michal Simek)
Date: Thu, 23 Jan 2014 16:06:33 +0100
Subject: [PATCH v2] tty: uartps: Initialize ports according to aliases
Message-ID: <225c74aa791dc09c72267f6718323cbcc36fef95.1390489583.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Register port numbers according to order in DT aliases.
If aliases are not defined, order in DT is used.
If aliases are defined, register port id based
on that.
This patch ensures proper ttyPS0/1 assignment.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---
This patch should by applied on the top of:
http://www.spinics.net/lists/arm-kernel/msg302143.html
http://www.spinics.net/lists/arm-kernel/msg302144.html

Changes in v2:
- Fix my fault by sending incorrect version

 drivers/tty/serial/xilinx_uartps.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index 528f16a..d8f46e8 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -1031,17 +1031,21 @@ static struct uart_port xuartps_port[2];
  * xuartps_get_port - Configure the port from the platform device resource
  *			info
  *
+ * @id: Port id
+ *
  * Return: a pointer to a uart_port or NULL for failure
  */
-static struct uart_port *xuartps_get_port(void)
+static struct uart_port *xuartps_get_port(int id)
 {
 	struct uart_port *port;
-	int id;

-	/* Find the next unused port */
-	for (id = 0; id < XUARTPS_NR_PORTS; id++)
-		if (xuartps_port[id].mapbase == 0)
-			break;
+	/* Try the given port id if failed use default method */
+	if (xuartps_port[id].mapbase != 0) {
+		/* Find the next unused port */
+		for (id = 0; id < XUARTPS_NR_PORTS; id++)
+			if (xuartps_port[id].mapbase == 0)
+				break;
+	}

 	if (id >= XUARTPS_NR_PORTS)
 		return NULL;
@@ -1333,6 +1337,7 @@ static int xuartps_probe(struct platform_device *pdev)
 	struct uart_port *port;
 	struct resource *res, *res2;
 	struct xuartps *xuartps_data;
+	int id;

 	xuartps_data = devm_kzalloc(&pdev->dev, sizeof(*xuartps_data),
 			GFP_KERNEL);
@@ -1380,9 +1385,15 @@ static int xuartps_probe(struct platform_device *pdev)
 				&xuartps_data->clk_rate_change_nb))
 		dev_warn(&pdev->dev, "Unable to register clock notifier.\n");
 #endif
+	/* Look for a serialN alias */
+	id = of_alias_get_id(pdev->dev.of_node, "serial");
+	if (id < 0) {
+		dev_warn(&pdev->dev, "failed to get alias id, errno %d\n", id);
+		id = 0;
+	}

 	/* Initialize the port structure */
-	port = xuartps_get_port();
+	port = xuartps_get_port(id);

 	if (!port) {
 		dev_err(&pdev->dev, "Cannot get uart_port structure\n");
--
1.8.2.3

-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140123/992b4901/attachment.sig>
