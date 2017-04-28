From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 28 Apr 2017 12:01:06 +0100
Subject: [PATCHv3 2/2] arm64: cpufeature: use static_branch_enable_cpuslocked()
In-Reply-To: <1493377266-2205-1-git-send-email-mark.rutland@arm.com>
References: <1493377266-2205-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1493377266-2205-3-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Recently, the hotplug locking was conveted to use a percpu rwsem. Unlike
the existing {get,put}_online_cpus() logic, this can't nest.
Unfortunately, in arm64's secondary boot path we can end up nesting via
static_branch_enable() in cpus_set_cap() when we detect an erratum.

This leads to a stream of messages as below, where the secondary
attempts to schedule before it has been fully onlined. As the CPU
orchestrating the onlining holds the rswem, this hangs the system.

[    0.250334] BUG: scheduling while atomic: swapper/1/0/0x00000002
[    0.250337] Modules linked in:
[    0.250346] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 4.11.0-rc7-next-20170424 #2
[    0.250349] Hardware name: ARM Juno development board (r1) (DT)
[    0.250353] Call trace:
[    0.250365] [<ffff000008088510>] dump_backtrace+0x0/0x238
[    0.250371] [<ffff00000808880c>] show_stack+0x14/0x20
[    0.250377] [<ffff00000839d854>] dump_stack+0x9c/0xc0
[    0.250384] [<ffff0000080e3540>] __schedule_bug+0x50/0x70
[    0.250391] [<ffff000008932ecc>] __schedule+0x52c/0x5a8
[    0.250395] [<ffff000008932f80>] schedule+0x38/0xa0
[    0.250400] [<ffff000008935e8c>] rwsem_down_read_failed+0xc4/0x108
[    0.250407] [<ffff0000080fe8e0>] __percpu_down_read+0x100/0x118
[    0.250414] [<ffff0000080c0b60>] get_online_cpus+0x70/0x78
[    0.250420] [<ffff0000081749e8>] static_key_enable+0x28/0x48
[    0.250425] [<ffff00000808de90>] update_cpu_capabilities+0x78/0xf8
[    0.250430] [<ffff00000808d14c>] update_cpu_errata_workarounds+0x1c/0x28
[    0.250435] [<ffff00000808e004>] check_local_cpu_capabilities+0xf4/0x128
[    0.250440] [<ffff00000808e894>] secondary_start_kernel+0x8c/0x118
[    0.250444] [<000000008093d1b4>] 0x8093d1b4

We call cpus_set_cap() from update_cpu_capabilities(), which is called
from the secondary boot path (where the CPU orchestrating the onlining
holds the hotplug rwsem), and in the primary boot path, where this is
not held.

This patch makes cpus_set_cap() use static_branch_enable_cpuslocked(),
and updates all the callers of update_cpu_capabilities() consistent with
the change.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Reported-by: Catalin Marinas <catalin.marinas@arm.com>
Suggested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
[Mark: minor fixups]
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
---
 arch/arm64/include/asm/cpufeature.h | 3 ++-
 arch/arm64/kernel/cpu_errata.c      | 9 ++++++++-
 arch/arm64/kernel/cpufeature.c      | 5 ++++-
 3 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index f31c48d..a8d1b5b 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -145,7 +145,7 @@ static inline void cpus_set_cap(unsigned int num)
 			num, ARM64_NCAPS);
 	} else {
 		__set_bit(num, cpu_hwcaps);
-		static_branch_enable(&cpu_hwcap_keys[num]);
+		static_branch_enable_cpuslocked(&cpu_hwcap_keys[num]);
 	}
 }
 
@@ -223,6 +223,7 @@ void update_cpu_capabilities(const struct arm64_cpu_capabilities *caps,
 void check_local_cpu_capabilities(void);
 
 void update_cpu_errata_workarounds(void);
+void update_cpu_errata_workarounds_cpuslocked(void);
 void __init enable_errata_workarounds(void);
 void verify_local_cpu_errata_workarounds(void);
 
diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index f6cc67e..e650cf8 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -175,11 +175,18 @@ void verify_local_cpu_errata_workarounds(void)
 		}
 }
 
-void update_cpu_errata_workarounds(void)
+void update_cpu_errata_workarounds_cpuslocked(void)
 {
 	update_cpu_capabilities(arm64_errata, "enabling workaround for");
 }
 
+void update_cpu_errata_workarounds(void)
+{
+	get_online_cpus();
+	update_cpu_errata_workarounds_cpuslocked();
+	put_online_cpus();
+}
+
 void __init enable_errata_workarounds(void)
 {
 	enable_cpu_capabilities(arm64_errata);
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index abda8e8..113c06d 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -956,6 +956,7 @@ static void __init setup_elf_hwcaps(const struct arm64_cpu_capabilities *hwcaps)
 			cap_set_elf_hwcap(hwcaps);
 }
 
+/* Should be called with CPU hotplug lock held */
 void update_cpu_capabilities(const struct arm64_cpu_capabilities *caps,
 			    const char *info)
 {
@@ -1075,14 +1076,16 @@ void check_local_cpu_capabilities(void)
 	 * advertised capabilities.
 	 */
 	if (!sys_caps_initialised)
-		update_cpu_errata_workarounds();
+		update_cpu_errata_workarounds_cpuslocked();
 	else
 		verify_local_cpu_capabilities();
 }
 
 static void __init setup_feature_capabilities(void)
 {
+	get_online_cpus();
 	update_cpu_capabilities(arm64_features, "detected feature:");
+	put_online_cpus();
 	enable_cpu_capabilities(arm64_features);
 }
 
-- 
1.9.1
