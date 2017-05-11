From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 11 May 2017 14:12:11 +0100
Subject: [PATCH] arm64/cpufeature: don't use mutex in bringup path
Message-ID: <1494508331-31644-1-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, cpus_set_cap() calls static_branch_enable_cpuslocked(), which
must take the jump_label mutex.

We call cpus_set_cap() in the secondary bringup path, from the idle
thread where interrupts are disabled. Taking a mutex in this path "is a
NONO" regardless of whether it's contended, and something we must avoid.
Additionally, the secondary CPU doesn't hold the percpu rwsem (as this
is held by the primary CPU), so this triggers a lockdep splat.

This patch fixes both issues by moving the static_key poking from
cpus_set_cap() into enable_cpu_capabilities(). This means that there is
a period between detecting an erratum and cpus_have_const_cap(erratum)
being true, but largely this is fine. Features are only enabled later
regardless, and most errata workarounds are best-effort.

This rework means that we can remove the *_cpuslocked() helpers added in
commit d54bb72551b999dd ("arm64/cpufeature: Use
static_branch_enable_cpuslocked()").

Fixes: efd9e03facd075f5 ("arm64: Use static keys for CPU features")
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Marc Zyniger <marc.zyngier@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Sebastian Sewior <bigeasy@linutronix.de>
Cc: Suzuki Poulose <suzuki.poulose@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/cpufeature.h |  3 +--
 arch/arm64/kernel/cpu_errata.c      |  9 +--------
 arch/arm64/kernel/cpufeature.c      | 16 +++++++++++++---
 3 files changed, 15 insertions(+), 13 deletions(-)

I'm not sure what to do about ARM64_WORKAROUND_CAVIUM_23154.

This patch will defer enabling the workaround until all CPUs are up, and I
can't see a good way of having the workaround on by default, then subsequently
disabled if no CPUs are affected.

Thanks,
Mark

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index 8a7ff73..5370626 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -145,7 +145,6 @@ static inline void cpus_set_cap(unsigned int num)
 			num, ARM64_NCAPS);
 	} else {
 		__set_bit(num, cpu_hwcaps);
-		static_branch_enable_cpuslocked(&cpu_hwcap_keys[num]);
 	}
 }
 
@@ -223,7 +222,7 @@ void update_cpu_capabilities(const struct arm64_cpu_capabilities *caps,
 void check_local_cpu_capabilities(void);
 
 void update_cpu_errata_workarounds(void);
-void update_cpu_errata_workarounds_cpuslocked(void);
+void update_cpu_errata_workarounds(void);
 void __init enable_errata_workarounds(void);
 void verify_local_cpu_errata_workarounds(void);
 
diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index 57d60fa..2ed2a76 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -190,16 +190,9 @@ void verify_local_cpu_errata_workarounds(void)
 		}
 }
 
-void update_cpu_errata_workarounds_cpuslocked(void)
-{
-	update_cpu_capabilities(arm64_errata, "enabling workaround for");
-}
-
 void update_cpu_errata_workarounds(void)
 {
-	get_online_cpus();
-	update_cpu_errata_workarounds_cpuslocked();
-	put_online_cpus();
+	update_cpu_capabilities(arm64_errata, "enabling workaround for");
 }
 
 void __init enable_errata_workarounds(void)
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 803afae..68ed74d 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -986,8 +986,16 @@ void update_cpu_capabilities(const struct arm64_cpu_capabilities *caps,
  */
 void __init enable_cpu_capabilities(const struct arm64_cpu_capabilities *caps)
 {
-	for (; caps->matches; caps++)
-		if (caps->enable && cpus_have_cap(caps->capability))
+	for (; caps->matches; caps++) {
+		unsigned int num = caps->capability;
+
+		if (!cpus_have_cap(num))
+			continue;
+
+		/* Ensure cpus_have_const_cap(num) works */
+		static_branch_enable(&cpu_hwcap_keys[num]);
+
+		if (caps->enable) {
 			/*
 			 * Use stop_machine() as it schedules the work allowing
 			 * us to modify PSTATE, instead of on_each_cpu() which
@@ -995,6 +1003,8 @@ void __init enable_cpu_capabilities(const struct arm64_cpu_capabilities *caps)
 			 * we return.
 			 */
 			stop_machine(caps->enable, NULL, cpu_online_mask);
+		}
+	}
 }
 
 /*
@@ -1086,7 +1096,7 @@ void check_local_cpu_capabilities(void)
 	 * advertised capabilities.
 	 */
 	if (!sys_caps_initialised)
-		update_cpu_errata_workarounds_cpuslocked();
+		update_cpu_errata_workarounds();
 	else
 		verify_local_cpu_capabilities();
 }
-- 
1.9.1
