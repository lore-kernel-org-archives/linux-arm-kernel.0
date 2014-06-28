From: thierry.reding@gmail.com (Thierry Reding)
Date: Sat, 28 Jun 2014 03:02:30 +0200
Subject: [PATCH v2 3/4] soc/tegra: Initialize interrupt controller from DT
In-Reply-To: <1403917351-13215-1-git-send-email-thierry.reding@gmail.com>
References: <1403917351-13215-1-git-send-email-thierry.reding@gmail.com>
Message-ID: <1403917351-13215-3-git-send-email-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thierry Reding <treding@nvidia.com>

Obtains the register ranges for the legacy interrupt controller from DT
and provide hard-coded values as fallback.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
Changes in v2:
- check for the exact number of controllers expected
- fallback to tegra_chip_id for non-DT
- warn on parsing errors

 arch/arm/mach-tegra/iomap.h |  18 -------
 arch/arm/mach-tegra/irq.c   | 123 ++++++++++++++++++++++++++++++++++++--------
 2 files changed, 101 insertions(+), 40 deletions(-)

diff --git a/arch/arm/mach-tegra/iomap.h b/arch/arm/mach-tegra/iomap.h
index ee79808e93a3..52bbb5c8fe84 100644
--- a/arch/arm/mach-tegra/iomap.h
+++ b/arch/arm/mach-tegra/iomap.h
@@ -28,24 +28,6 @@
 #define TEGRA_ARM_PERIF_BASE		0x50040000
 #define TEGRA_ARM_PERIF_SIZE		SZ_8K
 
-#define TEGRA_ARM_INT_DIST_BASE		0x50041000
-#define TEGRA_ARM_INT_DIST_SIZE		SZ_4K
-
-#define TEGRA_PRIMARY_ICTLR_BASE	0x60004000
-#define TEGRA_PRIMARY_ICTLR_SIZE	SZ_64
-
-#define TEGRA_SECONDARY_ICTLR_BASE	0x60004100
-#define TEGRA_SECONDARY_ICTLR_SIZE	SZ_64
-
-#define TEGRA_TERTIARY_ICTLR_BASE	0x60004200
-#define TEGRA_TERTIARY_ICTLR_SIZE	SZ_64
-
-#define TEGRA_QUATERNARY_ICTLR_BASE	0x60004300
-#define TEGRA_QUATERNARY_ICTLR_SIZE	SZ_64
-
-#define TEGRA_QUINARY_ICTLR_BASE	0x60004400
-#define TEGRA_QUINARY_ICTLR_SIZE	SZ_64
-
 #define TEGRA_TMR1_BASE			0x60005000
 #define TEGRA_TMR1_SIZE			SZ_8
 
diff --git a/arch/arm/mach-tegra/irq.c b/arch/arm/mach-tegra/irq.c
index 1a74d562dca1..1d52fe961d2b 100644
--- a/arch/arm/mach-tegra/irq.c
+++ b/arch/arm/mach-tegra/irq.c
@@ -26,9 +26,7 @@
 #include <linux/of_address.h>
 #include <linux/irqchip/arm-gic.h>
 #include <linux/syscore_ops.h>
-
-#include "board.h"
-#include "iomap.h"
+#include <linux/tegra-soc.h>
 
 #define ICTLR_CPU_IEP_VFIQ	0x08
 #define ICTLR_CPU_IEP_FIR	0x14
@@ -52,13 +50,7 @@
 
 static int num_ictlrs;
 
-static void __iomem *ictlr_reg_base[] = {
-	IO_ADDRESS(TEGRA_PRIMARY_ICTLR_BASE),
-	IO_ADDRESS(TEGRA_SECONDARY_ICTLR_BASE),
-	IO_ADDRESS(TEGRA_TERTIARY_ICTLR_BASE),
-	IO_ADDRESS(TEGRA_QUATERNARY_ICTLR_BASE),
-	IO_ADDRESS(TEGRA_QUINARY_ICTLR_BASE),
-};
+static void __iomem *ictlr_reg_base[] = { NULL, NULL, NULL, NULL, NULL };
 
 #ifdef CONFIG_PM_SLEEP
 static u32 cop_ier[TEGRA_MAX_NUM_ICTLRS];
@@ -70,10 +62,11 @@ static u32 ictlr_wake_mask[TEGRA_MAX_NUM_ICTLRS];
 static void __iomem *tegra_gic_cpu_base;
 #endif
 
