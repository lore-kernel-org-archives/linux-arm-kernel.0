From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Tue, 26 Jan 2016 09:23:43 +0000
Subject: [PATCH 4/4] ARM: use proper helper while extracting cpu features
In-Reply-To: <1453800223-18590-1-git-send-email-vladimir.murzin@arm.com>
References: <1453800223-18590-1-git-send-email-vladimir.murzin@arm.com>
Message-ID: <1453800223-18590-5-git-send-email-vladimir.murzin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update current users of cpu feature helpers to use the proper helper
depends on how feature bits should be handled. We follow the arm64
scheme [1] (slightly rephrased):

We have three types of fields:

a) A precise value or a value from which you derive some precise
   value.
b) Fields defining the presence of a feature (1, 2, 3). These would
   always be positive since the absence of such feature would mean a
   value of 0
c) Fields defining the absence of a feature by setting 0xf. These are
   usually fields that were initial RAZ and turned to -1.

So we can treat (a) and (b) as unsigned permanently and (c) as as
signed,

[1] https://lkml.org/lkml/2015/11/19/549

Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
---
 arch/arm/include/asm/smp_plat.h |    4 ++--
 arch/arm/kernel/setup.c         |   34 ++++++++++++++++++++--------------
 arch/arm/kernel/thumbee.c       |    4 +---
 arch/arm/mm/mmu.c               |    2 +-
 4 files changed, 24 insertions(+), 20 deletions(-)

diff --git a/arch/arm/include/asm/smp_plat.h b/arch/arm/include/asm/smp_plat.h
index f908071..03bbe02 100644
--- a/arch/arm/include/asm/smp_plat.h
+++ b/arch/arm/include/asm/smp_plat.h
@@ -49,7 +49,7 @@ static inline int tlb_ops_need_broadcast(void)
 	if (!is_smp())
 		return 0;
 
-	return ((read_cpuid_ext(CPUID_EXT_MMFR3) >> 12) & 0xf) < 2;
+	return cpuid_feature_extract_unsigned(CPUID_EXT_MMFR3, 12) < 2;
 }
 #endif
 
@@ -61,7 +61,7 @@ static inline int cache_ops_need_broadcast(void)
 	if (!is_smp())
 		return 0;
 
-	return ((read_cpuid_ext(CPUID_EXT_MMFR3) >> 12) & 0xf) < 1;
+	return cpuid_feature_extract_unsigned(CPUID_EXT_MMFR3, 12) < 1;
 }
 #endif
 
diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index fde041b..e696553 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -257,11 +257,15 @@ static int __get_cpu_architecture(void)
 		/* Revised CPUID format. Read the Memory Model Feature
 		 * Register 0 and check for VMSAv7 or PMSAv7 */
 		unsigned int mmfr0 = read_cpuid_ext(CPUID_EXT_MMFR0);
-		if ((mmfr0 & 0x0000000f) >= 0x00000003 ||
-		    (mmfr0 & 0x000000f0) >= 0x00000030)
+		unsigned int block;
+#ifdef CONFIG_MMU
+		block = cpuid_feature_extract_unsigned_field(mmfr0, 0);
+#else
+		block = cpuid_feature_extract_unsigned_field(mmfr0, 4);
+#endif
+		if (mmfr0 >= 3)
 			cpu_arch = CPU_ARCH_ARMv7;
-		else if ((mmfr0 & 0x0000000f) == 0x00000002 ||
-			 (mmfr0 & 0x000000f0) == 0x00000020)
+		else if (mmfr0 == 2)
 			cpu_arch = CPU_ARCH_ARMv6;
 		else
 			cpu_arch = CPU_ARCH_UNKNOWN;
