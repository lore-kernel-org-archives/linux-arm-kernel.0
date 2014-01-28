From: jg1.han@samsung.com (Jingoo Han)
Date: Tue, 28 Jan 2014 10:35:47 +0900
Subject: [PATCH 1/2] arm64: use num_possible_cpus() instead of NR_CPUS
Message-ID: <001d01cf1bc9$452569d0$cf703d70$%han@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use num_possible_cpus() instead of direct use of NR_CPUS. Also,
it fixes the following checkpatch warning.

  WARNING: usage of NR_CPUS is often wrong - consider using cpu_possible(), num_possible_cpus(), for_each_possible_cpu(), etc

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 arch/arm64/kernel/smp.c |   10 +++++-----
 arch/arm64/mm/context.c |    2 +-
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 1b7617a..09ff7d4 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -320,7 +320,7 @@ void __init smp_init_cpus(void)
 		 * cpu_logical_map was initialized to INVALID_HWID to
 		 * avoid matching valid MPIDR values.
 		 */
-		for (i = 1; (i < cpu) && (i < NR_CPUS); i++) {
+		for (i = 1; (i < cpu) && (i < num_possible_cpus()); i++) {
 			if (cpu_logical_map(i) == hwid) {
 				pr_err("%s: duplicate cpu reg properties in the DT\n",
 					dn->full_name);
@@ -352,7 +352,7 @@ void __init smp_init_cpus(void)
 			continue;
 		}
 
-		if (cpu >= NR_CPUS)
+		if (cpu >= num_possible_cpus())
 			goto next;
 
 		if (cpu_read_ops(dn, cpu) != 0)
@@ -368,9 +368,9 @@ next:
 	}
 
 	/* sanity check */
-	if (cpu > NR_CPUS)
+	if (cpu > num_possible_cpus())
 		pr_warning("no. of cores (%d) greater than configured maximum of %d - clipping\n",
-			   cpu, NR_CPUS);
+			   cpu, num_possible_cpus());
 
 	if (!bootcpu_valid) {
 		pr_err("DT missing boot CPU MPIDR, not enabling secondaries\n");
@@ -381,7 +381,7 @@ next:
 	 * All the cpus that made it to the cpu_logical_map have been
 	 * validated so set them as possible cpus.
 	 */
-	for (i = 0; i < NR_CPUS; i++)
+	for (i = 0; i < num_possible_cpus(); i++)
 		if (cpu_logical_map(i) != INVALID_HWID)
 			set_cpu_possible(i, true);
 }
diff --git a/arch/arm64/mm/context.c b/arch/arm64/mm/context.c
index baa758d..3ef960a 100644
--- a/arch/arm64/mm/context.c
+++ b/arch/arm64/mm/context.c
@@ -151,7 +151,7 @@ void __new_context(struct mm_struct *mm)
 		smp_wmb();
 		smp_call_function(reset_context, NULL, 1);
 #endif
-		cpu_last_asid += NR_CPUS - 1;
+		cpu_last_asid += num_possible_cpus() - 1;
 	}
 
 	set_mm_context(mm, asid);
-- 
1.7.10.4
