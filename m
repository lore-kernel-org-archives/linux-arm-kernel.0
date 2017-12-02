From: david@lechnology.com (David Lechner)
Date: Fri,  1 Dec 2017 20:34:09 -0600
Subject: [PATCH v1 1/6] ARM: davinci: clean up map_io functions
In-Reply-To: <1512182054-17410-1-git-send-email-david@lechnology.com>
References: <1512182054-17410-1-git-send-email-david@lechnology.com>
Message-ID: <1512182054-17410-2-git-send-email-david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This cleans up the map_io functions in the board init files for
mach-davinci.

Most of the boards had a wrapper function around <board>_init(). This
wrapper is removed and the function is used directly. Additionally, the
<board>_init() functions are renamed to <board>_map_io() to match the
field name.

Signed-off-by: David Lechner <david@lechnology.com>
---
 arch/arm/mach-davinci/board-da830-evm.c     |  7 +------
 arch/arm/mach-davinci/board-da850-evm.c     |  7 +------
 arch/arm/mach-davinci/board-dm355-evm.c     |  7 +------
 arch/arm/mach-davinci/board-dm355-leopard.c |  7 +------
 arch/arm/mach-davinci/board-dm365-evm.c     |  7 +------
 arch/arm/mach-davinci/board-dm644x-evm.c    |  8 +-------
 arch/arm/mach-davinci/board-dm646x-evm.c    | 14 ++------------
 arch/arm/mach-davinci/board-mityomapl138.c  |  7 +------
 arch/arm/mach-davinci/board-neuros-osd2.c   |  7 +------
 arch/arm/mach-davinci/board-omapl138-hawk.c |  7 +------
 arch/arm/mach-davinci/board-sffsdr.c        |  7 +------
 arch/arm/mach-davinci/da830.c               |  2 +-
 arch/arm/mach-davinci/da850.c               |  2 +-
 arch/arm/mach-davinci/da8xx-dt.c            |  2 +-
 arch/arm/mach-davinci/davinci.h             |  8 ++++----
 arch/arm/mach-davinci/dm355.c               |  2 +-
 arch/arm/mach-davinci/dm365.c               |  2 +-
 arch/arm/mach-davinci/dm644x.c              |  2 +-
 arch/arm/mach-davinci/dm646x.c              |  8 +++++++-
 arch/arm/mach-davinci/include/mach/da8xx.h  |  4 ++--
 20 files changed, 31 insertions(+), 86 deletions(-)

diff --git a/arch/arm/mach-davinci/board-da830-evm.c b/arch/arm/mach-davinci/board-da830-evm.c
index f673cd7..db656d4 100644
--- a/arch/arm/mach-davinci/board-da830-evm.c
+++ b/arch/arm/mach-davinci/board-da830-evm.c
@@ -629,14 +629,9 @@ static int __init da830_evm_console_init(void)
 console_initcall(da830_evm_console_init);
 #endif
 
-static void __init da830_evm_map_io(void)
-{
-	da830_init();
-}
-
 MACHINE_START(DAVINCI_DA830_EVM, "DaVinci DA830/OMAP-L137/AM17x EVM")
 	.atag_offset	= 0x100,
-	.map_io		= da830_evm_map_io,
+	.map_io		= da830_map_io,
 	.init_irq	= cp_intc_init,
 	.init_time	= davinci_timer_init,
 	.init_machine	= da830_evm_init,
diff --git a/arch/arm/mach-davinci/board-da850-evm.c b/arch/arm/mach-davinci/board-da850-evm.c
index cbde003..7333ade 100644
--- a/arch/arm/mach-davinci/board-da850-evm.c
+++ b/arch/arm/mach-davinci/board-da850-evm.c
@@ -1472,14 +1472,9 @@ static int __init da850_evm_console_init(void)
 console_initcall(da850_evm_console_init);
 #endif
 
-static void __init da850_evm_map_io(void)
-{
-	da850_init();
-}
-
 MACHINE_START(DAVINCI_DA850_EVM, "DaVinci DA850/OMAP-L138/AM18x EVM")
 	.atag_offset	= 0x100,
-	.map_io		= da850_evm_map_io,
+	.map_io		= da850_map_io,
 	.init_irq	= cp_intc_init,
 	.init_time	= davinci_timer_init,
 	.init_machine	= da850_evm_init,
