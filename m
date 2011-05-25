From: zonque@gmail.com (Daniel Mack)
Date: Wed, 25 May 2011 13:37:31 +0200
Subject: [PATCH 1/3] ARM: pxa: raumfeld: adapt to upcoming hardware change
In-Reply-To: <BANLkTikwkr8etp_fBnsUxiSq28VUyTbONQ@mail.gmail.com>
References: <BANLkTikwkr8etp_fBnsUxiSq28VUyTbONQ@mail.gmail.com>
Message-ID: <1306323453-6371-1-git-send-email-zonque@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sven Neumann <s.neumann@raumfeld.com>

The backlight control is going to change back to PWM in the
upcoming Raumfeld Controller hardware revision.

Signed-off-by: Sven Neumann <s.neumann@raumfeld.com>
Acked-by: Daniel Mack <zonque@gmail.com>
---
 arch/arm/mach-pxa/raumfeld.c |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-pxa/raumfeld.c b/arch/arm/mach-pxa/raumfeld.c
index 15bca98..8b2ace5 100644
--- a/arch/arm/mach-pxa/raumfeld.c
+++ b/arch/arm/mach-pxa/raumfeld.c
@@ -599,14 +599,15 @@ static void __init raumfeld_lcd_init(void)
 
 	pxa_set_fb_info(NULL, &raumfeld_sharp_lcd_info);
 
-	/* Earlier devices had the backlight regulator controlled
-	 * via PWM, later versions use another controller for that */
-	if ((system_rev & 0xff) < 2) {
+	/* Hardware revision 2 has the backlight regulator controlled
+	 * by an LT3593, earlier and later devices use PWM for that. */
+	if ((system_rev & 0xff) == 2) {
+		platform_device_register(&raumfeld_lt3593_device);
+	} else {
 		mfp_cfg_t raumfeld_pwm_pin_config = GPIO17_PWM0_OUT;
 		pxa3xx_mfp_config(&raumfeld_pwm_pin_config, 1);
 		platform_device_register(&raumfeld_pwm_backlight_device);
-	} else
-		platform_device_register(&raumfeld_lt3593_device);
+	}
 
 	ret = gpio_request(GPIO_TFT_VA_EN, "display VA enable");
 	if (ret < 0)
-- 
1.7.5.1
