From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 17 Feb 2014 10:05:36 +0100
Subject: [PATCH v3 01/15] extcon: max14577: Change extcon name instead of
 static name according to device type
In-Reply-To: <1392627950-26927-1-git-send-email-k.kozlowski@samsung.com>
References: <1392627950-26927-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1392627950-26927-2-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Chanwoo Choi <cw00.choi@samsung.com>

This patch use device name to make sysfs path according to device type:

max14577-muic
- /sys/class/extcon/max14577-muic/
max77836-muic
- /sys/class/extcon/max77836-muic/

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
Tested-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/extcon/extcon-max14577.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/extcon/extcon-max14577.c b/drivers/extcon/extcon-max14577.c
index 3846941801b8..59f084fee4f3 100644
--- a/drivers/extcon/extcon-max14577.c
+++ b/drivers/extcon/extcon-max14577.c
@@ -24,7 +24,6 @@
 #include <linux/mfd/max14577-private.h>
 #include <linux/extcon.h>
 
-#define	DEV_NAME			"max14577-muic"
 #define	DELAY_MS_DEFAULT		17000		/* unit: millisecond */
 
 enum max14577_muic_adc_debounce_time {
@@ -673,7 +672,8 @@ static int max14577_muic_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "failed to allocate memory for extcon\n");
 		return -ENOMEM;
 	}
-	info->edev->name = DEV_NAME;
+
+	info->edev->name = dev_name(&pdev->dev);
 	info->edev->supported_cable = max14577_extcon_cable;
 	ret = extcon_dev_register(info->edev);
 	if (ret) {
@@ -737,7 +737,7 @@ static int max14577_muic_remove(struct platform_device *pdev)
 
 static struct platform_driver max14577_muic_driver = {
 	.driver		= {
-		.name	= DEV_NAME,
+		.name	= "max14577-muic",
 		.owner	= THIS_MODULE,
 	},
 	.probe		= max14577_muic_probe,
-- 
1.7.9.5
