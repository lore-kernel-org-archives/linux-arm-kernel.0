From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Mon, 25 Sep 2017 10:05:42 +0100
Subject: [PATCH v3 6/8] ARM: V7M: Add support for MPU to M-class
In-Reply-To: <1506330344-31556-1-git-send-email-vladimir.murzin@arm.com>
References: <1506330344-31556-1-git-send-email-vladimir.murzin@arm.com>
Message-ID: <1506330344-31556-7-git-send-email-vladimir.murzin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch makes it possible to use MPU with v7M cores.

Tested-by: Szemz? Andr?s <sza@esh.hu>
Tested-by: Alexandre TORGUE <alexandre.torgue@st.com>
Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
---
 arch/arm/Kconfig-nommu         |  4 +--
 arch/arm/include/asm/cputype.h | 10 ++++++++
 arch/arm/include/asm/v7m.h     | 10 ++++++++
 arch/arm/kernel/head-nommu.S   | 56 ++++++++++++++++++++++++++++++------------
 arch/arm/mm/pmsa-v7.c          | 53 +++++++++++++++++++++++++++++++++++++--
 5 files changed, 113 insertions(+), 20 deletions(-)

diff --git a/arch/arm/Kconfig-nommu b/arch/arm/Kconfig-nommu
index 6d18395..930e000 100644
--- a/arch/arm/Kconfig-nommu
+++ b/arch/arm/Kconfig-nommu
@@ -52,8 +52,8 @@ config REMAP_VECTORS_TO_RAM
 
 config ARM_MPU
        bool 'Use the ARM v7 PMSA Compliant MPU'
-       depends on !XIP_KERNEL && CPU_V7
-       default y
+       depends on !XIP_KERNEL && (CPU_V7 || CPU_V7M)
+       default y if CPU_V7
        help
          Some ARM systems without an MMU have instead a Memory Protection
          Unit (MPU) that defines the type and permissions for regions of
diff --git a/arch/arm/include/asm/cputype.h b/arch/arm/include/asm/cputype.h
index b62eaeb..abaac5e 100644
--- a/arch/arm/include/asm/cputype.h
+++ b/arch/arm/include/asm/cputype.h
@@ -173,6 +173,11 @@ static inline unsigned int __attribute_const__ read_cpuid_cachetype(void)
 	return read_cpuid(CPUID_CACHETYPE);
 }
 
+static inline unsigned int __attribute_const__ read_cpuid_mputype(void)
+{
+	return read_cpuid(CPUID_MPUIR);
+}
+
 #elif defined(CONFIG_CPU_V7M)
 
 static inline unsigned int __attribute_const__ read_cpuid_id(void)
@@ -185,6 +190,11 @@ static inline unsigned int __attribute_const__ read_cpuid_cachetype(void)
 	return readl(BASEADDR_V7M_SCB + V7M_SCB_CTR);
 }
 
+static inline unsigned int __attribute_const__ read_cpuid_mputype(void)
+{
+	return readl(BASEADDR_V7M_SCB + MPU_TYPE);
+}
+
 #else /* ifdef CONFIG_CPU_CP15 / elif defined(CONFIG_CPU_V7M) */
 
 static inline unsigned int __attribute_const__ read_cpuid_id(void)
diff --git a/arch/arm/include/asm/v7m.h b/arch/arm/include/asm/v7m.h
index 1fd775c..5de776c 100644
--- a/arch/arm/include/asm/v7m.h
+++ b/arch/arm/include/asm/v7m.h
@@ -57,6 +57,16 @@
 #define	V7M_SCB_CCSIDR		0x80	/* Cache size ID register */
 #define	V7M_SCB_CSSELR		0x84	/* Cache size selection register */
 
+/* Memory-mapped MPU registers for M-class */
+#define MPU_TYPE		0x90
+#define MPU_CTRL		0x94
+#define MPU_CTRL_ENABLE		1
+#define MPU_CTRL_PRIVDEFENA	(1 << 2)
+
+#define MPU_RNR			0x98
+#define MPU_RBAR		0x9c
+#define MPU_RASR		0xa0
+
 /* Cache opeartions */
 #define	V7M_SCB_ICIALLU		0x250	/* I-cache invalidate all to PoU */
 #define	V7M_SCB_ICIMVAU		0x258	/* I-cache invalidate by MVA to PoU */
diff --git a/arch/arm/kernel/head-nommu.S b/arch/arm/kernel/head-nommu.S
index f242ae5..8a0718f 100644
--- a/arch/arm/kernel/head-nommu.S
+++ b/arch/arm/kernel/head-nommu.S
@@ -197,19 +197,33 @@ ENDPROC(__after_proc_init)
 #ifdef CONFIG_ARM_MPU
 
 
+#ifndef CONFIG_CPU_V7M
 /* Set which MPU region should be programmed */
-.macro set_region_nr tmp, rgnr
+.macro set_region_nr tmp, rgnr, unused
 	mov	\tmp, \rgnr			@ Use static region numbers
 	mcr	p15, 0, \tmp, c6, c2, 0		@ Write RGNR
 .endm
 
 /* Setup a single MPU region, either D or I side (D-side for unified) */
