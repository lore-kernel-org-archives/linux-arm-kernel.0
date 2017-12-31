From: david@lechnology.com (David Lechner)
Date: Sun, 31 Dec 2017 17:39:42 -0600
Subject: [PATCH v4 1/7] ARM: davinci: move davinci_clk_init() to init_time
In-Reply-To: <1514763588-31560-1-git-send-email-david@lechnology.com>
References: <1514763588-31560-1-git-send-email-david@lechnology.com>
Message-ID: <1514763588-31560-2-git-send-email-david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This moves the call of davinci_clk_init() from map_io to init_time for all
boards.

This is the proper place to init clocks. This is also done in preparation
for moving to the common clock framework.

Signed-off-by: David Lechner <david@lechnology.com>
---
 arch/arm/mach-davinci/board-da830-evm.c     |  2 +-
 arch/arm/mach-davinci/board-da850-evm.c     |  2 +-
 arch/arm/mach-davinci/board-dm355-evm.c     |  2 +-
 arch/arm/mach-davinci/board-dm355-leopard.c |  2 +-
 arch/arm/mach-davinci/board-dm365-evm.c     |  2 +-
 arch/arm/mach-davinci/board-dm644x-evm.c    |  2 +-
 arch/arm/mach-davinci/board-dm646x-evm.c    | 11 +++++++----
 arch/arm/mach-davinci/board-mityomapl138.c  |  2 +-
 arch/arm/mach-davinci/board-neuros-osd2.c   |  2 +-
 arch/arm/mach-davinci/board-omapl138-hawk.c |  2 +-
 arch/arm/mach-davinci/board-sffsdr.c        |  2 +-
 arch/arm/mach-davinci/da830.c               |  4 ++++
 arch/arm/mach-davinci/da850.c               |  4 ++++
 arch/arm/mach-davinci/da8xx-dt.c            |  2 +-
 arch/arm/mach-davinci/davinci.h             |  4 ++++
 arch/arm/mach-davinci/dm355.c               |  5 +++++
 arch/arm/mach-davinci/dm365.c               |  5 +++++
 arch/arm/mach-davinci/dm644x.c              |  5 +++++
 arch/arm/mach-davinci/dm646x.c              |  5 +++++
 arch/arm/mach-davinci/include/mach/da8xx.h  |  3 +++
 20 files changed, 53 insertions(+), 15 deletions(-)

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
index 003bbe5..dafc852 100644
--- a/arch/arm/mach-davinci/board-dm646x-evm.c
+++ b/arch/arm/mach-davinci/board-dm646x-evm.c
@@ -721,9 +721,12 @@ static void __init evm_init_i2c(void)
 static void __init davinci_map_io(void)
 {
 	dm646x_init();
+}
 
-	if (machine_is_davinci_dm6467tevm())
-		davinci_set_refclk_rate(DM6467T_EVM_REF_FREQ);
+static void __init dm6467t_evm_init_time(void)
+{
+	dm646x_init_time();
+	davinci_set_refclk_rate(DM6467T_EVM_REF_FREQ);
 }
 
 #define DM646X_EVM_PHY_ID		"davinci_mdio-0:01"
@@ -797,7 +800,7 @@ MACHINE_START(DAVINCI_DM6467_EVM, "DaVinci DM646x EVM")
 	.atag_offset  = 0x100,
 	.map_io       = davinci_map_io,
 	.init_irq     = davinci_irq_init,
-	.init_time	= davinci_timer_init,
+	.init_time	= dm646x_init_time,
 	.init_machine = evm_init,
 	.init_late	= davinci_init_late,
 	.dma_zone_size	= SZ_128M,
@@ -807,7 +810,7 @@ MACHINE_START(DAVINCI_DM6467TEVM, "DaVinci DM6467T EVM")
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
index ed0b700..6a8b6ff 100644
--- a/arch/arm/mach-davinci/da830.c
+++ b/arch/arm/mach-davinci/da830.c
@@ -1220,6 +1220,10 @@ void __init da830_init(void)
 
 	da8xx_syscfg0_base = ioremap(DA8XX_SYSCFG0_BASE, SZ_4K);
 	WARN(!da8xx_syscfg0_base, "Unable to map syscfg0 module");
