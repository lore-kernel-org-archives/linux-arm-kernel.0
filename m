From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Tue, 10 May 2016 11:14:41 +0100
Subject: [PATCH] arm64: secondary_start_kernel: Remove unnecessary barrier
Message-ID: <1462875281-5063-1-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove the unnecessary smp_wmb(), which was added to make sure
that the update_cpu_boot_status() completes before we mark the
CPU online. But update_cpu_boot_status() already has dsb() (required
for the failing CPUs) to ensure the correct behavior.

Cc: Will Deacon <will.deacon@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Dennis Chen <dennis.chen@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/kernel/smp.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index b2d5f4e..ec040a8 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -225,8 +225,6 @@ asmlinkage void secondary_start_kernel(void)
 	pr_info("CPU%u: Booted secondary processor [%08x]\n",
 					 cpu, read_cpuid_id());
 	update_cpu_boot_status(CPU_BOOT_SUCCESS);
-	/* Make sure the status update is visible before we complete */
-	smp_wmb();
 	set_cpu_online(cpu, true);
 	complete(&cpu_running);
 
-- 
1.7.9.5
