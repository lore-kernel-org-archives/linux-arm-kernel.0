From: chris.packham@alliedtelesis.co.nz (Chris Packham)
Date: Fri,  6 Jan 2017 17:14:59 +1300
Subject: [PATCHv3 2/5] arm: mvebu: support for SMP on 98DX3336 SoC
In-Reply-To: <20170106041517.9589-1-chris.packham@alliedtelesis.co.nz>
References: <20170105033641.6212-1-chris.packham@alliedtelesis.co.nz>
 <20170106041517.9589-1-chris.packham@alliedtelesis.co.nz>
Message-ID: <20170106041517.9589-3-chris.packham@alliedtelesis.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Compared to the armada-xp the 98DX3336 uses different registers to set
the boot address for the secondary CPU so a new enable-method is needed.
This will only work if the machine definition doesn't define an overall
smp_ops because there is not currently a way of overriding this from the
device tree if it is set in the machine definition.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
    Changes in v2:
    - Document new enable-method value
    - Correct some references from 98DX4521 to 98DX3236
    
    Changes in v3:
    - Simplify mv98dx3236_resume_init by using of_io_request_and_map()

 Documentation/devicetree/bindings/arm/cpus.txt     |  1 +
 .../bindings/arm/marvell/98dx3236-resume-ctrl.txt  | 18 ++++++++
 arch/arm/mach-mvebu/Makefile                       |  1 +
 arch/arm/mach-mvebu/common.h                       |  1 +
 arch/arm/mach-mvebu/platsmp.c                      | 43 ++++++++++++++++++
 arch/arm/mach-mvebu/pmsu-98dx3236.c                | 52 ++++++++++++++++++++++
 6 files changed, 116 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/marvell/98dx3236-resume-ctrl.txt
 create mode 100644 arch/arm/mach-mvebu/pmsu-98dx3236.c

diff --git a/Documentation/devicetree/bindings/arm/cpus.txt b/Documentation/devicetree/bindings/arm/cpus.txt
index a1bcfeed5f24..3c2fd72d0bf9 100644
--- a/Documentation/devicetree/bindings/arm/cpus.txt
+++ b/Documentation/devicetree/bindings/arm/cpus.txt
@@ -202,6 +202,7 @@ nodes to be present and contain the properties described below.
 			    "marvell,armada-380-smp"
 			    "marvell,armada-390-smp"
 			    "marvell,armada-xp-smp"
+			    "marvell,98dx3236-smp"
 			    "mediatek,mt6589-smp"
 			    "mediatek,mt81xx-tz-smp"
 			    "qcom,gcc-msm8660"
diff --git a/Documentation/devicetree/bindings/arm/marvell/98dx3236-resume-ctrl.txt b/Documentation/devicetree/bindings/arm/marvell/98dx3236-resume-ctrl.txt
new file mode 100644
index 000000000000..8082ba872edd
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/marvell/98dx3236-resume-ctrl.txt
@@ -0,0 +1,18 @@
+Resume Control
+--------------
+Available on Marvell SOCs: 98DX3336 and 98DX4251
+
+Required properties:
+
+- compatible: must be "marvell,98dx3336-resume-ctrl"
+
+- reg: Should contain resume control registers location and length
+
+Example:
+
+resume at 20980 {
+	compatible = "marvell,98dx3336-resume-ctrl";
+	reg = <0x20980 0x10>;
+};
+
+
diff --git a/arch/arm/mach-mvebu/Makefile b/arch/arm/mach-mvebu/Makefile
index 6c6497e80a7b..2a2dd8324fb8 100644
--- a/arch/arm/mach-mvebu/Makefile
+++ b/arch/arm/mach-mvebu/Makefile
@@ -7,6 +7,7 @@ obj-$(CONFIG_MACH_MVEBU_ANY)	 += system-controller.o mvebu-soc-id.o
 
 ifeq ($(CONFIG_MACH_MVEBU_V7),y)
 obj-y				 += cpu-reset.o board-v7.o coherency.o coherency_ll.o pmsu.o pmsu_ll.o
+obj-y				 += pmsu-98dx3236.o
 
 obj-$(CONFIG_PM)		 += pm.o pm-board.o
 obj-$(CONFIG_SMP)		 += platsmp.o headsmp.o platsmp-a9.o headsmp-a9.o
diff --git a/arch/arm/mach-mvebu/common.h b/arch/arm/mach-mvebu/common.h
index 6b775492cfad..099dabf23461 100644
--- a/arch/arm/mach-mvebu/common.h
+++ b/arch/arm/mach-mvebu/common.h
@@ -27,4 +27,5 @@ void __iomem *mvebu_get_scu_base(void);
 
 int mvebu_pm_suspend_init(void (*board_pm_enter)(void __iomem *sdram_reg,
 							u32 srcmd));
