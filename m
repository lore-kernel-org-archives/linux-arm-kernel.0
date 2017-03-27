From: juri.lelli@arm.com (Juri Lelli)
Date: Mon, 27 Mar 2017 14:18:23 +0100
Subject: [PATCH v3 7/9] arm,arm64,drivers: reduce scope of cap_parsing_failed
In-Reply-To: <20170327131825.32134-1-juri.lelli@arm.com>
References: <20170327131825.32134-1-juri.lelli@arm.com>
Message-ID: <20170327131825.32134-8-juri.lelli@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Reduce the scope of cap_parsing_failed (making it static in
drivers/base/arch_topology.c) by slightly changing {arm,arm64} DT
parsing code.

For arm checking for !cap_parsing_failed before calling normalize_
cpu_capacity() is superfluous, as returning an error from parse_
cpu_capacity() (above) means cap_from _dt is set to false.

For arm64 we can simply check if raw_capacity points to something,
which is not if capacity parsing has failed.

Suggested-by: Morten Rasmussen <morten.rasmussen@arm.com>
Signed-off-by: Juri Lelli <juri.lelli@arm.com>
---
 arch/arm/kernel/topology.c   | 3 +--
 arch/arm64/kernel/topology.c | 5 +----
 drivers/base/arch_topology.c | 4 ++--
 3 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/arm/kernel/topology.c b/arch/arm/kernel/topology.c
index 49ef025ffaa0..1e35a3265ddf 100644
--- a/arch/arm/kernel/topology.c
+++ b/arch/arm/kernel/topology.c
@@ -76,7 +76,6 @@ static unsigned long *__cpu_capacity;
 
 static unsigned long middle_capacity = 1;
 static bool cap_from_dt = true;
-extern bool cap_parsing_failed;
 extern void normalize_cpu_capacity(void);
 extern int __init parse_cpu_capacity(struct device_node *cpu_node, int cpu);
 
@@ -165,7 +164,7 @@ static void __init parse_dt_topology(void)
 		middle_capacity = ((max_capacity / 3)
 				>> (SCHED_CAPACITY_SHIFT-1)) + 1;
 
-	if (cap_from_dt && !cap_parsing_failed)
+	if (cap_from_dt)
 		normalize_cpu_capacity();
 }
 
diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
index c5bc31eb97e8..7e1f6f75185b 100644
--- a/arch/arm64/kernel/topology.c
+++ b/arch/arm64/kernel/topology.c
@@ -27,7 +27,6 @@
 #include <asm/cputype.h>
 #include <asm/topology.h>
 
-extern bool cap_parsing_failed;
 extern void normalize_cpu_capacity(void);
 extern int __init parse_cpu_capacity(struct device_node *cpu_node, int cpu);
 
@@ -187,10 +186,8 @@ static int __init parse_dt_topology(void)
 	 * cluster with restricted subnodes.
 	 */
 	map = of_get_child_by_name(cn, "cpu-map");
-	if (!map) {
-		cap_parsing_failed = true;
+	if (!map)
 		goto out;
-	}
 
 	ret = parse_cluster(map, 0);
 	if (ret != 0)
diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index b24d9a2af2c5..6543a032b332 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -93,7 +93,7 @@ subsys_initcall(register_cpu_capacity_sysctl);
 
 static u32 capacity_scale;
 static u32 *raw_capacity;
-bool cap_parsing_failed;
+static bool cap_parsing_failed;
 
 void normalize_cpu_capacity(void)
 {
@@ -208,7 +208,7 @@ static int __init register_cpufreq_notifier(void)
 	 * until we have the necessary code to parse the cpu capacity, so
 	 * skip registering cpufreq notifier.
 	 */
-	if (!acpi_disabled || cap_parsing_failed)
+	if (!acpi_disabled || !raw_capacity)
 		return -EINVAL;
 
 	if (!alloc_cpumask_var(&cpus_to_visit, GFP_KERNEL)) {
-- 
2.10.0
