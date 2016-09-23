From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Fri, 23 Sep 2016 14:09:06 +0100
Subject: [PATCH 1/2] ARM: vexpress: refine MCPM smp operations override
 criteria
Message-ID: <20160923130907.4187-1-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Current vexpress smp init code detects whether to override the
default smp ops with MCPM smp ops by matching the "cci-400"
compatible string, in that MCPM requires control over CCI ports
to manage low-power states entry/exit.

The "cci-400" compatible string check is a necessary but not
sufficient condition for MCPM to work, because the cci-400
can be made visible to the kernel, but firmware can nonetheless
disable non-secure CCI ports control, while still allowing PMU
access; if booted in non-secure world, the kernel would still
blindly override smp operations with MCPM operations, resulting
in kernel faults when the CCI ports programming interface is
accessed from non-secure world.

This means that the "cci-400" compatible string check would
result in a false positive in systems that eg boot in HYP mode,
where CCI ports non-secure access is explicitly not allowed,
and it is reported in the respective device tree nodes with
CCI ports marked as disabled.

Refactor the smp operations initialization to make sure that
the kernel is actually allowed to take control over CCI ports
(by enabling MCPM smp operations) before overriding default
vexpress smp operations.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Liviu Dudau <liviu.dudau@arm.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/mach-vexpress/platsmp.c | 31 ++++++++++++++++++++++++-------
 1 file changed, 24 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-vexpress/platsmp.c b/arch/arm/mach-vexpress/platsmp.c
index 8b8d072..6cfd782 100644
--- a/arch/arm/mach-vexpress/platsmp.c
+++ b/arch/arm/mach-vexpress/platsmp.c
@@ -26,17 +26,34 @@
 bool __init vexpress_smp_init_ops(void)
 {
 #ifdef CONFIG_MCPM
+	int cpu;
+	struct device_node *cpu_node, *cci_node;
+
 	/*
-	 * The best way to detect a multi-cluster configuration at the moment
-	 * is to look for the presence of a CCI in the system.
+	 * The best way to detect a multi-cluster configuration
+	 * is to detect if the kernel can take over CCI ports
+	 * control. Loop over possible CPUs and check if CCI
+	 * port control is available.
 	 * Override the default vexpress_smp_ops if so.
 	 */
-	struct device_node *node;
-	node = of_find_compatible_node(NULL, NULL, "arm,cci-400");
-	if (node && of_device_is_available(node)) {
-		mcpm_smp_set_ops();
-		return true;
+	for_each_possible_cpu(cpu) {
+		bool available;
+
+		cpu_node = of_get_cpu_node(cpu, NULL);
+		if (WARN(!cpu_node, "Missing cpu device node!"))
+			return false;
+
+		cci_node = of_parse_phandle(cpu_node, "cci-control-port", 0);
+		available = cci_node && of_device_is_available(cci_node);
+		of_node_put(cci_node);
+		of_node_put(cpu_node);
+
+		if (!available)
+			return false;
 	}
+
+	mcpm_smp_set_ops();
+	return true;
 #endif
 	return false;
 }
-- 
2.10.0
