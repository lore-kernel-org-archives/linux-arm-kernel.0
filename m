From: suzuki.poulose@arm.com (Suzuki K. Poulose)
Date: Mon, 19 Oct 2015 14:00:35 +0100
Subject: [PATCHv4 12/24] arm64: Refactor check_cpu_capabilities
In-Reply-To: <1445259647-21541-1-git-send-email-suzuki.poulose@arm.com>
References: <1445259647-21541-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1445259647-21541-13-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

check_cpu_capabilities runs through a given list of caps and
checks if the system has the cap, updates the system capability
bitmap and also runs any enable() methods associated with them.
All of this is not quite obvious from the name 'check'. This
patch splits the check_cpu_capabilities into two parts :

1) update_cpu_capabilities
 => Runs through the given list and updates the system
    wide capability map.
2) enable_cpu_capabilities
 => Runs through the given list and invokes enable() (if any)
    for the caps enabled on the system.

Cc: Andre Przywara <andre.przywara@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Suggested-by: Catalin Marinas <catalin.marinsa@arm.com>
Signed-off-by: Suzuki K. Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/include/asm/cpufeature.h |    2 +-
 arch/arm64/kernel/cpu_errata.c      |    2 +-
 arch/arm64/kernel/cpufeature.c      |   14 +++++++++++---
 3 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index 2797876..b2f224b 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -137,7 +137,7 @@ static inline bool id_aa64mmfr0_mixed_endian_el0(u64 mmfr0)
 
 void __init setup_cpu_features(void);
 
-void check_cpu_capabilities(const struct arm64_cpu_capabilities *caps,
+void update_cpu_capabilities(const struct arm64_cpu_capabilities *caps,
 			    const char *info);
 void check_local_cpu_errata(void);
 void check_local_cpu_features(void);
diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index 6ffd914..09eab32 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -88,5 +88,5 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
 
 void check_local_cpu_errata(void)
 {
-	check_cpu_capabilities(arm64_errata, "enabling workaround for");
+	update_cpu_capabilities(arm64_errata, "enabling workaround for");
 }
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index a90a64d..78c4cb7a 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -629,7 +629,7 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 	{},
 };
 
-void check_cpu_capabilities(const struct arm64_cpu_capabilities *caps,
+void update_cpu_capabilities(const struct arm64_cpu_capabilities *caps,
 			    const char *info)
 {
 	int i;
@@ -642,8 +642,15 @@ void check_cpu_capabilities(const struct arm64_cpu_capabilities *caps,
 			pr_info("%s %s\n", info, caps[i].desc);
 		cpus_set_cap(caps[i].capability);
 	}
+}
+
+/*
+ * Run through the enabled capabilities and enable() it on the CPUs
+ */
+void enable_cpu_capabilities(const struct arm64_cpu_capabilities *caps)
+{
+	int i;
 
-	/* second pass allows enable() to consider interacting capabilities */
 	for (i = 0; caps[i].desc; i++) {
 		if (cpus_have_cap(caps[i].capability) && caps[i].enable)
 			caps[i].enable();
@@ -652,7 +659,8 @@ void check_cpu_capabilities(const struct arm64_cpu_capabilities *caps,
 
 void check_local_cpu_features(void)
 {
-	check_cpu_capabilities(arm64_features, "detected feature:");
+	update_cpu_capabilities(arm64_features, "detected feature:");
+	enable_cpu_capabilities(arm64_features);
 }
 
 void __init setup_cpu_features(void)
-- 
1.7.9.5
