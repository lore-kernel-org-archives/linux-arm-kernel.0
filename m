From: david@lechnology.com (David Lechner)
Date: Sun,  7 Jan 2018 20:17:21 -0600
Subject: [PATCH v5 22/44] ARM: davinci: move davinci_clk_init() to init_time
In-Reply-To: <1515377863-20358-1-git-send-email-david@lechnology.com>
References: <1515377863-20358-1-git-send-email-david@lechnology.com>
Message-ID: <1515377863-20358-23-git-send-email-david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This moves the call of davinci_clk_init() from map_io to init_time for all
boards.

This is the proper place to init clocks. This is also done in preparation
for moving to the common clock framework.

dm646x is a special case because we need to handle different ref_clk rates
depending on which board is being used. The clock init in this case is
modified to set the rate before registering the clocks instead of using
davinci_set_refclk_rate() to recalculate the entire clock tree after all
of the clocks are registered.

Also, the cpu_clks field is removed from struct davinci_soc_info since it
is no longer needed.

Signed-off-by: David Lechner <david@lechnology.com>
---
 arch/arm/mach-davinci/board-da830-evm.c     |  2 +-
 arch/arm/mach-davinci/board-da850-evm.c     |  2 +-
 arch/arm/mach-davinci/board-dm355-evm.c     |  2 +-
 arch/arm/mach-davinci/board-dm355-leopard.c |  2 +-
 arch/arm/mach-davinci/board-dm365-evm.c     |  2 +-
 arch/arm/mach-davinci/board-dm644x-evm.c    |  2 +-
 arch/arm/mach-davinci/board-dm646x-evm.c    | 19 +++++++++++++------
 arch/arm/mach-davinci/board-mityomapl138.c  |  2 +-
 arch/arm/mach-davinci/board-neuros-osd2.c   |  2 +-
 arch/arm/mach-davinci/board-omapl138-hawk.c |  2 +-
 arch/arm/mach-davinci/board-sffsdr.c        |  2 +-
 arch/arm/mach-davinci/da830.c               |  7 +++++--
 arch/arm/mach-davinci/da850.c               |  7 +++++--
 arch/arm/mach-davinci/da8xx-dt.c            |  2 +-
 arch/arm/mach-davinci/davinci.h             |  4 ++++
 arch/arm/mach-davinci/dm355.c               |  8 ++++++--
 arch/arm/mach-davinci/dm365.c               |  8 ++++++--
 arch/arm/mach-davinci/dm644x.c              |  8 ++++++--
 arch/arm/mach-davinci/dm646x.c              | 22 +++++++++++-----------
 arch/arm/mach-davinci/include/mach/common.h |  1 -
 arch/arm/mach-davinci/include/mach/da8xx.h  |  3 +++
 21 files changed, 70 insertions(+), 39 deletions(-)

diff --git a/arch/arm/mach-davinci/board-da830-evm.c b/arch/arm/mach-davinci/board-da830-evm.c
index a58bfca..7adf009 100644
--- a/arch/arm/mach-davinci/board-da830-evm.c
+++ b/arch/arm/mach-davinci/board-da830-evm.c
@@ -638,7 +638,7 @@ MACHINE_START(DAVINCI_DA830_EVM, "DaVinci DA830/OMAP-L137/AM17x EVM")
 	.atag_offset	= 0x100,
 	.map_io		= da830_evm_map_io,
 	.init_irq	= cp_intc_init,
-	.init_time	= davinci_timer_init,
+	.init_time	= da830_init_time,
 	.init_machine	= da830_evm_init,
 	.init_late	= davinci_init_late,
 	.dma_zone_size	= SZ_128M,
diff --git a/arch/arm/mach-davinci/board-da850-evm.c b/arch/arm/mach-davinci/board-da850-evm.c
index 6039ec1..8602d0d 100644
--- a/arch/arm/mach-davinci/board-da850-evm.c
+++ b/arch/arm/mach-davinci/board-da850-evm.c
@@ -1481,7 +1481,7 @@ MACHINE_START(DAVINCI_DA850_EVM, "DaVinci DA850/OMAP-L138/AM18x EVM")
 	.atag_offset	= 0x100,
 	.map_io		= da850_evm_map_io,
 	.init_irq	= cp_intc_init,
-	.init_time	= davinci_timer_init,
+	.init_time	= da850_init_time,
 	.init_machine	= da850_evm_init,
 	.init_late	= davinci_init_late,
 	.dma_zone_size	= SZ_128M,
