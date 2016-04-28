From: chris.brand@broadcom.com (Chris Brand)
Date: Thu, 28 Apr 2016 10:59:59 -0700
Subject: [PATCH 3/3] arm: modify Broadcom CPU enable method
In-Reply-To: <1461866399-1725-1-git-send-email-chris.brand@broadcom.com>
References: <1461866399-1725-1-git-send-email-chris.brand@broadcom.com>
Message-ID: <1461866399-1725-4-git-send-email-chris.brand@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 84320e1a635fcf90cff4185f029ce9e31bf1d4a7
("ARM: BCM: Clean up SMP support for Broadcom Kona") moved the
"secondary-boot-reg" property from the "cpus" node to the individual "cpu"
nodes but negelected to actually support multiple "secondary-boot-reg"
properties.

This patchset rectifies that omission. Note that the behaviour is changed
slightly in that the "secondary-boot-reg" property is now read in
smp_boot_secondary() rather than smp_prepare_cpus(). This means that any
omissions will now only be reported when and if the cpu in question is being
brought up. It also means that an omission for one cpu will not force
uniprocessor mode.

Signed-off-by: Chris Brand <chris.brand@broadcom.com>
---
 arch/arm/mach-bcm/platsmp.c | 116 ++++++++++++++------------------------------
 1 file changed, 37 insertions(+), 79 deletions(-)

diff --git a/arch/arm/mach-bcm/platsmp.c b/arch/arm/mach-bcm/platsmp.c
index cfae9c71fb74..5e53cf2fc052 100644
--- a/arch/arm/mach-bcm/platsmp.c
+++ b/arch/arm/mach-bcm/platsmp.c
@@ -37,9 +37,6 @@
 #define OF_SECONDARY_BOOT	"secondary-boot-reg"
 #define MPIDR_CPUID_BITMASK	0x3
 
-/* I/O address of register used to coordinate secondary core startup */
-static u32	secondary_boot_addr;
-
 /*
  * Enable the Cortex A9 Snoop Control Unit
  *
@@ -81,20 +78,40 @@ static int __init scu_a9_enable(void)
 	return 0;
 }
 
-static int nsp_write_lut(void)
+static u32 secondary_boot_addr_for(unsigned int cpu)
+{
+	u32 secondary_boot_addr = 0;
+	struct device_node *cpu_node = of_get_cpu_node(cpu, NULL);
+
+        if (!cpu_node) {
+		pr_err("Failed to find device tree node for CPU%u\n", cpu);
+		return 0;
+	}
+
+	if (of_property_read_u32(cpu_node,
+				 OF_SECONDARY_BOOT,
+				 &secondary_boot_addr))
+		pr_err("required secondary boot register not specified for CPU%u\n",
+			cpu);
+
+	of_node_put(cpu_node);
+
+	return secondary_boot_addr;
+}
+
+static int nsp_write_lut(unsigned int cpu)
 {
 	void __iomem *sku_rom_lut;
 	phys_addr_t secondary_startup_phy;
+	const u32 secondary_boot_addr = secondary_boot_addr_for(cpu);
 
-	if (!secondary_boot_addr) {
-		pr_warn("required secondary boot register not specified\n");
+	if (!secondary_boot_addr)
 		return -EINVAL;
-	}
 
 	sku_rom_lut = ioremap_nocache((phys_addr_t)secondary_boot_addr,
-						sizeof(secondary_boot_addr));
+				      sizeof(phys_addr_t));
 	if (!sku_rom_lut) {
-		pr_warn("unable to ioremap SKU-ROM LUT register\n");
+		pr_warn("unable to ioremap SKU-ROM LUT register for cpu %u\n", cpu);
 		return -ENOMEM;
 	}
 
@@ -113,70 +130,12 @@ static int nsp_write_lut(void)
 
 static void __init bcm_smp_prepare_cpus(unsigned int max_cpus)
 {
-	static cpumask_t only_cpu_0 = { CPU_BITS_CPU0 };
-	struct device_node *cpus_node = NULL;
-	struct device_node *cpu_node = NULL;
-	int ret;
-
-	/*
-	 * This function is only called via smp_ops->smp_prepare_cpu().
-	 * That only happens if a "/cpus" device tree node exists
-	 * and has an "enable-method" property that selects the SMP
-	 * operations defined herein.
-	 */
-	cpus_node = of_find_node_by_path("/cpus");
-	if (!cpus_node)
-		return;
-
-	for_each_child_of_node(cpus_node, cpu_node) {
-		u32 cpuid;
-
-		if (of_node_cmp(cpu_node->type, "cpu"))
-			continue;
-
-		if (of_property_read_u32(cpu_node, "reg", &cpuid)) {
-			pr_debug("%s: missing reg property\n",
-				     cpu_node->full_name);
-			ret = -ENOENT;
-			goto out;
-		}
-
-		/*
-		 * "secondary-boot-reg" property should be defined only
-		 * for secondary cpu
-		 */
-		if ((cpuid & MPIDR_CPUID_BITMASK) == 1) {
-			/*
-			 * Our secondary enable method requires a
-			 * "secondary-boot-reg" property to specify a register
-			 * address used to request the ROM code boot a secondary
-			 * core. If we have any trouble getting this we fall
-			 * back to uniprocessor mode.
-			 */
-			if (of_property_read_u32(cpu_node,
-						OF_SECONDARY_BOOT,
-						&secondary_boot_addr)) {
-				pr_warn("%s: no" OF_SECONDARY_BOOT "property\n",
-					cpu_node->name);
-				ret = -ENOENT;
-				goto out;
-			}
-		}
-	}
-
-	/*
-	 * Enable the SCU on Cortex A9 based SoCs. If -ENOENT is
-	 * returned, the SoC reported a uniprocessor configuration.
-	 * We bail on any other error.
-	 */
-	ret = scu_a9_enable();
-out:
-	of_node_put(cpu_node);
-	of_node_put(cpus_node);
+	const cpumask_t only_cpu_0 = { CPU_BITS_CPU0 };
 
