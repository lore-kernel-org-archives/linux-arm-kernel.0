From: wangkefeng.wang@huawei.com (Kefeng Wang)
Date: Mon, 8 Aug 2016 14:05:16 +0800
Subject: [PATCH v2] arm64: Support hard limit of cpu count by nr_cpus
In-Reply-To: <02d77415-9eb0-92f4-7cb6-9b941cda9a4d@arm.com>
References: <02d77415-9eb0-92f4-7cb6-9b941cda9a4d@arm.com>
Message-ID: <1470636316-24552-1-git-send-email-wangkefeng.wang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the hard limit of cpu count by set boot options nr_cpus=x
on arm64, and show a better warning when cpu number exceeds the limit.

Reported-by: Shiyuan Hu <hushiyuan@huawei.com>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---

Changed since v1:
- clip cpu number in smp_init_cpus suggested-by Will and Suzuki, and update
  the warning.

 arch/arm64/kernel/smp.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 76a6d92..cbfc31c 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -661,9 +661,9 @@ void __init smp_init_cpus(void)
 		acpi_table_parse_madt(ACPI_MADT_TYPE_GENERIC_INTERRUPT,
 				      acpi_parse_gic_cpu_interface, 0);
 
-	if (cpu_count > NR_CPUS)
-		pr_warn("no. of cores (%d) greater than configured maximum of %d - clipping\n",
-			cpu_count, NR_CPUS);
+	if (cpu_count > nr_cpu_ids)
+		pr_warn("%d cores exceeds configured maximum of %d - clipping\n",
+			cpu_count, nr_cpu_ids);
 
 	if (!bootcpu_valid) {
 		pr_err("missing boot CPU MPIDR, not enabling secondaries\n");
@@ -677,7 +677,7 @@ void __init smp_init_cpus(void)
 	 * with entries in cpu_logical_map while initializing the cpus.
 	 * If the cpu set-up fails, invalidate the cpu_logical_map entry.
 	 */
-	for (i = 1; i < NR_CPUS; i++) {
+	for (i = 1; i < nr_cpu_ids; i++) {
 		if (cpu_logical_map(i) != INVALID_HWID) {
 			if (smp_cpu_setup(i))
 				cpu_logical_map(i) = INVALID_HWID;
-- 
1.7.12.4