@@ -446,41 +450,41 @@ static inline void patch_aeabi_idiv(void) { }
 
 static void __init cpuid_init_hwcaps(void)
 {
-	int block;
+	unsigned int block;
 	u32 isar5;
 
 	if (cpu_architecture() < CPU_ARCH_ARMv7)
 		return;
 
-	block = cpuid_feature_extract(CPUID_EXT_ISAR0, 24);
+	block = cpuid_feature_extract_unsigned(CPUID_EXT_ISAR0, 24);
 	if (block >= 2)
 		elf_hwcap |= HWCAP_IDIVA;
 	if (block >= 1)
 		elf_hwcap |= HWCAP_IDIVT;
 
 	/* LPAE implies atomic ldrd/strd instructions */
-	block = cpuid_feature_extract(CPUID_EXT_MMFR0, 0);
+	block = cpuid_feature_extract_unsigned(CPUID_EXT_MMFR0, 0);
 	if (block >= 5)
 		elf_hwcap |= HWCAP_LPAE;
 
 	/* check for supported v8 Crypto instructions */
 	isar5 = read_cpuid_ext(CPUID_EXT_ISAR5);
 
-	block = cpuid_feature_extract_field(isar5, 4);
+	block = cpuid_feature_extract_unsigned_field(isar5, 4);
 	if (block >= 2)
 		elf_hwcap2 |= HWCAP2_PMULL;
 	if (block >= 1)
 		elf_hwcap2 |= HWCAP2_AES;
 
-	block = cpuid_feature_extract_field(isar5, 8);
+	block = cpuid_feature_extract_unsigned_field(isar5, 8);
 	if (block >= 1)
 		elf_hwcap2 |= HWCAP2_SHA1;
 
-	block = cpuid_feature_extract_field(isar5, 12);
+	block = cpuid_feature_extract_unsigned_field(isar5, 12);
 	if (block >= 1)
 		elf_hwcap2 |= HWCAP2_SHA2;
 
-	block = cpuid_feature_extract_field(isar5, 16);
+	block = cpuid_feature_extract_unsigned_field(isar5, 16);
 	if (block >= 1)
 		elf_hwcap2 |= HWCAP2_CRC32;
 }
@@ -488,6 +492,7 @@ static void __init cpuid_init_hwcaps(void)
 static void __init elf_hwcap_fixup(void)
 {
 	unsigned id = read_cpuid_id();
+	unsigned int block;
 
 	/*
 	 * HWCAP_TLS is available only on 1136 r1p0 and later,
@@ -508,9 +513,10 @@ static void __init elf_hwcap_fixup(void)
 	 * avoid advertising SWP; it may not be atomic with
 	 * multiprocessing cores.
 	 */
-	if (cpuid_feature_extract(CPUID_EXT_ISAR3, 12) > 1 ||
-	    (cpuid_feature_extract(CPUID_EXT_ISAR3, 12) == 1 &&
-	     cpuid_feature_extract(CPUID_EXT_ISAR4, 20) >= 3))
+	block = cpuid_feature_extract_unsigned(CPUID_EXT_ISAR3, 12);
+
+	if (block > 1 || (block == 1 &&
+	    cpuid_feature_extract_unsigned(CPUID_EXT_ISAR4, 20) >= 3))
 		elf_hwcap &= ~HWCAP_SWP;
 }
 
diff --git a/arch/arm/kernel/thumbee.c b/arch/arm/kernel/thumbee.c
index 8ff8dbf..b5cac80 100644
--- a/arch/arm/kernel/thumbee.c
+++ b/arch/arm/kernel/thumbee.c
@@ -62,14 +62,12 @@ static struct notifier_block thumbee_notifier_block = {
 
 static int __init thumbee_init(void)
 {
-	unsigned long pfr0;
 	unsigned int cpu_arch = cpu_architecture();
 
 	if (cpu_arch < CPU_ARCH_ARMv7)
 		return 0;
 
-	pfr0 = read_cpuid_ext(CPUID_EXT_PFR0);
-	if ((pfr0 & 0x0000f000) != 0x00001000)
+	if (cpuid_feature_extract_unsigned(CPUID_EXT_PFR0, 12) != 1)
 		return 0;
 
 	pr_info("ThumbEE CPU extension supported.\n");
diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index 434d76f..06723a9 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -572,7 +572,7 @@ static void __init build_mem_type_table(void)
 	 * in the Short-descriptor translation table format descriptors.
 	 */
 	if (cpu_arch == CPU_ARCH_ARMv7 &&
-		(read_cpuid_ext(CPUID_EXT_MMFR0) & 0xF) >= 4) {
+		(cpuid_feature_extract_unsigned(CPUID_EXT_MMFR0, 0) >= 4)) {
 		user_pmd_table |= PMD_PXNTABLE;
 	}
 #endif
-- 
1.7.9.5