+static void __iomem *distbase;
+
 bool tegra_pending_sgi(void)
 {
 	u32 pending_set;
-	void __iomem *distbase = IO_ADDRESS(TEGRA_ARM_INT_DIST_BASE);
 
 	pending_set = readl_relaxed(distbase + GIC_DIST_PENDING_SET);
 
@@ -255,24 +248,109 @@ static void tegra114_gic_cpu_pm_registration(void)
 static void tegra114_gic_cpu_pm_registration(void) { }
 #endif
 
+static struct resource ictlr_regs[] = {
+	{ .start = 0x60004000, .end = 0x6000403f, .flags = IORESOURCE_MEM },
+	{ .start = 0x60004100, .end = 0x6000413f, .flags = IORESOURCE_MEM },
+	{ .start = 0x60004200, .end = 0x6000423f, .flags = IORESOURCE_MEM },
+	{ .start = 0x60004300, .end = 0x6000433f, .flags = IORESOURCE_MEM },
+	{ .start = 0x60004400, .end = 0x6000443f, .flags = IORESOURCE_MEM },
+};
+
+struct tegra_ictlr_soc {
+	unsigned int num_ictlrs;
+};
+
+static const struct tegra_ictlr_soc tegra20_ictlr_soc = {
+	.num_ictlrs = 4,
+};
+
+static const struct tegra_ictlr_soc tegra30_ictlr_soc = {
+	.num_ictlrs = 5,
+};
+
+static const struct of_device_id ictlr_matches[] = {
+	{ .compatible = "nvidia,tegra30-ictlr", .data = &tegra30_ictlr_soc },
+	{ .compatible = "nvidia,tegra20-ictlr", .data = &tegra20_ictlr_soc },
+	{ }
+};
+
+static const struct of_device_id gic_matches[] = {
+	{ .compatible = "arm,cortex-a15-gic", },
+	{ .compatible = "arm,cortex-a9-gic", },
+	{ }
+};
+
 void __init tegra_init_irq(void)
 {
-	int i;
-	void __iomem *distbase;
+	unsigned int max_ictlrs = ARRAY_SIZE(ictlr_regs), i;
+	const struct of_device_id *match;
+	struct device_node *np;
+	struct resource res;
+
+	np = of_find_matching_node_and_match(NULL, ictlr_matches, &match);
+	if (np) {
+		const struct tegra_ictlr_soc *soc = match->data;
+
+		for (i = 0; i < soc->num_ictlrs; i++) {
+			if (of_address_to_resource(np, i, &res) < 0)
+				break;
+
+			ictlr_regs[i] = res;
+		}
+
+		WARN(i != soc->num_ictlrs,
+		     "Found %u interrupt controllers in DT; expected %u.\n",
+		     i, soc->num_ictlrs);
+
+		max_ictlrs = soc->num_ictlrs;
+		of_node_put(np);
+	} else {
+		/*
+		 * If no matching device node was found, fall back to using
+		 * the chip ID.
+		 */
+
+		/* Tegra30 and later have five interrupt controllers, ... */
+		max_ictlrs = ARRAY_SIZE(ictlr_regs);
+
+		/* ..., but Tegra20 only has four. */
+		if (tegra_chip_id <= TEGRA20)
+			max_ictlrs--;
+	}
+
+	np = of_find_matching_node(NULL, gic_matches);
+	if (np) {
+		if (of_address_to_resource(np, 0, &res) < 0) {
+			WARN(1, "GIC registers are missing from DT\n");
+			res.start = res.end = 0;
+		}
 
-	distbase = IO_ADDRESS(TEGRA_ARM_INT_DIST_BASE);
+		of_node_put(np);
+	}
+
+	if (res.start == 0 || res.end == 0) {
+		res.start = 0x50041000;
+		res.end = 0x50041fff;
+		res.flags = IORESOURCE_MEM;
+	}
+
+	distbase = ioremap_nocache(res.start, resource_size(&res));
 	num_ictlrs = readl_relaxed(distbase + GIC_DIST_CTR) & 0x1f;
 
-	if (num_ictlrs > ARRAY_SIZE(ictlr_reg_base)) {
-		WARN(1, "Too many (%d) interrupt controllers found. Maximum is %d.",
-			num_ictlrs, ARRAY_SIZE(ictlr_reg_base));
-		num_ictlrs = ARRAY_SIZE(ictlr_reg_base);
+	if (num_ictlrs != max_ictlrs) {
+		WARN(1, "Too many (%d) interrupt controllers found. Maximum is %u.",
+		     num_ictlrs, max_ictlrs);
+		num_ictlrs = max_ictlrs;
 	}
 
 	for (i = 0; i < num_ictlrs; i++) {
-		void __iomem *ictlr = ictlr_reg_base[i];
+		struct resource *regs = &ictlr_regs[i];
+		void __iomem *ictlr;
+
+		ictlr = ioremap_nocache(regs->start, resource_size(regs));
 		writel(~0, ictlr + ICTLR_CPU_IER_CLR);
 		writel(0, ictlr + ICTLR_CPU_IEP_CLASS);
+		ictlr_reg_base[i] = ictlr;
 	}
 
 	gic_arch_extn.irq_ack = tegra_ack;
@@ -287,9 +365,10 @@ void __init tegra_init_irq(void)
 	 * Check if there is a devicetree present, since the GIC will be
 	 * initialized elsewhere under DT.
 	 */
-	if (!of_have_populated_dt())
-		gic_init(0, 29, distbase,
-			IO_ADDRESS(TEGRA_ARM_PERIF_BASE + 0x100));
+	if (!of_have_populated_dt()) {
+		void __iomem *cpubase = ioremap_nocache(0x50040000, 0x2000);
+		gic_init(0, 29, distbase, cpubase);
+	}
 
 	tegra114_gic_cpu_pm_registration();
 }
-- 
2.0.0
