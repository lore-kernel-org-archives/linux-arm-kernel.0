From: magnus.damm@gmail.com (Magnus Damm)
Date: Mon, 24 Feb 2014 16:52:03 +0900
Subject: [PATCH 02/02] ARM: shmobile: Lager DT USB PCI platform devices
In-Reply-To: <20140224075144.20255.59443.sendpatchset@w520>
References: <20140224075144.20255.59443.sendpatchset@w520>
Message-ID: <20140224075203.20255.88334.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Add USB1 and USB2 as PCI USB platform devices to the Lager DT Reference
board code. For this to work the PFC needs to be configured separately
via board specific DT code.

The Lager legacy code supports USB1 and USB2 already, and this patch
is moving us one step closer to being able to have equal software
support level for legacy Lager and DT reference Lager. The goal is to
be able to retire the legacy Lager code and to use DT to describe all
devices including these PCI USB devices. Plenty of complex bining work
is however needed for 4 different interconnected pieces of USB hardware,
so in the mean time use platform devices to allow us to retire legacy
code sooner.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Depends on "[PATCH 00/03] ARM: shmobile: Break out and extend clock workaround"

 arch/arm/mach-shmobile/board-lager-reference.c |   46 ++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

--- 0018/arch/arm/mach-shmobile/board-lager-reference.c
+++ work/arch/arm/mach-shmobile/board-lager-reference.c	2014-02-24 16:35:28.000000000 +0900
@@ -85,6 +85,44 @@ static void __init lager_add_du_device(v
 	platform_device_register_full(&info);
 }
 
+/* Internal PCI1 */
+static const struct resource pci1_resources[] __initconst = {
+	DEFINE_RES_MEM(0xee0b0000, 0x10000),	/* CFG */
+	DEFINE_RES_MEM(0xee0a0000, 0x10000),	/* MEM */
+	DEFINE_RES_IRQ(gic_spi(112)),
+};
+
+static const struct platform_device_info pci1_info __initconst = {
+	.parent		= &platform_bus,
+	.name		= "pci-rcar-gen2",
+	.id		= 1,
+	.res		= pci1_resources,
+	.num_res	= ARRAY_SIZE(pci1_resources),
+	.dma_mask	= DMA_BIT_MASK(32),
+};
+
+/* Internal PCI2 */
+static const struct resource pci2_resources[] __initconst = {
+	DEFINE_RES_MEM(0xee0d0000, 0x10000),	/* CFG */
+	DEFINE_RES_MEM(0xee0c0000, 0x10000),	/* MEM */
+	DEFINE_RES_IRQ(gic_spi(113)),
+};
+
+static const struct platform_device_info pci2_info __initconst = {
+	.parent		= &platform_bus,
+	.name		= "pci-rcar-gen2",
+	.id		= 2,
+	.res		= pci2_resources,
+	.num_res	= ARRAY_SIZE(pci2_resources),
+	.dma_mask	= DMA_BIT_MASK(32),
+};
+
+static void __init lager_add_usb1_usb2_devices(void)
+{
+	platform_device_register_full(&pci1_info);
+	platform_device_register_full(&pci2_info);
+}
+
 /*
  * This is a really crude hack to provide clkdev support to platform
  * devices until they get moved to DT.
@@ -108,6 +146,11 @@ static const struct clk_name clk_names[]
 	{ "lvds1", "lvds.1", "rcar-du-r8a7790" },
 };
 
+static const struct clk_name clk_ena_names[] = {
+	{ "ehci", NULL, "pci-rcar-gen2.1" },
+	{ "ehci", NULL, "pci-rcar-gen2.2" },
+};
+
 static void __init lager_add_standard_devices(void)
 {
 	shmobile_clk_workaround(clk_names, ARRAY_SIZE(clk_names), false);
@@ -115,6 +158,9 @@ static void __init lager_add_standard_de
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 
 	lager_add_du_device();
+
+	shmobile_clk_workaround(clk_ena_names, ARRAY_SIZE(clk_ena_names), true);
+	lager_add_usb1_usb2_devices();
 }
 
 static const char *lager_boards_compat_dt[] __initdata = {
