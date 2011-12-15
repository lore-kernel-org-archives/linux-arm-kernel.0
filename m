From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Thu, 15 Dec 2011 09:16:34 +0100
Subject: [PATCH] serial/imx: let probing fail for the dt case without a valid
 alias
In-Reply-To: <20111215021046.GD3259@S2101-09.ap.freescale.net>
References: <20111215021046.GD3259@S2101-09.ap.freescale.net>
Message-ID: <1323936994-2250-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When the uart device is instantiated by dt but dt doesn't provide an
alias then better let probing fail instead of falling back to an
unrelated device id used for the line number and no platform data.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 drivers/tty/serial/imx.c |   13 ++++++++++---
 1 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 75c159a..1c94218 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -1287,6 +1287,10 @@ static int serial_imx_resume(struct platform_device *dev)
 }
 
 #ifdef CONFIG_OF
+/*
+ * This function returns 1 iff pdev isn't a device instatiated by dt, 0 iff it
+ * could successfully get all information from dt or a negative errno.
+ */
 static int serial_imx_probe_dt(struct imx_port *sport,
 		struct platform_device *pdev)
 {
@@ -1296,7 +1300,8 @@ static int serial_imx_probe_dt(struct imx_port *sport,
 	int ret;
 
 	if (!np)
-		return -ENODEV;
+		/* no device tree device */
+		return 1;
 
 	ret = of_alias_get_id(np, "serial");
 	if (ret < 0) {
@@ -1319,7 +1324,7 @@ static int serial_imx_probe_dt(struct imx_port *sport,
 static inline int serial_imx_probe_dt(struct imx_port *sport,
 		struct platform_device *pdev)
 {
-	return -ENODEV;
+	return 1;
 }
 #endif
 
@@ -1354,8 +1359,10 @@ static int serial_imx_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	ret = serial_imx_probe_dt(sport, pdev);
-	if (ret == -ENODEV)
+	if (ret > 0)
 		serial_imx_probe_pdata(sport, pdev);
+	else if (ret < 0)
+		goto free;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res) {
-- 
1.7.7.3
