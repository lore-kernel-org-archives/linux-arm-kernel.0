From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 11 Mar 2015 15:43:00 +0000
Subject: [PATCH v6 3/6] ARM: tegra: skip gic_arch_extn setup if DT has a LIC
 node
In-Reply-To: <1426088583-15097-1-git-send-email-marc.zyngier@arm.com>
References: <1426088583-15097-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1426088583-15097-4-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If we detect that our DT has a LIC node, don't setup gic_arch_extn,
and skip tegra_legacy_irq_syscore_init as well.

This is only a temporary measure until that code is removed for good.

Acked-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/mach-tegra/irq.c   | 12 ++++++++++++
 arch/arm/mach-tegra/tegra.c |  1 -
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-tegra/irq.c b/arch/arm/mach-tegra/irq.c
index 7f87a50..1593c4c 100644
--- a/arch/arm/mach-tegra/irq.c
+++ b/arch/arm/mach-tegra/irq.c
@@ -255,11 +255,22 @@ static void tegra114_gic_cpu_pm_registration(void)
 static void tegra114_gic_cpu_pm_registration(void) { }
 #endif
 
+static const struct of_device_id tegra_ictlr_match[] __initconst = {
+	{ .compatible = "nvidia,tegra20-ictlr" },
+	{ .compatible = "nvidia,tegra30-ictlr" },
+	{ }
+};
+
 void __init tegra_init_irq(void)
 {
 	int i;
 	void __iomem *distbase;
 
+	if (of_find_matching_node(NULL, tegra_ictlr_match))
+		goto skip_extn_setup;
+
+	tegra_legacy_irq_syscore_init();
+
 	distbase = IO_ADDRESS(TEGRA_ARM_INT_DIST_BASE);
 	num_ictlrs = readl_relaxed(distbase + GIC_DIST_CTR) & 0x1f;
 
@@ -283,5 +294,6 @@ void __init tegra_init_irq(void)
 	gic_arch_extn.irq_set_wake = tegra_set_wake;
 	gic_arch_extn.flags = IRQCHIP_MASK_ON_SUSPEND;
 
+skip_extn_setup:
 	tegra114_gic_cpu_pm_registration();
 }
diff --git a/arch/arm/mach-tegra/tegra.c b/arch/arm/mach-tegra/tegra.c
index 914341b..861d884 100644
--- a/arch/arm/mach-tegra/tegra.c
+++ b/arch/arm/mach-tegra/tegra.c
@@ -82,7 +82,6 @@ static void __init tegra_dt_init_irq(void)
 {
 	tegra_init_irq();
 	irqchip_init();
-	tegra_legacy_irq_syscore_init();
 }
 
 static void __init tegra_dt_init(void)
-- 
2.1.4
