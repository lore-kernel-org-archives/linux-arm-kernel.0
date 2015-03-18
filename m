From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 18 Mar 2015 11:24:01 +0800
Subject: [PATCH 2/3] ARM: sun8i: Add SMP support for the Allwinner A23
In-Reply-To: <1426649042-30547-1-git-send-email-wens@csie.org>
References: <1426649042-30547-1-git-send-email-wens@csie.org>
Message-ID: <1426649042-30547-3-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The A23 is a dual Cortex-A7. Add the logic to use the IPs used to
control the CPU configuration and the CPU power so that we can
bring up secondary CPUs at boot.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---

We can't use of_io_request_and_map() here, as it will conflict
with PRCM, and leave us without a serial console.

I think a proper way to solve this would be a syscon device or
something like the mfd-simple device posted by Arnd.

---
 Documentation/devicetree/bindings/arm/cpus.txt |  1 +
 arch/arm/mach-sunxi/platsmp.c                  | 69 ++++++++++++++++++++++++++
 2 files changed, 70 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/cpus.txt b/Documentation/devicetree/bindings/arm/cpus.txt
index 8b9e0a95de31..40202d85b132 100644
--- a/Documentation/devicetree/bindings/arm/cpus.txt
+++ b/Documentation/devicetree/bindings/arm/cpus.txt
@@ -188,6 +188,7 @@ nodes to be present and contain the properties described below.
 			# On ARM 32-bit systems this property is optional and
 			  can be one of:
 			    "allwinner,sun6i-a31"
+			    "allwinner,sun8i-a23"
 			    "arm,psci"
 			    "brcm,brahma-b15"
 			    "marvell,armada-375-smp"
diff --git a/arch/arm/mach-sunxi/platsmp.c b/arch/arm/mach-sunxi/platsmp.c
index 587b0468efcc..e8483ec79d67 100644
--- a/arch/arm/mach-sunxi/platsmp.c
+++ b/arch/arm/mach-sunxi/platsmp.c
@@ -121,3 +121,72 @@ static struct smp_operations sun6i_smp_ops __initdata = {
 	.smp_boot_secondary	= sun6i_smp_boot_secondary,
 };
 CPU_METHOD_OF_DECLARE(sun6i_a31_smp, "allwinner,sun6i-a31", &sun6i_smp_ops);
+
+static void __init sun8i_smp_prepare_cpus(unsigned int max_cpus)
+{
+	struct device_node *node;
+
+	node = of_find_compatible_node(NULL, NULL, "allwinner,sun8i-a23-prcm");
+	if (!node) {
+		pr_err("Missing A23 PRCM node in the device tree\n");
+		return;
+	}
+
+	prcm_membase = of_iomap(node, 0);
+	if (!prcm_membase) {
+		pr_err("Couldn't map A23 PRCM registers\n");
+		return;
+	}
+
+	node = of_find_compatible_node(NULL, NULL,
+				       "allwinner,sun8i-a23-cpuconfig");
+	if (!node) {
+		pr_err("Missing A23 CPU config node in the device tree\n");
+		return;
+	}
+
+	cpucfg_membase = of_iomap(node, 0);
+	if (!cpucfg_membase)
+		pr_err("Couldn't map A23 CPU config registers\n");
+
+}
+
+static int sun8i_smp_boot_secondary(unsigned int cpu,
+				    struct task_struct *idle)
+{
+	u32 reg;
+
+	if (!(prcm_membase && cpucfg_membase))
+		return -EFAULT;
+
+	spin_lock(&cpu_lock);
+
+	/* Set CPU boot address */
+	writel(virt_to_phys(secondary_startup),
+	       cpucfg_membase + CPUCFG_PRIVATE0_REG);
+
+	/* Assert the CPU core in reset */
+	writel(0, cpucfg_membase + CPUCFG_CPU_RST_CTRL_REG(cpu));
+
+	/* Assert the L1 cache in reset */
+	reg = readl(cpucfg_membase + CPUCFG_GEN_CTRL_REG);
+	writel(reg & ~BIT(cpu), cpucfg_membase + CPUCFG_GEN_CTRL_REG);
+
+	/* Clear CPU power-off gating */
+	reg = readl(prcm_membase + PRCM_CPU_PWROFF_REG);
+	writel(reg & ~BIT(cpu), prcm_membase + PRCM_CPU_PWROFF_REG);
+	mdelay(1);
+
+	/* Deassert the CPU core reset */
+	writel(3, cpucfg_membase + CPUCFG_CPU_RST_CTRL_REG(cpu));
+
+	spin_unlock(&cpu_lock);
+
+	return 0;
+}
+
+struct smp_operations sun8i_smp_ops __initdata = {
+	.smp_prepare_cpus	= sun8i_smp_prepare_cpus,
+	.smp_boot_secondary	= sun8i_smp_boot_secondary,
+};
+CPU_METHOD_OF_DECLARE(sun8i_a23_smp, "allwinner,sun8i-a23", &sun8i_smp_ops);
-- 
2.1.4
