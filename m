From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Mon, 18 Feb 2013 23:33:25 +0300
Subject: [PATCH v2 3/4] ARM: mach-shmobile: r8a7779: add SATA support
Message-ID: <201302182333.25630.sergei.shtylyov@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Vladimir Barinov <vladimir.barinov@cogentembedded.com>

Add SATA clock for r8a7779 SoC (for both device tree and usual cases). 
Register SATA controller as a "late" platform device on r8a7779 SoC.
 
Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
Changes since v1:
- added new clock entry for the device tree case instead of the entry in
  r8a7779_auxdata_lookup[];
- initialized sata_device.dev.[coherent_]dma_mask;
- created r8a7779_late_devices[], add SATA device there, and register "late"
  devices from r8a7779_add_standard_devices();

Sorry for the previous empty posting -- hit the wrong button. :-(

 arch/arm/mach-shmobile/clock-r8a7779.c |    4 ++++
 arch/arm/mach-shmobile/setup-r8a7779.c |   31 +++++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+)

Index: renesas/arch/arm/mach-shmobile/clock-r8a7779.c
===================================================================
--- renesas.orig/arch/arm/mach-shmobile/clock-r8a7779.c
+++ renesas/arch/arm/mach-shmobile/clock-r8a7779.c
@@ -87,6 +87,7 @@ static struct clk div4_clks[DIV4_NR] = {
 };
 
 enum { MSTP323, MSTP322, MSTP321, MSTP320,
+	MSTP115,
 	MSTP101, MSTP100,
 	MSTP030,
 	MSTP029, MSTP028, MSTP027, MSTP026, MSTP025, MSTP024, MSTP023, MSTP022, MSTP021,
@@ -99,6 +100,7 @@ static struct clk mstp_clks[MSTP_NR] = {
 	[MSTP322] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR3, 22, 0), /* SDHI1 */
 	[MSTP321] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR3, 21, 0), /* SDHI2 */
 	[MSTP320] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR3, 20, 0), /* SDHI3 */
+	[MSTP115] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR1, 15, 0), /* SATA */
 	[MSTP101] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR1,  1, 0), /* USB2 */
 	[MSTP100] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR1,  0, 0), /* USB0/1 */
 	[MSTP030] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR0, 30, 0), /* I2C0 */
@@ -156,6 +158,8 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_CON_ID("peripheral_clk",	&div4_clks[DIV4_P]),
 
 	/* MSTP32 clocks */
+	CLKDEV_DEV_ID("sata_rcar", &mstp_clks[MSTP115]), /* SATA */
+	CLKDEV_DEV_ID("fc600000.sata", &mstp_clks[MSTP115]), /* SATA w/DT */
 	CLKDEV_DEV_ID("ehci-platform.1", &mstp_clks[MSTP101]), /* USB EHCI port2 */
 	CLKDEV_DEV_ID("ohci-platform.1", &mstp_clks[MSTP101]), /* USB OHCI port2 */
 	CLKDEV_DEV_ID("ehci-platform.0", &mstp_clks[MSTP100]), /* USB EHCI port0/1 */
Index: renesas/arch/arm/mach-shmobile/setup-r8a7779.c
===================================================================
--- renesas.orig/arch/arm/mach-shmobile/setup-r8a7779.c
+++ renesas/arch/arm/mach-shmobile/setup-r8a7779.c
@@ -29,6 +29,7 @@
 #include <linux/serial_sci.h>
 #include <linux/sh_intc.h>
 #include <linux/sh_timer.h>
+#include <linux/dma-mapping.h>
 #include <mach/hardware.h>
 #include <mach/irqs.h>
 #include <mach/r8a7779.h>
@@ -322,6 +323,30 @@ static struct platform_device i2c3_devic
 	.num_resources	= ARRAY_SIZE(rcar_i2c3_res),
 };
 
+static struct resource sata_resources[] = {
+	[0] = {
+		.name	= "rcar-sata",
+		.start	= 0xfc600000,
+		.end	= 0xfc601fff,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= gic_spi(100),
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device sata_device = {
+	.name		= "sata_rcar",
+	.id		= -1,
+	.resource	= sata_resources,
+	.num_resources	= ARRAY_SIZE(sata_resources),
+	.dev		= {
+		.dma_mask		= &sata_device.dev.coherent_dma_mask,
+		.coherent_dma_mask	= DMA_BIT_MASK(32),
+	},
+};
+
 static struct platform_device *r8a7779_early_devices_dt[] __initdata = {
 	&scif0_device,
 	&scif1_device,
@@ -340,6 +365,10 @@ static struct platform_device *r8a7779_e
 	&i2c3_device,
 };
 
+static struct platform_device *r8a7779_late_devices[] __initdata = {
+	&sata_device,
+};
+
 void __init r8a7779_add_standard_devices(void)
 {
 #ifdef CONFIG_CACHE_L2X0
@@ -354,6 +383,8 @@ void __init r8a7779_add_standard_devices
 			    ARRAY_SIZE(r8a7779_early_devices_dt));
 	platform_add_devices(r8a7779_early_devices,
 			    ARRAY_SIZE(r8a7779_early_devices));
+	platform_add_devices(r8a7779_late_devices,
+			    ARRAY_SIZE(r8a7779_late_devices));
 }
 
 /* do nothing for !CONFIG_SMP or !CONFIG_HAVE_TWD */
