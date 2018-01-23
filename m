From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Tue, 23 Jan 2018 12:28:00 +0000
Subject: [PATCH 07/16] arm64: capabilities: Filter the entries based on a
 given type
In-Reply-To: <20180123122809.16269-1-suzuki.poulose@arm.com>
References: <20180123122809.16269-1-suzuki.poulose@arm.com>
Message-ID: <20180123122809.16269-8-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

While processing the list of capabilities, it is useful to
filter out some of the entries based on the given type to
allow better control. This can be used later for handling
LOCAL vs SYSTEM wide capabilities and more.

Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/include/asm/cpufeature.h |  5 +++++
 arch/arm64/kernel/cpufeature.c      | 30 ++++++++++++++++++++----------
 2 files changed, 25 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index 27d037bb0451..a621d2184227 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -99,6 +99,11 @@ extern struct arm64_ftr_reg arm64_ftr_reg_ctrel0;
 /* Is it safe for a late CPU to miss this capability when system has it */
 #define ARM64_CPUCAP_LATE_CPU_SAFE_TO_MISS	BIT(3)
 
+#define ARM64_CPUCAP_TYPE_ALL			 \
+	(ARM64_CPUCAP_SCOPE_LOCAL_CPU		|\
+	 ARM64_CPUCAP_SCOPE_SYSTEM		|\
+	 ARM64_CPUCAP_LATE_CPU_SAFE_TO_HAVE	|\
+	 ARM64_CPUCAP_LATE_CPU_SAFE_TO_MISS)
 /*
  * CPU errata detected at boot time based on feature of one or more CPUs.
  * It is not safe for a late CPU to have this feature when the system doesn't
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 79737034a628..198c5daddd65 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1180,9 +1180,11 @@ static bool __this_cpu_has_cap(const struct arm64_cpu_capabilities *cap_array,
 }
 
 static void update_cpu_capabilities(const struct arm64_cpu_capabilities *caps,
-			    const char *info)
+				    u16 cap_type, const char *info)
 {
 	for (; caps->matches; caps++) {
+		if (!(caps->type & cap_type))
+			continue;
 		if (!caps->matches(caps, cpucap_default_scope(caps)))
 			continue;
 
@@ -1204,12 +1206,13 @@ static int __enable_cpu_capability(void *arg)
  * Run through the enabled capabilities and enable() it on all active
  * CPUs
  */
-static void __init enable_cpu_capabilities(const struct arm64_cpu_capabilities *caps)
+static void __init
+enable_cpu_capabilities(const struct arm64_cpu_capabilities *caps, u16 caps_type)
 {
 	for (; caps->matches; caps++) {
 		unsigned int num = caps->capability;
 
-		if (!cpus_have_cap(num))
+		if (!(caps->type & caps_type) || !cpus_have_cap(num))
 			continue;
 
 		/* Ensure cpus_have_const_cap(num) works */
@@ -1231,12 +1234,16 @@ static void __init enable_cpu_capabilities(const struct arm64_cpu_capabilities *
  * Run through the list of capabilities to check for conflicts.
  * Returns "false" on conflicts.
  */
-static bool __verify_local_cpu_caps(const struct arm64_cpu_capabilities *caps_list)
+static bool __verify_local_cpu_caps(const struct arm64_cpu_capabilities *caps_list,
+				    u16 caps_type)
 {
 	bool cpu_has_cap, system_has_cap;
 	const struct arm64_cpu_capabilities *caps = caps_list;
 
 	for (; caps->matches; caps++) {
+		if (!(caps->type & caps_type))
+			continue;
+
 		cpu_has_cap = __this_cpu_has_cap(caps_list, caps->capability);
 		system_has_cap =  cpus_have_cap(caps->capability);
 
@@ -1299,7 +1306,7 @@ verify_local_elf_hwcaps(const struct arm64_cpu_capabilities *caps)
 
 static void verify_local_cpu_features(void)
 {
-	if (!__verify_local_cpu_caps(arm64_features))
+	if (!__verify_local_cpu_caps(arm64_features, ARM64_CPUCAP_TYPE_ALL))
 		cpu_die_early();
 }
 
@@ -1327,18 +1334,20 @@ static void verify_sve_features(void)
  */
 static void verify_local_cpu_errata_workarounds(void)
 {
-	if (__verify_local_cpu_caps(arm64_errata))
+	if (!__verify_local_cpu_caps(arm64_errata, ARM64_CPUCAP_TYPE_ALL))
 		cpu_die_early();
 }
 
 static void update_cpu_errata_workarounds(void)
 {
-	update_cpu_capabilities(arm64_errata, "enabling workaround for");
+	update_cpu_capabilities(arm64_errata,
+				ARM64_CPUCAP_TYPE_ALL,
+				"enabling workaround for");
 }
 
 static void __init enable_errata_workarounds(void)
 {
-	enable_cpu_capabilities(arm64_errata);
+	enable_cpu_capabilities(arm64_errata, ARM64_CPUCAP_TYPE_ALL);
 }
 
 /*
@@ -1387,8 +1396,9 @@ void check_local_cpu_capabilities(void)
 
 static void __init setup_feature_capabilities(void)
 {
-	update_cpu_capabilities(arm64_features, "detected feature:");
-	enable_cpu_capabilities(arm64_features);
+	update_cpu_capabilities(arm64_features,
+				ARM64_CPUCAP_TYPE_ALL, "detected feature:");
+	enable_cpu_capabilities(arm64_features, ARM64_CPUCAP_TYPE_ALL);
 }
 
 DEFINE_STATIC_KEY_FALSE(arm64_const_caps_ready);
-- 
2.13.6
