From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Thu,  7 Apr 2016 11:07:26 +0100
Subject: [UPDATED] [PATCH 5/5] arm64: Fix behavior of maxcpus=N
In-Reply-To: <570625FE.4040001@arm.com>
References: <570625FE.4040001@arm.com>
Message-ID: <1460023646-21581-1-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

maxcpu=n sets the number of CPUs activated at boot time to a max of n,
but allowing the remaining CPUs to be brought up later if the user
decides to do so. However, on arm64 due to various reasons, we disallowed
hotplugging CPUs beyond n, by marking them not present. Now that
we have checks in place to make sure the hotplugged CPUs have compatible
features with system and requires no new errata, relax the restriction.

Cc: Will Deacon <will.deacon@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: James Morse <james.morse@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---

Changes:
  - Remove dead code (ncores) - [James Morse]

---
 arch/arm64/kernel/smp.c |   18 +-----------------
 1 file changed, 1 insertion(+), 17 deletions(-)

diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index b2d5f4e..fa9dbaa 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -647,33 +647,18 @@ void __init smp_init_cpus(void)
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
@@ -686,7 +671,6 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
 			continue;
 
 		set_cpu_present(cpu, true);
-		max_cpus--;
 	}
 }
 
-- 
1.7.9.5
