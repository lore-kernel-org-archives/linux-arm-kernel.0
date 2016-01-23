From: guohanjun@huawei.com (Hanjun Guo)
Date: Sat, 23 Jan 2016 17:39:25 +0800
Subject: [PATCH v3 10/12] acpi,
 numa: move bad_srat() and srat_disabled() to common place
In-Reply-To: <1453541967-3744-1-git-send-email-guohanjun@huawei.com>
References: <1453541967-3744-1-git-send-email-guohanjun@huawei.com>
Message-ID: <1453541967-3744-11-git-send-email-guohanjun@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Hanjun Guo <hanjun.guo@linaro.org>

bad_srat() and srat_disabled() are shared by arm64 and x86,
move it to common place to reduce duplication.

Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 arch/arm64/kernel/acpi_numa.c | 12 ------------
 arch/x86/include/asm/acpi.h   |  1 -
 arch/x86/mm/numa.c            |  2 +-
 arch/x86/mm/srat.c            | 13 -------------
 drivers/acpi/numa.c           |  1 +
 include/acpi/acpi_numa.h      | 12 ++++++++++++
 6 files changed, 14 insertions(+), 27 deletions(-)

diff --git a/arch/arm64/kernel/acpi_numa.c b/arch/arm64/kernel/acpi_numa.c
index 3bcf058..fb1556f 100644
--- a/arch/arm64/kernel/acpi_numa.c
+++ b/arch/arm64/kernel/acpi_numa.c
@@ -28,7 +28,6 @@
 #include <acpi/processor.h>
 #include <asm/numa.h>
 
-int acpi_numa __initdata;
 static int cpus_in_srat;
 
 struct __node_cpu_hwid {
@@ -39,17 +38,6 @@ struct __node_cpu_hwid {
 static struct __node_cpu_hwid early_node_cpu_hwid[NR_CPUS] = {
 [0 ... NR_CPUS - 1] = {NUMA_NO_NODE, PHYS_CPUID_INVALID} };
 
-static __init void bad_srat(void)
-{
-	pr_err("SRAT not used.\n");
-	acpi_numa = -1;
-}
-
-static __init inline int srat_disabled(void)
-{
-	return acpi_numa < 0;
-}
-
 void __init acpi_numa_set_node_info(unsigned int cpu, u64 hwid)
 {
 	int nid = 0, i;
diff --git a/arch/x86/include/asm/acpi.h b/arch/x86/include/asm/acpi.h
index 94c18eb..65f1e95 100644
--- a/arch/x86/include/asm/acpi.h
+++ b/arch/x86/include/asm/acpi.h
@@ -145,7 +145,6 @@ static inline void disable_acpi(void) { }
 #define ARCH_HAS_POWER_INIT	1
 
 #ifdef CONFIG_ACPI_NUMA
-extern int acpi_numa;
 extern int x86_acpi_numa_init(void);
 #endif /* CONFIG_ACPI_NUMA */
 
diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
index c3b3f65..fd59371 100644
--- a/arch/x86/mm/numa.c
+++ b/arch/x86/mm/numa.c
@@ -1,4 +1,5 @@
 /* Common code for 32 and 64-bit NUMA */
+#include <linux/acpi.h>
 #include <linux/kernel.h>
 #include <linux/mm.h>
 #include <linux/string.h>
@@ -15,7 +16,6 @@
 #include <asm/e820.h>
 #include <asm/proto.h>
 #include <asm/dma.h>
-#include <asm/acpi.h>
 #include <asm/amd_nb.h>
 
 #include "numa_internal.h"
diff --git a/arch/x86/mm/srat.c b/arch/x86/mm/srat.c
index 304cdf2..7078b3f 100644
--- a/arch/x86/mm/srat.c
+++ b/arch/x86/mm/srat.c
@@ -24,19 +24,6 @@
 #include <asm/apic.h>
 #include <asm/uv/uv.h>
 
-int acpi_numa __initdata;
-
-static __init void bad_srat(void)
-{
-	printk(KERN_ERR "SRAT: SRAT not used.\n");
-	acpi_numa = -1;
-}
-
-static __init inline int srat_disabled(void)
-{
-	return acpi_numa < 0;
-}
-
 /* Callback for Proximity Domain -> x2APIC mapping */
 void __init
 acpi_numa_x2apic_affinity_init(struct acpi_srat_x2apic_cpu_affinity *pa)
diff --git a/drivers/acpi/numa.c b/drivers/acpi/numa.c
index b33915e..05e3795 100644
--- a/drivers/acpi/numa.c
+++ b/drivers/acpi/numa.c
@@ -40,6 +40,7 @@ static int node_to_pxm_map[MAX_NUMNODES]
 			= { [0 ... MAX_NUMNODES - 1] = PXM_INVAL };
 
 unsigned char acpi_srat_revision __initdata;
+int acpi_numa __initdata;
 
 int pxm_to_node(int pxm)
 {
diff --git a/include/acpi/acpi_numa.h b/include/acpi/acpi_numa.h
index 94a37cd..28f06a6 100644
--- a/include/acpi/acpi_numa.h
+++ b/include/acpi/acpi_numa.h
@@ -15,6 +15,18 @@ extern int pxm_to_node(int);
 extern int node_to_pxm(int);
 extern int acpi_map_pxm_to_node(int);
 extern unsigned char acpi_srat_revision;
+extern int acpi_numa __initdata;
+
+static inline void bad_srat(void)
+{
+	pr_err("SRAT: SRAT not used.\n");
+	acpi_numa = -1;
+}
+
+static  inline int srat_disabled(void)
+{
+	return acpi_numa < 0;
+}
 
 #endif				/* CONFIG_ACPI_NUMA */
 #endif				/* __ACP_NUMA_H */
-- 
1.9.1
