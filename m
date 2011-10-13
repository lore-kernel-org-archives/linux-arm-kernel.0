From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Thu, 13 Oct 2011 12:07:01 +0800
Subject: [PATCH v4 4/8] ARM: pxa: rename NR_BUILTIN_GPIO
In-Reply-To: <1318478825-17187-1-git-send-email-haojian.zhuang@marvell.com>
References: <1318478825-17187-1-git-send-email-haojian.zhuang@marvell.com>
Message-ID: <1318478825-17187-5-git-send-email-haojian.zhuang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

NR_BUILTIN_GPIO is both defined in arch-pxa and arch-mmp. Now replace it
with PXA_NR_BUILTIN_GPIO and MMP_NR_BUILTIN_GPIO.

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 arch/arm/mach-mmp/include/mach/gpio-pxa.h  |    2 -
 arch/arm/mach-mmp/include/mach/gpio.h      |    1 -
 arch/arm/mach-mmp/include/mach/irqs.h      |    5 +--
 arch/arm/mach-mmp/tavorevb.c               |    1 +
 arch/arm/mach-mmp/ttc_dkb.c                |    7 +++--
 arch/arm/mach-pxa/include/mach/corgi.h     |    2 +-
 arch/arm/mach-pxa/include/mach/gpio-pxa.h  |    2 -
 arch/arm/mach-pxa/include/mach/gpio.h      |    1 -
 arch/arm/mach-pxa/include/mach/hx4700.h    |    2 +-
 arch/arm/mach-pxa/include/mach/irqs.h      |    4 +-
 arch/arm/mach-pxa/include/mach/littleton.h |    2 +-
 arch/arm/mach-pxa/include/mach/magician.h  |    2 +-
 arch/arm/mach-pxa/include/mach/poodle.h    |    2 +-
 arch/arm/mach-pxa/include/mach/spitz.h     |    6 ++--
 arch/arm/mach-pxa/include/mach/tosa.h      |    6 ++--
 arch/arm/mach-pxa/pcm990-baseboard.c       |    6 ++--
 arch/arm/plat-pxa/include/plat/gpio.h      |   30 ----------------------------
 17 files changed, 23 insertions(+), 58 deletions(-)
 delete mode 100644 arch/arm/plat-pxa/include/plat/gpio.h

diff --git a/arch/arm/mach-mmp/include/mach/gpio-pxa.h b/arch/arm/mach-mmp/include/mach/gpio-pxa.h
index f7bcc30..78199bd 100644
--- a/arch/arm/mach-mmp/include/mach/gpio-pxa.h
+++ b/arch/arm/mach-mmp/include/mach/gpio-pxa.h
@@ -10,8 +10,6 @@
 #define BANK_OFF(n)	(((n) < 3) ? (n) << 2 : 0x100 + (((n) - 3) << 2))
 #define GPIO_REG(x)	(*((volatile u32 *)(GPIO_REGS_VIRT + (x))))
 
-#define NR_BUILTIN_GPIO		IRQ_GPIO_NUM
-
 #define gpio_to_bank(gpio)	((gpio) >> 5)
 
 /* NOTE: these macros are defined here to make optimization of
diff --git a/arch/arm/mach-mmp/include/mach/gpio.h b/arch/arm/mach-mmp/include/mach/gpio.h
index 32b684a..904466d 100644
--- a/arch/arm/mach-mmp/include/mach/gpio.h
+++ b/arch/arm/mach-mmp/include/mach/gpio.h
@@ -6,5 +6,4 @@
 #define __gpio_is_inverted(gpio)	(0)
 #define __gpio_is_occupied(gpio)	(0)
 
-#include <plat/gpio.h>
 #endif /* __ASM_MACH_GPIO_H */
diff --git a/arch/arm/mach-mmp/include/mach/irqs.h b/arch/arm/mach-mmp/include/mach/irqs.h
index ec95951..34635a0 100644
--- a/arch/arm/mach-mmp/include/mach/irqs.h
+++ b/arch/arm/mach-mmp/include/mach/irqs.h
@@ -219,11 +219,10 @@
 #define IRQ_MMP2_MUX_END		(IRQ_MMP2_SSP_BASE + 2)
 
 #define IRQ_GPIO_START			128
-#define IRQ_GPIO_NUM			192
-#define IRQ_GPIO(x)			(IRQ_GPIO_START + (x))
+#define MMP_NR_BUILTIN_GPIO		192
 #define MMP_GPIO_TO_IRQ(gpio)		(IRQ_GPIO_START + (gpio))
 
