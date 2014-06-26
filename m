From: t.figa@samsung.com (Tomasz Figa)
Date: Thu, 26 Jun 2014 13:24:34 +0200
Subject: [PATCH 2/3] serial: samsung: Consider DT alias when probing ports
In-Reply-To: <1403781875-5425-1-git-send-email-t.figa@samsung.com>
References: <1403781875-5425-1-git-send-email-t.figa@samsung.com>
Message-ID: <1403781875-5425-3-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Current driver code relies on probe order of particular samsung-uart
instances, which makes it impossible to get proper initialization of
ports when not all ports are available on board, not even saying of
deterministic device naming.

This patch fixes this on DT-enabled systems by using DT aliases for
ports as instance ID, if specified, or falling back to legacy method
otherwise to provide backwards compatibility.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
---
 drivers/tty/serial/samsung.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.c
index c1d3ebd..a9bf024 100644
--- a/drivers/tty/serial/samsung.c
+++ b/drivers/tty/serial/samsung.c
@@ -1275,11 +1275,18 @@ static inline struct s3c24xx_serial_drv_data *s3c24xx_get_driver_data(
 static int s3c24xx_serial_probe(struct platform_device *pdev)
 {
 	struct s3c24xx_uart_port *ourport;
+	int index = probe_index;
 	int ret;
 
-	dbg("s3c24xx_serial_probe(%p) %d\n", pdev, probe_index);
+	if (pdev->dev.of_node) {
+		ret = of_alias_get_id(pdev->dev.of_node, "serial");
+		if (ret >= 0)
+			index = ret;
+	}
+
+	dbg("s3c24xx_serial_probe(%p) %d\n", pdev, index);
 
-	ourport = &s3c24xx_serial_ports[probe_index];
+	ourport = &s3c24xx_serial_ports[index];
 
 	ourport->drv_data = s3c24xx_get_driver_data(pdev);
 	if (!ourport->drv_data) {
@@ -1295,7 +1302,7 @@ static int s3c24xx_serial_probe(struct platform_device *pdev)
 
 	ourport->port.fifosize = (ourport->info->fifosize) ?
 		ourport->info->fifosize :
-		ourport->drv_data->fifosize[probe_index];
+		ourport->drv_data->fifosize[index];
 
 	probe_index++;
 
-- 
1.9.3