-	if (ret) {
+	/* Enable the SCU on Cortex A9 based SoCs */
+	if (scu_a9_enable()) {
 		/* Update the CPU present map to reflect uniprocessor mode */
-		pr_warn("disabling SMP\n");
+		pr_warn("failed to enable A9 SCU - disabling SMP\n");
 		init_cpu_present(&only_cpu_0);
 	}
 }
@@ -207,6 +166,7 @@ static int kona_boot_secondary(unsigned int cpu, struct task_struct *idle)
 	u32 cpu_id;
 	u32 boot_val;
 	bool timeout = false;
+	const u32 secondary_boot_addr = secondary_boot_addr_for(cpu);
 
 	cpu_id = cpu_logical_map(cpu);
 	if (cpu_id & ~BOOT_ADDR_CPUID_MASK) {
@@ -214,13 +174,11 @@ static int kona_boot_secondary(unsigned int cpu, struct task_struct *idle)
 		return -EINVAL;
 	}
 
-	if (!secondary_boot_addr) {
-		pr_err("required secondary boot register not specified\n");
+	if (!secondary_boot_addr)
 		return -EINVAL;
-	}
 
-	boot_reg = ioremap_nocache(
-			(phys_addr_t)secondary_boot_addr, sizeof(u32));
+	boot_reg = ioremap_nocache((phys_addr_t)secondary_boot_addr,
+				   sizeof(phys_addr_t));
 	if (!boot_reg) {
 		pr_err("unable to map boot register for cpu %u\n", cpu_id);
 		return -ENOMEM;
@@ -263,7 +221,7 @@ static int nsp_boot_secondary(unsigned int cpu, struct task_struct *idle)
 	 * After wake up, secondary core branches to the startup
 	 * address programmed at SKU ROM LUT location.
 	 */
-	ret = nsp_write_lut();
+	ret = nsp_write_lut(cpu);
 	if (ret) {
 		pr_err("unable to write startup addr to SKU ROM LUT\n");
 		goto out;
@@ -276,12 +234,12 @@ out:
 	return ret;
 }
 
-static const struct smp_operations bcm_smp_ops __initconst = {
+static const struct smp_operations kona_smp_ops __initconst = {
 	.smp_prepare_cpus	= bcm_smp_prepare_cpus,
 	.smp_boot_secondary	= kona_boot_secondary,
 };
 CPU_METHOD_OF_DECLARE(bcm_smp_bcm281xx, "brcm,bcm11351-cpu-method",
-			&bcm_smp_ops);
+			&kona_smp_ops);
 
 static const struct smp_operations nsp_smp_ops __initconst = {
 	.smp_prepare_cpus	= bcm_smp_prepare_cpus,
-- 
1.9.1
