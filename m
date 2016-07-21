From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Thu, 21 Jul 2016 11:12:55 +0100
Subject: [PATCH] arm64: Fix incorrect per-cpu usage for boot CPU
Message-ID: <1469095975-976-1-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In smp_prepare_boot_cpu(), we invoke cpuinfo_store_boot_cpu to  store
the cpuinfo in a per-cpu ptr, before initialising the per-cpu offset for
the boot CPU. This patch reorders the sequence to make sure we initialise
the per-cpu offset before accessing the per-cpu area.

Commit 4b998ff1885eec ("arm64: Delay cpuinfo_store_boot_cpu") fixed the
issue where we modified the per-cpu area even before the kernel initialises
the per-cpu areas, but failed to wait until the boot cpu updated it's
offset.

Fixes: commit 4b998ff1885eec ("arm64: Delay cpuinfo_store_boot_cpu")
Cc: <stable@vger.kernel.org>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/kernel/smp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 62ff3c0..d242e81 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -437,9 +437,9 @@ void __init smp_cpus_done(unsigned int max_cpus)
 
 void __init smp_prepare_boot_cpu(void)
 {
+	set_my_cpu_offset(per_cpu_offset(smp_processor_id()));
 	cpuinfo_store_boot_cpu();
 	save_boot_cpu_run_el();
-	set_my_cpu_offset(per_cpu_offset(smp_processor_id()));
 }
 
 static u64 __init of_get_cpu_mpidr(struct device_node *dn)
-- 
2.7.4
