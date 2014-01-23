From: michal.simek@xilinx.com (Michal Simek)
Date: Thu, 23 Jan 2014 15:45:14 +0100
Subject: [PATCH] tty: uartps: Initialize ports according to aliases
Message-ID: <c1882ea5f2e45b19cc1930b624254cb1b59b2fe0.1390488303.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Register port numbers according to order in DT aliases.
If aliases are not defined, order in DT is used.
If aliases are defined, register port id based
on that.
This patch ensures proper ttyPS0/1 assignment.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 drivers/tty/serial/xilinx_uartps.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index 528f16a..8c09a3b 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -1038,10 +1038,20 @@ static struct uart_port *xuartps_get_port(void)
 	struct uart_port *port;
 	int id;

-	/* Find the next unused port */
-	for (id = 0; id < XUARTPS_NR_PORTS; id++)
-		if (xuartps_port[id].mapbase == 0)
-			break;
+	/* Look for a serialN alias */
+	id = of_alias_get_id(pdev->dev.of_node, "serial");
+	if (id < 0) {
+		dev_warn(&pdev->dev, "failed to get alias id, errno %d\n", id);
+		id = 0;
+	}
+
+	/* Try the given port id if failed use default method */
+	if (xuartps_port[id].mapbase != 0) {
+		/* Find the next unused port */
+		for (id = 0; id < XUARTPS_NR_PORTS; id++)
+			if (xuartps_port[id].mapbase == 0)
+				break;
+	}

 	if (id >= XUARTPS_NR_PORTS)
 		return NULL;
--
1.8.2.3

-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140123/45598a8d/attachment.sig>