diff --git a/arch/arm/mach-davinci/board-dm355-evm.c b/arch/arm/mach-davinci/board-dm355-evm.c
index d60d998..3c15cb7 100644
--- a/arch/arm/mach-davinci/board-dm355-evm.c
+++ b/arch/arm/mach-davinci/board-dm355-evm.c
@@ -416,7 +416,7 @@ MACHINE_START(DAVINCI_DM355_EVM, "DaVinci DM355 EVM")
 	.atag_offset  = 0x100,
 	.map_io	      = dm355_evm_map_io,
 	.init_irq     = davinci_irq_init,
-	.init_time	= davinci_timer_init,
+	.init_time	= dm355_init_time,
 	.init_machine = dm355_evm_init,
 	.init_late	= davinci_init_late,
 	.dma_zone_size	= SZ_128M,
diff --git a/arch/arm/mach-davinci/board-dm355-leopard.c b/arch/arm/mach-davinci/board-dm355-leopard.c
index 1e7e9b8..3ebc89d 100644
--- a/arch/arm/mach-davinci/board-dm355-leopard.c
+++ b/arch/arm/mach-davinci/board-dm355-leopard.c
@@ -271,7 +271,7 @@ MACHINE_START(DM355_LEOPARD, "DaVinci DM355 leopard")
 	.atag_offset  = 0x100,
 	.map_io	      = dm355_leopard_map_io,
 	.init_irq     = davinci_irq_init,
-	.init_time	= davinci_timer_init,
+	.init_time	= dm355_init_time,
 	.init_machine = dm355_leopard_init,
 	.init_late	= davinci_init_late,
 	.dma_zone_size	= SZ_128M,
diff --git a/arch/arm/mach-davinci/board-dm365-evm.c b/arch/arm/mach-davinci/board-dm365-evm.c
index 17b2c29..3daeac7 100644
--- a/arch/arm/mach-davinci/board-dm365-evm.c
+++ b/arch/arm/mach-davinci/board-dm365-evm.c
@@ -774,7 +774,7 @@ MACHINE_START(DAVINCI_DM365_EVM, "DaVinci DM365 EVM")
 	.atag_offset	= 0x100,
 	.map_io		= dm365_evm_map_io,
 	.init_irq	= davinci_irq_init,
-	.init_time	= davinci_timer_init,
+	.init_time	= dm365_init_time,
 	.init_machine	= dm365_evm_init,
 	.init_late	= davinci_init_late,
 	.dma_zone_size	= SZ_128M,
diff --git a/arch/arm/mach-davinci/board-dm644x-evm.c b/arch/arm/mach-davinci/board-dm644x-evm.c
index 5e1afc2..8d8c4ab 100644
--- a/arch/arm/mach-davinci/board-dm644x-evm.c
+++ b/arch/arm/mach-davinci/board-dm644x-evm.c
@@ -817,7 +817,7 @@ MACHINE_START(DAVINCI_EVM, "DaVinci DM644x EVM")
 	.atag_offset  = 0x100,
 	.map_io	      = davinci_evm_map_io,
 	.init_irq     = davinci_irq_init,
-	.init_time	= davinci_timer_init,
+	.init_time	= dm644x_init_time,
 	.init_machine = davinci_evm_init,
 	.init_late	= davinci_init_late,
 	.dma_zone_size	= SZ_128M,
diff --git a/arch/arm/mach-davinci/board-dm646x-evm.c b/arch/arm/mach-davinci/board-dm646x-evm.c
index 003bbe5..2d37f5b 100644
--- a/arch/arm/mach-davinci/board-dm646x-evm.c
+++ b/arch/arm/mach-davinci/board-dm646x-evm.c
@@ -44,10 +44,8 @@
 #include <mach/common.h>
 #include <mach/irqs.h>
 #include <mach/serial.h>
-#include <mach/clock.h>
 
 #include "davinci.h"
-#include "clock.h"
 
 #define NAND_BLOCK_SIZE		SZ_128K
 
@@ -716,14 +714,23 @@ static void __init evm_init_i2c(void)
 }
 #endif
 
+#define DM646X_REF_FREQ			27000000
+#define DM646X_AUX_FREQ			24000000
 #define DM6467T_EVM_REF_FREQ		33000000
 
 static void __init davinci_map_io(void)
 {
 	dm646x_init();
+}
 
