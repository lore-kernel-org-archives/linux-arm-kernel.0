From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 25 Jan 2013 23:35:52 +0000
Subject: [PATCH 09/13] ARM: spear: make clock driver independent of headers
In-Reply-To: <1359156956-32404-1-git-send-email-arnd@arndb.de>
References: <1359156956-32404-1-git-send-email-arnd@arndb.de>
Message-ID: <1359156956-32404-10-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Device drivers should not access MMIO registers through hardcoded
platform specific address constants. Instead, we can pass the
MMIO token to the spear clock driver in the initialization routine
to contain that knowledge in the platform code itself.

Ideally, the clock driver would use of_iomap() or similar to
get the address, and that can be used later, but for now, this
is the minimal change.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-spear/generic.h                | 13 +++---
 arch/arm/mach-spear/include/mach/misc_regs.h |  2 +-
 arch/arm/mach-spear/include/mach/spear.h     | 28 +++++-------
 arch/arm/mach-spear/spear1310.c              |  2 -
 arch/arm/mach-spear/spear13xx.c              |  4 +-
 arch/arm/mach-spear/spear320.c               |  2 +-
 arch/arm/mach-spear/spear3xx.c               |  7 +--
 arch/arm/mach-spear/spear6xx.c               |  9 ++--
 drivers/clk/spear/spear1310_clock.c          | 64 ++++++++++++++--------------
 drivers/clk/spear/spear1340_clock.c          | 63 ++++++++++++++-------------
 drivers/clk/spear/spear3xx_clock.c           | 60 +++++++++++++++-----------
 drivers/clk/spear/spear6xx_clock.c           | 31 +++++++-------
 12 files changed, 143 insertions(+), 142 deletions(-)

diff --git a/arch/arm/mach-spear/generic.h b/arch/arm/mach-spear/generic.h
index 58c15c6..a0394f8 100644
--- a/arch/arm/mach-spear/generic.h
+++ b/arch/arm/mach-spear/generic.h
@@ -29,10 +29,11 @@ extern struct dw_dma_slave nand_write_dma_priv;
 bool dw_dma_filter(struct dma_chan *chan, void *slave);
 
 void __init spear_setup_of_timer(void);
-void __init spear3xx_clk_init(void);
+void __init spear3xx_clk_init(void __iomem *misc_base,
+			      void __iomem *soc_config_base);
 void __init spear3xx_map_io(void);
 void __init spear3xx_dt_init_irq(void);
-void __init spear6xx_clk_init(void);
+void __init spear6xx_clk_init(void __iomem *misc_base);
 void __init spear13xx_map_io(void);
 void __init spear13xx_dt_init_irq(void);
 void __init spear13xx_l2x0_init(void);
@@ -45,15 +46,15 @@ void __cpuinit spear13xx_cpu_die(unsigned int cpu);
 extern struct smp_operations spear13xx_smp_ops;
 
 #ifdef CONFIG_MACH_SPEAR1310
-void __init spear1310_clk_init(void);
+void __init spear1310_clk_init(void __iomem *misc_base, void __iomem *ras_base);
 #else
-static inline void spear1310_clk_init(void) {}
+static inline void spear1310_clk_init(void __iomem *misc_base, void __iomem *ras_base) {}
 #endif
 
 #ifdef CONFIG_MACH_SPEAR1340
-void __init spear1340_clk_init(void);
+void __init spear1340_clk_init(void __iomem *misc_base);
 #else
-static inline void spear1340_clk_init(void) {}
+static inline void spear1340_clk_init(void __iomem *misc_base) {}
 #endif
 
 #endif /* __MACH_GENERIC_H */
diff --git a/arch/arm/mach-spear/include/mach/misc_regs.h b/arch/arm/mach-spear/include/mach/misc_regs.h
index 075812c..935639c 100644
--- a/arch/arm/mach-spear/include/mach/misc_regs.h
+++ b/arch/arm/mach-spear/include/mach/misc_regs.h
@@ -16,7 +16,7 @@
 
 #include <mach/spear.h>
 
-#define MISC_BASE		IOMEM(VA_SPEAR_ICM3_MISC_REG_BASE)
+#define MISC_BASE		(VA_SPEAR_ICM3_MISC_REG_BASE)
 #define DMA_CHN_CFG		(MISC_BASE + 0x0A0)
 
 #endif /* __MACH_MISC_REGS_H */
diff --git a/arch/arm/mach-spear/include/mach/spear.h b/arch/arm/mach-spear/include/mach/spear.h
index 2198ab9..374ddc3 100644
--- a/arch/arm/mach-spear/include/mach/spear.h
+++ b/arch/arm/mach-spear/include/mach/spear.h
@@ -19,23 +19,23 @@
 
 /* ICM1 - Low speed connection */
 #define SPEAR_ICM1_2_BASE		UL(0xD0000000)
-#define VA_SPEAR_ICM1_2_BASE		UL(0xFD000000)
+#define VA_SPEAR_ICM1_2_BASE		IOMEM(0xFD000000)
 #define SPEAR_ICM1_UART_BASE		UL(0xD0000000)
-#define VA_SPEAR_ICM1_UART_BASE		(VA_SPEAR_ICM1_2_BASE | SPEAR_ICM1_UART_BASE)
+#define VA_SPEAR_ICM1_UART_BASE		(VA_SPEAR_ICM1_2_BASE - SPEAR_ICM1_2_BASE + SPEAR_ICM1_UART_BASE)
 #define SPEAR3XX_ICM1_SSP_BASE		UL(0xD0100000)
 
 /* ML-1, 2 - Multi Layer CPU Subsystem */
 #define SPEAR_ICM3_ML1_2_BASE		UL(0xF0000000)
-#define VA_SPEAR6XX_ML_CPU_BASE		UL(0xF0000000)
+#define VA_SPEAR6XX_ML_CPU_BASE		IOMEM(0xF0000000)
 
 /* ICM3 - Basic Subsystem */
 #define SPEAR_ICM3_SMI_CTRL_BASE	UL(0xFC000000)
