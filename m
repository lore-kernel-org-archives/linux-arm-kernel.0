From: Sudeep.KarkadaNagesha@arm.com (Sudeep KarkadaNagesha)
Date: Wed, 30 Oct 2013 13:47:16 +0000
Subject: [PATCH] ARM64: simplify cpu_read_bootcpu_ops using OF/DT helper
Message-ID: <1383140836-11998-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>

Once the cpu_logical_map for any logical cpu is populated with the
corresponding physical identifier(i.e. mpidr), it's device node can
be retrieved using the DT helper 'of_get_cpu_node'. Currently the
device tree parsing code to get boot cpu node is duplicated in
'cpu_read_bootcpu_ops'.

This patch replaces the code parsing the device tree for the boot
cpu with of_get_cpu_node.

Signed-off-by: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
---
 arch/arm64/kernel/cpu_ops.c | 22 +++++-----------------
 1 file changed, 5 insertions(+), 17 deletions(-)

diff --git a/arch/arm64/kernel/cpu_ops.c b/arch/arm64/kernel/cpu_ops.c
index aa0c9e7..4fbe440 100644
--- a/arch/arm64/kernel/cpu_ops.c
+++ b/arch/arm64/kernel/cpu_ops.c
@@ -78,22 +78,10 @@ int __init cpu_read_ops(struct device_node *dn, int cpu)
 
 void __init cpu_read_bootcpu_ops(void)
 {
-	struct device_node *dn = NULL;
-	u64 mpidr = cpu_logical_map(0);
-
-	while ((dn = of_find_node_by_type(dn, "cpu"))) {
-		u64 hwid;
-		const __be32 *prop;
-
-		prop = of_get_property(dn, "reg", NULL);
-		if (!prop)
-			continue;
-
-		hwid = of_read_number(prop, of_n_addr_cells(dn));
-		if (hwid == mpidr) {
-			cpu_read_ops(dn, 0);
-			of_node_put(dn);
-			return;
-		}
+	struct device_node *dn = of_get_cpu_node(0, NULL);
+	if (!dn) {
+		pr_err("failed to find device node for boot cpu\n");
+		return;
 	}
+	cpu_read_ops(dn, 0);
 }
-- 
1.8.1.2
