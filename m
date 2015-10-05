From: suzuki.poulose@arm.com (Suzuki K. Poulose)
Date: Mon,  5 Oct 2015 18:01:51 +0100
Subject: [PATCH v2 02/22] arm64: Delay ELF HWCAP initialisation until all CPUs
 are up
In-Reply-To: <1444064531-25607-1-git-send-email-suzuki.poulose@arm.com>
References: <1444064531-25607-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1444064531-25607-3-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Delay the ELF HWCAP initialisation untill all the (enabled) CPUs are
up, i.e, smp_cpus_done(). This is in preparation for detecting the
common features across the CPUS and creating a consistent ELF HWCAP
for the system.

Signed-off-by: Suzuki K. Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/include/asm/cpufeature.h |    1 +
 arch/arm64/kernel/setup.c           |   16 ++++++++--------
 arch/arm64/kernel/smp.c             |    1 +
 3 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index 1715707..b7769f6 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -81,6 +81,7 @@ static inline int __attribute_const__ cpuid_feature_extract_field(u64 features,
 	return (s64)(features << (64 - 4 - field)) >> (64 - 4);
 }
 
+void __init setup_cpu_features(void);
 
 void check_cpu_capabilities(const struct arm64_cpu_capabilities *caps,
 			    const char *info);
diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index 60fc9a9..d149c18 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -195,20 +195,13 @@ static void __init smp_build_mpidr_hash(void)
 	__flush_dcache_area(&mpidr_hash, sizeof(struct mpidr_hash));
 }
 
-static void __init setup_processor(void)
+void __init setup_cpu_features(void)
 {
 	u64 features;
 	s64 block;
 	u32 cwg;
 	int cls;
 
-	pr_info("Boot CPU: AArch64 Processor [%08x]\n", read_cpuid_id());
-
-	sprintf(init_utsname()->machine, ELF_PLATFORM);
-	elf_hwcap = 0;
-
-	cpuinfo_store_boot_cpu();
-
 	/*
 	 * Check for sane CTR_EL0.CWG value.
 	 */
@@ -292,6 +285,13 @@ static void __init setup_processor(void)
 #endif
 }
 
+static void __init setup_processor(void)
+{
+	pr_info("Boot CPU: AArch64 Processor [%08x]\n", read_cpuid_id());
+	sprintf(init_utsname()->machine, ELF_PLATFORM);
+	cpuinfo_store_boot_cpu();
+}
+
 static void __init setup_machine_fdt(phys_addr_t dt_phys)
 {
 	void *dt_virt = fixmap_remap_fdt(dt_phys);
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 641f529..cb3e0d8 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -326,6 +326,7 @@ static void __init hyp_mode_check(void)
 void __init smp_cpus_done(unsigned int max_cpus)
 {
 	pr_info("SMP: Total of %d processors activated.\n", num_online_cpus());
+	setup_cpu_features();
 	hyp_mode_check();
 	apply_alternatives_all();
 }
-- 
1.7.9.5
