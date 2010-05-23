From: Jiri.Pinkava@vscht.cz (Pinkava J.)
Date: Sun, 23 May 2010 06:42:26 +0200
Subject: [PATCH] s3c24xx fix: freeze during suspend/resume on s3c24xx if some
	GPIO banks not present
Message-ID: <4BF8B232.9020903@vscht.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When saving GPIOs during suspend/resume we need skip missing GPIO banks, not
trying get corresponding chip again and again in infinite loop.

Signed-off-by: Jiri Pinkava <jiri.pinkava@vscht.cz>
---
 arch/arm/plat-samsung/pm-gpio.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-samsung/pm-gpio.c b/arch/arm/plat-samsung/pm-gpio.c
index d50ab9d..7df03f8 100644
--- a/arch/arm/plat-samsung/pm-gpio.c
+++ b/arch/arm/plat-samsung/pm-gpio.c
@@ -331,8 +331,10 @@ void s3c_pm_save_gpios(void)

 	for (gpio_nr = 0; gpio_nr < S3C_GPIO_END;) {
 		ourchip = s3c_gpiolib_getchip(gpio_nr);
-		if (!ourchip)
+		if (!ourchip) {
+			gpio_nr++;
 			continue;
+		}

 		s3c_pm_save_gpio(ourchip);

@@ -369,8 +371,10 @@ void s3c_pm_restore_gpios(void)

 	for (gpio_nr = 0; gpio_nr < S3C_GPIO_END;) {
 		ourchip = s3c_gpiolib_getchip(gpio_nr);
-		if (!ourchip)
+		if (!ourchip) {
+			gpio_nr++;
 			continue;
+		}

 		s3c_pm_resume_gpio(ourchip);

-- 
1.7.1
