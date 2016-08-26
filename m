From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Fri, 26 Aug 2016 10:23:11 +0100
Subject: [PATCH v2 2/9] arm64: Use consistent naming for errata handling
In-Reply-To: <1472203398-8751-1-git-send-email-suzuki.poulose@arm.com>
References: <1472203398-8751-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1472203398-8751-3-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a cosmetic change to rename the functions dealing with
the errata work arounds to be more consistent with their naming.

1) check_local_cpu_errata() => update_cpu_errata_workarounds()
check_local_cpu_errata() actually updates the system's errata work
arounds. So rename it to reflect the same.

2) verify_local_cpu_errata() => verify_local_cpu_errata_workarounds()
Use errata_workarounds instead of _errata.

Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/include/asm/cpufeature.h | 4 ++--
 arch/arm64/kernel/cpu_errata.c      | 4 ++--
 arch/arm64/kernel/cpufeature.c      | 2 +-
 arch/arm64/kernel/cpuinfo.c         | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index f6f5e49..aadd946 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -193,10 +193,10 @@ void __init setup_cpu_features(void);
 void update_cpu_capabilities(const struct arm64_cpu_capabilities *caps,
 			    const char *info);
 void enable_cpu_capabilities(const struct arm64_cpu_capabilities *caps);
-void check_local_cpu_errata(void);
+void update_cpu_errata_workarounds(void);
 void __init enable_errata_workarounds(void);
 
-void verify_local_cpu_errata(void);
+void verify_local_cpu_errata_workarounds(void);
 void verify_local_cpu_capabilities(void);
 
 u64 read_system_reg(u32 id);
diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index 82b0fc2..5836b3d 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -116,7 +116,7 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
  * and the related information is freed soon after. If the new CPU requires
  * an errata not detected at boot, fail this CPU.
  */
-void verify_local_cpu_errata(void)
+void verify_local_cpu_errata_workarounds(void)
 {
 	const struct arm64_cpu_capabilities *caps = arm64_errata;
 
@@ -131,7 +131,7 @@ void verify_local_cpu_errata(void)
 		}
 }
 
-void check_local_cpu_errata(void)
+void update_cpu_errata_workarounds(void)
 {
 	update_cpu_capabilities(arm64_errata, "enabling workaround for");
 }
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 43f73e0..a591c35 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1017,7 +1017,7 @@ void verify_local_cpu_capabilities(void)
 	if (!sys_caps_initialised)
 		return;
 
-	verify_local_cpu_errata();
+	verify_local_cpu_errata_workarounds();
 	verify_local_cpu_features(arm64_features);
 	verify_local_elf_hwcaps(arm64_elf_hwcaps);
 	if (system_supports_32bit_el0())
diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
index ed1b84f..4fa7b73 100644
--- a/arch/arm64/kernel/cpuinfo.c
+++ b/arch/arm64/kernel/cpuinfo.c
@@ -364,7 +364,7 @@ static void __cpuinfo_store_cpu(struct cpuinfo_arm64 *info)
 
 	cpuinfo_detect_icache_policy(info);
 
-	check_local_cpu_errata();
+	update_cpu_errata_workarounds();
 }
 
 void cpuinfo_store_cpu(void)
-- 
2.7.4