-#define VA_SPEAR_ICM3_SMI_CTRL_BASE	UL(0xFC000000)
+#define VA_SPEAR_ICM3_SMI_CTRL_BASE	IOMEM(0xFC000000)
 #define SPEAR_ICM3_DMA_BASE		UL(0xFC400000)
 #define SPEAR_ICM3_SYS_CTRL_BASE	UL(0xFCA00000)
-#define VA_SPEAR_ICM3_SYS_CTRL_BASE	(VA_SPEAR_ICM3_SMI_CTRL_BASE | SPEAR_ICM3_SYS_CTRL_BASE)
+#define VA_SPEAR_ICM3_SYS_CTRL_BASE	(VA_SPEAR_ICM3_SMI_CTRL_BASE - SPEAR_ICM3_SMI_CTRL_BASE + SPEAR_ICM3_SYS_CTRL_BASE)
 #define SPEAR_ICM3_MISC_REG_BASE	UL(0xFCA80000)
-#define VA_SPEAR_ICM3_MISC_REG_BASE	(VA_SPEAR_ICM3_SMI_CTRL_BASE | SPEAR_ICM3_MISC_REG_BASE)
+#define VA_SPEAR_ICM3_MISC_REG_BASE	(VA_SPEAR_ICM3_SMI_CTRL_BASE - SPEAR_ICM3_SMI_CTRL_BASE + SPEAR_ICM3_MISC_REG_BASE)
 
 /* Debug uart for linux, will be used for debug and uncompress messages */
 #define SPEAR_DBG_UART_BASE		SPEAR_ICM1_UART_BASE
@@ -44,20 +44,11 @@
 /* Sysctl base for spear platform */
 #define SPEAR_SYS_CTRL_BASE		SPEAR_ICM3_SYS_CTRL_BASE
 #define VA_SPEAR_SYS_CTRL_BASE		VA_SPEAR_ICM3_SYS_CTRL_BASE
+#endif /* SPEAR3xx || SPEAR6XX */
 
 /* SPEAr320 Macros */
 #define SPEAR320_SOC_CONFIG_BASE	UL(0xB3000000)
-#define VA_SPEAR320_SOC_CONFIG_BASE	UL(0xFE000000)
-#define SPEAR320_CONTROL_REG		IOMEM(VA_SPEAR320_SOC_CONFIG_BASE)
-#define SPEAR320_EXT_CTRL_REG		IOMEM(VA_SPEAR320_SOC_CONFIG_BASE + 0x0018)
-	#define SPEAR320_UARTX_PCLK_MASK		0x1
-	#define SPEAR320_UART2_PCLK_SHIFT		8
-	#define SPEAR320_UART3_PCLK_SHIFT		9
-	#define SPEAR320_UART4_PCLK_SHIFT		10
-	#define SPEAR320_UART5_PCLK_SHIFT		11
-	#define SPEAR320_UART6_PCLK_SHIFT		12
-	#define SPEAR320_RS485_PCLK_SHIFT		13
-#endif /* SPEAR3xx || SPEAR6XX */
+#define VA_SPEAR320_SOC_CONFIG_BASE	IOMEM(0xFE000000)
 
 #ifdef CONFIG_ARCH_SPEAR13XX
 
@@ -79,6 +70,9 @@
 #define A9SM_AND_MPMC_BASE			UL(0xEC000000)
 #define VA_A9SM_AND_MPMC_BASE			IOMEM(0xFC000000)
 
+#define SPEAR1310_RAS_BASE			UL(0xD8400000)
+#define VA_SPEAR1310_RAS_BASE			IOMEM(UL(0xFA400000))
+
 /* A9SM peripheral offsets */
 #define A9SM_PERIP_BASE				UL(0xEC800000)
 #define VA_A9SM_PERIP_BASE			IOMEM(0xFC800000)
diff --git a/arch/arm/mach-spear/spear1310.c b/arch/arm/mach-spear/spear1310.c
index cddb8fe..7c9ae71 100644
--- a/arch/arm/mach-spear/spear1310.c
+++ b/arch/arm/mach-spear/spear1310.c
@@ -30,8 +30,6 @@
 
 #define SPEAR1310_RAS_GRP1_BASE			UL(0xD8000000)
 #define VA_SPEAR1310_RAS_GRP1_BASE		UL(0xFA000000)
