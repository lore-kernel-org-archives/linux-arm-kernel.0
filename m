From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 24 May 2013 11:06:24 +0900
Subject: [PATCH] ARM: mach-shmobile: r8a7790: add SATA support
Message-ID: <1369361184-20862-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add SATA clock for r8a7790 SoC (for both device tree and usual cases).
Register SATA controller as a "late" platform device on r8a7790 SoC.

Based on "ARM: mach-shmobile: r8a7779: add SATA support" by
Vladimir Barinov.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/clock-r8a7790.c |  4 ++++
 arch/arm/mach-shmobile/setup-r8a7790.c | 21 +++++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/arch/arm/mach-shmobile/clock-r8a7790.c b/arch/arm/mach-shmobile/clock-r8a7790.c
index b393592..3619a52 100644
--- a/arch/arm/mach-shmobile/clock-r8a7790.c
+++ b/arch/arm/mach-shmobile/clock-r8a7790.c
@@ -50,6 +50,7 @@
 #define SMSTPCR2 0xe6150138
 #define SMSTPCR3 0xe615013c
 #define SMSTPCR7 0xe615014c
+#define SMSTPCR8 0xe6150990
 
 #define MODEMR		0xE6160060
 #define SDCKCR		0xE6150074
@@ -180,6 +181,7 @@ static struct clk div6_clks[DIV6_NR] = {
 
 /* MSTP */
 enum {
+	MSTP814,
 	MSTP721, MSTP720,
 	MSTP304,
 	MSTP216, MSTP207, MSTP206, MSTP204, MSTP203, MSTP202,
@@ -187,6 +189,7 @@ enum {
 };
 
 static struct clk mstp_clks[MSTP_NR] = {
+	[MSTP814] = SH_CLK_MSTP32(&p_clk, SMSTPCR8, 15, 0), /* SATA1 */
 	[MSTP721] = SH_CLK_MSTP32(&p_clk, SMSTPCR7, 21, 0), /* SCIF0 */
 	[MSTP720] = SH_CLK_MSTP32(&p_clk, SMSTPCR7, 20, 0), /* SCIF1 */
 	[MSTP304] = SH_CLK_MSTP32(&cp_clk, SMSTPCR3, 4, 0), /* TPU0 */
@@ -249,6 +252,7 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("sh-sci.5", &mstp_clks[MSTP202]),
 	CLKDEV_DEV_ID("sh-sci.6", &mstp_clks[MSTP721]),
 	CLKDEV_DEV_ID("sh-sci.7", &mstp_clks[MSTP720]),
+	CLKDEV_DEV_ID("sata_rcar.1", &mstp_clks[MSTP814]),
 };
 
 #define R8A7790_CLOCK_ROOT(e, m, p0, p1, p30, p31)		\
diff --git a/arch/arm/mach-shmobile/setup-r8a7790.c b/arch/arm/mach-shmobile/setup-r8a7790.c
index ed7ee24..5a2a073 100644
--- a/arch/arm/mach-shmobile/setup-r8a7790.c
+++ b/arch/arm/mach-shmobile/setup-r8a7790.c
@@ -18,6 +18,7 @@
  * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  */
 
+#include <linux/dma-mapping.h>
 #include <linux/irq.h>
 #include <linux/kernel.h>
 #include <linux/of_platform.h>
@@ -118,6 +119,25 @@ static inline void r8a7790_register_scif(int idx)
 				      sizeof(struct plat_sci_port));
 }
 
+static __init void r8a7790_register_sata1(void)
+{
+
+	struct resource res[] = {
+		DEFINE_RES_MEM_NAMED(0xee300000, 0x200000, "rcar-sata"),
+		DEFINE_RES_IRQ(gic_iid(106)),
+	};
+
+	struct platform_device_info pdevinfo = {
+		.name = "sata_rcar",
+		.id = 1,
+		.res = res,
+		.num_res = ARRAY_SIZE(res),
+		.dma_mask = DMA_BIT_MASK(32),
+	};
+
+	platform_device_register_full(&pdevinfo);
+}
+
 static struct renesas_irqc_config irqc0_data = {
 	.irq_base = irq_pin(0), /* IRQ0 -> IRQ3 */
 };
@@ -148,6 +168,7 @@ void __init r8a7790_add_standard_devices(void)
 	r8a7790_register_scif(SCIF0);
 	r8a7790_register_scif(SCIF1);
 	r8a7790_register_irqc(0);
+	r8a7790_register_sata1();
 }
 
 void __init r8a7790_timer_init(void)
-- 
1.8.2.1
