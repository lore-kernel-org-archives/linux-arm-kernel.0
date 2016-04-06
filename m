From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Wed,  6 Apr 2016 12:24:14 +0100
Subject: [PATCH 5/5] arm64: Fix behavior of maxcpus=N
In-Reply-To: <1459941854-5190-1-git-send-email-suzuki.poulose@arm.com>
References: <1459941854-5190-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1459941854-5190-6-git-send-email-suzuki.poulose@arm.com>
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
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/kernel/smp.c |   10 ----------
 1 file changed, 10 deletions(-)

diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index b2d5f4e..0988ccc 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -659,21 +659,12 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
 	if (max_cpus > ncores)
 		max_cpus = ncores;
 
-	/* Don't bother if we're effectively UP */
-	if (max_cpus <= 1)
-		return;
-
 	/*
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
@@ -686,7 +677,6 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
 			continue;
 
 		set_cpu_present(cpu, true);
-		max_cpus--;
 	}
 }
 
-- 
1.7.9.5