-#define IRQ_BOARD_START			(IRQ_GPIO_START + IRQ_GPIO_NUM)
+#define IRQ_BOARD_START			(IRQ_GPIO_START + MMP_NR_BUILTIN_GPIO)
 
 #define NR_IRQS				(IRQ_BOARD_START)
 
diff --git a/arch/arm/mach-mmp/tavorevb.c b/arch/arm/mach-mmp/tavorevb.c
index 0afe3a3..331f5f3 100644
--- a/arch/arm/mach-mmp/tavorevb.c
+++ b/arch/arm/mach-mmp/tavorevb.c
@@ -19,6 +19,7 @@
 #include <mach/addr-map.h>
 #include <mach/mfp-pxa910.h>
 #include <mach/pxa910.h>
+#include <mach/irqs.h>
 
 #include "common.h"
 
diff --git a/arch/arm/mach-mmp/ttc_dkb.c b/arch/arm/mach-mmp/ttc_dkb.c
index 176515a..fac0d5d 100644
--- a/arch/arm/mach-mmp/ttc_dkb.c
+++ b/arch/arm/mach-mmp/ttc_dkb.c
@@ -24,12 +24,13 @@
 #include <mach/addr-map.h>
 #include <mach/mfp-pxa910.h>
 #include <mach/pxa910.h>
+#include <mach/irqs.h>
 
 #include "common.h"
 
-#define TTCDKB_GPIO_EXT0(x)	(NR_BUILTIN_GPIO + ((x < 0) ? 0 :	\
+#define TTCDKB_GPIO_EXT0(x)	(MMP_NR_BUILTIN_GPIO + ((x < 0) ? 0 :	\
 				((x < 16) ? x : 15)))
-#define TTCDKB_GPIO_EXT1(x)	(NR_BUILTIN_GPIO + 16 + ((x < 0) ? 0 :	\
+#define TTCDKB_GPIO_EXT1(x)	(MMP_NR_BUILTIN_GPIO + 16 + ((x < 0) ? 0 : \
 				((x < 16) ? x : 15)))
 
 /*
@@ -136,7 +137,7 @@ static struct i2c_board_info ttc_dkb_i2c_info[] = {
 	{
 		.type		= "max7312",
 		.addr		= 0x23,
-		.irq		= IRQ_GPIO(80),
+		.irq		= MMP_GPIO_TO_IRQ(80),
 		.platform_data	= &max7312_data,
 	},
 };
diff --git a/arch/arm/mach-pxa/include/mach/corgi.h b/arch/arm/mach-pxa/include/mach/corgi.h
index c9f8617..f3c3493 100644
--- a/arch/arm/mach-pxa/include/mach/corgi.h
+++ b/arch/arm/mach-pxa/include/mach/corgi.h
@@ -98,7 +98,7 @@
 			CORGI_SCP_MIC_BIAS )
 #define CORGI_SCOOP_IO_OUT	( CORGI_SCP_MUTE_L | CORGI_SCP_MUTE_R )
 
-#define CORGI_SCOOP_GPIO_BASE		(NR_BUILTIN_GPIO)
+#define CORGI_SCOOP_GPIO_BASE		(PXA_NR_BUILTIN_GPIO)
 #define CORGI_GPIO_LED_GREEN		(CORGI_SCOOP_GPIO_BASE + 0)
 #define CORGI_GPIO_SWA			(CORGI_SCOOP_GPIO_BASE + 1)  /* Hinge Switch A */
 #define CORGI_GPIO_SWB			(CORGI_SCOOP_GPIO_BASE + 2)  /* Hinge Switch B */
diff --git a/arch/arm/mach-pxa/include/mach/gpio-pxa.h b/arch/arm/mach-pxa/include/mach/gpio-pxa.h
index 41b4c93..134b3bc 100644
--- a/arch/arm/mach-pxa/include/mach/gpio-pxa.h
+++ b/arch/arm/mach-pxa/include/mach/gpio-pxa.h
@@ -93,8 +93,6 @@
 #define GAFR(x)		GPIO_REG(0x54 + (((x) & 0x70) >> 2))
 
 
-#define NR_BUILTIN_GPIO		PXA_GPIO_IRQ_NUM
-
 #define gpio_to_bank(gpio)	((gpio) >> 5)
 
 #ifdef CONFIG_CPU_PXA26x
