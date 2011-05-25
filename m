From: christian.riesch@omicron.at (Christian Riesch)
Date: Wed, 25 May 2011 10:37:02 +0200
Subject: [PATCH] davinci: da850: move input frequency to board specific files.
Message-ID: <1306312622-4901-1-git-send-email-christian.riesch@omicron.at>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently the input frequency of the SoC is hardcoded in the SoC specific
da850.c file to 24 MHz. Since the SoC accepts input frequencies in a wide 
range from 12 to 50 MHz, boards with different oscillator/crystal 
frequencies may be built.

This patch moves the definition of the input frequency to the board 
specific files to support boards with oscillator/crystal frequencies other 
than 24 MHz.

Signed-off-by: Christian Riesch <christian.riesch@omicron.at>
---
 arch/arm/mach-davinci/board-da850-evm.c     |    4 +++-
 arch/arm/mach-davinci/board-mityomapl138.c  |    4 +++-
 arch/arm/mach-davinci/board-omapl138-hawk.c |    4 +++-
 arch/arm/mach-davinci/da850.c               |    7 +++----
 arch/arm/mach-davinci/include/mach/da8xx.h  |    2 +-
 5 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-davinci/board-da850-evm.c b/arch/arm/mach-davinci/board-da850-evm.c
index a7b41bf..8984096 100644
--- a/arch/arm/mach-davinci/board-da850-evm.c
+++ b/arch/arm/mach-davinci/board-da850-evm.c
@@ -42,6 +42,8 @@
 #include <mach/aemif.h>
 #include <mach/spi.h>
 
+#define DA850_EVM_REF_FREQ		24000000
+
 #define DA850_EVM_PHY_ID		"0:00"
 #define DA850_LCD_PWR_PIN		GPIO_TO_PIN(2, 8)
 #define DA850_LCD_BL_PIN		GPIO_TO_PIN(2, 15)
@@ -1252,7 +1254,7 @@ console_initcall(da850_evm_console_init);
 
 static void __init da850_evm_map_io(void)
 {
-	da850_init();
+	da850_init(DA850_EVM_REF_FREQ);
 }
 
 MACHINE_START(DAVINCI_DA850_EVM, "DaVinci DA850/OMAP-L138/AM18x EVM")
diff --git a/arch/arm/mach-davinci/board-mityomapl138.c b/arch/arm/mach-davinci/board-mityomapl138.c
index 606a6f2..58fdabb 100644
--- a/arch/arm/mach-davinci/board-mityomapl138.c
+++ b/arch/arm/mach-davinci/board-mityomapl138.c
@@ -29,6 +29,8 @@
 #include <mach/mux.h>
 #include <mach/spi.h>
 
+#define MITYOMAPL138_REF_FREQ	24000000
+
 #define MITYOMAPL138_PHY_ID		""
 
 #define FACTORY_CONFIG_MAGIC	0x012C0138
@@ -561,7 +563,7 @@ console_initcall(mityomapl138_console_init);
 
 static void __init mityomapl138_map_io(void)
 {
-	da850_init();
+	da850_init(MITYOMAPL138_REF_FREQ);
 }
 
 MACHINE_START(MITYOMAPL138, "MityDSP-L138/MityARM-1808")
diff --git a/arch/arm/mach-davinci/board-omapl138-hawk.c b/arch/arm/mach-davinci/board-omapl138-hawk.c
index 67c38d0..27dd43c 100644
--- a/arch/arm/mach-davinci/board-omapl138-hawk.c
+++ b/arch/arm/mach-davinci/board-omapl138-hawk.c
@@ -21,6 +21,8 @@
 #include <mach/da8xx.h>
 #include <mach/mux.h>
 
+#define HAWKBOARD_REF_FREQ		24000000
+
 #define HAWKBOARD_PHY_ID		"0:07"
 #define DA850_HAWK_MMCSD_CD_PIN		GPIO_TO_PIN(3, 12)
 #define DA850_HAWK_MMCSD_WP_PIN		GPIO_TO_PIN(3, 13)
@@ -334,7 +336,7 @@ console_initcall(omapl138_hawk_console_init);
 
 static void __init omapl138_hawk_map_io(void)
 {
-	da850_init();
+	da850_init(HAWKBOARD_REF_FREQ);
 }
 
 MACHINE_START(OMAPL138_HAWKBOARD, "AM18x/OMAP-L138 Hawkboard")
diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
index 133aac4..0bcdc34 100644
--- a/arch/arm/mach-davinci/da850.c
+++ b/arch/arm/mach-davinci/da850.c
@@ -39,8 +39,6 @@
 #define DA850_TIMER64P2_BASE	0x01f0c000
 #define DA850_TIMER64P3_BASE	0x01f0d000
 
-#define DA850_REF_FREQ		24000000
-
 #define CFGCHIP3_ASYNC3_CLKSRC	BIT(4)
 #define CFGCHIP3_PLL1_MASTER_LOCK	BIT(5)
 #define CFGCHIP0_PLL_MASTER_LOCK	BIT(4)
@@ -57,7 +55,6 @@ static struct pll_data pll0_data = {
 
 static struct clk ref_clk = {
 	.name		= "ref_clk",
-	.rate		= DA850_REF_FREQ,
 };
 
 static struct clk pll0_clk = {
@@ -1104,10 +1101,12 @@ static struct davinci_soc_info davinci_soc_info_da850 = {
 	.reset_device		= &da8xx_wdt_device,
 };
 
-void __init da850_init(void)
+void __init da850_init(unsigned long ref_clk_rate)
 {
 	unsigned int v;
 
+	ref_clk.rate = ref_clk_rate;
+
 	davinci_common_init(&davinci_soc_info_da850);
 
 	da8xx_syscfg0_base = ioremap(DA8XX_SYSCFG0_BASE, SZ_4K);
diff --git a/arch/arm/mach-davinci/include/mach/da8xx.h b/arch/arm/mach-davinci/include/mach/da8xx.h
index ad64da7..e8e704e 100644
--- a/arch/arm/mach-davinci/include/mach/da8xx.h
+++ b/arch/arm/mach-davinci/include/mach/da8xx.h
@@ -70,7 +70,7 @@ extern unsigned int da850_max_speed;
 #define DA8XX_ARM_RAM_BASE	0xffff0000
 
 void __init da830_init(void);
-void __init da850_init(void);
+void __init da850_init(unsigned long ref_clk_rate);
 
 int da830_register_edma(struct edma_rsv_info *rsv);
 int da850_register_edma(struct edma_rsv_info *rsv[2]);
-- 
1.7.0.4
