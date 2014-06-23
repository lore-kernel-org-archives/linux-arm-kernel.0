From: denis@eukrea.com (Denis Carikli)
Date: Mon, 23 Jun 2014 15:07:18 +0200
Subject: [PATCH v2 1/2] video: imxfb: Fix unbalanced regulators
Message-ID: <1403528839-31901-1-git-send-email-denis@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Both regulator_enable and regulator_disable's comments
say that they must be balanced with its counterpart
enable/disable function.

Not doing it result in kernel warnings each time
the lcd is powered off twice, for instance trough sysfs.

Signed-off-by: Denis Carikli <denis@eukrea.com>
---
Changelog v1->v2:
 - None
---
 drivers/video/fbdev/imxfb.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/imxfb.c b/drivers/video/fbdev/imxfb.c
index f6e6216..121cbd7 100644
--- a/drivers/video/fbdev/imxfb.c
+++ b/drivers/video/fbdev/imxfb.c
@@ -769,9 +769,9 @@ static int imxfb_lcd_set_power(struct lcd_device *lcddev, int power)
 	struct imxfb_info *fbi = dev_get_drvdata(&lcddev->dev);
 
 	if (!IS_ERR(fbi->lcd_pwr)) {
-		if (power)
+		if (power && !regulator_is_enabled(fbi->lcd_pwr))
 			return regulator_enable(fbi->lcd_pwr);
-		else
+		else if (regulator_is_enabled(fbi->lcd_pwr))
 			return regulator_disable(fbi->lcd_pwr);
 	}
 
-- 
1.7.9.5
