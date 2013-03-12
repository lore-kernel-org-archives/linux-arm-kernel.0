From: magnus.damm@gmail.com (Magnus Damm)
Date: Tue, 12 Mar 2013 13:56:19 +0900
Subject: [PATCH 02/04] ARM: shmobile: r8a73a4 SCIF support
In-Reply-To: <20130312045559.19701.77841.sendpatchset@w520>
References: <20130312045559.19701.77841.sendpatchset@w520>
Message-ID: <20130312045619.19701.29486.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Add SCIF serial port support to the r8a73a4 SoC by
adding platform devices for SCIFA0 -> SCIFA1 as well
as SCIFB0 -> SCIFB3 together with clock bindings. DT
device description is excluded at this point since
such bindings are still under development.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/clock-r8a73a4.c |   15 +++-
 arch/arm/mach-shmobile/setup-r8a73a4.c |  115 ++++++++++++++++++++++++++++++++
 2 files changed, 129 insertions(+), 1 deletion(-)

--- 0002/arch/arm/mach-shmobile/clock-r8a73a4.c
+++ work/arch/arm/mach-shmobile/clock-r8a73a4.c	2013-03-12 12:49:35.000000000 +0900
@@ -28,6 +28,7 @@
 #define CPG_LEN 0x270
 
 #define MPCKCR 0xe6150080
