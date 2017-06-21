From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Wed, 21 Jun 2017 10:16:43 +0530
Subject: [PATCH V2 4/5] arch_topology: Return 0 or -ve errors from
 topology_parse_cpu_capacity()
In-Reply-To: <cover.1498019799.git.viresh.kumar@linaro.org>
References: <cover.1498019799.git.viresh.kumar@linaro.org>
Message-ID: <2213a1f0657ef057dd775085943b362dc3e9757d.1498019799.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the standard way of returning errors instead of returning 0(failure)
OR 1(success) and making it hard to read.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 arch/arm/kernel/topology.c   | 2 +-
 drivers/base/arch_topology.c | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/kernel/topology.c b/arch/arm/kernel/topology.c
index bf949a763dbe..a7ef4c35855e 100644
--- a/arch/arm/kernel/topology.c
+++ b/arch/arm/kernel/topology.c
@@ -111,7 +111,7 @@ static void __init parse_dt_topology(void)
 			continue;
 		}
 
-		if (topology_parse_cpu_capacity(cn, cpu)) {
+		if (!topology_parse_cpu_capacity(cn, cpu)) {
 			of_node_put(cn);
 			continue;
 		}
diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index 07784ba666a7..ff8713b83090 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -121,11 +121,11 @@ void topology_normalize_cpu_scale(void)
 
 int __init topology_parse_cpu_capacity(struct device_node *cpu_node, int cpu)
 {
-	int ret = 1;
+	int ret;
 	u32 cpu_capacity;
 
 	if (cap_parsing_failed)
-		return !ret;
+		return -EINVAL;
 
 	ret = of_property_read_u32(cpu_node, "capacity-dmips-mhz",
 				   &cpu_capacity);
@@ -137,7 +137,7 @@ int __init topology_parse_cpu_capacity(struct device_node *cpu_node, int cpu)
 			if (!raw_capacity) {
 				pr_err("cpu_capacity: failed to allocate memory for raw capacities\n");
 				cap_parsing_failed = true;
-				return 0;
+				return -ENOMEM;
 			}
 		}
 		capacity_scale = max(cpu_capacity, capacity_scale);
@@ -154,7 +154,7 @@ int __init topology_parse_cpu_capacity(struct device_node *cpu_node, int cpu)
 		kfree(raw_capacity);
 	}
 
-	return !ret;
+	return ret;
 }
 
 #ifdef CONFIG_CPU_FREQ
-- 
2.13.0.71.gd7076ec9c9cb