diff --git a/arch/arm/mach-pxa/include/mach/gpio.h b/arch/arm/mach-pxa/include/mach/gpio.h
index 5cf0137..561cdbf 100644
--- a/arch/arm/mach-pxa/include/mach/gpio.h
+++ b/arch/arm/mach-pxa/include/mach/gpio.h
@@ -28,5 +28,4 @@
 /* The defines for the driver are needed for the accelerated accessors */
 #include "gpio-pxa.h"
 
-#include <plat/gpio.h>
 #endif
diff --git a/arch/arm/mach-pxa/include/mach/hx4700.h b/arch/arm/mach-pxa/include/mach/hx4700.h
index 3740844..8bc0291 100644
--- a/arch/arm/mach-pxa/include/mach/hx4700.h
+++ b/arch/arm/mach-pxa/include/mach/hx4700.h
@@ -15,7 +15,7 @@
 #include <linux/gpio.h>
 #include <linux/mfd/asic3.h>
 
-#define HX4700_ASIC3_GPIO_BASE	NR_BUILTIN_GPIO
+#define HX4700_ASIC3_GPIO_BASE	PXA_NR_BUILTIN_GPIO
 #define HX4700_EGPIO_BASE	(HX4700_ASIC3_GPIO_BASE + ASIC3_NUM_GPIOS)
 #define HX4700_NR_IRQS		(IRQ_BOARD_START + 70)
 
diff --git a/arch/arm/mach-pxa/include/mach/irqs.h b/arch/arm/mach-pxa/include/mach/irqs.h
index b83d8ff..32975ad 100644
--- a/arch/arm/mach-pxa/include/mach/irqs.h
+++ b/arch/arm/mach-pxa/include/mach/irqs.h
@@ -88,7 +88,7 @@
 #define IRQ_U2P		PXA_IRQ(93)	/* USB PHY D+/D- Lines (PXA935) */
 
 #define PXA_GPIO_IRQ_BASE	PXA_IRQ(96)
-#define PXA_GPIO_IRQ_NUM	(192)
+#define PXA_NR_BUILTIN_GPIO	(192)
 #define PXA_GPIO_TO_IRQ(x)	(PXA_GPIO_IRQ_BASE + (x))
 
 /*
@@ -98,7 +98,7 @@
  * By default, no board IRQ is reserved. It should be finished in
  * custom board since sparse IRQ is already enabled.
  */
-#define IRQ_BOARD_START		(PXA_GPIO_IRQ_BASE + PXA_GPIO_IRQ_NUM)
+#define IRQ_BOARD_START		(PXA_GPIO_IRQ_BASE + PXA_NR_BUILTIN_GPIO)
 
 #define NR_IRQS			(IRQ_BOARD_START)
 
diff --git a/arch/arm/mach-pxa/include/mach/littleton.h b/arch/arm/mach-pxa/include/mach/littleton.h
index b6238cb..e20ac1b 100644
--- a/arch/arm/mach-pxa/include/mach/littleton.h
+++ b/arch/arm/mach-pxa/include/mach/littleton.h
@@ -7,7 +7,7 @@
 
 #define LITTLETON_GPIO_LCD_CS	(17)
 
-#define EXT0_GPIO_BASE	(NR_BUILTIN_GPIO)
+#define EXT0_GPIO_BASE	(PXA_NR_BUILTIN_GPIO)
 #define EXT0_GPIO(x)	(EXT0_GPIO_BASE + (x))
 
 #define LITTLETON_NR_IRQS	(IRQ_BOARD_START + 8)
diff --git a/arch/arm/mach-pxa/include/mach/magician.h b/arch/arm/mach-pxa/include/mach/magician.h
index 7cbfc5d..ba6a6e1 100644
--- a/arch/arm/mach-pxa/include/mach/magician.h
+++ b/arch/arm/mach-pxa/include/mach/magician.h
@@ -78,7 +78,7 @@
  * CPLD EGPIOs
  */
 
-#define MAGICIAN_EGPIO_BASE			NR_BUILTIN_GPIO
+#define MAGICIAN_EGPIO_BASE			PXA_NR_BUILTIN_GPIO
 #define MAGICIAN_EGPIO(reg,bit) \
 	(MAGICIAN_EGPIO_BASE + 8*reg + bit)
 
