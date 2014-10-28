From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Tue, 28 Oct 2014 03:02:05 +0300
Subject: [PATCH 12/15] ARM: pxa: poodle: don't preallocate IRQ space for locomo
In-Reply-To: <1414454528-24240-1-git-send-email-dbaryshkov@gmail.com>
References: <1414454528-24240-1-git-send-email-dbaryshkov@gmail.com>
Message-ID: <1414454528-24240-13-git-send-email-dbaryshkov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As new locomo driver supports SPARSE_IRQ, don't preallocate NR_IRQS
space for it on poodle.

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 arch/arm/mach-pxa/include/mach/poodle.h | 2 +-
 arch/arm/mach-pxa/poodle.c              | 8 ++++++--
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-pxa/include/mach/poodle.h b/arch/arm/mach-pxa/include/mach/poodle.h
index e8eb51e..105410a 100644
--- a/arch/arm/mach-pxa/include/mach/poodle.h
+++ b/arch/arm/mach-pxa/include/mach/poodle.h
@@ -91,7 +91,7 @@
 #define POODLE_GPIO_MUTE_L	(POODLE_LOCOMO_GPIO_BASE + 10)
 #define POODLE_GPIO_MUTE_R	(POODLE_LOCOMO_GPIO_BASE + 11)
 
-#define POODLE_NR_IRQS		(IRQ_BOARD_START + 4)	/* 4 for LoCoMo */
+#define POODLE_NR_IRQS		IRQ_BOARD_START
 
 extern struct platform_device poodle_locomo_device;
 
diff --git a/arch/arm/mach-pxa/poodle.c b/arch/arm/mach-pxa/poodle.c
index 3041d83..97eced9 100644
--- a/arch/arm/mach-pxa/poodle.c
+++ b/arch/arm/mach-pxa/poodle.c
@@ -181,14 +181,18 @@ static struct locomo_platform_data locomo_info = {
 	.gpio_data = {
 		.gpio_base = POODLE_LOCOMO_GPIO_BASE,
 	},
-	.bl_data = {
+	.lcd_data = {
 		.comadj	          = 118,
 		.gpio_lcd_vsha_on = POODLE_GPIO_LCD_VSHA_ON,
 		.gpio_lcd_vshd_on = POODLE_GPIO_LCD_VSHD_ON,
 		.gpio_lcd_vee_on  = POODLE_GPIO_LCD_VEE_ON,
 		.gpio_lcd_mod     = POODLE_GPIO_LCD_MOD,
+	},
+	.bl_data = {
 		.gpio_fl_vr       = POODLE_GPIO_FL_VR,
 	},
+	.gpio_amp1_on	= -1,
+	.gpio_amp2_on	= -1,
 };
 
 struct platform_device poodle_locomo_device = {
@@ -453,7 +457,7 @@ static void __init poodle_init(void)
 	platform_scoop_config = &poodle_pcmcia_config;
 
 	if (sharpsl_param.comadj != -1)
-		locomo_info.bl_data.comadj = sharpsl_param.comadj;
+		locomo_info.lcd_data.comadj = sharpsl_param.comadj;
 
 	ret = platform_add_devices(devices, ARRAY_SIZE(devices));
 	if (ret)
-- 
2.1.1
