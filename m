From: chris.packham@alliedtelesis.co.nz (Chris Packham)
Date: Fri, 13 Jan 2017 22:12:17 +1300
Subject: [PATCHv4 2/5] arm: mvebu: support for SMP on 98DX3336 SoC
In-Reply-To: <20170113091222.7132-1-chris.packham@alliedtelesis.co.nz>
References: <20170113091222.7132-1-chris.packham@alliedtelesis.co.nz>
Message-ID: <20170113091222.7132-3-chris.packham@alliedtelesis.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Compared to the armada-xp the 98DX3336 uses different registers to set
the boot address for the secondary CPU so a new enable-method is needed.
This will only work if the machine definition doesn't define an overall
smp_ops because there is not currently a way of overriding this from the
device tree if it is set in the machine definition.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
Acked-by: Rob Herring <robh@kernel.org>
---

Notes:
    Changes in v2:
    - Document new enable-method value
    - Correct some references from 98DX4521 to 98DX3236
    Changes in v3:
    - Simplify mv98dx3236_resume_init by using of_io_request_and_map()
    Changes in v4:
    - integrate changes into platsmp.c instead of new init call
    - avoid duplicated code.
    - fix error return
    - Collect ack from Rob

 Documentation/devicetree/bindings/arm/cpus.txt     |  1 +
 .../bindings/arm/marvell/98dx3236-resume-ctrl.txt  | 18 +++++
 arch/arm/mach-mvebu/platsmp.c                      | 86 ++++++++++++++++++++++
 3 files changed, 105 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/marvell/98dx3236-resume-ctrl.txt

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
diff --git a/arch/arm/mach-mvebu/platsmp.c b/arch/arm/mach-mvebu/platsmp.c
index 46c742d3bd41..59be3ca0464f 100644
--- a/arch/arm/mach-mvebu/platsmp.c
+++ b/arch/arm/mach-mvebu/platsmp.c
@@ -184,3 +184,89 @@ const struct smp_operations armada_xp_smp_ops __initconst = {
 
 CPU_METHOD_OF_DECLARE(armada_xp_smp, "marvell,armada-xp-smp",
 		      &armada_xp_smp_ops);
+
+struct resume_controller {
+	u32 resume_control;
+	u32 resume_boot_addr;
+};
+
+static const struct resume_controller mv98dx3336_resume_controller = {
+	.resume_control = 0x08,
+	.resume_boot_addr = 0x04,
+};
+
+static const struct of_device_id of_mv98dx3236_resume_table[] = {
+	{
+		.compatible = "marvell,98dx3336-resume-ctrl",
+		.data = (void *)&mv98dx3336_resume_controller,
+	},
+	{ /* end of list */ },
+};
+
+static int mv98dx3236_resume_set_cpu_boot_addr(int hw_cpu, void *boot_addr)
+{
+	const struct of_device_id *match;
+	struct device_node *np;
+	void __iomem *base;
+	struct resume_controller *rc;
+
+	WARN_ON(hw_cpu != 1);
+
+	np = of_find_matching_node_and_match(NULL, of_mv98dx3236_resume_table,
+					     &match);
+	if (!np)
+		return -ENODEV;
+
+	base = of_io_request_and_map(np, 0, of_node_full_name(np));
+	rc = (struct resume_controller *)match->data;
+	of_node_put(np);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	writel(0, base + rc->resume_control);
+	writel(virt_to_phys(boot_addr), base + rc->resume_boot_addr);
+
+	return 0;
+}
+
+static int mv98dx3236_boot_secondary(unsigned int cpu, struct task_struct *idle)
+{
+	int ret, hw_cpu;
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
+static const struct smp_operations mv98dx3236_smp_ops __initconst = {
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
+CPU_METHOD_OF_DECLARE(mv98dx3236_smp, "marvell,98dx3236-smp",
+		      &mv98dx3236_smp_ops);
-- 
2.11.0.24.ge6920cf