+}
 
+void __init da830_init_time(void)
+{
 	davinci_clk_init(davinci_soc_info_da830.cpu_clks);
+	davinci_timer_init();
 }
diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
index 04a58a3..4da5b25 100644
--- a/arch/arm/mach-davinci/da850.c
+++ b/arch/arm/mach-davinci/da850.c
@@ -1392,6 +1392,10 @@ void __init da850_init(void)
 	v = __raw_readl(DA8XX_SYSCFG0_VIRT(DA8XX_CFGCHIP3_REG));
 	v &= ~CFGCHIP3_PLL1_MASTER_LOCK;
 	__raw_writel(v, DA8XX_SYSCFG0_VIRT(DA8XX_CFGCHIP3_REG));
+}
 
+void __init da850_init_time(void)
+{
 	davinci_clk_init(davinci_soc_info_da850.cpu_clks);
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
index c62b90c..d70f4d9 100644
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
+void dm646x_init_time(void);
 void dm646x_init_mcasp0(struct snd_platform_data *pdata);
 void dm646x_init_mcasp1(struct snd_platform_data *pdata);
 int dm646x_init_edma(struct edma_rsv_info *rsv);
diff --git a/arch/arm/mach-davinci/dm355.c b/arch/arm/mach-davinci/dm355.c
index 938747f..40641c0 100644
--- a/arch/arm/mach-davinci/dm355.c
+++ b/arch/arm/mach-davinci/dm355.c
@@ -1043,7 +1043,12 @@ void __init dm355_init(void)
 {
 	davinci_common_init(&davinci_soc_info_dm355);
 	davinci_map_sysmod();
+}
+
+void __init dm355_init_time(void)
+{
 	davinci_clk_init(davinci_soc_info_dm355.cpu_clks);
+	davinci_timer_init();
 }
 
 int __init dm355_init_video(struct vpfe_config *vpfe_cfg,
diff --git a/arch/arm/mach-davinci/dm365.c b/arch/arm/mach-davinci/dm365.c
index 5d9f96d..0789ac6 100644
--- a/arch/arm/mach-davinci/dm365.c
+++ b/arch/arm/mach-davinci/dm365.c
@@ -1168,7 +1168,12 @@ void __init dm365_init(void)
 {
 	davinci_common_init(&davinci_soc_info_dm365);
 	davinci_map_sysmod();
+}
+
+void __init dm365_init_time(void)
+{
 	davinci_clk_init(davinci_soc_info_dm365.cpu_clks);
+	davinci_timer_init();
 }
 
 static struct resource dm365_vpss_resources[] = {
diff --git a/arch/arm/mach-davinci/dm644x.c b/arch/arm/mach-davinci/dm644x.c
index 6b41e1c..a1a2433 100644
--- a/arch/arm/mach-davinci/dm644x.c
+++ b/arch/arm/mach-davinci/dm644x.c
@@ -931,7 +931,12 @@ void __init dm644x_init(void)
 {
 	davinci_common_init(&davinci_soc_info_dm644x);
 	davinci_map_sysmod();
+}
+
+void __init dm644x_init_time(void)
+{
 	davinci_clk_init(davinci_soc_info_dm644x.cpu_clks);
+	davinci_timer_init();
 }
 
 int __init dm644x_init_video(struct vpfe_config *vpfe_cfg,
diff --git a/arch/arm/mach-davinci/dm646x.c b/arch/arm/mach-davinci/dm646x.c
index 6fc06a6..c518403 100644
--- a/arch/arm/mach-davinci/dm646x.c
+++ b/arch/arm/mach-davinci/dm646x.c
@@ -956,7 +956,12 @@ void __init dm646x_init(void)
 {
 	davinci_common_init(&davinci_soc_info_dm646x);
 	davinci_map_sysmod();
+}
+
+void __init dm646x_init_time(void)
+{
 	davinci_clk_init(davinci_soc_info_dm646x.cpu_clks);
+	davinci_timer_init();
 }
 
 static int __init dm646x_init_devices(void)
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
