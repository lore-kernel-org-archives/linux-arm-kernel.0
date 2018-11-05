From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Mon,  5 Nov 2018 11:55:14 +0000
Subject: [PATCH 4/7] arm64: capabilities: Speed up capability lookup
In-Reply-To: <1541418917-14219-1-git-send-email-suzuki.poulose@arm.com>
References: <1541418917-14219-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1541418917-14219-5-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We maintain two separate tables of capabilities, errata and features,
which decide the system capabilities. We iterate over each of these
tables for various operations (e.g, detection, verification etc.).
We do not have a way to map a system "capability" to its entry,
(i.e, cap -> struct arm64_cpu_capabilities) which is needed for
this_cpu_has_cap(). So we iterate over the table one by one to
find the entry and then do the operation. Also, this prevents
us from optimizing the way we "enable" the capabilities on the
CPUs, where we now issue a stop_machine() for each available
capability.

One solution is to merge the two tables into a single table,
sorted by the capability. But this is has the following
disadvantages:
  - We loose the "classification" of an errata vs. feature
  - It is quite easy to make a mistake when adding an entry,
    unless we sort the table at runtime.

So we maintain a list of pointers to the capability entry, sorted
by the "cap number" in a separate array, initialized at boot time.
The only restriction is that we can have one "entry" per capability.
While at it, remove the duplicate declaration of arm64_errata table.

Cc: Vladimir Murzin <vladimir.murzin@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/kernel/cpufeature.c | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index af50064..7e9ebbe 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -52,6 +52,7 @@ unsigned int compat_elf_hwcap2 __read_mostly;
 
 DECLARE_BITMAP(cpu_hwcaps, ARM64_NCAPS);
 EXPORT_SYMBOL(cpu_hwcaps);
+static struct arm64_cpu_capabilities const __ro_after_init *cpu_hwcaps_ptrs[ARM64_NCAPS];
 
 /*
  * Flag to indicate if we have computed the system wide
@@ -518,6 +519,25 @@ static void __init init_cpu_ftr_reg(u32 sys_reg, u64 new)
 }
 
 extern const struct arm64_cpu_capabilities arm64_errata[];
+static const struct arm64_cpu_capabilities arm64_features[];
+
+static void __init
+init_cpu_hwcaps_indirect_list_from_array(const struct arm64_cpu_capabilities *caps)
+{
+	for (; caps->matches; caps++) {
+		if (WARN_ON(caps->capability > ARM64_NCAPS ||
+			    cpu_hwcaps_ptrs[caps->capability]))
+			continue;
+		cpu_hwcaps_ptrs[caps->capability] = caps;
+	}
+}
+
+static void __init init_cpu_hwcaps_indirect_list(void)
+{
+	init_cpu_hwcaps_indirect_list_from_array(arm64_features);
+	init_cpu_hwcaps_indirect_list_from_array(arm64_errata);
+}
+
 static void __init setup_boot_cpu_capabilities(void);
 
 void __init init_cpu_features(struct cpuinfo_arm64 *info)
@@ -564,6 +584,12 @@ void __init init_cpu_features(struct cpuinfo_arm64 *info)
 	}
 
 	/*
+	 * Initialize the indirect array of CPU hwcaps capabilities pointers
+	 * before we handle the boot CPU below.
+	 */
+	init_cpu_hwcaps_indirect_list();
+
+	/*
 	 * Detect and enable early CPU capabilities based on the boot CPU,
 	 * after we have initialised the CPU feature infrastructure.
 	 */
@@ -1750,8 +1776,6 @@ static void __init mark_const_caps_ready(void)
 	static_branch_enable(&arm64_const_caps_ready);
 }
 
-extern const struct arm64_cpu_capabilities arm64_errata[];
-
 bool this_cpu_has_cap(unsigned int cap)
 {
 	return (__this_cpu_has_cap(arm64_features, cap) ||
-- 
2.7.4
