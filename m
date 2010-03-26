From: marek.vasut@gmail.com (Marek Vasut)
Date: Fri, 26 Mar 2010 05:38:10 +0100
Subject: [PATCH] VPAC270: Add DS1339 RTC support
Message-ID: <1269578290-16979-1-git-send-email-marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
---
 arch/arm/mach-pxa/vpac270.c |   26 ++++++++++++++++++++++++++
 1 files changed, 26 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-pxa/vpac270.c b/arch/arm/mach-pxa/vpac270.c
index fa428ca..0a9647b 100644
--- a/arch/arm/mach-pxa/vpac270.c
+++ b/arch/arm/mach-pxa/vpac270.c
@@ -36,6 +36,8 @@
 #include <mach/pxa27x-udc.h>
 #include <mach/udc.h>
 
+#include <plat/i2c.h>
+
 #include "generic.h"
 #include "devices.h"
 
@@ -132,6 +134,10 @@ static unsigned long vpac270_pin_config[] __initdata = {
 	GPIO95_AC97_nRESET,
 	GPIO98_AC97_SYSCLK,
 	GPIO113_GPIO,	/* TS IRQ */
+
+	/* I2C */
+	GPIO117_I2C_SCL,
+	GPIO118_I2C_SDA,
 };
 
 /******************************************************************************
@@ -398,6 +404,25 @@ static inline void vpac270_ts_init(void) {}
 #endif
 
 /******************************************************************************
+ * RTC
+ ******************************************************************************/
+#if defined(CONFIG_RTC_DRV_DS1307) || defined(CONFIG_RTC_DRV_DS1307_MODULE)
+static struct i2c_board_info __initdata vpac270_i2c_devs[] = {
+	{
+		I2C_BOARD_INFO("ds1339", 0x68),
+	},
+};
+
+static void __init vpac270_rtc_init(void)
+{
+	pxa_set_i2c_info(NULL);
+	i2c_register_board_info(0, ARRAY_AND_SIZE(vpac270_i2c_devs));
+}
+#else
+static inline void vpac270_rtc_init(void) {}
+#endif
+
+/******************************************************************************
  * Framebuffer
  ******************************************************************************/
 #if defined(CONFIG_FB_PXA) || defined(CONFIG_FB_PXA_MODULE)
@@ -481,6 +506,7 @@ static void __init vpac270_init(void)
 	vpac270_udc_init();
 	vpac270_eth_init();
 	vpac270_ts_init();
+	vpac270_rtc_init();
 }
 
 MACHINE_START(VPAC270, "Voipac PXA270")
-- 
1.7.0
