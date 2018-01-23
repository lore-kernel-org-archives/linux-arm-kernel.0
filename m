From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Tue, 23 Jan 2018 12:28:01 +0000
Subject: [PATCH 08/16] arm64: capabilities: Group handling of features and
 errata
In-Reply-To: <20180123122809.16269-1-suzuki.poulose@arm.com>
References: <20180123122809.16269-1-suzuki.poulose@arm.com>
Message-ID: <20180123122809.16269-9-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

So far we have had separate routes for triggering errata and feature
capabilities. Also, we never allowed "features" based on local CPU
and "errata" based on System wide safe registers. This patch
groups the handling of errata and features and also allows them
to have all the possible scopes.

So, we now run through the arm64_features and arm64_errata:

 1) with SCOPE_LOCAL_CPU filter on each boot time enabeld CPUs,
    via update_cpu_local_capabilities().
 2) with SCOPE_SYSTEM filter only once after all boot time enabled
    CPUs are active.

We could ideally merge the two tables into one. But leave it as
it is for easy access to the list of particular type.

Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/kernel/cpufeature.c | 77 ++++++++++++++++++++++++------------------
 1 file changed, 44 insertions(+), 33 deletions(-)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 198c5daddd65..7ae5cf9092d0 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -504,7 +504,7 @@ static void __init init_cpu_ftr_reg(u32 sys_reg, u64 new)
 }
 
 extern const struct arm64_cpu_capabilities arm64_errata[];
-static void update_cpu_errata_workarounds(void);
+static void update_cpu_local_capabilities(void);
 
 void __init init_cpu_features(struct cpuinfo_arm64 *info)
 {
@@ -553,7 +553,7 @@ void __init init_cpu_features(struct cpuinfo_arm64 *info)
 	 * Run the errata work around checks on the boot CPU, once we have
 	 * initialised the cpu feature infrastructure.
 	 */
-	update_cpu_errata_workarounds();
+	update_cpu_local_capabilities();
 }
 
 static void update_cpu_ftr_reg(struct arm64_ftr_reg *reg, u64 new)
@@ -1179,8 +1179,8 @@ static bool __this_cpu_has_cap(const struct arm64_cpu_capabilities *cap_array,
 	return false;
 }
 