-	if (machine_is_davinci_dm6467tevm())
-		davinci_set_refclk_rate(DM6467T_EVM_REF_FREQ);
+static void __init dm646x_evm_init_time(void)
+{
+	dm646x_init_time(DM646X_REF_FREQ, DM646X_AUX_FREQ);
+}
+
+static void __init dm6467t_evm_init_time(void)
+{
+	dm646x_init_time(DM6467T_EVM_REF_FREQ, DM646X_AUX_FREQ);
 }
 
 #define DM646X_EVM_PHY_ID		"davinci_mdio-0:01"
@@ -797,7 +804,7 @@ MACHINE_START(DAVINCI_DM6467_EVM, "DaVinci DM646x EVM")
 	.atag_offset  = 0x100,
 	.map_io       = davinci_map_io,
 	.init_irq     = davinci_irq_init,
-	.init_time	= davinci_timer_init,
+	.init_time	= dm646x_evm_init_time,
 	.init_machine = evm_init,
 	.init_late	= davinci_init_late,
 	.dma_zone_size	= SZ_128M,
@@ -807,7 +814,7 @@ MACHINE_START(DAVINCI_DM6467TEVM, "DaVinci DM6467T EVM")
 	.atag_offset  = 0x100,
 	.map_io       = davinci_map_io,
 	.init_irq     = davinci_irq_init,
-	.init_time	= davinci_timer_init,
+	.init_time	= dm6467t_evm_init_time,
 	.init_machine = evm_init,
 	.init_late	= davinci_init_late,
 	.dma_zone_size	= SZ_128M,
diff --git a/arch/arm/mach-davinci/board-mityomapl138.c b/arch/arm/mach-davinci/board-mityomapl138.c
index 0b23cf3..f9a725a 100644
--- a/arch/arm/mach-davinci/board-mityomapl138.c
+++ b/arch/arm/mach-davinci/board-mityomapl138.c
@@ -570,7 +570,7 @@ MACHINE_START(MITYOMAPL138, "MityDSP-L138/MityARM-1808")
 	.atag_offset	= 0x100,
 	.map_io		= mityomapl138_map_io,
 	.init_irq	= cp_intc_init,
-	.init_time	= davinci_timer_init,
+	.init_time	= da850_init_time,
 	.init_machine	= mityomapl138_init,
 	.init_late	= davinci_init_late,
 	.dma_zone_size	= SZ_128M,
diff --git a/arch/arm/mach-davinci/board-neuros-osd2.c b/arch/arm/mach-davinci/board-neuros-osd2.c
index 1e27baa..ff871a0 100644
--- a/arch/arm/mach-davinci/board-neuros-osd2.c
+++ b/arch/arm/mach-davinci/board-neuros-osd2.c
@@ -227,7 +227,7 @@ MACHINE_START(NEUROS_OSD2, "Neuros OSD2")
 	.atag_offset	= 0x100,
 	.map_io		 = davinci_ntosd2_map_io,
 	.init_irq	= davinci_irq_init,
-	.init_time	= davinci_timer_init,
+	.init_time	= dm644x_init_time,
 	.init_machine = davinci_ntosd2_init,
 	.init_late	= davinci_init_late,
 	.dma_zone_size	= SZ_128M,
diff --git a/arch/arm/mach-davinci/board-omapl138-hawk.c b/arch/arm/mach-davinci/board-omapl138-hawk.c
index 88ab45c..bc8a747 100644
--- a/arch/arm/mach-davinci/board-omapl138-hawk.c
+++ b/arch/arm/mach-davinci/board-omapl138-hawk.c
@@ -334,7 +334,7 @@ MACHINE_START(OMAPL138_HAWKBOARD, "AM18x/OMAP-L138 Hawkboard")
 	.atag_offset	= 0x100,
 	.map_io		= omapl138_hawk_map_io,
 	.init_irq	= cp_intc_init,
-	.init_time	= davinci_timer_init,
+	.init_time	= da850_init_time,
 	.init_machine	= omapl138_hawk_init,
 	.init_late	= davinci_init_late,
 	.dma_zone_size	= SZ_128M,
diff --git a/arch/arm/mach-davinci/board-sffsdr.c b/arch/arm/mach-davinci/board-sffsdr.c
index 1f02d4e..2922da9 100644
--- a/arch/arm/mach-davinci/board-sffsdr.c
+++ b/arch/arm/mach-davinci/board-sffsdr.c
@@ -150,7 +150,7 @@ MACHINE_START(SFFSDR, "Lyrtech SFFSDR")
 	.atag_offset  = 0x100,
 	.map_io	      = davinci_sffsdr_map_io,
 	.init_irq     = davinci_irq_init,
