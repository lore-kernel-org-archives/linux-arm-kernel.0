From: denis@eukrea.com (Denis Carikli)
Date: Tue, 17 Jun 2014 12:46:39 +0200
Subject: [PATCH 3/3] video: imxfb: Fix lcd_ops .set_power on/off inversion
In-Reply-To: <1403001999-12316-1-git-send-email-denis@eukrea.com>
References: <1403001999-12316-1-git-send-email-denis@eukrea.com>
Message-ID: <1403001999-12316-3-git-send-email-denis@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

.set_power takes the blank level as argument instead
of an on/off parameter:
fb_blank calls fb_notifier_call_chain with the blank
level encoded in its parameters, which is then sent
as-is to the set_power callback.

imxfb_lcd_set_power was expecting an on/off parameter
instead.
This resulted in the inversion of the on/off behaviour.

Signed-off-by: Denis Carikli <denis@eukrea.com>
---
 drivers/video/fbdev/imxfb.c |   20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/video/fbdev/imxfb.c b/drivers/video/fbdev/imxfb.c
index 121cbd7..2ffbd5e 100644
--- a/drivers/video/fbdev/imxfb.c
+++ b/drivers/video/fbdev/imxfb.c
@@ -764,15 +764,25 @@ static int imxfb_lcd_get_power(struct lcd_device *lcddev)
 	return 1;
 }
 
-static int imxfb_lcd_set_power(struct lcd_device *lcddev, int power)
+static int imxfb_lcd_set_power(struct lcd_device *lcddev, int blank)
 {
 	struct imxfb_info *fbi = dev_get_drvdata(&lcddev->dev);
 
 	if (!IS_ERR(fbi->lcd_pwr)) {
-		if (power && !regulator_is_enabled(fbi->lcd_pwr))
-			return regulator_enable(fbi->lcd_pwr);
-		else if (regulator_is_enabled(fbi->lcd_pwr))
-			return regulator_disable(fbi->lcd_pwr);
+		switch (blank) {
+		case FB_BLANK_VSYNC_SUSPEND:
+		case FB_BLANK_HSYNC_SUSPEND:
+		case FB_BLANK_NORMAL:
+		case FB_BLANK_POWERDOWN:
+			if (regulator_is_enabled(fbi->lcd_pwr))
+				return regulator_disable(fbi->lcd_pwr);
+			break;
+
+		case FB_BLANK_UNBLANK:
+			if (!regulator_is_enabled(fbi->lcd_pwr))
+				return regulator_enable(fbi->lcd_pwr);
+			break;
+		}
 	}
 
 	return 0;
-- 
1.7.9.5