-static void update_cpu_capabilities(const struct arm64_cpu_capabilities *caps,
-				    u16 cap_type, const char *info)
+static void __update_cpu_capabilities(const struct arm64_cpu_capabilities *caps,
+				      u16 cap_type, const char *info)
 {
 	for (; caps->matches; caps++) {
 		if (!(caps->type & cap_type))
@@ -1194,6 +1194,13 @@ static void update_cpu_capabilities(const struct arm64_cpu_capabilities *caps,
 	}
 }
 
+static void update_cpu_capabilities(u16 type)
+{
+	__update_cpu_capabilities(arm64_features, type,
+				"detected feature:");
+	__update_cpu_capabilities(arm64_errata, type,
+				"enabling work around for");
+}
 
 static int __enable_cpu_capability(void *arg)
 {
@@ -1207,7 +1214,7 @@ static int __enable_cpu_capability(void *arg)
  * CPUs
  */
 static void __init
-enable_cpu_capabilities(const struct arm64_cpu_capabilities *caps, u16 caps_type)
+__enable_cpu_capabilities(const struct arm64_cpu_capabilities *caps, u16 caps_type)
 {
 	for (; caps->matches; caps++) {
 		unsigned int num = caps->capability;
@@ -1282,6 +1289,12 @@ static bool __verify_local_cpu_caps(const struct arm64_cpu_capabilities *caps_li
 	return true;
 }
 
+static bool verify_local_cpu_caps(u16 type)
+{
+	return __verify_local_cpu_caps(arm64_features, type) &&
+	       __verify_local_cpu_caps(arm64_errata, type);
+}
+
 /*
  * Check for CPU features that are used in early boot
  * based on the Boot CPU value.
@@ -1304,12 +1317,6 @@ verify_local_elf_hwcaps(const struct arm64_cpu_capabilities *caps)
 		}
 }
 
-static void verify_local_cpu_features(void)
-{
-	if (!__verify_local_cpu_caps(arm64_features, ARM64_CPUCAP_TYPE_ALL))
-		cpu_die_early();
-}
-
 static void verify_sve_features(void)
 {
 	u64 safe_zcr = read_sanitised_ftr_reg(SYS_ZCR_EL1);
@@ -1328,26 +1335,28 @@ static void verify_sve_features(void)
 }
 
 /*
- * The CPU Errata work arounds are detected and applied at boot time
- * and the related information is freed soon after. If the new CPU requires
- * an errata not detected at boot, fail this CPU.
+ * Check for all capablities within the scope of local CPU.
+ * This is run on all boot time activated CPUs.
  */
-static void verify_local_cpu_errata_workarounds(void)
+static void update_cpu_local_capabilities(void)
 {
-	if (!__verify_local_cpu_caps(arm64_errata, ARM64_CPUCAP_TYPE_ALL))
-		cpu_die_early();
+	update_cpu_capabilities(ARM64_CPUCAP_SCOPE_LOCAL_CPU);
 }
 
-static void update_cpu_errata_workarounds(void)
+/*
+ * Check for all capablities with a system wide scope.
+ * This is run only once after all the boot CPUs are
+ * brought online.
+ */
+static void update_system_capabilities(void)
 {
-	update_cpu_capabilities(arm64_errata,
-				ARM64_CPUCAP_TYPE_ALL,
-				"enabling workaround for");
+	update_cpu_capabilities(ARM64_CPUCAP_SCOPE_SYSTEM);
 }
 
-static void __init enable_errata_workarounds(void)
+static void enable_cpu_capabilities(u16 type)
 {
-	enable_cpu_capabilities(arm64_errata, ARM64_CPUCAP_TYPE_ALL);
+	__enable_cpu_capabilities(arm64_errata, type);
+	__enable_cpu_capabilities(arm64_features, type);
 }
 
 /*
@@ -1360,8 +1369,8 @@ static void __init enable_errata_workarounds(void)
  */
 static void verify_local_cpu_capabilities(void)
 {
-	verify_local_cpu_errata_workarounds();
-	verify_local_cpu_features();
+	if (!verify_local_cpu_caps(ARM64_CPUCAP_TYPE_ALL))
+		cpu_die_early();
 	verify_local_elf_hwcaps(arm64_elf_hwcaps);
 
 	if (system_supports_32bit_el0())
@@ -1389,16 +1398,20 @@ void check_local_cpu_capabilities(void)
 	 * advertised capabilities.
 	 */
 	if (!sys_caps_initialised)
-		update_cpu_errata_workarounds();
+		update_cpu_local_capabilities();
 	else
 		verify_local_cpu_capabilities();
 }
 
-static void __init setup_feature_capabilities(void)
+static void __init setup_system_capabilities(void)
 {
-	update_cpu_capabilities(arm64_features,
-				ARM64_CPUCAP_TYPE_ALL, "detected feature:");
-	enable_cpu_capabilities(arm64_features, ARM64_CPUCAP_TYPE_ALL);
+	/*
+	 * We have finalised the system wide safe feature registers,
+	 * finalise the capabilities that depend on it.
+	 */
+	update_system_capabilities();
+	/* Enable all the available capabilities */
+	enable_cpu_capabilities(ARM64_CPUCAP_TYPE_ALL);
 }
 
 DEFINE_STATIC_KEY_FALSE(arm64_const_caps_ready);
@@ -1422,9 +1435,7 @@ void __init setup_cpu_features(void)
 	u32 cwg;
 	int cls;
 
-	/* Set the CPU feature capabilies */
-	setup_feature_capabilities();
-	enable_errata_workarounds();
+	setup_system_capabilities();
 	mark_const_caps_ready();
 	setup_elf_hwcaps(arm64_elf_hwcaps);
 
-- 
2.13.6
