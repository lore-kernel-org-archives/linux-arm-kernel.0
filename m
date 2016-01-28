From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Thu, 28 Jan 2016 11:32:13 +0000
Subject: [PATCH 2/6] arm64: HWCAP: Split COMPAT HWCAP table entries
In-Reply-To: <1453980737-6126-1-git-send-email-suzuki.poulose@arm.com>
References: <1453980737-6126-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1453980737-6126-3-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to handle systems which do not support 32bit at EL0,
split the COMPAT HWCAP entries into a separate table which can
be processed, only if the support is available.

Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/kernel/cpufeature.c |   78 ++++++++++++++++++++++++----------------
 1 file changed, 47 insertions(+), 31 deletions(-)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index a3c254b..b88cbef 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -691,6 +691,10 @@ static const struct arm64_cpu_capabilities arm64_elf_hwcaps[] = {
 	HWCAP_CAP(SYS_ID_AA64ISAR0_EL1, ID_AA64ISAR0_ATOMICS_SHIFT, FTR_UNSIGNED, 2, CAP_HWCAP, HWCAP_ATOMICS),
 	HWCAP_CAP(SYS_ID_AA64PFR0_EL1, ID_AA64PFR0_FP_SHIFT, FTR_SIGNED, 0, CAP_HWCAP, HWCAP_FP),
 	HWCAP_CAP(SYS_ID_AA64PFR0_EL1, ID_AA64PFR0_ASIMD_SHIFT, FTR_SIGNED, 0, CAP_HWCAP, HWCAP_ASIMD),
+	{},
+};
+
+static const struct arm64_cpu_capabilities compat_elf_hwcaps[] = {
 #ifdef CONFIG_COMPAT
 	HWCAP_CAP(SYS_ID_ISAR5_EL1, ID_ISAR5_AES_SHIFT, FTR_UNSIGNED, 2, CAP_COMPAT_HWCAP2, COMPAT_HWCAP2_PMULL),
 	HWCAP_CAP(SYS_ID_ISAR5_EL1, ID_ISAR5_AES_SHIFT, FTR_UNSIGNED, 1, CAP_COMPAT_HWCAP2, COMPAT_HWCAP2_AES),
@@ -746,10 +750,9 @@ static bool cpus_have_elf_hwcap(const struct arm64_cpu_capabilities *cap)
 	return rc;
 }
 
-static void __init setup_elf_hwcaps(void)
+static void __init setup_elf_hwcaps(const struct arm64_cpu_capabilities *hwcaps)
 {
 	int i;
-	const struct arm64_cpu_capabilities *hwcaps = arm64_elf_hwcaps;
 
 	for (i = 0; hwcaps[i].desc; i++)
 		if (hwcaps[i].matches(&hwcaps[i]))
@@ -850,29 +853,26 @@ static void check_early_cpu_features(void)
 	verify_cpu_asid_bits();
 }
 
-/*
- * Run through the enabled system capabilities and enable() it on this CPU.
- * The capabilities were decided based on the available CPUs at the boot time.
- * Any new CPU should match the system wide status of the capability. If the
- * new CPU doesn't have a capability which the system now has enabled, we
- * cannot do anything to fix it up and could cause unexpected failures. So
- * we park the CPU.
- */
-void verify_local_cpu_capabilities(void)
+static void
+verify_local_elf_hwcaps(const struct arm64_cpu_capabilities *caps)
 {
 	int i;
-	const struct arm64_cpu_capabilities *caps;
 
-	check_early_cpu_features();
-
-	/*
-	 * If we haven't computed the system capabilities, there is nothing
-	 * to verify.
-	 */
-	if (!sys_caps_initialised)
-		return;
+	for (i = 0; caps[i].desc; i++) {
+		if (!cpus_have_elf_hwcap(&caps[i]))
+			continue;
+		if (!feature_matches(__raw_read_system_reg(caps[i].sys_reg), &caps[i])) {
+			pr_crit("CPU%d: missing HWCAP: %s\n",
+					smp_processor_id(), caps[i].desc);
+			cpu_die_early();
+		}
+	}
+}
 
-	caps = arm64_features;
+static void
+verify_local_cpu_features(const struct arm64_cpu_capabilities *caps)
+{
+	int i;
 	for (i = 0; caps[i].desc; i++) {
 		if (!cpus_have_cap(caps[i].capability) || !caps[i].sys_reg)
 			continue;
@@ -888,16 +888,31 @@ void verify_local_cpu_capabilities(void)
 		if (caps[i].enable)
 			caps[i].enable(NULL);
 	}
+}
 
-	for (i = 0, caps = arm64_elf_hwcaps; caps[i].desc; i++) {
-		if (!cpus_have_elf_hwcap(&caps[i]))
-			continue;
-		if (!feature_matches(__raw_read_system_reg(caps[i].sys_reg), &caps[i])) {
-			pr_crit("CPU%d: missing HWCAP: %s\n",
-					smp_processor_id(), caps[i].desc);
-			cpu_die_early();
-		}
-	}
+/*
+ * Run through the enabled system capabilities and enable() it on this CPU.
+ * The capabilities were decided based on the available CPUs at the boot time.
+ * Any new CPU should match the system wide status of the capability. If the
+ * new CPU doesn't have a capability which the system now has enabled, we
+ * cannot do anything to fix it up and could cause unexpected failures. So
+ * we park the CPU.
+ */
+void verify_local_cpu_capabilities(void)
+{
+
+	check_early_cpu_features();
+
+	/*
+	 * If we haven't computed the system capabilities, there is nothing
+	 * to verify.
+	 */
+	if (!sys_caps_initialised)
+		return;
+
+	verify_local_cpu_features(arm64_features);
+	verify_local_elf_hwcaps(arm64_elf_hwcaps);
+	verify_local_elf_hwcaps(compat_elf_hwcaps);
 }
 
 static void __init setup_feature_capabilities(void)
@@ -913,7 +928,8 @@ void __init setup_cpu_features(void)
 
 	/* Set the CPU feature capabilies */
 	setup_feature_capabilities();
-	setup_elf_hwcaps();
+	setup_elf_hwcaps(arm64_elf_hwcaps);
+	setup_elf_hwcaps(compat_elf_hwcaps);
 
 	/* Advertise that we have computed the system capabilities */
 	set_sys_caps_initialised();
-- 
1.7.9.5
