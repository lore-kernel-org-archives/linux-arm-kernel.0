From: gheorghiuandru@gmail.com (Alexandru Gheorghiu)
Date: Thu, 14 Mar 2013 11:27:29 +0200
Subject: [PATCH] drivers: gpio: Use devm_ioremap_resource function
Message-ID: <1363253249-3128-1-git-send-email-gheorghiuandru@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the newly introduced devm_ioremap_resource() instead of
devm_request_and_ioremap() which provides more consistent error
handling.

Signed-off-by: Alexandru Gheorghiu <gheorghiuandru@gmail.com>
---
 drivers/gpio/gpio-vt8500.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-vt8500.c b/drivers/gpio/gpio-vt8500.c
index 81683ca..eaed4ac 100644
--- a/drivers/gpio/gpio-vt8500.c
+++ b/drivers/gpio/gpio-vt8500.c
@@ -309,10 +309,10 @@ static int vt8500_gpio_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	gpio_base = devm_request_and_ioremap(&pdev->dev, res);
-	if (!gpio_base) {
+	gpio_base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(gpio_base)) {
 		dev_err(&pdev->dev, "Unable to map GPIO registers\n");
-		return -ENOMEM;
+		return PTR_ERR(gpio_base);
 	}
 
 	ret = vt8500_add_chips(pdev, gpio_base, of_id->data);
-- 
1.7.9.5
