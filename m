From: lokeshvutla@ti.com (Lokesh Vutla)
Date: Thu, 13 Jun 2013 16:23:58 +0530
Subject: [PATCH] ARM: OMAP3EVM: Marking omap3_evm_display_init() with
 CONFIG_BROKEN
Message-ID: <1371120838-29599-1-git-send-email-lokeshvutla@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 37xx EVM non-dt boot fails with current mainline,
because of broken GPIO numbering in the board file
that uses hardcoded GPIOs.

So marking omap3_evm_display_init() with CONFIG_BROKEN
for now as suggested by Tony as per the below link:
http://www.mail-archive.com/linux-omap at vger.kernel.org/msg90399.html

Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
---
 arch/arm/mach-omap2/board-omap3evm.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index f76d0de..278bf25 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -174,6 +174,7 @@ static struct panel_sharp_ls037v7dw01_data omap3_evm_lcd_data = {
 	.ud_gpio = OMAP3EVM_LCD_PANEL_UD,
 };
 
+#ifdef CONFIG_BROKEN
 static void __init omap3_evm_display_init(void)
 {
 	int r;
@@ -193,6 +194,7 @@ static void __init omap3_evm_display_init(void)
 	else
 		gpio_set_value_cansleep(OMAP3EVM_LCD_PANEL_BKLIGHT_GPIO, 1);
 }
+#endif
 
 static struct omap_dss_device omap3_evm_lcd_device = {
 	.name			= "lcd",
@@ -715,7 +717,9 @@ static void __init omap3_evm_init(void)
 
 	omap_ads7846_init(1, OMAP3_EVM_TS_GPIO, 310, NULL);
 	omap3evm_init_smsc911x();
+#ifdef CONFIG_BROKEN
 	omap3_evm_display_init();
+#endif
 	omap3_evm_wl12xx_init();
 	omap_twl4030_audio_init("omap3evm", NULL);
 }
-- 
1.7.9.5
