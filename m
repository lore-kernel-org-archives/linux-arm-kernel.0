From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue,  2 Apr 2013 14:06:58 +0900
Subject: [PATCH 02/30] ARM: shmobile: r8a73a4 SCIF support V3
In-Reply-To: <1364879246-9470-1-git-send-email-horms+renesas@verge.net.au>
References: <1364879246-9470-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1364879246-9470-3-git-send-email-horms+renesas@verge.net.au>
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
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/clock-r8a73a4.c |   15 ++++++++++-
 arch/arm/mach-shmobile/setup-r8a73a4.c |   43 ++++++++++++++++++++++++++++++++
 2 files changed, 57 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/clock-r8a73a4.c b/arch/arm/mach-shmobile/clock-r8a73a4.c
index 15d479d..037713b 100644
--- a/arch/arm/mach-shmobile/clock-r8a73a4.c
+++ b/arch/arm/mach-shmobile/clock-r8a73a4.c
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
diff --git a/arch/arm/mach-shmobile/setup-r8a73a4.c b/arch/arm/mach-shmobile/setup-r8a73a4.c
index 69156bc..746a3dc 100644
--- a/arch/arm/mach-shmobile/setup-r8a73a4.c
+++ b/arch/arm/mach-shmobile/setup-r8a73a4.c
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
-- 
1.7.10.4
