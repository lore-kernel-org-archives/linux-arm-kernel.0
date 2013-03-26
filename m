From: magnus.damm@gmail.com (Magnus Damm)
Date: Tue, 26 Mar 2013 10:34:33 +0900
Subject: [PATCH 02/04] ARM: shmobile: r8a73a4 SCIF support V3
In-Reply-To: <20130326013414.11796.9937.sendpatchset@w520>
References: <20130326013414.11796.9937.sendpatchset@w520>
Message-ID: <20130326013433.11796.74393.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

V3 of SCIF serial port support for the r8a73a4 SoC.
This is done by adding platform devices for SCIFA0
-> SCIFA1 as well as SCIFB0 -> SCIFB3 together with
clock bindings. DT device description is excluded at
this point since such bindings are still under
development.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Changes since V2:
 - Fixed a bug where PORT_SCIFA was always selected regardless of port type

 Changes since V1:
 - Replaced static platform devices with array of platform data
   together with a call to platform_device_register_data()

 arch/arm/mach-shmobile/clock-r8a73a4.c |   15 ++++++++++-
 arch/arm/mach-shmobile/setup-r8a73a4.c |   43 ++++++++++++++++++++++++++++++++
 2 files changed, 57 insertions(+), 1 deletion(-)

--- 0003/arch/arm/mach-shmobile/clock-r8a73a4.c
+++ work/arch/arm/mach-shmobile/clock-r8a73a4.c	2013-03-26 10:14:50.000000000 +0900
@@ -28,6 +28,7 @@
 #define CPG_LEN 0x270
 
 #define MPCKCR 0xe6150080
+#define SMSTPCR2 0xe6150138
 
 static struct clk_mapping cpg_mapping = {
 	.phys   = CPG_BASE,
@@ -55,11 +56,23 @@ static struct clk *main_clks[] = {
 	&extal2_clk,
 };
 
-enum { MSTP_NR };
+enum { MSTP217, MSTP216, MSTP207, MSTP206, MSTP204, MSTP203, MSTP_NR };
 static struct clk mstp_clks[MSTP_NR] = {
+	[MSTP204] = SH_CLK_MSTP32(&extal2_clk, SMSTPCR2, 4, 0), /* SCIFA0 */
+	[MSTP203] = SH_CLK_MSTP32(&extal2_clk, SMSTPCR2, 3, 0), /* SCIFA1 */
+	[MSTP206] = SH_CLK_MSTP32(&extal2_clk, SMSTPCR2, 6, 0), /* SCIFB0 */
+	[MSTP207] = SH_CLK_MSTP32(&extal2_clk, SMSTPCR2, 7, 0), /* SCIFB1 */
+	[MSTP216] = SH_CLK_MSTP32(&extal2_clk, SMSTPCR2, 16, 0), /* SCIFB2 */
+	[MSTP217] = SH_CLK_MSTP32(&extal2_clk, SMSTPCR2, 17, 0), /* SCIFB3 */
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
--- 0003/arch/arm/mach-shmobile/setup-r8a73a4.c
+++ work/arch/arm/mach-shmobile/setup-r8a73a4.c	2013-03-26 10:15:08.000000000 +0900
@@ -21,13 +21,56 @@
 #include <linux/irqchip.h>
 #include <linux/kernel.h>
 #include <linux/of_platform.h>
+#include <linux/serial_sci.h>
 #include <mach/common.h>
 #include <mach/irqs.h>
 #include <mach/r8a73a4.h>
 #include <asm/mach/arch.h>
 
+#define SCIF_COMMON(scif_type, baseaddr, irq)			\
+	.type		= scif_type,				\
+	.mapbase	= baseaddr,				\
+	.flags		= UPF_BOOT_AUTOCONF | UPF_IOREMAP,	\
+	.scbrr_algo_id	= SCBRR_ALGO_4,				\
+	.irqs		= SCIx_IRQ_MUXED(irq)
+
+#define SCIFA_DATA(index, baseaddr, irq)		\
+[index] = {						\
+	SCIF_COMMON(PORT_SCIFA, baseaddr, irq),		\
+	.scscr = SCSCR_RE | SCSCR_TE | SCSCR_CKE0,	\
+}
+
+#define SCIFB_DATA(index, baseaddr, irq)	\
+[index] = {					\
+	SCIF_COMMON(PORT_SCIFB, baseaddr, irq),	\
+	.scscr = SCSCR_RE | SCSCR_TE,		\
+}
+
+enum { SCIFA0, SCIFA1, SCIFB0, SCIFB1, SCIFB2, SCIFB3 };
+
+static const struct plat_sci_port scif[] = {
+	SCIFA_DATA(SCIFA0, 0xe6c40000, gic_spi(144)), /* SCIFA0 */
+	SCIFA_DATA(SCIFA1, 0xe6c50000, gic_spi(145)), /* SCIFA1 */
+	SCIFB_DATA(SCIFB0, 0xe6c50000, gic_spi(145)), /* SCIFB0 */
+	SCIFB_DATA(SCIFB1, 0xe6c30000, gic_spi(149)), /* SCIFB1 */
+	SCIFB_DATA(SCIFB2, 0xe6ce0000, gic_spi(150)), /* SCIFB2 */
+	SCIFB_DATA(SCIFB3, 0xe6cf0000, gic_spi(151)), /* SCIFB3 */
+};
+
+static inline void r8a73a4_register_scif(int idx)
+{
+	platform_device_register_data(&platform_bus, "sh-sci", idx, &scif[idx],
+				      sizeof(struct plat_sci_port));
+}
+
 void __init r8a73a4_add_standard_devices(void)
 {
+	r8a73a4_register_scif(SCIFA0);
+	r8a73a4_register_scif(SCIFA1);
+	r8a73a4_register_scif(SCIFB0);
+	r8a73a4_register_scif(SCIFB1);
+	r8a73a4_register_scif(SCIFB2);
+	r8a73a4_register_scif(SCIFB3);
 }
 
 #ifdef CONFIG_USE_OF
