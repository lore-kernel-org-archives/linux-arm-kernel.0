From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Fri,  8 Jul 2016 12:37:11 +0100
Subject: [PATCH 2/8] arm64: Use consistent naming for errata handling
In-Reply-To: <1467977839-27543-1-git-send-email-suzuki.poulose@arm.com>
References: <1467977839-27543-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1467977839-27543-3-git-send-email-suzuki.poulose@arm.com>
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
index 2926c7d..0aab3ec 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -192,10 +192,10 @@ void __init setup_cpu_features(void);
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
index af647d2..f0fd6a2c 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -110,7 +110,7 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
  * and the related information is freed soon after. If the new CPU requires
  * an errata not detected at boot, fail this CPU.
  */
-void verify_local_cpu_errata(void)
+void verify_local_cpu_errata_workarounds(void)
 {
 	const struct arm64_cpu_capabilities *caps = arm64_errata;
 
@@ -125,7 +125,7 @@ void verify_local_cpu_errata(void)
 		}
 }
 
-void check_local_cpu_errata(void)
+void update_cpu_errata_workarounds(void)
 {
 	update_cpu_capabilities(arm64_errata, "enabling workaround for");
 }
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 3566b6d..7b8bb7f 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -998,7 +998,7 @@ void verify_local_cpu_capabilities(void)
 	if (!sys_caps_initialised)
 		return;
 
-	verify_local_cpu_errata();
+	verify_local_cpu_errata_workarounds();
 	verify_local_cpu_features(arm64_features);
 	verify_local_elf_hwcaps(arm64_elf_hwcaps);
 	if (system_supports_32bit_el0())
diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
index c173d32..2de8767 100644
--- a/arch/arm64/kernel/cpuinfo.c
+++ b/arch/arm64/kernel/cpuinfo.c
@@ -246,7 +246,7 @@ static void __cpuinfo_store_cpu(struct cpuinfo_arm64 *info)
 
 	cpuinfo_detect_icache_policy(info);
 
-	check_local_cpu_errata();
+	update_cpu_errata_workarounds();
 }
 
 void cpuinfo_store_cpu(void)
-- 
2.7.4