+#define SMSTPCR2 0xe6150138
 
 static struct clk_mapping cpg_mapping = {
 	.phys   = CPG_BASE,
@@ -53,11 +54,23 @@ static struct clk *main_clks[] = {
 	&extal2_clk,
 };
 
-enum { MSTP_NR };
+enum { MSTP217, MSTP216, MSTP207, MSTP206, MSTP204, MSTP203, MSTP_NR };
 static struct clk mstp_clks[MSTP_NR] = {
+	[MSTP204] = SH_CLK_MSTP32(&extal2_clk, SMSTPCR2, 4, 1), /* SCIFA0 */
+	[MSTP203] = SH_CLK_MSTP32(&extal2_clk, SMSTPCR2, 3, 1), /* SCIFA1 */
+	[MSTP206] = SH_CLK_MSTP32(&extal2_clk, SMSTPCR2, 6, 1), /* SCIFB0 */
+	[MSTP207] = SH_CLK_MSTP32(&extal2_clk, SMSTPCR2, 7, 1), /* SCIFB1 */
+	[MSTP216] = SH_CLK_MSTP32(&extal2_clk, SMSTPCR2, 16, 1), /* SCIFB2 */
+	[MSTP217] = SH_CLK_MSTP32(&extal2_clk, SMSTPCR2, 17, 1), /* SCIFB3 */
 };
 
 static struct clk_lookup lookups[] = {
+	CLKDEV_DEV_ID("sh-sci.0", &mstp_clks[MSTP204]),
+	CLKDEV_DEV_ID("sh-sci.1", &mstp_clks[MSTP203]),
+	CLKDEV_DEV_ID("sh-sci.2", &mstp_clks[MSTP206]),
+	CLKDEV_DEV_ID("sh-sci.3", &mstp_clks[MSTP207]),
+	CLKDEV_DEV_ID("sh-sci.4", &mstp_clks[MSTP216]),
+	CLKDEV_DEV_ID("sh-sci.5", &mstp_clks[MSTP217]),
 };
 
 void __init r8a73a4_clock_init(void)
--- 0002/arch/arm/mach-shmobile/setup-r8a73a4.c
+++ work/arch/arm/mach-shmobile/setup-r8a73a4.c	2013-03-12 12:49:46.000000000 +0900
@@ -21,12 +21,127 @@
 #include <linux/irqchip.h>
 #include <linux/of_platform.h>
 #include <linux/irq.h>
+#include <linux/serial_sci.h>
 #include <mach/common.h>
 #include <mach/irqs.h>
 #include <mach/r8a73a4.h>
 #include <asm/mach/arch.h>
 
+/* SCIFA0 */
+static struct plat_sci_port scif0_platform_data = {
+	.mapbase	= 0xe6c40000,
+	.flags		= UPF_BOOT_AUTOCONF | UPF_IOREMAP,
+	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_CKE0,
+	.scbrr_algo_id	= SCBRR_ALGO_4,
+	.type		= PORT_SCIFA,
+	.irqs		= SCIx_IRQ_MUXED(gic_spi(144)),
+};
+
+static struct platform_device scif0_device = {
+	.name		= "sh-sci",
+	.id		= 0,
+	.dev		= {
+		.platform_data  = &scif0_platform_data,
+	},
+};
+
+/* SCIFA1 */
+static struct plat_sci_port scif1_platform_data = {
+	.mapbase	= 0xe6c50000,
+	.flags		= UPF_BOOT_AUTOCONF | UPF_IOREMAP,
+	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_CKE0,
+	.scbrr_algo_id	= SCBRR_ALGO_4,
+	.type		= PORT_SCIFA,
+	.irqs		= SCIx_IRQ_MUXED(gic_spi(145)),
+};
+
+static struct platform_device scif1_device = {
+	.name		= "sh-sci",
+	.id		= 1,
+	.dev		= {
+		.platform_data  = &scif1_platform_data,
+	},
+};
+
+/* SCIFB0 */
+static struct plat_sci_port scif2_platform_data = {
+	.mapbase	= 0xe6c20000,
+	.flags		= UPF_BOOT_AUTOCONF | UPF_IOREMAP,
+	.scscr		= SCSCR_RE | SCSCR_TE,
+	.scbrr_algo_id	= SCBRR_ALGO_4,
+	.type		= PORT_SCIFB,
+	.irqs		= SCIx_IRQ_MUXED(gic_spi(148)),
+};
+
+static struct platform_device scif2_device = {
+	.name		= "sh-sci",
+	.id		= 2,
+	.dev		= {
+		.platform_data  = &scif2_platform_data,
+	},
+};
+
+/* SCIFB1 */
+static struct plat_sci_port scif3_platform_data = {
+	.mapbase	= 0xe6c30000,
+	.flags		= UPF_BOOT_AUTOCONF | UPF_IOREMAP,
+	.scscr		= SCSCR_RE | SCSCR_TE,
+	.scbrr_algo_id	= SCBRR_ALGO_4,
+	.type		= PORT_SCIFB,
+	.irqs		= SCIx_IRQ_MUXED(gic_spi(149)),
+};
+
+static struct platform_device scif3_device = {
+	.name		= "sh-sci",
+	.id		= 3,
+	.dev		= {
+		.platform_data  = &scif3_platform_data,
+	},
+};
+
+/* SCIFB2 */
+static struct plat_sci_port scif4_platform_data = {
+	.mapbase	= 0xe6ce0000,
+	.flags		= UPF_BOOT_AUTOCONF | UPF_IOREMAP,
+	.scscr		= SCSCR_RE | SCSCR_TE,
+	.scbrr_algo_id	= SCBRR_ALGO_4,
+	.type		= PORT_SCIFB,
+	.irqs		= SCIx_IRQ_MUXED(gic_spi(150)),
+};
+
+static struct platform_device scif4_device = {
+	.name		= "sh-sci",
+	.id		= 4,
+	.dev		= {
+		.platform_data  = &scif4_platform_data,
+	},
+};
+
+/* SCIFB3 */
+static struct plat_sci_port scif5_platform_data = {
+	.mapbase	= 0xe6cf0000,
+	.flags		= UPF_BOOT_AUTOCONF | UPF_IOREMAP,
+	.scscr		= SCSCR_RE | SCSCR_TE,
+	.scbrr_algo_id	= SCBRR_ALGO_4,
+	.type		= PORT_SCIFB,
+	.irqs		= SCIx_IRQ_MUXED(gic_spi(151)),
+};
+
+static struct platform_device scif5_device = {
+	.name		= "sh-sci",
+	.id		= 5,
+	.dev		= {
+		.platform_data  = &scif5_platform_data,
+	},
+};
+
 static struct platform_device *r8a73a4_devices[] __initdata = {
+	&scif0_device,
+	&scif1_device,
+	&scif2_device,
+	&scif3_device,
+	&scif4_device,
+	&scif5_device,
 };
 
 void __init r8a73a4_add_standard_devices(void)