-#define SPEAR1310_RAS_BASE			UL(0xD8400000)
-#define VA_SPEAR1310_RAS_BASE			IOMEM(UL(0xFA400000))
 
 static struct arasan_cf_pdata cf_pdata = {
 	.cf_if_clk = CF_IF_CLK_166M,
diff --git a/arch/arm/mach-spear/spear13xx.c b/arch/arm/mach-spear/spear13xx.c
index 82d53b7..9758e42 100644
--- a/arch/arm/mach-spear/spear13xx.c
+++ b/arch/arm/mach-spear/spear13xx.c
@@ -147,9 +147,9 @@ void __init spear13xx_map_io(void)
 static void __init spear13xx_clk_init(void)
 {
 	if (of_machine_is_compatible("st,spear1310"))
-		spear1310_clk_init();
+		spear1310_clk_init(VA_MISC_BASE, VA_SPEAR1310_RAS_BASE);
 	else if (of_machine_is_compatible("st,spear1340"))
-		spear1340_clk_init();
+		spear1340_clk_init(VA_MISC_BASE);
 	else
 		pr_err("%s: Unknown machine\n", __func__);
 }
diff --git a/arch/arm/mach-spear/spear320.c b/arch/arm/mach-spear/spear320.c
index 1b98989..9d9082d 100644
--- a/arch/arm/mach-spear/spear320.c
+++ b/arch/arm/mach-spear/spear320.c
@@ -254,7 +254,7 @@ static const char * const spear320_dt_board_compat[] = {
 
 struct map_desc spear320_io_desc[] __initdata = {
 	{
-		.virtual	= VA_SPEAR320_SOC_CONFIG_BASE,
+		.virtual	= (unsigned long)VA_SPEAR320_SOC_CONFIG_BASE,
 		.pfn		= __phys_to_pfn(SPEAR320_SOC_CONFIG_BASE),
 		.length		= SZ_16M,
 		.type		= MT_DEVICE
diff --git a/arch/arm/mach-spear/spear3xx.c b/arch/arm/mach-spear/spear3xx.c
index b502672..73ae7f7 100644
--- a/arch/arm/mach-spear/spear3xx.c
+++ b/arch/arm/mach-spear/spear3xx.c
@@ -25,6 +25,7 @@
 #include "pl080.h"
 #include "generic.h"
 #include <mach/spear.h>
+#include <mach/misc_regs.h>
 
 /* ssp device registration */
 struct pl022_ssp_controller pl022_plat_data = {
@@ -71,12 +72,12 @@ struct pl08x_platform_data pl080_plat_data = {
  */
 struct map_desc spear3xx_io_desc[] __initdata = {
 	{
-		.virtual	= VA_SPEAR_ICM1_2_BASE,
+		.virtual	= (unsigned long)VA_SPEAR_ICM1_2_BASE,
 		.pfn		= __phys_to_pfn(SPEAR_ICM1_2_BASE),
 		.length		= SZ_16M,
 		.type		= MT_DEVICE
 	}, {
-		.virtual	= VA_SPEAR_ICM3_SMI_CTRL_BASE,
+		.virtual	= (unsigned long)VA_SPEAR_ICM3_SMI_CTRL_BASE,
 		.pfn		= __phys_to_pfn(SPEAR_ICM3_SMI_CTRL_BASE),
 		.length		= SZ_16M,
 		.type		= MT_DEVICE
@@ -94,7 +95,7 @@ static void __init spear3xx_timer_init(void)
 	char pclk_name[] = "pll3_clk";
 	struct clk *gpt_clk, *pclk;
 
-	spear3xx_clk_init();
+	spear3xx_clk_init(MISC_BASE, VA_SPEAR320_SOC_CONFIG_BASE);
 
 	/* get the system timer clock */
 	gpt_clk = clk_get_sys("gpt0", NULL);
diff --git a/arch/arm/mach-spear/spear6xx.c b/arch/arm/mach-spear/spear6xx.c
index 32d7d47..79cbda0 100644
--- a/arch/arm/mach-spear/spear6xx.c
+++ b/arch/arm/mach-spear/spear6xx.c
@@ -28,6 +28,7 @@
 #include "pl080.h"
 #include "generic.h"
 #include <mach/spear.h>
+#include <mach/misc_regs.h>
 
 /* dmac device registration */
 static struct pl08x_channel_data spear600_dma_info[] = {
@@ -351,17 +352,17 @@ struct pl08x_platform_data pl080_plat_data = {
  */
 struct map_desc spear6xx_io_desc[] __initdata = {
 	{
-		.virtual	= VA_SPEAR6XX_ML_CPU_BASE,
+		.virtual	= (unsigned long)VA_SPEAR6XX_ML_CPU_BASE,
 		.pfn		= __phys_to_pfn(SPEAR_ICM3_ML1_2_BASE),
 		.length		= 2 * SZ_16M,
 		.type		= MT_DEVICE
 	},	{
-		.virtual	= VA_SPEAR_ICM1_2_BASE,
+		.virtual	= (unsigned long)VA_SPEAR_ICM1_2_BASE,
 		.pfn		= __phys_to_pfn(SPEAR_ICM1_2_BASE),
 		.length		= SZ_16M,
 		.type		= MT_DEVICE
 	}, {
-		.virtual	= VA_SPEAR_ICM3_SMI_CTRL_BASE,
+		.virtual	= (unsigned long)VA_SPEAR_ICM3_SMI_CTRL_BASE,
 		.pfn		= __phys_to_pfn(SPEAR_ICM3_SMI_CTRL_BASE),
 		.length		= SZ_16M,
 		.type		= MT_DEVICE
@@ -379,7 +380,7 @@ static void __init spear6xx_timer_init(void)
 	char pclk_name[] = "pll3_clk";
 	struct clk *gpt_clk, *pclk;
 
-	spear6xx_clk_init();
+	spear6xx_clk_init(MISC_BASE);
 
 	/* get the system timer clock */
 	gpt_clk = clk_get_sys("gpt0", NULL);
diff --git a/drivers/clk/spear/spear1310_clock.c b/drivers/clk/spear/spear1310_clock.c
index ed9af42..aedbbe1 100644
--- a/drivers/clk/spear/spear1310_clock.c
+++ b/drivers/clk/spear/spear1310_clock.c
@@ -17,12 +17,10 @@
 #include <linux/io.h>
 #include <linux/of_platform.h>
 #include <linux/spinlock_types.h>
-#include <mach/spear.h>
 #include "clk.h"
 
-#define VA_SPEAR1310_RAS_BASE			IOMEM(UL(0xFA400000))
 /* PLL related registers and bit values */
-#define SPEAR1310_PLL_CFG			(VA_MISC_BASE + 0x210)
+#define SPEAR1310_PLL_CFG			(misc_base + 0x210)
 	/* PLL_CFG bit values */
 	#define SPEAR1310_CLCD_SYNT_CLK_MASK		1
 	#define SPEAR1310_CLCD_SYNT_CLK_SHIFT		31
@@ -35,15 +33,15 @@
 	#define SPEAR1310_PLL2_CLK_SHIFT		22
 	#define SPEAR1310_PLL1_CLK_SHIFT		20
 
-#define SPEAR1310_PLL1_CTR			(VA_MISC_BASE + 0x214)
-#define SPEAR1310_PLL1_FRQ			(VA_MISC_BASE + 0x218)
-#define SPEAR1310_PLL2_CTR			(VA_MISC_BASE + 0x220)
-#define SPEAR1310_PLL2_FRQ			(VA_MISC_BASE + 0x224)
-#define SPEAR1310_PLL3_CTR			(VA_MISC_BASE + 0x22C)
-#define SPEAR1310_PLL3_FRQ			(VA_MISC_BASE + 0x230)
-#define SPEAR1310_PLL4_CTR			(VA_MISC_BASE + 0x238)
-#define SPEAR1310_PLL4_FRQ			(VA_MISC_BASE + 0x23C)
-#define SPEAR1310_PERIP_CLK_CFG			(VA_MISC_BASE + 0x244)
+#define SPEAR1310_PLL1_CTR			(misc_base + 0x214)
+#define SPEAR1310_PLL1_FRQ			(misc_base + 0x218)
+#define SPEAR1310_PLL2_CTR			(misc_base + 0x220)
+#define SPEAR1310_PLL2_FRQ			(misc_base + 0x224)
+#define SPEAR1310_PLL3_CTR			(misc_base + 0x22C)
+#define SPEAR1310_PLL3_FRQ			(misc_base + 0x230)
+#define SPEAR1310_PLL4_CTR			(misc_base + 0x238)
+#define SPEAR1310_PLL4_FRQ			(misc_base + 0x23C)
+#define SPEAR1310_PERIP_CLK_CFG			(misc_base + 0x244)
 	/* PERIP_CLK_CFG bit values */
 	#define SPEAR1310_GPT_OSC24_VAL			0
 	#define SPEAR1310_GPT_APB_VAL			1
@@ -65,7 +63,7 @@
 	#define SPEAR1310_C3_CLK_MASK			1
 	#define SPEAR1310_C3_CLK_SHIFT			1
 
-#define SPEAR1310_GMAC_CLK_CFG			(VA_MISC_BASE + 0x248)
+#define SPEAR1310_GMAC_CLK_CFG			(misc_base + 0x248)
 	#define SPEAR1310_GMAC_PHY_IF_SEL_MASK		3
 	#define SPEAR1310_GMAC_PHY_IF_SEL_SHIFT		4
 	#define SPEAR1310_GMAC_PHY_CLK_MASK		1
@@ -73,7 +71,7 @@
 	#define SPEAR1310_GMAC_PHY_INPUT_CLK_MASK	2
 	#define SPEAR1310_GMAC_PHY_INPUT_CLK_SHIFT	1
 
-#define SPEAR1310_I2S_CLK_CFG			(VA_MISC_BASE + 0x24C)
+#define SPEAR1310_I2S_CLK_CFG			(misc_base + 0x24C)
 	/* I2S_CLK_CFG register mask */
 	#define SPEAR1310_I2S_SCLK_X_MASK		0x1F
 	#define SPEAR1310_I2S_SCLK_X_SHIFT		27
@@ -91,21 +89,21 @@
 	#define SPEAR1310_I2S_SRC_CLK_MASK		2
 	#define SPEAR1310_I2S_SRC_CLK_SHIFT		0
 
-#define SPEAR1310_C3_CLK_SYNT			(VA_MISC_BASE + 0x250)
-#define SPEAR1310_UART_CLK_SYNT			(VA_MISC_BASE + 0x254)
-#define SPEAR1310_GMAC_CLK_SYNT			(VA_MISC_BASE + 0x258)
-#define SPEAR1310_SDHCI_CLK_SYNT		(VA_MISC_BASE + 0x25C)
-#define SPEAR1310_CFXD_CLK_SYNT			(VA_MISC_BASE + 0x260)
-#define SPEAR1310_ADC_CLK_SYNT			(VA_MISC_BASE + 0x264)
-#define SPEAR1310_AMBA_CLK_SYNT			(VA_MISC_BASE + 0x268)
-#define SPEAR1310_CLCD_CLK_SYNT			(VA_MISC_BASE + 0x270)
-#define SPEAR1310_RAS_CLK_SYNT0			(VA_MISC_BASE + 0x280)
-#define SPEAR1310_RAS_CLK_SYNT1			(VA_MISC_BASE + 0x288)
-#define SPEAR1310_RAS_CLK_SYNT2			(VA_MISC_BASE + 0x290)
-#define SPEAR1310_RAS_CLK_SYNT3			(VA_MISC_BASE + 0x298)
+#define SPEAR1310_C3_CLK_SYNT			(misc_base + 0x250)
+#define SPEAR1310_UART_CLK_SYNT			(misc_base + 0x254)
+#define SPEAR1310_GMAC_CLK_SYNT			(misc_base + 0x258)
+#define SPEAR1310_SDHCI_CLK_SYNT		(misc_base + 0x25C)
+#define SPEAR1310_CFXD_CLK_SYNT			(misc_base + 0x260)
+#define SPEAR1310_ADC_CLK_SYNT			(misc_base + 0x264)
+#define SPEAR1310_AMBA_CLK_SYNT			(misc_base + 0x268)
+#define SPEAR1310_CLCD_CLK_SYNT			(misc_base + 0x270)
+#define SPEAR1310_RAS_CLK_SYNT0			(misc_base + 0x280)
+#define SPEAR1310_RAS_CLK_SYNT1			(misc_base + 0x288)
+#define SPEAR1310_RAS_CLK_SYNT2			(misc_base + 0x290)
+#define SPEAR1310_RAS_CLK_SYNT3			(misc_base + 0x298)
 	/* Check Fractional synthesizer reg masks */
 
-#define SPEAR1310_PERIP1_CLK_ENB		(VA_MISC_BASE + 0x300)
+#define SPEAR1310_PERIP1_CLK_ENB		(misc_base + 0x300)
 	/* PERIP1_CLK_ENB register masks */
 	#define SPEAR1310_RTC_CLK_ENB			31
 	#define SPEAR1310_ADC_CLK_ENB			30
@@ -138,7 +136,7 @@
 	#define SPEAR1310_SYSROM_CLK_ENB		1
 	#define SPEAR1310_BUS_CLK_ENB			0
 
-#define SPEAR1310_PERIP2_CLK_ENB		(VA_MISC_BASE + 0x304)
+#define SPEAR1310_PERIP2_CLK_ENB		(misc_base + 0x304)
 	/* PERIP2_CLK_ENB register masks */
 	#define SPEAR1310_THSENS_CLK_ENB		8
 	#define SPEAR1310_I2S_REF_PAD_CLK_ENB		7
@@ -150,7 +148,7 @@
 	#define SPEAR1310_DDR_CORE_CLK_ENB		1
 	#define SPEAR1310_DDR_CTRL_CLK_ENB		0
 
-#define SPEAR1310_RAS_CLK_ENB			(VA_MISC_BASE + 0x310)
+#define SPEAR1310_RAS_CLK_ENB			(misc_base + 0x310)
 	/* RAS_CLK_ENB register masks */
 	#define SPEAR1310_SYNT3_CLK_ENB			17
 	#define SPEAR1310_SYNT2_CLK_ENB			16
@@ -172,7 +170,7 @@
 	#define SPEAR1310_ACLK_CLK_ENB			0
 
 /* RAS Area Control Register */
-#define SPEAR1310_RAS_CTRL_REG0			(VA_SPEAR1310_RAS_BASE + 0x000)
+#define SPEAR1310_RAS_CTRL_REG0			(ras_base + 0x000)
 	#define SPEAR1310_SSP1_CLK_MASK			3
 	#define SPEAR1310_SSP1_CLK_SHIFT		26
 	#define SPEAR1310_TDM_CLK_MASK			1
@@ -197,12 +195,12 @@
 	#define SPEAR1310_PCI_CLK_MASK			1
 	#define SPEAR1310_PCI_CLK_SHIFT			0
 
-#define SPEAR1310_RAS_CTRL_REG1			(VA_SPEAR1310_RAS_BASE + 0x004)
+#define SPEAR1310_RAS_CTRL_REG1			(ras_base + 0x004)
 	#define SPEAR1310_PHY_CLK_MASK			0x3
 	#define SPEAR1310_RMII_PHY_CLK_SHIFT		0
 	#define SPEAR1310_SMII_RGMII_PHY_CLK_SHIFT	2
 
-#define SPEAR1310_RAS_SW_CLK_CTRL		(VA_SPEAR1310_RAS_BASE + 0x0148)
+#define SPEAR1310_RAS_SW_CLK_CTRL		(ras_base + 0x0148)
 	#define SPEAR1310_CAN1_CLK_ENB			25
 	#define SPEAR1310_CAN0_CLK_ENB			24
 	#define SPEAR1310_GPT64_CLK_ENB			23
@@ -385,7 +383,7 @@ static const char *ssp1_parents[] = { "ras_apb_clk", "gen_syn1_clk",
 static const char *pci_parents[] = { "ras_pll3_clk", "gen_syn2_clk", };
 static const char *tdm_parents[] = { "ras_pll3_clk", "gen_syn1_clk", };
 
-void __init spear1310_clk_init(void)
+void __init spear1310_clk_init(void __iomem *misc_base, void __iomem *ras_base)
 {
 	struct clk *clk, *clk1;
 
diff --git a/drivers/clk/spear/spear1340_clock.c b/drivers/clk/spear/spear1340_clock.c
index 82abea3..3ceb450 100644
--- a/drivers/clk/spear/spear1340_clock.c
+++ b/drivers/clk/spear/spear1340_clock.c
@@ -17,18 +17,17 @@
 #include <linux/io.h>
 #include <linux/of_platform.h>
 #include <linux/spinlock_types.h>
-#include <mach/spear.h>
 #include "clk.h"
 
 /* Clock Configuration Registers */
-#define SPEAR1340_SYS_CLK_CTRL			(VA_MISC_BASE + 0x200)
+#define SPEAR1340_SYS_CLK_CTRL			(misc_base + 0x200)
 	#define SPEAR1340_HCLK_SRC_SEL_SHIFT	27
 	#define SPEAR1340_HCLK_SRC_SEL_MASK	1
 	#define SPEAR1340_SCLK_SRC_SEL_SHIFT	23
 	#define SPEAR1340_SCLK_SRC_SEL_MASK	3
 
 /* PLL related registers and bit values */
-#define SPEAR1340_PLL_CFG			(VA_MISC_BASE + 0x210)
+#define SPEAR1340_PLL_CFG			(misc_base + 0x210)
 	/* PLL_CFG bit values */
 	#define SPEAR1340_CLCD_SYNT_CLK_MASK		1
 	#define SPEAR1340_CLCD_SYNT_CLK_SHIFT		31
@@ -40,15 +39,15 @@
 	#define SPEAR1340_PLL2_CLK_SHIFT		22
 	#define SPEAR1340_PLL1_CLK_SHIFT		20
 
-#define SPEAR1340_PLL1_CTR			(VA_MISC_BASE + 0x214)
-#define SPEAR1340_PLL1_FRQ			(VA_MISC_BASE + 0x218)
-#define SPEAR1340_PLL2_CTR			(VA_MISC_BASE + 0x220)
-#define SPEAR1340_PLL2_FRQ			(VA_MISC_BASE + 0x224)
-#define SPEAR1340_PLL3_CTR			(VA_MISC_BASE + 0x22C)
-#define SPEAR1340_PLL3_FRQ			(VA_MISC_BASE + 0x230)
-#define SPEAR1340_PLL4_CTR			(VA_MISC_BASE + 0x238)
-#define SPEAR1340_PLL4_FRQ			(VA_MISC_BASE + 0x23C)
-#define SPEAR1340_PERIP_CLK_CFG			(VA_MISC_BASE + 0x244)
+#define SPEAR1340_PLL1_CTR			(misc_base + 0x214)
+#define SPEAR1340_PLL1_FRQ			(misc_base + 0x218)
+#define SPEAR1340_PLL2_CTR			(misc_base + 0x220)
+#define SPEAR1340_PLL2_FRQ			(misc_base + 0x224)
+#define SPEAR1340_PLL3_CTR			(misc_base + 0x22C)
+#define SPEAR1340_PLL3_FRQ			(misc_base + 0x230)
+#define SPEAR1340_PLL4_CTR			(misc_base + 0x238)
+#define SPEAR1340_PLL4_FRQ			(misc_base + 0x23C)
+#define SPEAR1340_PERIP_CLK_CFG			(misc_base + 0x244)
 	/* PERIP_CLK_CFG bit values */
 	#define SPEAR1340_SPDIF_CLK_MASK		1
 	#define SPEAR1340_SPDIF_OUT_CLK_SHIFT		15
@@ -66,13 +65,13 @@
 	#define SPEAR1340_C3_CLK_MASK			1
 	#define SPEAR1340_C3_CLK_SHIFT			1
 
-#define SPEAR1340_GMAC_CLK_CFG			(VA_MISC_BASE + 0x248)
+#define SPEAR1340_GMAC_CLK_CFG			(misc_base + 0x248)
 	#define SPEAR1340_GMAC_PHY_CLK_MASK		1
 	#define SPEAR1340_GMAC_PHY_CLK_SHIFT		2
 	#define SPEAR1340_GMAC_PHY_INPUT_CLK_MASK	2
 	#define SPEAR1340_GMAC_PHY_INPUT_CLK_SHIFT	0
 
-#define SPEAR1340_I2S_CLK_CFG			(VA_MISC_BASE + 0x24C)
+#define SPEAR1340_I2S_CLK_CFG			(misc_base + 0x24C)
 	/* I2S_CLK_CFG register mask */
 	#define SPEAR1340_I2S_SCLK_X_MASK		0x1F
 	#define SPEAR1340_I2S_SCLK_X_SHIFT		27
@@ -90,21 +89,21 @@
 	#define SPEAR1340_I2S_SRC_CLK_MASK		2
 	#define SPEAR1340_I2S_SRC_CLK_SHIFT		0
 
-#define SPEAR1340_C3_CLK_SYNT			(VA_MISC_BASE + 0x250)
-#define SPEAR1340_UART0_CLK_SYNT		(VA_MISC_BASE + 0x254)
-#define SPEAR1340_UART1_CLK_SYNT		(VA_MISC_BASE + 0x258)
-#define SPEAR1340_GMAC_CLK_SYNT			(VA_MISC_BASE + 0x25C)
-#define SPEAR1340_SDHCI_CLK_SYNT		(VA_MISC_BASE + 0x260)
-#define SPEAR1340_CFXD_CLK_SYNT			(VA_MISC_BASE + 0x264)
-#define SPEAR1340_ADC_CLK_SYNT			(VA_MISC_BASE + 0x270)
-#define SPEAR1340_AMBA_CLK_SYNT			(VA_MISC_BASE + 0x274)
-#define SPEAR1340_CLCD_CLK_SYNT			(VA_MISC_BASE + 0x27C)
-#define SPEAR1340_SYS_CLK_SYNT			(VA_MISC_BASE + 0x284)
-#define SPEAR1340_GEN_CLK_SYNT0			(VA_MISC_BASE + 0x28C)
-#define SPEAR1340_GEN_CLK_SYNT1			(VA_MISC_BASE + 0x294)
-#define SPEAR1340_GEN_CLK_SYNT2			(VA_MISC_BASE + 0x29C)
-#define SPEAR1340_GEN_CLK_SYNT3			(VA_MISC_BASE + 0x304)
-#define SPEAR1340_PERIP1_CLK_ENB		(VA_MISC_BASE + 0x30C)
+#define SPEAR1340_C3_CLK_SYNT			(misc_base + 0x250)
+#define SPEAR1340_UART0_CLK_SYNT		(misc_base + 0x254)
+#define SPEAR1340_UART1_CLK_SYNT		(misc_base + 0x258)
+#define SPEAR1340_GMAC_CLK_SYNT			(misc_base + 0x25C)
+#define SPEAR1340_SDHCI_CLK_SYNT		(misc_base + 0x260)
+#define SPEAR1340_CFXD_CLK_SYNT			(misc_base + 0x264)
+#define SPEAR1340_ADC_CLK_SYNT			(misc_base + 0x270)
+#define SPEAR1340_AMBA_CLK_SYNT			(misc_base + 0x274)
+#define SPEAR1340_CLCD_CLK_SYNT			(misc_base + 0x27C)
+#define SPEAR1340_SYS_CLK_SYNT			(misc_base + 0x284)
+#define SPEAR1340_GEN_CLK_SYNT0			(misc_base + 0x28C)
+#define SPEAR1340_GEN_CLK_SYNT1			(misc_base + 0x294)
+#define SPEAR1340_GEN_CLK_SYNT2			(misc_base + 0x29C)
+#define SPEAR1340_GEN_CLK_SYNT3			(misc_base + 0x304)
+#define SPEAR1340_PERIP1_CLK_ENB		(misc_base + 0x30C)
 	#define SPEAR1340_RTC_CLK_ENB			31
 	#define SPEAR1340_ADC_CLK_ENB			30
 	#define SPEAR1340_C3_CLK_ENB			29
@@ -133,7 +132,7 @@
 	#define SPEAR1340_SYSROM_CLK_ENB		1
 	#define SPEAR1340_BUS_CLK_ENB			0
 
-#define SPEAR1340_PERIP2_CLK_ENB		(VA_MISC_BASE + 0x310)
+#define SPEAR1340_PERIP2_CLK_ENB		(misc_base + 0x310)
 	#define SPEAR1340_THSENS_CLK_ENB		8
 	#define SPEAR1340_I2S_REF_PAD_CLK_ENB		7
 	#define SPEAR1340_ACP_CLK_ENB			6
@@ -144,7 +143,7 @@
 	#define SPEAR1340_DDR_CORE_CLK_ENB		1
 	#define SPEAR1340_DDR_CTRL_CLK_ENB		0
 
-#define SPEAR1340_PERIP3_CLK_ENB		(VA_MISC_BASE + 0x314)
+#define SPEAR1340_PERIP3_CLK_ENB		(misc_base + 0x314)
 	#define SPEAR1340_PLGPIO_CLK_ENB		18
 	#define SPEAR1340_VIDEO_DEC_CLK_ENB		16
 	#define SPEAR1340_VIDEO_ENC_CLK_ENB		15
@@ -441,7 +440,7 @@ static const char *gen_synth0_1_parents[] = { "vco1div4_clk", "vco3div2_clk",
 static const char *gen_synth2_3_parents[] = { "vco1div4_clk", "vco2div2_clk",
 	"pll2_clk", };
 
-void __init spear1340_clk_init(void)
+void __init spear1340_clk_init(void __iomem *misc_base)
 {
 	struct clk *clk, *clk1;
 
diff --git a/drivers/clk/spear/spear3xx_clock.c b/drivers/clk/spear/spear3xx_clock.c
index 33d3ac5..f9ec43f 100644
--- a/drivers/clk/spear/spear3xx_clock.c
+++ b/drivers/clk/spear/spear3xx_clock.c
@@ -15,21 +15,20 @@
 #include <linux/io.h>
 #include <linux/of_platform.h>
 #include <linux/spinlock_types.h>
-#include <mach/misc_regs.h>
 #include "clk.h"
 
 static DEFINE_SPINLOCK(_lock);
 
-#define PLL1_CTR			(MISC_BASE + 0x008)
-#define PLL1_FRQ			(MISC_BASE + 0x00C)
-#define PLL2_CTR			(MISC_BASE + 0x014)
-#define PLL2_FRQ			(MISC_BASE + 0x018)
-#define PLL_CLK_CFG			(MISC_BASE + 0x020)
+#define PLL1_CTR			(misc_base + 0x008)
+#define PLL1_FRQ			(misc_base + 0x00C)
+#define PLL2_CTR			(misc_base + 0x014)
+#define PLL2_FRQ			(misc_base + 0x018)
+#define PLL_CLK_CFG			(misc_base + 0x020)
 	/* PLL_CLK_CFG register masks */
 	#define MCTR_CLK_SHIFT		28
 	#define MCTR_CLK_MASK		3
 
-#define CORE_CLK_CFG			(MISC_BASE + 0x024)
+#define CORE_CLK_CFG			(misc_base + 0x024)
 	/* CORE CLK CFG register masks */
 	#define GEN_SYNTH2_3_CLK_SHIFT	18
 	#define GEN_SYNTH2_3_CLK_MASK	1
@@ -39,7 +38,7 @@ static DEFINE_SPINLOCK(_lock);
 	#define PCLK_RATIO_SHIFT	8
 	#define PCLK_RATIO_MASK		2
 
-#define PERIP_CLK_CFG			(MISC_BASE + 0x028)
+#define PERIP_CLK_CFG			(misc_base + 0x028)
 	/* PERIP_CLK_CFG register masks */
 	#define UART_CLK_SHIFT		4
 	#define UART_CLK_MASK		1
@@ -50,7 +49,7 @@ static DEFINE_SPINLOCK(_lock);
 	#define GPT2_CLK_SHIFT		12
 	#define GPT_CLK_MASK		1
 
-#define PERIP1_CLK_ENB			(MISC_BASE + 0x02C)
+#define PERIP1_CLK_ENB			(misc_base + 0x02C)
 	/* PERIP1_CLK_ENB register masks */
 	#define UART_CLK_ENB		3
 	#define SSP_CLK_ENB		5
@@ -69,7 +68,7 @@ static DEFINE_SPINLOCK(_lock);
 	#define USBH_CLK_ENB		25
 	#define C3_CLK_ENB		31
 
-#define RAS_CLK_ENB			(MISC_BASE + 0x034)
+#define RAS_CLK_ENB			(misc_base + 0x034)
 	#define RAS_AHB_CLK_ENB		0
 	#define RAS_PLL1_CLK_ENB	1
 	#define RAS_APB_CLK_ENB		2
@@ -82,20 +81,20 @@ static DEFINE_SPINLOCK(_lock);
 	#define RAS_SYNT2_CLK_ENB	10
 	#define RAS_SYNT3_CLK_ENB	11
 
-#define PRSC0_CLK_CFG			(MISC_BASE + 0x044)
-#define PRSC1_CLK_CFG			(MISC_BASE + 0x048)
-#define PRSC2_CLK_CFG			(MISC_BASE + 0x04C)
-#define AMEM_CLK_CFG			(MISC_BASE + 0x050)
+#define PRSC0_CLK_CFG			(misc_base + 0x044)
+#define PRSC1_CLK_CFG			(misc_base + 0x048)
+#define PRSC2_CLK_CFG			(misc_base + 0x04C)
+#define AMEM_CLK_CFG			(misc_base + 0x050)
 	#define AMEM_CLK_ENB		0
 
-#define CLCD_CLK_SYNT			(MISC_BASE + 0x05C)
-#define FIRDA_CLK_SYNT			(MISC_BASE + 0x060)
-#define UART_CLK_SYNT			(MISC_BASE + 0x064)
-#define GMAC_CLK_SYNT			(MISC_BASE + 0x068)
-#define GEN0_CLK_SYNT			(MISC_BASE + 0x06C)
-#define GEN1_CLK_SYNT			(MISC_BASE + 0x070)
-#define GEN2_CLK_SYNT			(MISC_BASE + 0x074)
-#define GEN3_CLK_SYNT			(MISC_BASE + 0x078)
+#define CLCD_CLK_SYNT			(misc_base + 0x05C)
+#define FIRDA_CLK_SYNT			(misc_base + 0x060)
+#define UART_CLK_SYNT			(misc_base + 0x064)
+#define GMAC_CLK_SYNT			(misc_base + 0x068)
+#define GEN0_CLK_SYNT			(misc_base + 0x06C)
+#define GEN1_CLK_SYNT			(misc_base + 0x070)
+#define GEN2_CLK_SYNT			(misc_base + 0x074)
+#define GEN3_CLK_SYNT			(misc_base + 0x078)
 
 /* pll rate configuration table, in ascending order of rates */
 static struct pll_rate_tbl pll_rtbl[] = {
@@ -211,6 +210,17 @@ static inline void spear310_clk_init(void) { }
 
 /* array of all spear 320 clock lookups */
 #ifdef CONFIG_MACH_SPEAR320
+
+#define SPEAR320_CONTROL_REG		(soc_config_base + 0x0000)
+#define SPEAR320_EXT_CTRL_REG		(soc_config_base + 0x0018)
+
+	#define SPEAR320_UARTX_PCLK_MASK		0x1
+	#define SPEAR320_UART2_PCLK_SHIFT		8
+	#define SPEAR320_UART3_PCLK_SHIFT		9
+	#define SPEAR320_UART4_PCLK_SHIFT		10
+	#define SPEAR320_UART5_PCLK_SHIFT		11
+	#define SPEAR320_UART6_PCLK_SHIFT		12
+	#define SPEAR320_RS485_PCLK_SHIFT		13
 	#define SMII_PCLK_SHIFT				18
 	#define SMII_PCLK_MASK				2
 	#define SMII_PCLK_VAL_PAD			0x0
@@ -235,7 +245,7 @@ static const char *smii0_parents[] = { "smii_125m_pad", "ras_pll2_clk",
 	"ras_syn0_gclk", };
 static const char *uartx_parents[] = { "ras_syn1_gclk", "ras_apb_clk", };
 
-static void __init spear320_clk_init(void)
+static void __init spear320_clk_init(void __iomem *soc_config_base)
 {
 	struct clk *clk;
 
@@ -362,7 +372,7 @@ static void __init spear320_clk_init(void)
 static inline void spear320_clk_init(void) { }
 #endif
 
-void __init spear3xx_clk_init(void)
+void __init spear3xx_clk_init(void __iomem *misc_base, void __iomem *soc_config_base)
 {
 	struct clk *clk, *clk1;
 
@@ -634,5 +644,5 @@ void __init spear3xx_clk_init(void)
 	else if (of_machine_is_compatible("st,spear310"))
 		spear310_clk_init();
 	else if (of_machine_is_compatible("st,spear320"))
-		spear320_clk_init();
+		spear320_clk_init(soc_config_base);
 }
diff --git a/drivers/clk/spear/spear6xx_clock.c b/drivers/clk/spear/spear6xx_clock.c
index e862a33..9406f24 100644
--- a/drivers/clk/spear/spear6xx_clock.c
+++ b/drivers/clk/spear/spear6xx_clock.c
@@ -13,28 +13,27 @@
 #include <linux/clkdev.h>
 #include <linux/io.h>
 #include <linux/spinlock_types.h>
-#include <mach/misc_regs.h>
 #include "clk.h"
 
 static DEFINE_SPINLOCK(_lock);
 
-#define PLL1_CTR			(MISC_BASE + 0x008)
-#define PLL1_FRQ			(MISC_BASE + 0x00C)
-#define PLL2_CTR			(MISC_BASE + 0x014)
-#define PLL2_FRQ			(MISC_BASE + 0x018)
-#define PLL_CLK_CFG			(MISC_BASE + 0x020)
+#define PLL1_CTR			(misc_base + 0x008)
+#define PLL1_FRQ			(misc_base + 0x00C)
+#define PLL2_CTR			(misc_base + 0x014)
+#define PLL2_FRQ			(misc_base + 0x018)
+#define PLL_CLK_CFG			(misc_base + 0x020)
 	/* PLL_CLK_CFG register masks */
 	#define MCTR_CLK_SHIFT		28
 	#define MCTR_CLK_MASK		3
 
-#define CORE_CLK_CFG			(MISC_BASE + 0x024)
+#define CORE_CLK_CFG			(misc_base + 0x024)
 	/* CORE CLK CFG register masks */
 	#define HCLK_RATIO_SHIFT	10
 	#define HCLK_RATIO_MASK		2
 	#define PCLK_RATIO_SHIFT	8
 	#define PCLK_RATIO_MASK		2
 
-#define PERIP_CLK_CFG			(MISC_BASE + 0x028)
+#define PERIP_CLK_CFG			(misc_base + 0x028)
 	/* PERIP_CLK_CFG register masks */
 	#define CLCD_CLK_SHIFT		2
 	#define CLCD_CLK_MASK		2
@@ -48,7 +47,7 @@ static DEFINE_SPINLOCK(_lock);
 	#define GPT3_CLK_SHIFT		12
 	#define GPT_CLK_MASK		1
 
-#define PERIP1_CLK_ENB			(MISC_BASE + 0x02C)
+#define PERIP1_CLK_ENB			(misc_base + 0x02C)
 	/* PERIP1_CLK_ENB register masks */
 	#define UART0_CLK_ENB		3
 	#define UART1_CLK_ENB		4
@@ -74,13 +73,13 @@ static DEFINE_SPINLOCK(_lock);
 	#define USBH0_CLK_ENB		25
 	#define USBH1_CLK_ENB		26
 
-#define PRSC0_CLK_CFG			(MISC_BASE + 0x044)
-#define PRSC1_CLK_CFG			(MISC_BASE + 0x048)
-#define PRSC2_CLK_CFG			(MISC_BASE + 0x04C)
+#define PRSC0_CLK_CFG			(misc_base + 0x044)
+#define PRSC1_CLK_CFG			(misc_base + 0x048)
+#define PRSC2_CLK_CFG			(misc_base + 0x04C)
 
-#define CLCD_CLK_SYNT			(MISC_BASE + 0x05C)
-#define FIRDA_CLK_SYNT			(MISC_BASE + 0x060)
-#define UART_CLK_SYNT			(MISC_BASE + 0x064)
+#define CLCD_CLK_SYNT			(misc_base + 0x05C)
+#define FIRDA_CLK_SYNT			(misc_base + 0x060)
+#define UART_CLK_SYNT			(misc_base + 0x064)
 
 /* vco rate configuration table, in ascending order of rates */
 static struct pll_rate_tbl pll_rtbl[] = {
@@ -115,7 +114,7 @@ static struct gpt_rate_tbl gpt_rtbl[] = {
 	{.mscale = 1, .nscale = 0}, /* 83 MHz */
 };
 
-void __init spear6xx_clk_init(void)
+void __init spear6xx_clk_init(void __iomem *misc_base)
 {
 	struct clk *clk, *clk1;
 
-- 
1.8.0
