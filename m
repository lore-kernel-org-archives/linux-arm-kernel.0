From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 18 Mar 2015 15:20:51 +0100
Subject: [PATCH v4 1/2] ARM: treat CPU feature register fields as signed
 quantities
In-Reply-To: <1426688452-10804-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1426688452-10804-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1426688452-10804-2-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The various CPU feature registers consist of 4-bit blocks that
represent signed quantities, whose positive values represent
incremental features, and whose negative values are reserved.

To improve forward compatibility, update the feature detection code
to take possible future higher values into account, but ignore
negative values.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm/include/asm/cputype.h | 16 ++++++++++++++++
 arch/arm/kernel/setup.c        | 22 +++++++++-------------
 2 files changed, 25 insertions(+), 13 deletions(-)

diff --git a/arch/arm/include/asm/cputype.h b/arch/arm/include/asm/cputype.h
index 819777d0e91f..85e374f873ac 100644
--- a/arch/arm/include/asm/cputype.h
+++ b/arch/arm/include/asm/cputype.h
@@ -253,4 +253,20 @@ static inline int cpu_is_pj4(void)
 #else
 #define cpu_is_pj4()	0
 #endif
+
+static inline int __attribute_const__ cpuid_feature_extract_field(u32 features,
+								  int field)
+{
+	int feature = (features >> field) & 15;
+
+	/* feature registers are signed values */
+	if (feature > 8)
+		feature -= 16;
+
+	return feature;
+}
+
+#define cpuid_feature_extract(reg, field) \
+	cpuid_feature_extract_field(read_cpuid_ext(reg), field)
+
 #endif
diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index e55408e96559..637c449e6060 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -375,30 +375,26 @@ void __init early_print(const char *str, ...)
 
 static void __init cpuid_init_hwcaps(void)
 {
-	unsigned int divide_instrs, vmsa;
+	int block;
 
 	if (cpu_architecture() < CPU_ARCH_ARMv7)
 		return;
 
-	divide_instrs = (read_cpuid_ext(CPUID_EXT_ISAR0) & 0x0f000000) >> 24;
-
-	switch (divide_instrs) {
-	case 2:
+	block = cpuid_feature_extract(CPUID_EXT_ISAR0, 24);
+	if (block >= 2)
 		elf_hwcap |= HWCAP_IDIVA;
-	case 1:
+	if (block >= 1)
 		elf_hwcap |= HWCAP_IDIVT;
-	}
 
 	/* LPAE implies atomic ldrd/strd instructions */
-	vmsa = (read_cpuid_ext(CPUID_EXT_MMFR0) & 0xf) >> 0;
-	if (vmsa >= 5)
+	block = cpuid_feature_extract(CPUID_EXT_MMFR0, 0);
+	if (block >= 5)
 		elf_hwcap |= HWCAP_LPAE;
 }
 
 static void __init elf_hwcap_fixup(void)
 {
 	unsigned id = read_cpuid_id();
-	unsigned sync_prim;
 
 	/*
 	 * HWCAP_TLS is available only on 1136 r1p0 and later,
@@ -419,9 +415,9 @@ static void __init elf_hwcap_fixup(void)
 	 * avoid advertising SWP; it may not be atomic with
 	 * multiprocessing cores.
 	 */
-	sync_prim = ((read_cpuid_ext(CPUID_EXT_ISAR3) >> 8) & 0xf0) |
-		    ((read_cpuid_ext(CPUID_EXT_ISAR4) >> 20) & 0x0f);
-	if (sync_prim >= 0x13)
+	if (cpuid_feature_extract(CPUID_EXT_ISAR3, 12) > 1 ||
+	    (cpuid_feature_extract(CPUID_EXT_ISAR3, 12) == 1 &&
+	     cpuid_feature_extract(CPUID_EXT_ISAR3, 20) >= 3))
 		elf_hwcap &= ~HWCAP_SWP;
 }
 
-- 
1.8.3.2
