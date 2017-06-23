From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 23 Jun 2017 14:55:32 +0530
Subject: [PATCH V3 3/5] arch_topology: Change return type of
 topology_parse_cpu_capacity() to bool
In-Reply-To: <cover.1498209817.git.viresh.kumar@linaro.org>
References: <cover.1498209817.git.viresh.kumar@linaro.org>
Message-ID: <23788541e21b137b0f868f9da3ab1c4db028debc.1498209817.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

topology_parse_cpu_capacity() returns 1 on success and 0 on errors. Make
it return bool instead of int as that suits the purpose better.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/arch_topology.c  | 8 ++++----
 include/linux/arch_topology.h | 4 +++-
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index a3cd7c869c3e..5728e2fbb765 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -119,13 +119,13 @@ void topology_normalize_cpu_scale(void)
 	mutex_unlock(&cpu_scale_mutex);
 }
 
-int __init topology_parse_cpu_capacity(struct device_node *cpu_node, int cpu)
+bool __init topology_parse_cpu_capacity(struct device_node *cpu_node, int cpu)
 {
-	int ret = 1;
+	int ret;
 	u32 cpu_capacity;
 
 	if (cap_parsing_failed)
-		return !ret;
+		return false;
 
 	ret = of_property_read_u32(cpu_node, "capacity-dmips-mhz",
 				   &cpu_capacity);
@@ -137,7 +137,7 @@ int __init topology_parse_cpu_capacity(struct device_node *cpu_node, int cpu)
 			if (!raw_capacity) {
 				pr_err("cpu_capacity: failed to allocate memory for raw capacities\n");
 				cap_parsing_failed = true;
-				return 0;
+				return false;
 			}
 		}
 		capacity_scale = max(cpu_capacity, capacity_scale);
diff --git a/include/linux/arch_topology.h b/include/linux/arch_topology.h
index 9af3c174c03a..716ce587247e 100644
--- a/include/linux/arch_topology.h
+++ b/include/linux/arch_topology.h
@@ -4,10 +4,12 @@
 #ifndef _LINUX_ARCH_TOPOLOGY_H_
 #define _LINUX_ARCH_TOPOLOGY_H_
 
+#include <linux/types.h>
+
 void topology_normalize_cpu_scale(void);
 
 struct device_node;
-int topology_parse_cpu_capacity(struct device_node *cpu_node, int cpu);
+bool topology_parse_cpu_capacity(struct device_node *cpu_node, int cpu);
 
 struct sched_domain;
 unsigned long topology_get_cpu_scale(struct sched_domain *sd, int cpu);
-- 
2.13.0.71.gd7076ec9c9cb
