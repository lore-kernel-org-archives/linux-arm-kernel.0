From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 28 Nov 2014 17:26:52 +0000
Subject: [PATCH 8/9] ARM: tegra: use DT to find the GIC distributor
In-Reply-To: <1417195613-8447-1-git-send-email-marc.zyngier@arm.com>
References: <1417195613-8447-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1417195613-8447-9-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tegra likes to peek at the distributor to find out if SGIs are
pending. This looks odd, but I'm sure there's a good reason.

But instead of hardcoding everything, let's use the DT instead.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/mach-tegra/iomap.h |  3 ---
 arch/arm/mach-tegra/irq.c   | 20 +++++++++++++++++++-
 2 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-tegra/iomap.h b/arch/arm/mach-tegra/iomap.h
index 81dc950..52bbb5c 100644
--- a/arch/arm/mach-tegra/iomap.h
+++ b/arch/arm/mach-tegra/iomap.h
@@ -28,9 +28,6 @@
 #define TEGRA_ARM_PERIF_BASE		0x50040000
 #define TEGRA_ARM_PERIF_SIZE		SZ_8K
 
-#define TEGRA_ARM_INT_DIST_BASE		0x50041000
-#define TEGRA_ARM_INT_DIST_SIZE		SZ_4K
-
 #define TEGRA_TMR1_BASE			0x60005000
 #define TEGRA_TMR1_SIZE			SZ_8
 
diff --git a/arch/arm/mach-tegra/irq.c b/arch/arm/mach-tegra/irq.c
index a1befd3..37b17d5 100644
--- a/arch/arm/mach-tegra/irq.c
+++ b/arch/arm/mach-tegra/irq.c
@@ -36,10 +36,28 @@
 static void __iomem *tegra_gic_cpu_base;
 #endif
 
+static const struct of_device_id dt_gic_match[] __initconst = {
+	{ .compatible = "arm,cortex-a9-gic" },
+	{ .compatible = "arm,cortex-a15-gic" },
+	{ }
+};
+
 bool tegra_pending_sgi(void)
 {
 	u32 pending_set;
-	void __iomem *distbase = IO_ADDRESS(TEGRA_ARM_INT_DIST_BASE);
+	static void __iomem *distbase;
+
+	if (unlikely(!distbase)) {
+		struct device_node *dn;
+
+		dn = of_find_matching_node(NULL, dt_gic_match);
+		if (WARN_ONCE(!dn, "No GIC node????\n"))
+			return false;
+
+		distbase = of_iomap(dn, 0);
+		if (WARN_ONCE(!distbase, "Unable to map distributor????\n"))
+			return false;
+	}
 
 	pending_set = readl_relaxed(distbase + GIC_DIST_PENDING_SET);
 
-- 
2.1.3
