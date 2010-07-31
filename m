From: marek.vasut@gmail.com (Marek Vasut)
Date: Sat, 31 Jul 2010 04:30:53 +0200
Subject: [PATCH] PXA: Colibri320: Add M41T00 RTC support
Message-ID: <1280543453-28237-1-git-send-email-marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
---
 arch/arm/mach-pxa/colibri-pxa320.c       |   16 ++++++++++++++++
 arch/arm/mach-pxa/colibri-pxa3xx.c       |   14 ++++++++++++++
 arch/arm/mach-pxa/include/mach/colibri.h |    7 +++++++
 3 files changed, 37 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-pxa/colibri-pxa320.c b/arch/arm/mach-pxa/colibri-pxa320.c
index 99e850d..0bc5f98 100644
--- a/arch/arm/mach-pxa/colibri-pxa320.c
+++ b/arch/arm/mach-pxa/colibri-pxa320.c
@@ -236,6 +236,21 @@ static void __init colibri_pxa320_init_uart(void)
 	pxa3xx_mfp_config(ARRAY_AND_SIZE(colibri_pxa320_uart_pin_config));
 }
 
+#if defined(CONFIG_RTC_DRV_DS1307) || defined(CONFIG_RTC_DRV_DS1307_MODULE)
+static mfp_cfg_t colibri_pxa320_i2c_pin_config[] __initdata = {
+	GPIO32_I2C_SCL,
+	GPIO33_I2C_SDA,
+};
+
+static void __init colibri_pxa320_init_rtc(void)
+{
+	pxa3xx_mfp_config(ARRAY_AND_SIZE(colibri_pxa320_i2c_pin_config));
+	colibri_pxa3xx_init_rtc();
+}
+#else
+static inline void colibri_pxa320_init_rtc(void) {}
+#endif
+
 void __init colibri_pxa320_init(void)
 {
 	pxa_set_ffuart_info(NULL);
@@ -252,6 +267,7 @@ void __init colibri_pxa320_init(void)
 				mfp_to_gpio(MFP_PIN_GPIO28));
 	colibri_pxa320_init_uart();
 	colibri_pxa320_init_udc();
+	colibri_pxa320_init_rtc();
 }
 
 MACHINE_START(COLIBRI320, "Toradex Colibri PXA320")
diff --git a/arch/arm/mach-pxa/colibri-pxa3xx.c b/arch/arm/mach-pxa/colibri-pxa3xx.c
index 199afa2..2bbeae6 100644
--- a/arch/arm/mach-pxa/colibri-pxa3xx.c
+++ b/arch/arm/mach-pxa/colibri-pxa3xx.c
@@ -26,6 +26,7 @@
 #include <mach/mmc.h>
 #include <mach/pxafb.h>
 #include <plat/pxa3xx_nand.h>
+#include <plat/i2c.h>
 
 #include "generic.h"
 #include "devices.h"
@@ -198,3 +199,16 @@ void __init colibri_pxa3xx_init_nand(void)
 }
 #endif
 
+#if defined(CONFIG_RTC_DRV_DS1307) || defined(CONFIG_RTC_DRV_DS1307_MODULE)
+static struct i2c_board_info __initdata colibri_pxa3xx_i2c_devs[] = {
+	{
+		I2C_BOARD_INFO("m41t00", 0x68),
+	},
+};
+
+void __init colibri_pxa3xx_init_rtc(void)
+{
+	pxa_set_i2c_info(NULL);
+	i2c_register_board_info(0, ARRAY_AND_SIZE(colibri_pxa3xx_i2c_devs));
+}
+#endif
diff --git a/arch/arm/mach-pxa/include/mach/colibri.h b/arch/arm/mach-pxa/include/mach/colibri.h
index 58dada1..d5dc04d 100644
--- a/arch/arm/mach-pxa/include/mach/colibri.h
+++ b/arch/arm/mach-pxa/include/mach/colibri.h
@@ -51,6 +51,13 @@ extern void colibri_pxa3xx_init_nand(void);
 static inline void colibri_pxa3xx_init_nand(void) {}
 #endif
 
+#if defined(CONFIG_RTC_DRV_DS1307) || defined(CONFIG_RTC_DRV_DS1307_MODULE)
+extern void colibri_pxa3xx_init_rtc(void);
+#else
+static inline void colibri_pxa3xx_init_rtc(void) {}
+#endif
+
+
 /* physical memory regions */
 #define COLIBRI_SDRAM_BASE	0xa0000000      /* SDRAM region */
 
-- 
1.7.1
