From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  9 Oct 2013 15:49:55 +0900
Subject: [PATCH 11/14] ARM: shmobile: r7s72100 SCIF support
In-Reply-To: <cover.1381293239.git.horms+renesas@verge.net.au>
References: <cover.1381293239.git.horms+renesas@verge.net.au>
Message-ID: <f6ca6f11c921b227e33c5e91084be5ef30c32771.1381293239.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Add SCIF serial port support to the r7s72100 SoC by
adding platform devices for SCIF0 -> SCIF7 together with
clock bindings. DT device description is excluded at
this point since such bindings are still under
development.

Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/clock-r7s72100.c        |  8 +++++
 arch/arm/mach-shmobile/include/mach/r7s72100.h |  1 +
 arch/arm/mach-shmobile/setup-r7s72100.c        | 45 ++++++++++++++++++++++++++
 3 files changed, 54 insertions(+)

diff --git a/arch/arm/mach-shmobile/clock-r7s72100.c b/arch/arm/mach-shmobile/clock-r7s72100.c
index 1e71094..4aba20c 100644
--- a/arch/arm/mach-shmobile/clock-r7s72100.c
+++ b/arch/arm/mach-shmobile/clock-r7s72100.c
@@ -170,6 +170,14 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_CON_ID("cpu_clk", &div4_clks[DIV4_I]),
 
 	/* MSTP clocks */
+	CLKDEV_ICK_ID("sci_fck", "sh-sci.0", &mstp_clks[MSTP47]),
+	CLKDEV_ICK_ID("sci_fck", "sh-sci.1", &mstp_clks[MSTP46]),
+	CLKDEV_ICK_ID("sci_fck", "sh-sci.2", &mstp_clks[MSTP45]),
+	CLKDEV_ICK_ID("sci_fck", "sh-sci.3", &mstp_clks[MSTP44]),
+	CLKDEV_ICK_ID("sci_fck", "sh-sci.4", &mstp_clks[MSTP43]),
+	CLKDEV_ICK_ID("sci_fck", "sh-sci.5", &mstp_clks[MSTP42]),
+	CLKDEV_ICK_ID("sci_fck", "sh-sci.6", &mstp_clks[MSTP41]),
+	CLKDEV_ICK_ID("sci_fck", "sh-sci.7", &mstp_clks[MSTP40]),
 };
 
 void __init r7s72100_clock_init(void)
diff --git a/arch/arm/mach-shmobile/include/mach/r7s72100.h b/arch/arm/mach-shmobile/include/mach/r7s72100.h
index f78062e..5f34b20 100644
--- a/arch/arm/mach-shmobile/include/mach/r7s72100.h
+++ b/arch/arm/mach-shmobile/include/mach/r7s72100.h
@@ -1,6 +1,7 @@
 #ifndef __ASM_R7S72100_H__
 #define __ASM_R7S72100_H__
 
+void r7s72100_add_dt_devices(void);
 void r7s72100_clock_init(void);
 void r7s72100_init_early(void);
 
diff --git a/arch/arm/mach-shmobile/setup-r7s72100.c b/arch/arm/mach-shmobile/setup-r7s72100.c
index c1aded0..d4eb509 100644
--- a/arch/arm/mach-shmobile/setup-r7s72100.c
+++ b/arch/arm/mach-shmobile/setup-r7s72100.c
@@ -21,10 +21,55 @@
 #include <linux/irq.h>
 #include <linux/kernel.h>
 #include <linux/of_platform.h>
+#include <linux/serial_sci.h>
 #include <mach/common.h>
+#include <mach/irqs.h>
 #include <mach/r7s72100.h>
 #include <asm/mach/arch.h>
 
+#define SCIF_DATA(index, baseaddr, irq)					\
+[index] = {								\
+	.type		= PORT_SCIF,					\
+	.regtype	= SCIx_SH2_SCIF_FIFODATA_REGTYPE,		\
+	.flags		= UPF_BOOT_AUTOCONF | UPF_IOREMAP,		\
+	.scbrr_algo_id	= SCBRR_ALGO_2,					\
+	.scscr		= SCSCR_RIE | SCSCR_TIE | SCSCR_RE | SCSCR_TE |	\
+			  SCSCR_REIE,					\
+	.mapbase	= baseaddr,					\
+	.irqs		= { irq + 1, irq + 2, irq + 3, irq },		\
+}
+
+enum { SCIF0, SCIF1, SCIF2, SCIF3, SCIF4, SCIF5, SCIF6, SCIF7 };
+
+static const struct plat_sci_port scif[] __initconst = {
+	SCIF_DATA(SCIF0, 0xe8007000, gic_iid(221)), /* SCIF0 */
+	SCIF_DATA(SCIF1, 0xe8007800, gic_iid(225)), /* SCIF1 */
+	SCIF_DATA(SCIF2, 0xe8008000, gic_iid(229)), /* SCIF2 */
+	SCIF_DATA(SCIF3, 0xe8008800, gic_iid(233)), /* SCIF3 */
+	SCIF_DATA(SCIF4, 0xe8009000, gic_iid(237)), /* SCIF4 */
+	SCIF_DATA(SCIF5, 0xe8009800, gic_iid(241)), /* SCIF5 */
+	SCIF_DATA(SCIF6, 0xe800a000, gic_iid(245)), /* SCIF6 */
+	SCIF_DATA(SCIF7, 0xe800a800, gic_iid(249)), /* SCIF7 */
+};
+
+static inline void r7s72100_register_scif(int idx)
+{
+	platform_device_register_data(&platform_bus, "sh-sci", idx, &scif[idx],
+				      sizeof(struct plat_sci_port));
+}
+
+void __init r7s72100_add_dt_devices(void)
+{
+	r7s72100_register_scif(SCIF0);
+	r7s72100_register_scif(SCIF1);
+	r7s72100_register_scif(SCIF2);
+	r7s72100_register_scif(SCIF3);
+	r7s72100_register_scif(SCIF4);
+	r7s72100_register_scif(SCIF5);
+	r7s72100_register_scif(SCIF6);
+	r7s72100_register_scif(SCIF7);
+}
+
 void __init r7s72100_init_early(void)
 {
 	shmobile_setup_delay(400, 1, 3); /* Cortex-A9 @ 400MHz */
-- 
1.8.4
