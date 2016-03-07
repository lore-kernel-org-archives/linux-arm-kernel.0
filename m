From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Mon,  7 Mar 2016 20:53:44 +0100
Subject: [PATCH 2/3] video: fbdev: imxfb: enable lcd regulator in .probe
In-Reply-To: <1457380425-20244-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1457380425-20244-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1457380425-20244-3-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This asserts that the display is on after the driver is initialized.
Otherwise, depending on how the boot loader handled the display, it is
either disabled as the regulator doesn't seem in use, or it stays off.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 drivers/video/fbdev/imxfb.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/video/fbdev/imxfb.c b/drivers/video/fbdev/imxfb.c
index c5fcedde2a60..3dd2824e6773 100644
--- a/drivers/video/fbdev/imxfb.c
+++ b/drivers/video/fbdev/imxfb.c
@@ -979,8 +979,17 @@ static int imxfb_probe(struct platform_device *pdev)
 	imxfb_enable_controller(fbi);
 	fbi->pdev = pdev;
 
+	if (!IS_ERR(fbi->lcd_pwr)) {
+		ret = regulator_enable(fbi->lcd_pwr);
+		if (ret)
+			goto failed_regulator;
+	}
+
 	return 0;
 
+failed_regulator:
+	imxfb_disable_controller(fbi);
+
 failed_lcd:
 	unregister_framebuffer(info);
 
-- 
2.7.0
