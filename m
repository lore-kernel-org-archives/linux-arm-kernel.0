From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Thu, 31 Mar 2016 18:27:30 +0100
Subject: [PATCH v3 2/7] arm64: HWCAP: Split COMPAT HWCAP table entries
In-Reply-To: <1459445255-15653-1-git-send-email-suzuki.poulose@arm.com>
References: <1459445255-15653-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1459445255-15653-3-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to handle systems which do not support 32bit at EL0,
split the COMPAT HWCAP entries into a separate table which can
be processed, only if the support is available.

Tested-by: Yury Norov <ynorov@caviumnetworks.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/kernel/cpufeature.c |  104 +++++++++++++++++++++-------------------
 1 file changed, 56 insertions(+), 48 deletions(-)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 23b0f15..a067c31 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -751,6 +751,10 @@ static const struct arm64_cpu_capabilities arm64_elf_hwcaps[] = {
 	HWCAP_CAP(SYS_ID_AA64PFR0_EL1, ID_AA64PFR0_FP_SHIFT, FTR_SIGNED, 1, CAP_HWCAP, HWCAP_FPHP),
 	HWCAP_CAP(SYS_ID_AA64PFR0_EL1, ID_AA64PFR0_ASIMD_SHIFT, FTR_SIGNED, 0, CAP_HWCAP, HWCAP_ASIMD),
 	HWCAP_CAP(SYS_ID_AA64PFR0_EL1, ID_AA64PFR0_ASIMD_SHIFT, FTR_SIGNED, 1, CAP_HWCAP, HWCAP_ASIMDHP),
+	{},
+};
+
+static const struct arm64_cpu_capabilities compat_elf_hwcaps[] = {
 #ifdef CONFIG_COMPAT
 	HWCAP_CAP(SYS_ID_ISAR5_EL1, ID_ISAR5_AES_SHIFT, FTR_UNSIGNED, 2, CAP_COMPAT_HWCAP2, COMPAT_HWCAP2_PMULL),
 	HWCAP_CAP(SYS_ID_ISAR5_EL1, ID_ISAR5_AES_SHIFT, FTR_UNSIGNED, 1, CAP_COMPAT_HWCAP2, COMPAT_HWCAP2_AES),
@@ -806,28 +810,23 @@ static bool cpus_have_elf_hwcap(const struct arm64_cpu_capabilities *cap)
 	return rc;
 }
 