-	.init_time	= davinci_timer_init,
+	.init_time	= dm644x_init_time,
 	.init_machine = davinci_sffsdr_init,
 	.init_late	= davinci_init_late,
 	.dma_zone_size	= SZ_128M,
diff --git a/arch/arm/mach-davinci/da830.c b/arch/arm/mach-davinci/da830.c
index 57ab18c..350d767 100644
--- a/arch/arm/mach-davinci/da830.c
+++ b/arch/arm/mach-davinci/da830.c
@@ -1200,7 +1200,6 @@ static const struct davinci_soc_info davinci_soc_info_da830 = {
 	.jtag_id_reg		= DA8XX_SYSCFG0_BASE + DA8XX_JTAG_ID_REG,
 	.ids			= da830_ids,
 	.ids_num		= ARRAY_SIZE(da830_ids),
-	.cpu_clks		= da830_clks,
 	.psc_bases		= da830_psc_bases,
 	.psc_bases_num		= ARRAY_SIZE(da830_psc_bases),
 	.pinmux_base		= DA8XX_SYSCFG0_BASE + 0x120,
@@ -1220,6 +1219,10 @@ void __init da830_init(void)
 
 	da8xx_syscfg0_base = ioremap(DA8XX_SYSCFG0_BASE, SZ_4K);
 	WARN(!da8xx_syscfg0_base, "Unable to map syscfg0 module");
+}
 
-	davinci_clk_init(davinci_soc_info_da830.cpu_clks);
+void __init da830_init_time(void)
+{
+	davinci_clk_init(da830_clks);
+	davinci_timer_init();
 }
diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
index aa37cbd..34117e61 100644
--- a/arch/arm/mach-davinci/da850.c
+++ b/arch/arm/mach-davinci/da850.c
@@ -1353,7 +1353,6 @@ static const struct davinci_soc_info davinci_soc_info_da850 = {
 	.jtag_id_reg		= DA8XX_SYSCFG0_BASE + DA8XX_JTAG_ID_REG,
 	.ids			= da850_ids,
 	.ids_num		= ARRAY_SIZE(da850_ids),
-	.cpu_clks		= da850_clks,
 	.psc_bases		= da850_psc_bases,
 	.psc_bases_num		= ARRAY_SIZE(da850_psc_bases),
 	.pinmux_base		= DA8XX_SYSCFG0_BASE + 0x120,
@@ -1392,6 +1391,10 @@ void __init da850_init(void)
 	v = __raw_readl(DA8XX_SYSCFG0_VIRT(DA8XX_CFGCHIP3_REG));
 	v &= ~CFGCHIP3_PLL1_MASTER_LOCK;
 	__raw_writel(v, DA8XX_SYSCFG0_VIRT(DA8XX_CFGCHIP3_REG));
+}
 
-	davinci_clk_init(davinci_soc_info_da850.cpu_clks);
+void __init da850_init_time(void)
+{
+	davinci_clk_init(da850_clks);
+	davinci_timer_init();
 }
