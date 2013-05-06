From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon,  6 May 2013 14:39:04 -0600
Subject: [PATCH] ARM: tegra: disable LP2 cpuidle state if PCIe is enabled
Message-ID: <1367872744-25002-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

Tegra20 HW appears to have a bug such that PCIe device interrupts, whether
they are legacy IRQs or MSI, are lost when LP2 is enabled. To work around
this, simply disable LP2 if the PCI driver and DT node are both enabled.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
Thierry,

This patch is physically based on next-20130506 so that it doesn't
conflict with any of the recent cpuidle cleanup work. I'm sending it with
the expectation that you'll apply it to your PCIe development branch
though. If you do that, you'll see some conflicts unless you rebase your
dev branch onto something more recent than next-20130422; I assume you'll
do that rebase soon enough anyway, but if you weren't planning to, I can
resend the patch based on your current dev branch.

 arch/arm/mach-tegra/cpuidle-tegra20.c |   30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm/mach-tegra/cpuidle-tegra20.c b/arch/arm/mach-tegra/cpuidle-tegra20.c
index 0cdba8d..d2c9349 100644
--- a/arch/arm/mach-tegra/cpuidle-tegra20.c
+++ b/arch/arm/mach-tegra/cpuidle-tegra20.c
@@ -25,6 +25,7 @@
 #include <linux/cpu_pm.h>
 #include <linux/clockchips.h>
 #include <linux/clk/tegra.h>
+#include <linux/of.h>
 
 #include <asm/cpuidle.h>
 #include <asm/proc-fns.h>
@@ -212,10 +213,39 @@ static int tegra20_idle_lp2_coupled(struct cpuidle_device *dev,
 }
 #endif
 
+static const struct of_device_id pcie_matches[] __initconst = {
+	{ .compatible = "nvidia,tegra20-pcie" },
+	{ }
+};
+
+/*
+ * Tegra20 HW appears to have a bug such that PCIe device interrupts, whether
+ * they are legacy IRQs or MSI, are lost when LP2 is enabled. To work around
+ * this, simply disable LP2 if the PCI driver and DT node are both enabled.
+ */
+static void __init tegra20_cpuidle_disable_lp2_with_pcie(void)
+{
+	struct device_node *np;
+
+	if (!IS_ENABLED(CONFIG_PCI_TEGRA))
+		return;
+
+	np = of_find_matching_node(NULL, pcie_matches);
+	if (!np)
+		return;
+
+	if (!of_device_is_available(np))
+		return;
+
+	pr_info("Disabling LP2 cpuidle state, since PCIe is enabled\n");
+	tegra_idle_driver.state_count = 1;
+}
+
 int __init tegra20_cpuidle_init(void)
 {
 #ifdef CONFIG_PM_SLEEP
 	tegra_tear_down_cpu = tegra20_tear_down_cpu;
 #endif
+	tegra20_cpuidle_disable_lp2_with_pcie();
 	return cpuidle_register(&tegra_idle_driver, cpu_possible_mask);
 }
-- 
1.7.10.4
