From: wangkefeng.wang@huawei.com (Kefeng Wang)
Date: Fri, 5 Aug 2016 14:03:55 +0800
Subject: [PATCH] arm64: Support hard limit of cpu count by nr_cpus
Message-ID: <1470377035-1591-1-git-send-email-wangkefeng.wang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the hard limit of cpu count by nr_cpus on arm64.
The code is borrowed from MIPS.

Reported-by: Shiyuan Hu <hushiyuan@huawei.com>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 arch/arm64/kernel/setup.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index 536dce2..597b777 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -224,6 +224,21 @@ static void __init request_standard_resources(void)
 
 u64 __cpu_logical_map[NR_CPUS] = { [0 ... NR_CPUS-1] = INVALID_HWID };
 
+static void __init prefill_possible_map(void)
+{
+	int i, possible = num_possible_cpus();
+
+	if (possible > nr_cpu_ids)
+		possible = nr_cpu_ids;
+
+	for (i = 0; i < possible; i++)
+		set_cpu_possible(i, true);
+	for (; i < NR_CPUS; i++)
+		set_cpu_possible(i, false);
+
+	nr_cpu_ids = possible;
+}
+
 void __init setup_arch(char **cmdline_p)
 {
 	pr_info("Boot CPU: AArch64 Processor [%08x]\n", read_cpuid_id());
@@ -285,6 +300,7 @@ void __init setup_arch(char **cmdline_p)
 	cpu_read_bootcpu_ops();
 	smp_init_cpus();
 	smp_build_mpidr_hash();
+	prefill_possible_map();
 
 #ifdef CONFIG_VT
 #if defined(CONFIG_VGA_CONSOLE)
-- 
1.7.12.4