diff --git a/arch/arm/mach-davinci/da8xx-dt.c b/arch/arm/mach-davinci/da8xx-dt.c
index 779e8ce..ab199f4 100644
--- a/arch/arm/mach-davinci/da8xx-dt.c
+++ b/arch/arm/mach-davinci/da8xx-dt.c
@@ -96,7 +96,7 @@ static const char *const da850_boards_compat[] __initconst = {
 
 DT_MACHINE_START(DA850_DT, "Generic DA850/OMAP-L138/AM18x")
 	.map_io		= da850_init,
-	.init_time	= davinci_timer_init,
+	.init_time	= da850_init_time,
 	.init_machine	= da850_init_machine,
 	.dt_compat	= da850_boards_compat,
 	.init_late	= davinci_init_late,
diff --git a/arch/arm/mach-davinci/davinci.h b/arch/arm/mach-davinci/davinci.h
index c62b90c..270cef8 100644
--- a/arch/arm/mach-davinci/davinci.h
+++ b/arch/arm/mach-davinci/davinci.h
@@ -83,6 +83,7 @@ int davinci_init_wdt(void);
 
 /* DM355 function declarations */
 void dm355_init(void);
+void dm355_init_time(void);
 void dm355_init_spi0(unsigned chipselect_mask,
 		const struct spi_board_info *info, unsigned len);
 void dm355_init_asp1(u32 evt_enable);
@@ -91,6 +92,7 @@ int dm355_gpio_register(void);
 
 /* DM365 function declarations */
 void dm365_init(void);
+void dm365_init_time(void);
 void dm365_init_asp(void);
 void dm365_init_vc(void);
 void dm365_init_ks(struct davinci_ks_platform_data *pdata);
@@ -102,12 +104,14 @@ int dm365_gpio_register(void);
 
 /* DM644x function declarations */
 void dm644x_init(void);
+void dm644x_init_time(void);
 void dm644x_init_asp(void);
 int dm644x_init_video(struct vpfe_config *, struct vpbe_config *);
 int dm644x_gpio_register(void);
 
 /* DM646x function declarations */
 void dm646x_init(void);
+void dm646x_init_time(unsigned long ref_clk_rate, unsigned long aux_clkin_rate);
 void dm646x_init_mcasp0(struct snd_platform_data *pdata);
 void dm646x_init_mcasp1(struct snd_platform_data *pdata);
 int dm646x_init_edma(struct edma_rsv_info *rsv);
diff --git a/arch/arm/mach-davinci/dm355.c b/arch/arm/mach-davinci/dm355.c
index 938747f..f294804 100644
--- a/arch/arm/mach-davinci/dm355.c
+++ b/arch/arm/mach-davinci/dm355.c
@@ -1012,7 +1012,6 @@ static const struct davinci_soc_info davinci_soc_info_dm355 = {
 	.jtag_id_reg		= 0x01c40028,
 	.ids			= dm355_ids,
 	.ids_num		= ARRAY_SIZE(dm355_ids),
-	.cpu_clks		= dm355_clks,
 	.psc_bases		= dm355_psc_bases,
 	.psc_bases_num		= ARRAY_SIZE(dm355_psc_bases),
 	.pinmux_base		= DAVINCI_SYSTEM_MODULE_BASE,
@@ -1043,7 +1042,12 @@ void __init dm355_init(void)
 {
 	davinci_common_init(&davinci_soc_info_dm355);
 	davinci_map_sysmod();
-	davinci_clk_init(davinci_soc_info_dm355.cpu_clks);
+}
+
+void __init dm355_init_time(void)
+{
+	davinci_clk_init(dm355_clks);
+	davinci_timer_init();
 }
 
 int __init dm355_init_video(struct vpfe_config *vpfe_cfg,
diff --git a/arch/arm/mach-davinci/dm365.c b/arch/arm/mach-davinci/dm365.c
index 5d9f96d..1e3df9d 100644
--- a/arch/arm/mach-davinci/dm365.c
+++ b/arch/arm/mach-davinci/dm365.c
@@ -1116,7 +1116,6 @@ static const struct davinci_soc_info davinci_soc_info_dm365 = {
 	.jtag_id_reg		= 0x01c40028,
 	.ids			= dm365_ids,
 	.ids_num		= ARRAY_SIZE(dm365_ids),
-	.cpu_clks		= dm365_clks,
 	.psc_bases		= dm365_psc_bases,
 	.psc_bases_num		= ARRAY_SIZE(dm365_psc_bases),
 	.pinmux_base		= DAVINCI_SYSTEM_MODULE_BASE,
@@ -1168,7 +1167,12 @@ void __init dm365_init(void)
 {
 	davinci_common_init(&davinci_soc_info_dm365);
 	davinci_map_sysmod();
-	davinci_clk_init(davinci_soc_info_dm365.cpu_clks);
+}
+
+void __init dm365_init_time(void)
+{
+	davinci_clk_init(dm365_clks);
+	davinci_timer_init();
 }
 
 static struct resource dm365_vpss_resources[] = {
diff --git a/arch/arm/mach-davinci/dm644x.c b/arch/arm/mach-davinci/dm644x.c
index 6b41e1c..b409801 100644
--- a/arch/arm/mach-davinci/dm644x.c
+++ b/arch/arm/mach-davinci/dm644x.c
@@ -905,7 +905,6 @@ static const struct davinci_soc_info davinci_soc_info_dm644x = {
 	.jtag_id_reg		= 0x01c40028,
 	.ids			= dm644x_ids,
 	.ids_num		= ARRAY_SIZE(dm644x_ids),
-	.cpu_clks		= dm644x_clks,
 	.psc_bases		= dm644x_psc_bases,
 	.psc_bases_num		= ARRAY_SIZE(dm644x_psc_bases),
 	.pinmux_base		= DAVINCI_SYSTEM_MODULE_BASE,
@@ -931,7 +930,12 @@ void __init dm644x_init(void)
 {
 	davinci_common_init(&davinci_soc_info_dm644x);
 	davinci_map_sysmod();
-	davinci_clk_init(davinci_soc_info_dm644x.cpu_clks);
+}
+
+void __init dm644x_init_time(void)
+{
+	davinci_clk_init(dm644x_clks);
+	davinci_timer_init();
 }
 
 int __init dm644x_init_video(struct vpfe_config *vpfe_cfg,
diff --git a/arch/arm/mach-davinci/dm646x.c b/arch/arm/mach-davinci/dm646x.c
index 6fc06a6..d4d7658 100644
--- a/arch/arm/mach-davinci/dm646x.c
+++ b/arch/arm/mach-davinci/dm646x.c
@@ -39,12 +39,6 @@
 #define VSCLKDIS_MASK		(BIT_MASK(11) | BIT_MASK(10) | BIT_MASK(9) |\
 					BIT_MASK(8))
 
-/*
- * Device specific clocks
- */
-#define DM646X_REF_FREQ		27000000
-#define DM646X_AUX_FREQ		24000000
-
 #define DM646X_EMAC_BASE		0x01c80000
 #define DM646X_EMAC_MDIO_BASE		(DM646X_EMAC_BASE + 0x4000)
 #define DM646X_EMAC_CNTRL_OFFSET	0x0000
@@ -64,13 +58,12 @@ static struct pll_data pll2_data = {
 
 static struct clk ref_clk = {
 	.name = "ref_clk",
-	.rate = DM646X_REF_FREQ,
-	.set_rate = davinci_simple_set_rate,
+	/* rate is initalized in dm646x_init_time() */
 };
 
 static struct clk aux_clkin = {
 	.name = "aux_clkin",
-	.rate = DM646X_AUX_FREQ,
+	/* rate is initalized in dm646x_init_time() */
 };
 
 static struct clk pll1_clk = {
@@ -888,7 +881,6 @@ static const struct davinci_soc_info davinci_soc_info_dm646x = {
 	.jtag_id_reg		= 0x01c40028,
 	.ids			= dm646x_ids,
 	.ids_num		= ARRAY_SIZE(dm646x_ids),
-	.cpu_clks		= dm646x_clks,
 	.psc_bases		= dm646x_psc_bases,
 	.psc_bases_num		= ARRAY_SIZE(dm646x_psc_bases),
 	.pinmux_base		= DAVINCI_SYSTEM_MODULE_BASE,
@@ -956,7 +948,15 @@ void __init dm646x_init(void)
 {
 	davinci_common_init(&davinci_soc_info_dm646x);
 	davinci_map_sysmod();
-	davinci_clk_init(davinci_soc_info_dm646x.cpu_clks);
+}
+
+void __init dm646x_init_time(unsigned long ref_clk_rate,
+			     unsigned long aux_clkin_rate)
+{
+	ref_clk.rate = ref_clk_rate;
+	aux_clkin.rate = aux_clkin_rate;
+	davinci_clk_init(dm646x_clks);
+	davinci_timer_init();
 }
 
 static int __init dm646x_init_devices(void)
diff --git a/arch/arm/mach-davinci/include/mach/common.h b/arch/arm/mach-davinci/include/mach/common.h
index 19b9346..f0d5e858 100644
--- a/arch/arm/mach-davinci/include/mach/common.h
+++ b/arch/arm/mach-davinci/include/mach/common.h
@@ -53,7 +53,6 @@ struct davinci_soc_info {
 	u32				jtag_id_reg;
 	struct davinci_id		*ids;
 	unsigned long			ids_num;
-	struct clk_lookup		*cpu_clks;
 	u32				*psc_bases;
 	unsigned long			psc_bases_num;
 	u32				pinmux_base;
diff --git a/arch/arm/mach-davinci/include/mach/da8xx.h b/arch/arm/mach-davinci/include/mach/da8xx.h
index 751d2ac..3481a0d 100644
--- a/arch/arm/mach-davinci/include/mach/da8xx.h
+++ b/arch/arm/mach-davinci/include/mach/da8xx.h
@@ -87,7 +87,10 @@ extern unsigned int da850_max_speed;
 #define DA8XX_ARM_RAM_BASE	0xffff0000
 
 void da830_init(void);
+void da830_init_time(void);
+
 void da850_init(void);
+void da850_init_time(void);
 
 int da830_register_edma(struct edma_rsv_info *rsv);
 int da850_register_edma(struct edma_rsv_info *rsv[2]);
-- 
2.7.4
