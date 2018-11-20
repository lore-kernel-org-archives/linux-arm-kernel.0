From: tiny.windzz@gmail.com (Yangtao Li)
Date: Tue, 20 Nov 2018 09:01:09 -0500
Subject: [PATCH] arm: add missing of_node_put()
Message-ID: <20181120140109.20334-1-tiny.windzz@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

use of_node_put() to release the refcount.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 arch/arm/kernel/devtree.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/arm/kernel/devtree.c b/arch/arm/kernel/devtree.c
index e3057c1b55b9..9576adf0d15b 100644
--- a/arch/arm/kernel/devtree.c
+++ b/arch/arm/kernel/devtree.c
@@ -101,7 +101,7 @@ void __init arm_dt_init_cpu_maps(void)
 		if (!cell || prop_bytes < sizeof(*cell)) {
 			pr_debug(" * %pOF missing reg property\n", cpu);
 			of_node_put(cpu);
-			return;
+			goto out;
 		}
 
 		/*
@@ -115,7 +115,7 @@ void __init arm_dt_init_cpu_maps(void)
 
 		if (prop_bytes || (hwid & ~MPIDR_HWID_BITMASK)) {
 			of_node_put(cpu);
-			return;
+			goto out;
 		}
 
 		/*
@@ -129,7 +129,7 @@ void __init arm_dt_init_cpu_maps(void)
 			if (WARN(tmp_map[j] == hwid,
 				 "Duplicate /cpu reg properties in the DT\n")) {
 				of_node_put(cpu);
-				return;
+				goto out;
 			}
 
 		/*
@@ -171,7 +171,7 @@ void __init arm_dt_init_cpu_maps(void)
 
 	if (!bootcpu_valid) {
 		pr_warn("DT missing boot CPU MPIDR[23:0], fall back to default cpu_logical_map\n");
-		return;
+		goto out;
 	}
 
 	/*
@@ -184,6 +184,8 @@ void __init arm_dt_init_cpu_maps(void)
 		cpu_logical_map(i) = tmp_map[i];
 		pr_debug("cpu logical map 0x%x\n", cpu_logical_map(i));
 	}
+out:
+	of_node_put(cpus);
 }
 
 bool arch_match_cpu_phys_id(int cpu, u64 phys_id)
-- 
2.17.0
