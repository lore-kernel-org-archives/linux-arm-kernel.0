From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Tue, 26 Apr 2016 15:49:00 +0100
Subject: [PATCH v5 5/5] arm64: Fix behavior of maxcpus=N
In-Reply-To: <1461682140-7131-1-git-send-email-suzuki.poulose@arm.com>
References: <1461682140-7131-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1461682140-7131-6-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

maxcpu=n sets the number of CPUs activated at boot time to a max of n,
but allowing the remaining CPUs to be brought up later if the user
decides to do so. However, on arm64 due to various reasons, we disallowed
hotplugging CPUs beyond n, by marking them not present. Now that
we have checks in place to make sure the hotplugged CPUs have compatible
features with system and requires no new errata, relax the restriction.

Cc: Will Deacon <will.deacon@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: James Morse <james.morse@arm.com>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/kernel/smp.c |   18 +-----------------
 1 file changed, 1 insertion(+), 17 deletions(-)

diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index fef2e73..dc96475 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -689,33 +689,18 @@ void __init smp_init_cpus(void)
 void __init smp_prepare_cpus(unsigned int max_cpus)
 {
 	int err;
-	unsigned int cpu, ncores = num_possible_cpus();
+	unsigned int cpu;
 
 	init_cpu_topology();
 
 	smp_store_cpu_info(smp_processor_id());
 
 	/*
-	 * are we trying to boot more cores than exist?
-	 */
-	if (max_cpus > ncores)
-		max_cpus = ncores;
-
-	/* Don't bother if we're effectively UP */
-	if (max_cpus <= 1)
-		return;
-
-	/*
 	 * Initialise the present map (which describes the set of CPUs
 	 * actually populated at the present time) and release the
 	 * secondaries from the bootloader.
-	 *
-	 * Make sure we online@most (max_cpus - 1) additional CPUs.
 	 */
-	max_cpus--;
 	for_each_possible_cpu(cpu) {
-		if (max_cpus == 0)
-			break;
 
 		if (cpu == smp_processor_id())
 			continue;
@@ -728,7 +713,6 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
 			continue;
 
 		set_cpu_present(cpu, true);
-		max_cpus--;
 	}
 }
 
-- 
1.7.9.5
