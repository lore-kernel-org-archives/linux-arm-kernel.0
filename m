From: ch.naveen@samsung.com (Naveen Krishna Chatradhi)
Date: Mon, 14 Jul 2014 17:07:18 +0530
Subject: [PATCH 3/3] serial: samsung: improve code clarity by defining a
 variable
In-Reply-To: <1405337838-30335-1-git-send-email-ch.naveen@samsung.com>
References: <1405337838-30335-1-git-send-email-ch.naveen@samsung.com>
Message-ID: <1405337838-30335-4-git-send-email-ch.naveen@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The of_node is derived from pdev for every usage, define a
device_node variable instead.

Signed-off-by: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
Cc: gregkh at linuxfoundation.org
---
 drivers/tty/serial/samsung.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.c
index d98f93d..4aff02d 100644
--- a/drivers/tty/serial/samsung.c
+++ b/drivers/tty/serial/samsung.c
@@ -1269,12 +1269,13 @@ static inline struct s3c24xx_serial_drv_data *s3c24xx_get_driver_data(
 
 static int s3c24xx_serial_probe(struct platform_device *pdev)
 {
+	struct device_node *np = pdev->dev.of_node;
 	struct s3c24xx_uart_port *ourport;
 	int index = probe_index;
 	int ret;
 
-	if (pdev->dev.of_node) {
-		ret = of_alias_get_id(pdev->dev.of_node, "serial");
+	if (np) {
+		ret = of_alias_get_id(np, "serial");
 		if (ret >= 0)
 			index = ret;
 	}
@@ -1295,8 +1296,8 @@ static int s3c24xx_serial_probe(struct platform_device *pdev)
 			dev_get_platdata(&pdev->dev) :
 			ourport->drv_data->def_cfg;
 
-	if (pdev->dev.of_node)
-		of_property_read_u32(pdev->dev.of_node,
+	if (np)
+		of_property_read_u32(np,
 			"samsung,uart-fifosize", &ourport->port.fifosize);
 
 	if (!ourport->port.fifosize) {
-- 
1.7.9.5