-.macro setup_region bar, acr, sr, side = MPU_DATA_SIDE
+.macro setup_region bar, acr, sr, side = MPU_DATA_SIDE, unused
 	mcr	p15, 0, \bar, c6, c1, (0 + \side)	@ I/DRBAR
 	mcr	p15, 0, \acr, c6, c1, (4 + \side)	@ I/DRACR
 	mcr	p15, 0, \sr, c6, c1, (2 + \side)		@ I/DRSR
 .endm
+#else
+.macro set_region_nr tmp, rgnr, base
+	mov	\tmp, \rgnr
+	str     \tmp, [\base, #MPU_RNR]
+.endm
+
+.macro setup_region bar, acr, sr, unused, base
+	lsl     \acr, \acr, #16
+	orr     \acr, \acr, \sr
+	str     \bar, [\base, #MPU_RBAR]
+	str     \acr, [\base, #MPU_RASR]
+.endm
 
+#endif
 /*
  * Setup the MPU and initial MPU Regions. We create the following regions:
  * Region 0: Use this for probing the MPU details, so leave disabled.
@@ -223,48 +237,58 @@ ENDPROC(__after_proc_init)
 ENTRY(__setup_mpu)
 
 	/* Probe for v7 PMSA compliance */
-	mrc	p15, 0, r0, c0, c1, 4		@ Read ID_MMFR0
+M_CLASS(movw	r12, #:lower16:BASEADDR_V7M_SCB)
+M_CLASS(movt	r12, #:upper16:BASEADDR_V7M_SCB)
+
+AR_CLASS(mrc	p15, 0, r0, c0, c1, 4)		@ Read ID_MMFR0
+M_CLASS(ldr	r0, [r12, 0x50])
 	and	r0, r0, #(MMFR0_PMSA)		@ PMSA field
 	teq	r0, #(MMFR0_PMSAv7)		@ PMSA v7
 	bxne	lr
 
 	/* Determine whether the D/I-side memory map is unified. We set the
 	 * flags here and continue to use them for the rest of this function */
-	mrc	p15, 0, r0, c0, c0, 4		@ MPUIR
+AR_CLASS(mrc	p15, 0, r0, c0, c0, 4)		@ MPUIR
+M_CLASS(ldr    r0, [r12, #MPU_TYPE])
 	ands	r5, r0, #MPUIR_DREGION_SZMASK	@ 0 size d region => No MPU
 	bxeq	lr
 	tst	r0, #MPUIR_nU			@ MPUIR_nU = 0 for unified
 
 	/* Setup second region first to free up r6 */
-	set_region_nr r0, #MPU_RAM_REGION
+	set_region_nr r0, #MPU_RAM_REGION, r12
 	isb
 	/* Full access from PL0, PL1, shared for CONFIG_SMP, cacheable */
 	ldr	r0, =PLAT_PHYS_OFFSET		@ RAM starts at PHYS_OFFSET
 	ldr	r5,=(MPU_AP_PL1RW_PL0RW | MPU_RGN_NORMAL)
 
-	setup_region r0, r5, r6, MPU_DATA_SIDE	@ PHYS_OFFSET, shared, enabled
-	beq	1f				@ Memory-map not unified
-	setup_region r0, r5, r6, MPU_INSTR_SIDE @ PHYS_OFFSET, shared, enabled
+	setup_region r0, r5, r6, MPU_DATA_SIDE, r12	@ PHYS_OFFSET, shared, enabled
+	beq	1f					@ Memory-map not unified
+	setup_region r0, r5, r6, MPU_INSTR_SIDE, r12	@ PHYS_OFFSET, shared, enabled
 1:	isb
 
 	/* First/background region */
-	set_region_nr r0, #MPU_BG_REGION
+	set_region_nr r0, #MPU_BG_REGION, r12
 	isb
 	/* Execute Never,  strongly ordered, inaccessible to PL0, rw PL1  */
 	mov	r0, #0				@ BG region starts at 0x0
 	ldr	r5,=(MPU_ACR_XN | MPU_RGN_STRONGLY_ORDERED | MPU_AP_PL1RW_PL0NA)
 	mov	r6, #MPU_RSR_ALL_MEM		@ 4GB region, enabled
 
-	setup_region r0, r5, r6, MPU_DATA_SIDE	@ 0x0, BG region, enabled
-	beq	2f				@ Memory-map not unified
-	setup_region r0, r5, r6, MPU_INSTR_SIDE @ 0x0, BG region, enabled
+	setup_region r0, r5, r6, MPU_DATA_SIDE, r12	@ 0x0, BG region, enabled
+	beq	2f					@ Memory-map not unified
+	setup_region r0, r5, r6, MPU_INSTR_SIDE r12	@ 0x0, BG region, enabled
 2:	isb
 
 	/* Enable the MPU */
-	mrc	p15, 0, r0, c1, c0, 0		@ Read SCTLR
-	bic	r0, r0, #CR_BR			@ Disable the 'default mem-map'
-	orr	r0, r0, #CR_M			@ Set SCTRL.M (MPU on)
-	mcr	p15, 0, r0, c1, c0, 0		@ Enable MPU
+AR_CLASS(mrc	p15, 0, r0, c1, c0, 0)		@ Read SCTLR
+AR_CLASS(bic	r0, r0, #CR_BR)			@ Disable the 'default mem-map'
+AR_CLASS(orr	r0, r0, #CR_M)			@ Set SCTRL.M (MPU on)
+AR_CLASS(mcr	p15, 0, r0, c1, c0, 0)		@ Enable MPU
+
+M_CLASS(ldr	r0, [r12, #MPU_CTRL])
+M_CLASS(bic	r0, #MPU_CTRL_PRIVDEFENA)
+M_CLASS(orr	r0, #MPU_CTRL_ENABLE)
+M_CLASS(str	r0, [r12, #MPU_CTRL])
 	isb
 
 	ret	lr
diff --git a/arch/arm/mm/pmsa-v7.c b/arch/arm/mm/pmsa-v7.c
index 029d204..72f1a9f 100644
--- a/arch/arm/mm/pmsa-v7.c
+++ b/arch/arm/mm/pmsa-v7.c
@@ -15,6 +15,8 @@
 static unsigned int __initdata mpu_min_region_order;
 static unsigned int __initdata mpu_max_regions;
 
+#ifndef CONFIG_CPU_V7M
+
 #define DRBAR	__ACCESS_CP15(c6, 0, c1, 0)
 #define IRBAR	__ACCESS_CP15(c6, 0, c1, 1)
 #define DRSR	__ACCESS_CP15(c6, 0, c1, 2)
@@ -78,6 +80,51 @@ static inline u32 irbar_read(void)
 	return read_sysreg(IRBAR);
 }
 
+#else
+
+static inline void rgnr_write(u32 v)
+{
+	writel_relaxed(v, BASEADDR_V7M_SCB + MPU_RNR);
+}
+
+/* Data-side / unified region attributes */
+
+/* Region access control register */
+static inline void dracr_write(u32 v)
+{
+	u32 rsr = readl_relaxed(BASEADDR_V7M_SCB + MPU_RASR) & GENMASK(15, 0);
+
+	writel_relaxed((v << 16) | rsr, BASEADDR_V7M_SCB + MPU_RASR);
+}
+
+/* Region size register */
+static inline void drsr_write(u32 v)
+{
+	u32 racr = readl_relaxed(BASEADDR_V7M_SCB + MPU_RASR) & GENMASK(31, 16);
+
+	writel_relaxed(v | racr, BASEADDR_V7M_SCB + MPU_RASR);
+}
+
+/* Region base address register */
+static inline void drbar_write(u32 v)
+{
+	writel_relaxed(v, BASEADDR_V7M_SCB + MPU_RBAR);
+}
+
+static inline u32 drbar_read(void)
+{
+	return readl_relaxed(BASEADDR_V7M_SCB + MPU_RBAR);
+}
+
+/* ARMv7-M only supports a unified MPU, so I-side operations are nop */
+
+static inline void iracr_write(u32 v) {}
+static inline void irsr_write(u32 v) {}
+static inline void irbar_write(u32 v) {}
+static inline unsigned long irbar_read(void) {return 0;}
+
+#endif
+
 static int __init mpu_present(void)
 {
 	return ((read_cpuid_ext(CPUID_EXT_MMFR0) & MMFR0_PMSA) == MMFR0_PMSAv7);
@@ -166,7 +213,7 @@ static int __init __mpu_max_regions(void)
 	 */
 	u32 dregions, iregions, mpuir;
 
-	mpuir = read_cpuid(CPUID_MPUIR);
+	mpuir = read_cpuid_mputype();
 
 	dregions = iregions = (mpuir & MPUIR_DREGION_SZMASK) >> MPUIR_DREGION;
 
@@ -181,7 +228,7 @@ static int __init __mpu_max_regions(void)
 static int __init mpu_iside_independent(void)
 {
 	/* MPUIR.nU specifies whether there is *not* a unified memory map */
-	return read_cpuid(CPUID_MPUIR) & MPUIR_nU;
+	return read_cpuid_mputype() & MPUIR_nU;
 }
 
 static int __init __mpu_min_region_order(void)
@@ -284,9 +331,11 @@ void __init mpu_setup(void)
 				MPU_AP_PL1RW_PL0RW | MPU_RGN_NORMAL);
 
 	/* Vectors */
+#ifndef CONFIG_CPU_V7M
 	err |= mpu_setup_region(region++, vectors_base,
 				ilog2(2 * PAGE_SIZE),
 				MPU_AP_PL1RW_PL0NA | MPU_RGN_NORMAL);
+#endif
 	if (err) {
 		panic("MPU region initialization failure! %d", err);
 	} else {
-- 
1.9.1