diff --git a/arch/arm/mach-pxa/include/mach/poodle.h b/arch/arm/mach-pxa/include/mach/poodle.h
index 763fdc4..f32ff75 100644
--- a/arch/arm/mach-pxa/include/mach/poodle.h
+++ b/arch/arm/mach-pxa/include/mach/poodle.h
@@ -71,7 +71,7 @@
 #define POODLE_SCOOP_IO_DIR	( POODLE_SCOOP_VPEN | POODLE_SCOOP_HS_OUT )
 #define POODLE_SCOOP_IO_OUT	( 0 )
 
-#define POODLE_SCOOP_GPIO_BASE	(NR_BUILTIN_GPIO)
+#define POODLE_SCOOP_GPIO_BASE	(PXA_NR_BUILTIN_GPIO)
 #define POODLE_GPIO_CHARGE_ON	(POODLE_SCOOP_GPIO_BASE + 0)
 #define POODLE_GPIO_CP401	(POODLE_SCOOP_GPIO_BASE + 2)
 #define POODLE_GPIO_VPEN	(POODLE_SCOOP_GPIO_BASE + 7)
diff --git a/arch/arm/mach-pxa/include/mach/spitz.h b/arch/arm/mach-pxa/include/mach/spitz.h
index 273381a..0bfe650 100644
--- a/arch/arm/mach-pxa/include/mach/spitz.h
+++ b/arch/arm/mach-pxa/include/mach/spitz.h
@@ -108,7 +108,7 @@
 #define SPITZ_SCP_SUS_CLR     (SPITZ_SCP_MUTE_L | SPITZ_SCP_MUTE_R | SPITZ_SCP_JK_A | SPITZ_SCP_ADC_TEMP_ON)
 #define SPITZ_SCP_SUS_SET     0
 
-#define SPITZ_SCP_GPIO_BASE	(NR_BUILTIN_GPIO)
+#define SPITZ_SCP_GPIO_BASE	(PXA_NR_BUILTIN_GPIO)
 #define SPITZ_GPIO_LED_GREEN	(SPITZ_SCP_GPIO_BASE + 0)
 #define SPITZ_GPIO_JK_B		(SPITZ_SCP_GPIO_BASE + 1)
 #define SPITZ_GPIO_CHRG_ON	(SPITZ_SCP_GPIO_BASE + 2)
@@ -140,7 +140,7 @@
                              SPITZ_SCP2_BACKLIGHT_CONT | SPITZ_SCP2_BACKLIGHT_ON | SPITZ_SCP2_MIC_BIAS)
 #define SPITZ_SCP2_SUS_SET  (SPITZ_SCP2_IR_ON | SPITZ_SCP2_RESERVED_1)
 
-#define SPITZ_SCP2_GPIO_BASE		(NR_BUILTIN_GPIO + 12)
+#define SPITZ_SCP2_GPIO_BASE		(PXA_NR_BUILTIN_GPIO + 12)
 #define SPITZ_GPIO_IR_ON		(SPITZ_SCP2_GPIO_BASE + 0)
 #define SPITZ_GPIO_AKIN_PULLUP		(SPITZ_SCP2_GPIO_BASE + 1)
 #define SPITZ_GPIO_RESERVED_1		(SPITZ_SCP2_GPIO_BASE + 2)
@@ -152,7 +152,7 @@
 #define SPITZ_GPIO_MIC_BIAS		(SPITZ_SCP2_GPIO_BASE + 8)
 
 /* Akita IO Expander GPIOs */
-#define AKITA_IOEXP_GPIO_BASE		(NR_BUILTIN_GPIO + 12)
+#define AKITA_IOEXP_GPIO_BASE		(PXA_NR_BUILTIN_GPIO + 12)
 #define AKITA_GPIO_RESERVED_0		(AKITA_IOEXP_GPIO_BASE + 0)
 #define AKITA_GPIO_RESERVED_1		(AKITA_IOEXP_GPIO_BASE + 1)
 #define AKITA_GPIO_MIC_BIAS		(AKITA_IOEXP_GPIO_BASE + 2)
diff --git a/arch/arm/mach-pxa/include/mach/tosa.h b/arch/arm/mach-pxa/include/mach/tosa.h
index 4653539..2bb0e86 100644
--- a/arch/arm/mach-pxa/include/mach/tosa.h
+++ b/arch/arm/mach-pxa/include/mach/tosa.h
@@ -24,7 +24,7 @@
 /*
  * SCOOP2 internal GPIOs
  */
