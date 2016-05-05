From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 05 May 2016 14:34:14 +0200
Subject: [RFC v2 01/13] usb: misc: usb3503: Clean up on driver unbind
In-Reply-To: <1462451666-17945-1-git-send-email-k.kozlowski@samsung.com>
References: <1462451666-17945-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1462451666-17945-2-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The driver should clean up after itself by unpreparing the clock when it
is unbound.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 drivers/usb/misc/usb3503.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/usb/misc/usb3503.c b/drivers/usb/misc/usb3503.c
index b45cb77c0744..a464636675a6 100644
--- a/drivers/usb/misc/usb3503.c
+++ b/drivers/usb/misc/usb3503.c
@@ -330,6 +330,19 @@ static int usb3503_i2c_probe(struct i2c_client *i2c,
 	return usb3503_probe(hub);
 }
 
+static int usb3503_i2c_remove(struct i2c_client *i2c)
+{
+	struct usb3503 *hub;
+
+	hub = i2c_get_clientdata(i2c);
+	if (hub) {
+		if (hub->clk)
+			clk_disable_unprepare(hub->clk);
+	}
+
+	return 0;
+}
+
 static int usb3503_platform_probe(struct platform_device *pdev)
 {
 	struct usb3503 *hub;
@@ -342,6 +355,19 @@ static int usb3503_platform_probe(struct platform_device *pdev)
 	return usb3503_probe(hub);
 }
 
+static int usb3503_platform_remove(struct platform_device *pdev)
+{
+	struct usb3503 *hub;
+
+	hub = platform_get_drvdata(pdev);
+	if (hub) {
+		if (hub->clk)
+			clk_disable_unprepare(hub->clk);
+	}
+
+	return 0;
+}
+
 #ifdef CONFIG_PM_SLEEP
 static int usb3503_i2c_suspend(struct device *dev)
 {
@@ -395,6 +421,7 @@ static struct i2c_driver usb3503_i2c_driver = {
 		.of_match_table = of_match_ptr(usb3503_of_match),
 	},
 	.probe		= usb3503_i2c_probe,
+	.remove		= usb3503_i2c_remove,
 	.id_table	= usb3503_id,
 };
 
@@ -404,6 +431,7 @@ static struct platform_driver usb3503_platform_driver = {
 		.of_match_table = of_match_ptr(usb3503_of_match),
 	},
 	.probe		= usb3503_platform_probe,
+	.remove		= usb3503_platform_remove,
 };
 
 static int __init usb3503_init(void)
-- 
1.9.1
