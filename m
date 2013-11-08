From: denis@eukrea.com (Denis Carikli)
Date: Fri,  8 Nov 2013 17:31:29 +0100
Subject: [PATCHv6][ 1/2] backlight: gpio_backlight: Use a default state enum.
Message-ID: <1383928290-9487-1-git-send-email-denis@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

That enum adds a "keep" state which permits to tell the
  driver trough its platform data not to touch the
  hardware during the probe.

Cc: Richard Purdie <rpurdie@rpsys.net>
Cc: Jingoo Han <jg1.han@samsung.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
Cc: devicetree at vger.kernel.org
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: linux-arm-kernel at lists.infradead.org
Cc: Lothar Wa?mann <LW@KARO-electronics.de>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Eric B?nard <eric@eukrea.com>
Signed-off-by: Denis Carikli <denis@eukrea.com>
---
ChangeLog v5->v6:
- New patch.
---
 drivers/video/backlight/gpio_backlight.c     |    7 +++++--
 include/linux/platform_data/gpio_backlight.h |    6 ++++++
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/video/backlight/gpio_backlight.c b/drivers/video/backlight/gpio_backlight.c
index 81fb127..6ddeba9 100644
--- a/drivers/video/backlight/gpio_backlight.c
+++ b/drivers/video/backlight/gpio_backlight.c
@@ -23,6 +23,7 @@ struct gpio_backlight {
 
 	int gpio;
 	int active;
+	enum gpio_backlight_default_state def_value;
 };
 
 static int gpio_backlight_update_status(struct backlight_device *bl)
@@ -103,8 +104,10 @@ static int gpio_backlight_probe(struct platform_device *pdev)
 		return PTR_ERR(bl);
 	}
 
-	bl->props.brightness = pdata->def_value;
-	backlight_update_status(bl);
+	if (pdata->def_value != BACKLIGHT_GPIO_DEFSTATE_KEEP) {
+		bl->props.brightness = pdata->def_value;
+		backlight_update_status(bl);
+	}
 
 	platform_set_drvdata(pdev, bl);
 	return 0;
diff --git a/include/linux/platform_data/gpio_backlight.h b/include/linux/platform_data/gpio_backlight.h
index 5ae0d9c..3b437b3 100644
--- a/include/linux/platform_data/gpio_backlight.h
+++ b/include/linux/platform_data/gpio_backlight.h
@@ -10,6 +10,12 @@
 
 struct device;
 
+enum gpio_backlight_default_state {
+	BACKLIGHT_GPIO_DEFSTATE_OFF,
+	BACKLIGHT_GPIO_DEFSTATE_ON,
+	BACKLIGHT_GPIO_DEFSTATE_KEEP,
+};
+
 struct gpio_backlight_platform_data {
 	struct device *fbdev;
 	int gpio;
-- 
1.7.9.5
