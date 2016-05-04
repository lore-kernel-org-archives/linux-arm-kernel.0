From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Wed,  4 May 2016 11:43:16 +0200
Subject: [PATCH v2 1/3] video: fbdev: imxfb: fix semantic of .get_power and
 .set_power
In-Reply-To: <1462354998-5792-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1462354998-5792-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1462354998-5792-2-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

.set_power gets passed an FB_BLANK_XXX value, not a bool. So 0 signals
on; and >1 means off. The same applies for return values of .get_power.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---

Changes since (implicit) v1, sent with
Message-Id: 1457380425-20244-2-git-send-email-u.kleine-koenig at pengutronix.de

 - Make it explicit that we're working on FB_BLANK_XXX values,
   suggested by Philipp Zabel.

 drivers/video/fbdev/imxfb.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/video/fbdev/imxfb.c b/drivers/video/fbdev/imxfb.c
index 76b6a7784b06..6d402c1a0f2b 100644
--- a/drivers/video/fbdev/imxfb.c
+++ b/drivers/video/fbdev/imxfb.c
@@ -758,10 +758,11 @@ static int imxfb_lcd_get_power(struct lcd_device *lcddev)
 {
 	struct imxfb_info *fbi = dev_get_drvdata(&lcddev->dev);
 
-	if (!IS_ERR(fbi->lcd_pwr))
-		return regulator_is_enabled(fbi->lcd_pwr);
+	if (!IS_ERR(fbi->lcd_pwr) &&
+	    !regulator_is_enabled(fbi->lcd_pwr))
+		return FB_BLANK_POWERDOWN;
 
-	return 1;
+	return FB_BLANK_UNBLANK;
 }
 
 static int imxfb_lcd_set_power(struct lcd_device *lcddev, int power)
@@ -769,7 +770,7 @@ static int imxfb_lcd_set_power(struct lcd_device *lcddev, int power)
 	struct imxfb_info *fbi = dev_get_drvdata(&lcddev->dev);
 
 	if (!IS_ERR(fbi->lcd_pwr)) {
-		if (power)
+		if (power == FB_BLANK_UNBLANK)
 			return regulator_enable(fbi->lcd_pwr);
 		else
 			return regulator_disable(fbi->lcd_pwr);
-- 
2.8.0.rc3