-static void __init setup_elf_hwcaps(void)
+static void __init setup_elf_hwcaps(const struct arm64_cpu_capabilities *hwcaps)
 {
-	int i;
-	const struct arm64_cpu_capabilities *hwcaps = arm64_elf_hwcaps;
-
-	for (i = 0; hwcaps[i].matches; i++)
-		if (hwcaps[i].matches(&hwcaps[i]))
-			cap_set_elf_hwcap(&hwcaps[i]);
+	for (; hwcaps->matches; hwcaps++)
+		if (hwcaps->matches(hwcaps))
+			cap_set_elf_hwcap(hwcaps);
 }
 
 void update_cpu_capabilities(const struct arm64_cpu_capabilities *caps,
 			    const char *info)
 {
-	int i;
-
-	for (i = 0; caps[i].matches; i++) {
-		if (!caps[i].matches(&caps[i]))
+	for (; caps->matches; caps++) {
+		if (!caps->matches(caps))
 			continue;
 
-		if (!cpus_have_cap(caps[i].capability) && caps[i].desc)
-			pr_info("%s %s\n", info, caps[i].desc);
-		cpus_set_cap(caps[i].capability);
+		if (!cpus_have_cap(caps->capability) && caps->desc)
+			pr_info("%s %s\n", info, caps->desc);
+		cpus_set_cap(caps->capability);
 	}
 }
 
@@ -838,11 +837,9 @@ void update_cpu_capabilities(const struct arm64_cpu_capabilities *caps,
 static void __init
 enable_cpu_capabilities(const struct arm64_cpu_capabilities *caps)
 {
-	int i;
-
-	for (i = 0; caps[i].matches; i++)
-		if (caps[i].enable && cpus_have_cap(caps[i].capability))
-			on_each_cpu(caps[i].enable, NULL, true);
+	for (; caps->matches; caps++)
+		if (caps->enable && cpus_have_cap(caps->capability))
+			on_each_cpu(caps->enable, NULL, true);
 }
 
 /*
@@ -911,6 +908,41 @@ static void check_early_cpu_features(void)
 	verify_cpu_asid_bits();
 }
 
+static void
+verify_local_elf_hwcaps(const struct arm64_cpu_capabilities *caps)
+{
+
+	for (; caps->matches; caps++) {
+		if (!cpus_have_elf_hwcap(caps))
+			continue;
+		if (!feature_matches(__raw_read_system_reg(caps->sys_reg), caps)) {
+			pr_crit("CPU%d: missing HWCAP: %s\n",
+					smp_processor_id(), caps->desc);
+			cpu_die_early();
+		}
+	}
+}
+
+static void
+verify_local_cpu_features(const struct arm64_cpu_capabilities *caps)
+{
+	for (; caps->matches; caps++) {
+		if (!cpus_have_cap(caps->capability) || !caps->sys_reg)
+			continue;
+		/*
+		 * If the new CPU misses an advertised feature, we cannot proceed
+		 * further, park the cpu.
+		 */
+		if (!feature_matches(__raw_read_system_reg(caps->sys_reg), caps)) {
+			pr_crit("CPU%d: missing feature: %s\n",
+					smp_processor_id(), caps->desc);
+			cpu_die_early();
+		}
+		if (caps->enable)
+			caps->enable(NULL);
+	}
+}
+
 /*
  * Run through the enabled system capabilities and enable() it on this CPU.
  * The capabilities were decided based on the available CPUs at the boot time.
@@ -921,8 +953,6 @@ static void check_early_cpu_features(void)
  */
 void verify_local_cpu_capabilities(void)
 {
-	int i;
-	const struct arm64_cpu_capabilities *caps;
 
 	check_early_cpu_features();
 
@@ -933,32 +963,9 @@ void verify_local_cpu_capabilities(void)
 	if (!sys_caps_initialised)
 		return;
 
-	caps = arm64_features;
-	for (i = 0; caps[i].matches; i++) {
-		if (!cpus_have_cap(caps[i].capability) || !caps[i].sys_reg)
-			continue;
-		/*
-		 * If the new CPU misses an advertised feature, we cannot proceed
-		 * further, park the cpu.
-		 */
-		if (!feature_matches(__raw_read_system_reg(caps[i].sys_reg), &caps[i])) {
-			pr_crit("CPU%d: missing feature: %s\n",
-					smp_processor_id(), caps[i].desc);
-			cpu_die_early();
-		}
-		if (caps[i].enable)
-			caps[i].enable(NULL);
-	}
-
-	for (i = 0, caps = arm64_elf_hwcaps; caps[i].matches; i++) {
-		if (!cpus_have_elf_hwcap(&caps[i]))
-			continue;
-		if (!feature_matches(__raw_read_system_reg(caps[i].sys_reg), &caps[i])) {
-			pr_crit("CPU%d: missing HWCAP: %s\n",
-					smp_processor_id(), caps[i].desc);
-			cpu_die_early();
-		}
-	}
+	verify_local_cpu_features(arm64_features);
+	verify_local_elf_hwcaps(arm64_elf_hwcaps);
+	verify_local_elf_hwcaps(compat_elf_hwcaps);
 }
 
 static void __init setup_feature_capabilities(void)
@@ -974,7 +981,8 @@ void __init setup_cpu_features(void)
 
 	/* Set the CPU feature capabilies */
 	setup_feature_capabilities();
-	setup_elf_hwcaps();
+	setup_elf_hwcaps(arm64_elf_hwcaps);
+	setup_elf_hwcaps(compat_elf_hwcaps);
 
 	/* Advertise that we have computed the system capabilities */
 	set_sys_caps_initialised();
-- 
1.7.9.5