-#define TOSA_SCOOP_GPIO_BASE		NR_BUILTIN_GPIO
+#define TOSA_SCOOP_GPIO_BASE		PXA_NR_BUILTIN_GPIO
 #define TOSA_SCOOP_PXA_VCORE1		SCOOP_GPCR_PA11
 #define TOSA_GPIO_TC6393XB_REST_IN	(TOSA_SCOOP_GPIO_BASE + 1)
 #define TOSA_GPIO_IR_POWERDWN		(TOSA_SCOOP_GPIO_BASE + 2)
@@ -42,7 +42,7 @@
 /*
  * SCOOP2 jacket GPIOs
  */
-#define TOSA_SCOOP_JC_GPIO_BASE		(NR_BUILTIN_GPIO + 12)
+#define TOSA_SCOOP_JC_GPIO_BASE		(PXA_NR_BUILTIN_GPIO + 12)
 #define TOSA_GPIO_BT_LED		(TOSA_SCOOP_JC_GPIO_BASE + 0)
 #define TOSA_GPIO_NOTE_LED		(TOSA_SCOOP_JC_GPIO_BASE + 1)
 #define TOSA_GPIO_CHRG_ERR_LED		(TOSA_SCOOP_JC_GPIO_BASE + 2)
@@ -59,7 +59,7 @@
 /*
  * TC6393XB GPIOs
  */
-#define TOSA_TC6393XB_GPIO_BASE		(NR_BUILTIN_GPIO + 2 * 12)
+#define TOSA_TC6393XB_GPIO_BASE		(PXA_NR_BUILTIN_GPIO + 2 * 12)
 
 #define TOSA_GPIO_TG_ON			(TOSA_TC6393XB_GPIO_BASE + 0)
 #define TOSA_GPIO_L_MUTE		(TOSA_TC6393XB_GPIO_BASE + 1)
diff --git a/arch/arm/mach-pxa/pcm990-baseboard.c b/arch/arm/mach-pxa/pcm990-baseboard.c
index 9a9c539..3805e5d 100644
--- a/arch/arm/mach-pxa/pcm990-baseboard.c
+++ b/arch/arm/mach-pxa/pcm990-baseboard.c
@@ -378,7 +378,7 @@ struct pxacamera_platform_data pcm990_pxacamera_platform_data = {
 #include <linux/i2c/pca953x.h>
 
 static struct pca953x_platform_data pca9536_data = {
-	.gpio_base	= NR_BUILTIN_GPIO,
+	.gpio_base	= PXA_NR_BUILTIN_GPIO,
 };
 
 static int gpio_bus_switch = -EINVAL;
@@ -406,9 +406,9 @@ static unsigned long pcm990_camera_query_bus_param(struct soc_camera_link *link)
 	int ret;
 
 	if (gpio_bus_switch < 0) {
-		ret = gpio_request(NR_BUILTIN_GPIO, "camera");
+		ret = gpio_request(PXA_NR_BUILTIN_GPIO, "camera");
 		if (!ret) {
-			gpio_bus_switch = NR_BUILTIN_GPIO;
+			gpio_bus_switch = PXA_NR_BUILTIN_GPIO;
 			gpio_direction_output(gpio_bus_switch, 0);
 		}
 	}
diff --git a/arch/arm/plat-pxa/include/plat/gpio.h b/arch/arm/plat-pxa/include/plat/gpio.h
deleted file mode 100644
index 258f772..0000000
--- a/arch/arm/plat-pxa/include/plat/gpio.h
+++ /dev/null
@@ -1,30 +0,0 @@
-#ifndef __PLAT_GPIO_H
-#define __PLAT_GPIO_H
-
-#define __ARM_GPIOLIB_COMPLEX
-
-/* The individual machine provides register offsets and NR_BUILTIN_GPIO */
-#include <mach/gpio-pxa.h>
-
-static inline int gpio_get_value(unsigned gpio)
-{
-	if (__builtin_constant_p(gpio) && (gpio < NR_BUILTIN_GPIO))
-		return GPLR(gpio) & GPIO_bit(gpio);
-	else
-		return __gpio_get_value(gpio);
-}
-
-static inline void gpio_set_value(unsigned gpio, int value)
-{
-	if (__builtin_constant_p(gpio) && (gpio < NR_BUILTIN_GPIO)) {
-		if (value)
-			GPSR(gpio) = GPIO_bit(gpio);
-		else
-			GPCR(gpio) = GPIO_bit(gpio);
-	} else
-		__gpio_set_value(gpio, value);
-}
-
-#define gpio_cansleep		__gpio_cansleep
-
-#endif /* __PLAT_GPIO_H */
-- 
1.7.2.5