diff --git a/arch/arm/mach-davinci/board-dm355-evm.c b/arch/arm/mach-davinci/board-dm355-evm.c
index 62e7bc3..da462e7 100644
--- a/arch/arm/mach-davinci/board-dm355-evm.c
+++ b/arch/arm/mach-davinci/board-dm355-evm.c
@@ -314,11 +314,6 @@ static struct platform_device *davinci_evm_devices[] __initdata = {
 	&davinci_nand_device,
 };
 
-static void __init dm355_evm_map_io(void)
-{
-	dm355_init();
-}
-
 static int dm355evm_mmc_get_cd(int module)
 {
 	if (!gpio_is_valid(dm355evm_mmc_gpios))
@@ -414,7 +409,7 @@ static __init void dm355_evm_init(void)
 
 MACHINE_START(DAVINCI_DM355_EVM, "DaVinci DM355 EVM")
 	.atag_offset  = 0x100,
-	.map_io	      = dm355_evm_map_io,
+	.map_io		= dm355_map_io,
 	.init_irq     = davinci_irq_init,
 	.init_time	= davinci_timer_init,
 	.init_machine = dm355_evm_init,
diff --git a/arch/arm/mach-davinci/board-dm355-leopard.c b/arch/arm/mach-davinci/board-dm355-leopard.c
index be99724..21fd713 100644
--- a/arch/arm/mach-davinci/board-dm355-leopard.c
+++ b/arch/arm/mach-davinci/board-dm355-leopard.c
@@ -174,11 +174,6 @@ static struct platform_device *davinci_leopard_devices[] __initdata = {
 	&davinci_nand_device,
 };
 
-static void __init dm355_leopard_map_io(void)
-{
-	dm355_init();
-}
-
 static int dm355leopard_mmc_get_cd(int module)
 {
 	if (!gpio_is_valid(leopard_mmc_gpio))
@@ -269,7 +264,7 @@ static __init void dm355_leopard_init(void)
 
 MACHINE_START(DM355_LEOPARD, "DaVinci DM355 leopard")
 	.atag_offset  = 0x100,
-	.map_io	      = dm355_leopard_map_io,
+	.map_io		= dm355_map_io,
 	.init_irq     = davinci_irq_init,
 	.init_time	= davinci_timer_init,
 	.init_machine = dm355_leopard_init,
diff --git a/arch/arm/mach-davinci/board-dm365-evm.c b/arch/arm/mach-davinci/board-dm365-evm.c
index e75741f..4ec759b 100644
--- a/arch/arm/mach-davinci/board-dm365-evm.c
+++ b/arch/arm/mach-davinci/board-dm365-evm.c
@@ -714,11 +714,6 @@ static void __init evm_init_cpld(void)
 	/* REVISIT export switches: NTSC/PAL (SW5.6), EXTRA1 (SW5.2), etc */
 }
 
-static void __init dm365_evm_map_io(void)
-{
-	dm365_init();
-}
-
 static struct spi_eeprom at25640 = {
 	.byte_len	= SZ_64K / 8,
 	.name		= "at25640",
@@ -772,7 +767,7 @@ static __init void dm365_evm_init(void)
 
 MACHINE_START(DAVINCI_DM365_EVM, "DaVinci DM365 EVM")
 	.atag_offset	= 0x100,
-	.map_io		= dm365_evm_map_io,
+	.map_io		= dm365_map_io,
 	.init_irq	= davinci_irq_init,
 	.init_time	= davinci_timer_init,
 	.init_machine	= dm365_evm_init,
diff --git a/arch/arm/mach-davinci/board-dm644x-evm.c b/arch/arm/mach-davinci/board-dm644x-evm.c
index b07c9b1..8f6e9ea 100644
--- a/arch/arm/mach-davinci/board-dm644x-evm.c
+++ b/arch/arm/mach-davinci/board-dm644x-evm.c
@@ -725,12 +725,6 @@ static struct platform_device *davinci_evm_devices[] __initdata = {
 	&rtc_dev,
 };
 
-static void __init
-davinci_evm_map_io(void)
-{
-	dm644x_init();
-}
-
 static int davinci_phy_fixup(struct phy_device *phydev)
 {
 	unsigned int control;
@@ -815,7 +809,7 @@ static __init void davinci_evm_init(void)
 MACHINE_START(DAVINCI_EVM, "DaVinci DM644x EVM")
 	/* Maintainer: MontaVista Software <source@mvista.com> */
 	.atag_offset  = 0x100,
-	.map_io	      = davinci_evm_map_io,
+	.map_io		= dm644x_map_io,
 	.init_irq     = davinci_irq_init,
 	.init_time	= davinci_timer_init,
 	.init_machine = davinci_evm_init,
diff --git a/arch/arm/mach-davinci/board-dm646x-evm.c b/arch/arm/mach-davinci/board-dm646x-evm.c
index cb0a41e..f0e2762 100644
--- a/arch/arm/mach-davinci/board-dm646x-evm.c
+++ b/arch/arm/mach-davinci/board-dm646x-evm.c
@@ -716,16 +716,6 @@ static void __init evm_init_i2c(void)
 }
 #endif
 
-#define DM6467T_EVM_REF_FREQ		33000000
-
-static void __init davinci_map_io(void)
-{
-	dm646x_init();
-
-	if (machine_is_davinci_dm6467tevm())
-		davinci_set_refclk_rate(DM6467T_EVM_REF_FREQ);
-}
-
 #define DM646X_EVM_PHY_ID		"davinci_mdio-0:01"
 /*
  * The following EDMA channels/slots are not being used by drivers (for
@@ -795,7 +785,7 @@ static __init void evm_init(void)
 
 MACHINE_START(DAVINCI_DM6467_EVM, "DaVinci DM646x EVM")
 	.atag_offset  = 0x100,
-	.map_io       = davinci_map_io,
+	.map_io		= dm646x_map_io,
 	.init_irq     = davinci_irq_init,
 	.init_time	= davinci_timer_init,
 	.init_machine = evm_init,
@@ -806,7 +796,7 @@ MACHINE_END
 
 MACHINE_START(DAVINCI_DM6467TEVM, "DaVinci DM6467T EVM")
 	.atag_offset  = 0x100,
-	.map_io       = davinci_map_io,
+	.map_io		= dm646x_map_io,
 	.init_irq     = davinci_irq_init,
 	.init_time	= davinci_timer_init,
 	.init_machine = evm_init,
diff --git a/arch/arm/mach-davinci/board-mityomapl138.c b/arch/arm/mach-davinci/board-mityomapl138.c
index b73ce7b..9ea2628 100644
--- a/arch/arm/mach-davinci/board-mityomapl138.c
+++ b/arch/arm/mach-davinci/board-mityomapl138.c
@@ -561,14 +561,9 @@ static int __init mityomapl138_console_init(void)
 console_initcall(mityomapl138_console_init);
 #endif
 
-static void __init mityomapl138_map_io(void)
-{
-	da850_init();
-}
-
 MACHINE_START(MITYOMAPL138, "MityDSP-L138/MityARM-1808")
 	.atag_offset	= 0x100,
-	.map_io		= mityomapl138_map_io,
+	.map_io		= da850_map_io,
 	.init_irq	= cp_intc_init,
 	.init_time	= davinci_timer_init,
 	.init_machine	= mityomapl138_init,
diff --git a/arch/arm/mach-davinci/board-neuros-osd2.c b/arch/arm/mach-davinci/board-neuros-osd2.c
index 0c02aaa..6f4e7dc 100644
--- a/arch/arm/mach-davinci/board-neuros-osd2.c
+++ b/arch/arm/mach-davinci/board-neuros-osd2.c
@@ -154,11 +154,6 @@ static struct platform_device *davinci_ntosd2_devices[] __initdata = {
 	&ntosd2_leds_dev,
 };
 
-static void __init davinci_ntosd2_map_io(void)
-{
-	dm644x_init();
-}
-
 static struct davinci_mmc_config davinci_ntosd2_mmc_config = {
 	.wires		= 4,
 };
@@ -225,7 +220,7 @@ static __init void davinci_ntosd2_init(void)
 MACHINE_START(NEUROS_OSD2, "Neuros OSD2")
 	/* Maintainer: Neuros Technologies <neuros@groups.google.com> */
 	.atag_offset	= 0x100,
-	.map_io		 = davinci_ntosd2_map_io,
+	.map_io		= dm644x_map_io,
 	.init_irq	= davinci_irq_init,
 	.init_time	= davinci_timer_init,
 	.init_machine = davinci_ntosd2_init,
diff --git a/arch/arm/mach-davinci/board-omapl138-hawk.c b/arch/arm/mach-davinci/board-omapl138-hawk.c
index a3e7807..0fdb7b7 100644
--- a/arch/arm/mach-davinci/board-omapl138-hawk.c
+++ b/arch/arm/mach-davinci/board-omapl138-hawk.c
@@ -325,14 +325,9 @@ static int __init omapl138_hawk_console_init(void)
 console_initcall(omapl138_hawk_console_init);
 #endif
 
-static void __init omapl138_hawk_map_io(void)
-{
-	da850_init();
-}
-
 MACHINE_START(OMAPL138_HAWKBOARD, "AM18x/OMAP-L138 Hawkboard")
 	.atag_offset	= 0x100,
-	.map_io		= omapl138_hawk_map_io,
+	.map_io		= da850_map_io,
 	.init_irq	= cp_intc_init,
 	.init_time	= davinci_timer_init,
 	.init_machine	= omapl138_hawk_init,
diff --git a/arch/arm/mach-davinci/board-sffsdr.c b/arch/arm/mach-davinci/board-sffsdr.c
index d85accf..3c1059a 100644
--- a/arch/arm/mach-davinci/board-sffsdr.c
+++ b/arch/arm/mach-davinci/board-sffsdr.c
@@ -125,11 +125,6 @@ static struct platform_device *davinci_sffsdr_devices[] __initdata = {
 	&davinci_sffsdr_nandflash_device,
 };
 
-static void __init davinci_sffsdr_map_io(void)
-{
-	dm644x_init();
-}
-
 static __init void davinci_sffsdr_init(void)
 {
 	struct davinci_soc_info *soc_info = &davinci_soc_info;
@@ -148,7 +143,7 @@ static __init void davinci_sffsdr_init(void)
 
 MACHINE_START(SFFSDR, "Lyrtech SFFSDR")
 	.atag_offset  = 0x100,
-	.map_io	      = davinci_sffsdr_map_io,
+	.map_io		= dm644x_map_io,
 	.init_irq     = davinci_irq_init,
 	.init_time	= davinci_timer_init,
 	.init_machine = davinci_sffsdr_init,
diff --git a/arch/arm/mach-davinci/da830.c b/arch/arm/mach-davinci/da830.c
index bd88470..2e249f0 100644
--- a/arch/arm/mach-davinci/da830.c
+++ b/arch/arm/mach-davinci/da830.c
@@ -1214,7 +1214,7 @@ static struct davinci_soc_info davinci_soc_info_da830 = {
 	.emac_pdata		= &da8xx_emac_pdata,
 };
 
-void __init da830_init(void)
+void __init da830_map_io(void)
 {
 	davinci_common_init(&davinci_soc_info_da830);
 
diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
index 07d6f0e..056b148 100644
--- a/arch/arm/mach-davinci/da850.c
+++ b/arch/arm/mach-davinci/da850.c
@@ -1369,7 +1369,7 @@ static struct davinci_soc_info davinci_soc_info_da850 = {
 	.sram_len		= SZ_128K,
 };
 
-void __init da850_init(void)
+void __init da850_map_io(void)
 {
 	unsigned int v;
 
diff --git a/arch/arm/mach-davinci/da8xx-dt.c b/arch/arm/mach-davinci/da8xx-dt.c
index f06db67..92c7c34 100644
--- a/arch/arm/mach-davinci/da8xx-dt.c
+++ b/arch/arm/mach-davinci/da8xx-dt.c
@@ -95,7 +95,7 @@ static const char *const da850_boards_compat[] __initconst = {
 };
 
 DT_MACHINE_START(DA850_DT, "Generic DA850/OMAP-L138/AM18x")
-	.map_io		= da850_init,
+	.map_io		= da850_map_io,
 	.init_time	= davinci_timer_init,
 	.init_machine	= da850_init_machine,
 	.dt_compat	= da850_boards_compat,
diff --git a/arch/arm/mach-davinci/davinci.h b/arch/arm/mach-davinci/davinci.h
index c62b90c..d550717 100644
--- a/arch/arm/mach-davinci/davinci.h
+++ b/arch/arm/mach-davinci/davinci.h
@@ -82,7 +82,7 @@ int davinci_gpio_register(struct resource *res, int size, void *pdata);
 int davinci_init_wdt(void);
 
 /* DM355 function declarations */
-void dm355_init(void);
+void dm355_map_io(void);
 void dm355_init_spi0(unsigned chipselect_mask,
 		const struct spi_board_info *info, unsigned len);
 void dm355_init_asp1(u32 evt_enable);
@@ -90,7 +90,7 @@ int dm355_init_video(struct vpfe_config *, struct vpbe_config *);
 int dm355_gpio_register(void);
 
 /* DM365 function declarations */
-void dm365_init(void);
+void dm365_map_io(void);
 void dm365_init_asp(void);
 void dm365_init_vc(void);
 void dm365_init_ks(struct davinci_ks_platform_data *pdata);
@@ -101,13 +101,13 @@ int dm365_init_video(struct vpfe_config *, struct vpbe_config *);
 int dm365_gpio_register(void);
 
 /* DM644x function declarations */
-void dm644x_init(void);
+void dm644x_map_io(void);
 void dm644x_init_asp(void);
 int dm644x_init_video(struct vpfe_config *, struct vpbe_config *);
 int dm644x_gpio_register(void);
 
 /* DM646x function declarations */
-void dm646x_init(void);
+void dm646x_map_io(void);
 void dm646x_init_mcasp0(struct snd_platform_data *pdata);
 void dm646x_init_mcasp1(struct snd_platform_data *pdata);
 int dm646x_init_edma(struct edma_rsv_info *rsv);
diff --git a/arch/arm/mach-davinci/dm355.c b/arch/arm/mach-davinci/dm355.c
index bd50367..88c3c80 100644
--- a/arch/arm/mach-davinci/dm355.c
+++ b/arch/arm/mach-davinci/dm355.c
@@ -1039,7 +1039,7 @@ void __init dm355_init_asp1(u32 evt_enable)
 	platform_device_register(&dm355_asp1_device);
 }
 
-void __init dm355_init(void)
+void __init dm355_map_io(void)
 {
 	davinci_common_init(&davinci_soc_info_dm355);
 	davinci_map_sysmod();
diff --git a/arch/arm/mach-davinci/dm365.c b/arch/arm/mach-davinci/dm365.c
index 8be04ec..f979180 100644
--- a/arch/arm/mach-davinci/dm365.c
+++ b/arch/arm/mach-davinci/dm365.c
@@ -1162,7 +1162,7 @@ void __init dm365_init_rtc(void)
 	platform_device_register(&dm365_rtc_device);
 }
 
-void __init dm365_init(void)
+void __init dm365_map_io(void)
 {
 	davinci_common_init(&davinci_soc_info_dm365);
 	davinci_map_sysmod();
diff --git a/arch/arm/mach-davinci/dm644x.c b/arch/arm/mach-davinci/dm644x.c
index b437c37..80048c0 100644
--- a/arch/arm/mach-davinci/dm644x.c
+++ b/arch/arm/mach-davinci/dm644x.c
@@ -927,7 +927,7 @@ void __init dm644x_init_asp(void)
 	platform_device_register(&dm644x_asp_device);
 }
 
-void __init dm644x_init(void)
+void __init dm644x_map_io(void)
 {
 	davinci_common_init(&davinci_soc_info_dm644x);
 	davinci_map_sysmod();
diff --git a/arch/arm/mach-davinci/dm646x.c b/arch/arm/mach-davinci/dm646x.c
index da21353..b3be5c8 100644
--- a/arch/arm/mach-davinci/dm646x.c
+++ b/arch/arm/mach-davinci/dm646x.c
@@ -17,6 +17,7 @@
 #include <linux/platform_data/edma.h>
 #include <linux/platform_data/gpio-davinci.h>
 
+#include <asm/mach-types.h>
 #include <asm/mach/map.h>
 
 #include <mach/cputype.h>
@@ -952,11 +953,16 @@ int __init dm646x_init_edma(struct edma_rsv_info *rsv)
 	return IS_ERR(edma_pdev) ? PTR_ERR(edma_pdev) : 0;
 }
 
-void __init dm646x_init(void)
+#define DM6467T_EVM_REF_FREQ		33000000
+
+void __init dm646x_map_io(void)
 {
 	davinci_common_init(&davinci_soc_info_dm646x);
 	davinci_map_sysmod();
 	davinci_clk_init(davinci_soc_info_dm646x.cpu_clks);
+
+	if (machine_is_davinci_dm6467tevm())
+		davinci_set_refclk_rate(DM6467T_EVM_REF_FREQ);
 }
 
 static int __init dm646x_init_devices(void)
diff --git a/arch/arm/mach-davinci/include/mach/da8xx.h b/arch/arm/mach-davinci/include/mach/da8xx.h
index 93ff156..c760c1b 100644
--- a/arch/arm/mach-davinci/include/mach/da8xx.h
+++ b/arch/arm/mach-davinci/include/mach/da8xx.h
@@ -86,8 +86,8 @@ extern unsigned int da850_max_speed;
 #define DA8XX_SHARED_RAM_BASE	0x80000000
 #define DA8XX_ARM_RAM_BASE	0xffff0000
 
-void da830_init(void);
-void da850_init(void);
+void da830_map_io(void);
+void da850_map_io(void);
 
 int da830_register_edma(struct edma_rsv_info *rsv);
 int da850_register_edma(struct edma_rsv_info *rsv[2]);
-- 
2.7.4