+void mv98dx3236_resume_set_cpu_boot_addr(int hw_cpu, void *boot_addr);
 #endif
diff --git a/arch/arm/mach-mvebu/platsmp.c b/arch/arm/mach-mvebu/platsmp.c
index 46c742d3bd41..3c9ab9a008ad 100644
--- a/arch/arm/mach-mvebu/platsmp.c
+++ b/arch/arm/mach-mvebu/platsmp.c
@@ -182,5 +182,48 @@ const struct smp_operations armada_xp_smp_ops __initconst = {
 #endif
 };
 
+static int mv98dx3236_boot_secondary(unsigned int cpu, struct task_struct *idle)
+{
+	int ret, hw_cpu;
+
+	pr_info("Booting CPU %d\n", cpu);
+
+	hw_cpu = cpu_logical_map(cpu);
+	set_secondary_cpu_clock(hw_cpu);
+	mv98dx3236_resume_set_cpu_boot_addr(hw_cpu,
+					    armada_xp_secondary_startup);
+
+	/*
+	 * This is needed to wake up CPUs in the offline state after
+	 * using CPU hotplug.
+	 */
+	arch_send_wakeup_ipi_mask(cpumask_of(cpu));
+
+	/*
+	 * This is needed to take secondary CPUs out of reset on the
+	 * initial boot.
+	 */
+	ret = mvebu_cpu_reset_deassert(hw_cpu);
+	if (ret) {
+		pr_warn("unable to boot CPU: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+struct smp_operations mv98dx3236_smp_ops __initdata = {
+	.smp_init_cpus		= armada_xp_smp_init_cpus,
+	.smp_prepare_cpus	= armada_xp_smp_prepare_cpus,
+	.smp_boot_secondary	= mv98dx3236_boot_secondary,
+	.smp_secondary_init     = armada_xp_secondary_init,
+#ifdef CONFIG_HOTPLUG_CPU
+	.cpu_die		= armada_xp_cpu_die,
+	.cpu_kill               = armada_xp_cpu_kill,
+#endif
+};
+
 CPU_METHOD_OF_DECLARE(armada_xp_smp, "marvell,armada-xp-smp",
 		      &armada_xp_smp_ops);
+CPU_METHOD_OF_DECLARE(mv98dx3236_smp, "marvell,98dx3236-smp",
+		      &mv98dx3236_smp_ops);
diff --git a/arch/arm/mach-mvebu/pmsu-98dx3236.c b/arch/arm/mach-mvebu/pmsu-98dx3236.c
new file mode 100644
index 000000000000..1052674dd439
--- /dev/null
+++ b/arch/arm/mach-mvebu/pmsu-98dx3236.c
@@ -0,0 +1,52 @@
+/**
+ * CPU resume support for 98DX3236 internal CPU (a.k.a. MSYS).
+ */
+
+#define pr_fmt(fmt) "mv98dx3236-resume: " fmt
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/of_address.h>
+#include <linux/io.h>
+#include "common.h"
+
+static void __iomem *mv98dx3236_resume_base;
+#define MV98DX3236_CPU_RESUME_CTRL_OFFSET	0x08
+#define MV98DX3236_CPU_RESUME_ADDR_OFFSET	0x04
+
+static const struct of_device_id of_mv98dx3236_resume_table[] = {
+	{.compatible = "marvell,98dx3336-resume-ctrl",},
+	{ /* end of list */ },
+};
+
+void mv98dx3236_resume_set_cpu_boot_addr(int hw_cpu, void *boot_addr)
+{
+	WARN_ON(hw_cpu != 1);
+
+	writel(0, mv98dx3236_resume_base + MV98DX3236_CPU_RESUME_CTRL_OFFSET);
+	writel(virt_to_phys(boot_addr), mv98dx3236_resume_base +
+	       MV98DX3236_CPU_RESUME_ADDR_OFFSET);
+}
+
+static int __init mv98dx3236_resume_init(void)
+{
+	struct device_node *np;
+	void __iomem *base;
+
+	np = of_find_matching_node(NULL, of_mv98dx3236_resume_table);
+	if (!np)
+		return 0;
+
+	base = of_io_request_and_map(np, 0, of_node_full_name(np));
+	if (IS_ERR(base)) {
+		pr_err("unable to map registers\n");
+		of_node_put(np);
+		return PTR_ERR(mv98dx3236_resume_base);
+	}
+
+	mv98dx3236_resume_base = base;
+	of_node_put(np);
+	return 0;
+}
+
+early_initcall(mv98dx3236_resume_init);
-- 
2.11.0.24.ge6920cf
