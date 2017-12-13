From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Wed, 13 Dec 2017 17:02:03 +0000
Subject: [RFC PATCH 1/5] ARM: NOMMU: Move PMSAv7 MPU under it's own namespace
In-Reply-To: <1513184527-44120-1-git-send-email-vladimir.murzin@arm.com>
References: <1513184527-44120-1-git-send-email-vladimir.murzin@arm.com>
Message-ID: <1513184527-44120-2-git-send-email-vladimir.murzin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We are going to support different MPU which programming model is not
compatible to PMSAv7, so move PMSAv7 MPU under it's own namespace.

Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
---
 arch/arm/include/asm/mpu.h    | 62 +++++++++++++++-----------------
 arch/arm/include/asm/v7m.h    |  6 ++--
 arch/arm/kernel/asm-offsets.c |  6 ++--
 arch/arm/kernel/head-nommu.S  | 84 ++++++++++++++++++++++++-------------------
 arch/arm/mm/nommu.c           | 26 ++++++++++++++
 arch/arm/mm/pmsa-v7.c         | 59 +++++++++++++-----------------
 6 files changed, 133 insertions(+), 110 deletions(-)

diff --git a/arch/arm/include/asm/mpu.h b/arch/arm/include/asm/mpu.h
index 6d1491c..fbde275 100644
--- a/arch/arm/include/asm/mpu.h
+++ b/arch/arm/include/asm/mpu.h
@@ -14,50 +14,50 @@
 #define MMFR0_PMSAv7		(3 << 4)
 
 /* MPU D/I Size Register fields */
-#define MPU_RSR_SZ		1
-#define MPU_RSR_EN		0
-#define MPU_RSR_SD		8
+#define PMSAv7_RSR_SZ		1
+#define PMSAv7_RSR_EN		0
+#define PMSAv7_RSR_SD		8
 
 /* Number of subregions (SD) */
-#define MPU_NR_SUBREGS		8
-#define MPU_MIN_SUBREG_SIZE	256
+#define PMSAv7_NR_SUBREGS	8
+#define PMSAv7_MIN_SUBREG_SIZE	256
 
 /* The D/I RSR value for an enabled region spanning the whole of memory */
-#define MPU_RSR_ALL_MEM		63
+#define PMSAv7_RSR_ALL_MEM	63
 
 /* Individual bits in the DR/IR ACR */
-#define MPU_ACR_XN		(1 << 12)
-#define MPU_ACR_SHARED		(1 << 2)
+#define PMSAv7_ACR_XN		(1 << 12)
+#define PMSAv7_ACR_SHARED	(1 << 2)
 
 /* C, B and TEX[2:0] bits only have semantic meanings when grouped */
-#define MPU_RGN_CACHEABLE	0xB
-#define MPU_RGN_SHARED_CACHEABLE (MPU_RGN_CACHEABLE | MPU_ACR_SHARED)
-#define MPU_RGN_STRONGLY_ORDERED 0
+#define PMSAv7_RGN_CACHEABLE		0xB
+#define PMSAv7_RGN_SHARED_CACHEABLE	(PMSAv7_RGN_CACHEABLE | PMSAv7_ACR_SHARED)
+#define PMSAv7_RGN_STRONGLY_ORDERED	0
 
 /* Main region should only be shared for SMP */
 #ifdef CONFIG_SMP
-#define MPU_RGN_NORMAL		(MPU_RGN_CACHEABLE | MPU_ACR_SHARED)
+#define PMSAv7_RGN_NORMAL	(PMSAv7_RGN_CACHEABLE | PMSAv7_ACR_SHARED)
 #else
-#define MPU_RGN_NORMAL		MPU_RGN_CACHEABLE
+#define PMSAv7_RGN_NORMAL	PMSAv7_RGN_CACHEABLE
 #endif
 
 /* Access permission bits of ACR (only define those that we use)*/
-#define MPU_AP_PL1RO_PL0NA	(0x5 << 8)
-#define MPU_AP_PL1RW_PL0RW	(0x3 << 8)
-#define MPU_AP_PL1RW_PL0R0	(0x2 << 8)
-#define MPU_AP_PL1RW_PL0NA	(0x1 << 8)
+#define PMSAv7_AP_PL1RO_PL0NA	(0x5 << 8)
+#define PMSAv7_AP_PL1RW_PL0RW	(0x3 << 8)
+#define PMSAv7_AP_PL1RW_PL0R0	(0x2 << 8)
+#define PMSAv7_AP_PL1RW_PL0NA	(0x1 << 8)
 
 /* For minimal static MPU region configurations */
-#define MPU_PROBE_REGION	0
-#define MPU_BG_REGION		1
-#define MPU_RAM_REGION		2
-#define MPU_ROM_REGION		3
+#define PMSAv7_PROBE_REGION	0
+#define PMSAv7_BG_REGION	1
+#define PMSAv7_RAM_REGION	2
+#define PMSAv7_ROM_REGION	3
 
 /* Maximum number of regions Linux is interested in */
-#define MPU_MAX_REGIONS		16
+#define MPU_MAX_REGIONS	16
 
-#define MPU_DATA_SIDE		0
-#define MPU_INSTR_SIDE		1
+#define PMSAv7_DATA_SIDE	0
+#define PMSAv7_INSTR_SIDE	1
 
 #ifndef __ASSEMBLY__
 
@@ -75,16 +75,12 @@ struct mpu_rgn_info {
 extern struct mpu_rgn_info mpu_rgn_info;
 
 #ifdef CONFIG_ARM_MPU
-
-extern void __init adjust_lowmem_bounds_mpu(void);
-extern void __init mpu_setup(void);
-
+extern void __init pmsav7_adjust_lowmem_bounds(void);
+extern void __init pmsav7_setup(void);
 #else
-
-static inline void adjust_lowmem_bounds_mpu(void) {}
-static inline void mpu_setup(void) {}
-
-#endif /* !CONFIG_ARM_MPU */
+static inline void pmsav7_adjust_lowmem_bounds(void) {};
+static inline void pmsav7_setup(void) {};
+#endif
 
 #endif /* __ASSEMBLY__ */
 
diff --git a/arch/arm/include/asm/v7m.h b/arch/arm/include/asm/v7m.h
index 634e771..aba49e0 100644
--- a/arch/arm/include/asm/v7m.h
+++ b/arch/arm/include/asm/v7m.h
@@ -64,9 +64,9 @@
 #define MPU_CTRL_ENABLE		1
 #define MPU_CTRL_PRIVDEFENA	(1 << 2)
 
-#define MPU_RNR			0x98
-#define MPU_RBAR		0x9c
-#define MPU_RASR		0xa0
+#define PMSAv7_RNR		0x98
+#define PMSAv7_RBAR		0x9c
+#define PMSAv7_RASR		0xa0
 
 /* Cache opeartions */
 #define	V7M_SCB_ICIALLU		0x250	/* I-cache invalidate all to PoU */
diff --git a/arch/arm/kernel/asm-offsets.c b/arch/arm/kernel/asm-offsets.c
index f369ece..250a985 100644
--- a/arch/arm/kernel/asm-offsets.c
+++ b/arch/arm/kernel/asm-offsets.c
@@ -194,9 +194,9 @@ int main(void)
   DEFINE(MPU_RNG_INFO_USED,	offsetof(struct mpu_rgn_info, used));
 
   DEFINE(MPU_RNG_SIZE,		sizeof(struct mpu_rgn));
-  DEFINE(MPU_RGN_DRBAR,		offsetof(struct mpu_rgn, drbar));
-  DEFINE(MPU_RGN_DRSR,		offsetof(struct mpu_rgn, drsr));
-  DEFINE(MPU_RGN_DRACR,		offsetof(struct mpu_rgn, dracr));
+  DEFINE(MPU_RGN_DRBAR,	offsetof(struct mpu_rgn, drbar));
+  DEFINE(MPU_RGN_DRSR,	offsetof(struct mpu_rgn, drsr));
+  DEFINE(MPU_RGN_DRACR,	offsetof(struct mpu_rgn, dracr));
 #endif
   return 0; 
 }
diff --git a/arch/arm/kernel/head-nommu.S b/arch/arm/kernel/head-nommu.S
index 2e38f85..0d17187 100644
--- a/arch/arm/kernel/head-nommu.S
+++ b/arch/arm/kernel/head-nommu.S
@@ -68,14 +68,6 @@ ENTRY(stext)
 	beq	__error_p				@ yes, error 'p'
 
 #ifdef CONFIG_ARM_MPU
-	/* Calculate the size of a region covering just the kernel */
-	ldr	r5, =PLAT_PHYS_OFFSET		@ Region start: PHYS_OFFSET
-	ldr     r6, =(_end)			@ Cover whole kernel
-	sub	r6, r6, r5			@ Minimum size of region to map
-	clz	r6, r6				@ Region size must be 2^N...
-	rsb	r6, r6, #31			@ ...so round up region size
-	lsl	r6, r6, #MPU_RSR_SZ		@ Put size in right field
-	orr	r6, r6, #(1 << MPU_RSR_EN)	@ Set region enabled bit
 	bl	__setup_mpu
 #endif
 
@@ -110,8 +102,6 @@ ENTRY(secondary_startup)
 	ldr	r7, __secondary_data
 
 #ifdef CONFIG_ARM_MPU
-	/* Use MPU region info supplied by __cpu_up */
-	ldr	r6, [r7]			@ get secondary_data.mpu_rgn_info
 	bl      __secondary_setup_mpu		@ Initialize the MPU
 #endif
 
@@ -184,7 +174,7 @@ ENDPROC(__after_proc_init)
 .endm
 
 /* Setup a single MPU region, either D or I side (D-side for unified) */
-.macro setup_region bar, acr, sr, side = MPU_DATA_SIDE, unused
+.macro setup_region bar, acr, sr, side = PMSAv7_DATA_SIDE, unused
 	mcr	p15, 0, \bar, c6, c1, (0 + \side)	@ I/DRBAR
 	mcr	p15, 0, \acr, c6, c1, (4 + \side)	@ I/DRACR
 	mcr	p15, 0, \sr, c6, c1, (2 + \side)		@ I/DRSR
@@ -192,14 +182,14 @@ ENDPROC(__after_proc_init)
 #else
 .macro set_region_nr tmp, rgnr, base
 	mov	\tmp, \rgnr
-	str     \tmp, [\base, #MPU_RNR]
+	str     \tmp, [\base, #PMSAv7_RNR]
 .endm
 
 .macro setup_region bar, acr, sr, unused, base
 	lsl     \acr, \acr, #16
 	orr     \acr, \acr, \sr
-	str     \bar, [\base, #MPU_RBAR]
-	str     \acr, [\base, #MPU_RASR]
+	str     \bar, [\base, #PMSAv7_RBAR]
+	str     \acr, [\base, #PMSAv7_RASR]
 .endm
 
 #endif
@@ -210,7 +200,7 @@ ENDPROC(__after_proc_init)
  * Region 2: Normal, Shared, cacheable for RAM. From PHYS_OFFSET, size from r6
  * Region 3: Normal, shared, inaccessible from PL0 to protect the vectors page
  *
- * r6: Value to be written to DRSR (and IRSR if required) for MPU_RAM_REGION
+ * r6: Value to be written to DRSR (and IRSR if required) for PMSAv7_RAM_REGION
 */
 
 ENTRY(__setup_mpu)
@@ -223,7 +213,20 @@ AR_CLASS(mrc	p15, 0, r0, c0, c1, 4)		@ Read ID_MMFR0
 M_CLASS(ldr	r0, [r12, 0x50])
 	and	r0, r0, #(MMFR0_PMSA)		@ PMSA field
 	teq	r0, #(MMFR0_PMSAv7)		@ PMSA v7
-	bxne	lr
+	beq	__setup_pmsa_v7
+
+	ret	lr
+ENDPROC(__setup_mpu)
+
+ENTRY(__setup_pmsa_v7)
+	/* Calculate the size of a region covering just the kernel */
+	ldr	r5, =PLAT_PHYS_OFFSET		@ Region start: PHYS_OFFSET
+	ldr     r6, =(_end)			@ Cover whole kernel
+	sub	r6, r6, r5			@ Minimum size of region to map
+	clz	r6, r6				@ Region size must be 2^N...
+	rsb	r6, r6, #31			@ ...so round up region size
+	lsl	r6, r6, #PMSAv7_RSR_SZ		@ Put size in right field
+	orr	r6, r6, #(1 << PMSAv7_RSR_EN)	@ Set region enabled bit
 
 	/* Determine whether the D/I-side memory map is unified. We set the
 	 * flags here and continue to use them for the rest of this function */
@@ -234,47 +237,47 @@ M_CLASS(ldr    r0, [r12, #MPU_TYPE])
 	tst	r0, #MPUIR_nU			@ MPUIR_nU = 0 for unified
 
 	/* Setup second region first to free up r6 */
-	set_region_nr r0, #MPU_RAM_REGION, r12
+	set_region_nr r0, #PMSAv7_RAM_REGION, r12
 	isb
 	/* Full access from PL0, PL1, shared for CONFIG_SMP, cacheable */
 	ldr	r0, =PLAT_PHYS_OFFSET		@ RAM starts at PHYS_OFFSET
-	ldr	r5,=(MPU_AP_PL1RW_PL0RW | MPU_RGN_NORMAL)
+	ldr	r5,=(PMSAv7_AP_PL1RW_PL0RW | PMSAv7_RGN_NORMAL)
 
-	setup_region r0, r5, r6, MPU_DATA_SIDE, r12	@ PHYS_OFFSET, shared, enabled
+	setup_region r0, r5, r6, PMSAv7_DATA_SIDE, r12	@ PHYS_OFFSET, shared, enabled
 	beq	1f					@ Memory-map not unified
-	setup_region r0, r5, r6, MPU_INSTR_SIDE, r12	@ PHYS_OFFSET, shared, enabled
+	setup_region r0, r5, r6, PMSAv7_INSTR_SIDE, r12	@ PHYS_OFFSET, shared, enabled
 1:	isb
 
 	/* First/background region */
-	set_region_nr r0, #MPU_BG_REGION, r12
+	set_region_nr r0, #PMSAv7_BG_REGION, r12
 	isb
 	/* Execute Never,  strongly ordered, inaccessible to PL0, rw PL1  */
 	mov	r0, #0				@ BG region starts at 0x0
-	ldr	r5,=(MPU_ACR_XN | MPU_RGN_STRONGLY_ORDERED | MPU_AP_PL1RW_PL0NA)
-	mov	r6, #MPU_RSR_ALL_MEM		@ 4GB region, enabled
+	ldr	r5,=(PMSAv7_ACR_XN | PMSAv7_RGN_STRONGLY_ORDERED | PMSAv7_AP_PL1RW_PL0NA)
+	mov	r6, #PMSAv7_RSR_ALL_MEM		@ 4GB region, enabled
 
-	setup_region r0, r5, r6, MPU_DATA_SIDE, r12	@ 0x0, BG region, enabled
+	setup_region r0, r5, r6, PMSAv7_DATA_SIDE, r12	@ 0x0, BG region, enabled
 	beq	2f					@ Memory-map not unified
-	setup_region r0, r5, r6, MPU_INSTR_SIDE r12	@ 0x0, BG region, enabled
+	setup_region r0, r5, r6, PMSAv7_INSTR_SIDE r12	@ 0x0, BG region, enabled
 2:	isb
 
 #ifdef CONFIG_XIP_KERNEL
-	set_region_nr r0, #MPU_ROM_REGION, r12
+	set_region_nr r0, #PMSAv7_ROM_REGION, r12
 	isb
 
-	ldr	r5,=(MPU_AP_PL1RO_PL0NA | MPU_RGN_NORMAL)
+	ldr	r5,=(PMSAv7_AP_PL1RO_PL0NA | PMSAv7_RGN_NORMAL)
 
 	ldr	r0, =CONFIG_XIP_PHYS_ADDR		@ ROM start
 	ldr     r6, =(_exiprom)				@ ROM end
 	sub	r6, r6, r0				@ Minimum size of region to map
 	clz	r6, r6					@ Region size must be 2^N...
 	rsb	r6, r6, #31				@ ...so round up region size
-	lsl	r6, r6, #MPU_RSR_SZ			@ Put size in right field
-	orr	r6, r6, #(1 << MPU_RSR_EN)		@ Set region enabled bit
+	lsl	r6, r6, #PMSAv7_RSR_SZ			@ Put size in right field
+	orr	r6, r6, #(1 << PMSAv7_RSR_EN)		@ Set region enabled bit
 
-	setup_region r0, r5, r6, MPU_DATA_SIDE, r12	@ XIP_PHYS_ADDR, shared, enabled
+	setup_region r0, r5, r6, PMSAv7_DATA_SIDE, r12	@ XIP_PHYS_ADDR, shared, enabled
 	beq	3f					@ Memory-map not unified
-	setup_region r0, r5, r6, MPU_INSTR_SIDE, r12	@ XIP_PHYS_ADDR, shared, enabled
+	setup_region r0, r5, r6, PMSAv7_INSTR_SIDE, r12	@ XIP_PHYS_ADDR, shared, enabled
 3:	isb
 #endif
 
@@ -291,7 +294,7 @@ M_CLASS(str	r0, [r12, #MPU_CTRL])
 	isb
 
 	ret	lr
-ENDPROC(__setup_mpu)
+ENDPROC(__setup_pmsa_v7)
 
 #ifdef CONFIG_SMP
 /*
@@ -299,12 +302,21 @@ ENDPROC(__setup_mpu)
  */
 
 ENTRY(__secondary_setup_mpu)
+	/* Use MPU region info supplied by __cpu_up */
+	ldr	r6, [r7]			@ get secondary_data.mpu_rgn_info
+
 	/* Probe for v7 PMSA compliance */
 	mrc	p15, 0, r0, c0, c1, 4		@ Read ID_MMFR0
 	and	r0, r0, #(MMFR0_PMSA)		@ PMSA field
 	teq	r0, #(MMFR0_PMSAv7)		@ PMSA v7
-	bne	__error_p
+	beq	__secondary_setup_pmsa_v7
+ 	b	__error_p
+ENDPROC(__secondary_setup_mpu)
 
+/*
+ * r6: pointer@mpu_rgn_info
+ */
+ENTRY(__secondary_setup_pmsa_v7)
 	/* Determine whether the D/I-side memory map is unified. We set the
 	 * flags here and continue to use them for the rest of this function */
 	mrc	p15, 0, r0, c0, c0, 4		@ MPUIR
@@ -328,9 +340,9 @@ ENTRY(__secondary_setup_mpu)
 	ldr	r6, [r3, #MPU_RGN_DRSR]
 	ldr	r5, [r3, #MPU_RGN_DRACR]
 
-	setup_region r0, r5, r6, MPU_DATA_SIDE
+	setup_region r0, r5, r6, PMSAv7_DATA_SIDE
 	beq	2f
-	setup_region r0, r5, r6, MPU_INSTR_SIDE
+	setup_region r0, r5, r6, PMSAv7_INSTR_SIDE
 2:	isb
 
 	mrc	p15, 0, r0, c0, c0, 4		@ Reevaluate the MPUIR
@@ -345,7 +357,7 @@ ENTRY(__secondary_setup_mpu)
 	isb
 
 	ret	lr
-ENDPROC(__secondary_setup_mpu)
+ENDPROC(__secondary_setup_pmsa_v7)
 
 #endif /* CONFIG_SMP */
 #endif /* CONFIG_ARM_MPU */
diff --git a/arch/arm/mm/nommu.c b/arch/arm/mm/nommu.c
index 4b4af66..7534885 100644
--- a/arch/arm/mm/nommu.c
+++ b/arch/arm/mm/nommu.c
@@ -100,6 +100,32 @@ void __init arm_mm_memblock_reserve(void)
 	memblock_reserve(0, 1);
 }
 
+static void __init adjust_lowmem_bounds_mpu(void)
+{
+	unsigned long pmsa = read_cpuid_ext(CPUID_EXT_MMFR0) & MMFR0_PMSA;
+
+	switch (pmsa) {
+	case MMFR0_PMSAv7:
+		pmsav7_adjust_lowmem_bounds();
+		break;
+	default:
+		break;
+	}
+}
+
+static void __init mpu_setup(void)
+{
+	unsigned long pmsa = read_cpuid_ext(CPUID_EXT_MMFR0) & MMFR0_PMSA;
+
+	switch (pmsa) {
+	case MMFR0_PMSAv7:
+		pmsav7_setup();
+		break;
+	default:
+		break;
+	}
+}
+
 void __init adjust_lowmem_bounds(void)
 {
 	phys_addr_t end;
diff --git a/arch/arm/mm/pmsa-v7.c b/arch/arm/mm/pmsa-v7.c
index 976df60..eeb84dc 100644
--- a/arch/arm/mm/pmsa-v7.c
+++ b/arch/arm/mm/pmsa-v7.c
@@ -101,7 +101,7 @@ static inline u32 irbar_read(void)
 
 static inline void rgnr_write(u32 v)
 {
-	writel_relaxed(v, BASEADDR_V7M_SCB + MPU_RNR);
+	writel_relaxed(v, BASEADDR_V7M_SCB + PMSAv7_RNR);
 }
 
 /* Data-side / unified region attributes */
@@ -109,28 +109,28 @@ static inline void rgnr_write(u32 v)
 /* Region access control register */
 static inline void dracr_write(u32 v)
 {
-	u32 rsr = readl_relaxed(BASEADDR_V7M_SCB + MPU_RASR) & GENMASK(15, 0);
+	u32 rsr = readl_relaxed(BASEADDR_V7M_SCB + PMSAv7_RASR) & GENMASK(15, 0);
 
-	writel_relaxed((v << 16) | rsr, BASEADDR_V7M_SCB + MPU_RASR);
+	writel_relaxed((v << 16) | rsr, BASEADDR_V7M_SCB + PMSAv7_RASR);
 }
 
 /* Region size register */
 static inline void drsr_write(u32 v)
 {
-	u32 racr = readl_relaxed(BASEADDR_V7M_SCB + MPU_RASR) & GENMASK(31, 16);
+	u32 racr = readl_relaxed(BASEADDR_V7M_SCB + PMSAv7_RASR) & GENMASK(31, 16);
 
-	writel_relaxed(v | racr, BASEADDR_V7M_SCB + MPU_RASR);
+	writel_relaxed(v | racr, BASEADDR_V7M_SCB + PMSAv7_RASR);
 }
 
 /* Region base address register */
 static inline void drbar_write(u32 v)
 {
-	writel_relaxed(v, BASEADDR_V7M_SCB + MPU_RBAR);
+	writel_relaxed(v, BASEADDR_V7M_SCB + PMSAv7_RBAR);
 }
 
 static inline u32 drbar_read(void)
 {
-	return readl_relaxed(BASEADDR_V7M_SCB + MPU_RBAR);
+	return readl_relaxed(BASEADDR_V7M_SCB + PMSAv7_RBAR);
 }
 
 /* ARMv7-M only supports a unified MPU, so I-side operations are nop */
@@ -142,11 +142,6 @@ static inline unsigned long irbar_read(void) {return 0;}
 
 #endif
 
-static int __init mpu_present(void)
-{
-	return ((read_cpuid_ext(CPUID_EXT_MMFR0) & MMFR0_PMSA) == MMFR0_PMSAv7);
-}
-
 static bool __init try_split_region(phys_addr_t base, phys_addr_t size, struct region *region)
 {
 	unsigned long  subreg, bslots, sslots;
@@ -160,7 +155,7 @@ static bool __init try_split_region(phys_addr_t base, phys_addr_t size, struct r
 
 	bdiff = base - abase;
 	sdiff = p2size - asize;
-	subreg = p2size / MPU_NR_SUBREGS;
+	subreg = p2size / PMSAv7_NR_SUBREGS;
 
 	if ((bdiff % subreg) || (sdiff % subreg))
 		return false;
@@ -171,17 +166,17 @@ static bool __init try_split_region(phys_addr_t base, phys_addr_t size, struct r
 	if (bslots || sslots) {
 		int i;
 
-		if (subreg < MPU_MIN_SUBREG_SIZE)
+		if (subreg < PMSAv7_MIN_SUBREG_SIZE)
 			return false;
 
-		if (bslots + sslots > MPU_NR_SUBREGS)
+		if (bslots + sslots > PMSAv7_NR_SUBREGS)
 			return false;
 
 		for (i = 0; i < bslots; i++)
 			_set_bit(i, &region->subreg);
 
 		for (i = 1; i <= sslots; i++)
-			_set_bit(MPU_NR_SUBREGS - i, &region->subreg);
+			_set_bit(PMSAv7_NR_SUBREGS - i, &region->subreg);
 	}
 
 	region->base = abase;
@@ -232,7 +227,7 @@ static int __init allocate_region(phys_addr_t base, phys_addr_t size,
 }
 
 /* MPU initialisation functions */
-void __init adjust_lowmem_bounds_mpu(void)
+void __init pmsav7_adjust_lowmem_bounds(void)
 {
 	phys_addr_t  specified_mem_size = 0, total_mem_size = 0;
 	struct memblock_region *reg;
@@ -242,10 +237,7 @@ void __init adjust_lowmem_bounds_mpu(void)
 	unsigned int mem_max_regions;
 	int num, i;
 
-	if (!mpu_present())
-		return;
-
-	/* Free-up MPU_PROBE_REGION */
+	/* Free-up PMSAv7_PROBE_REGION */
 	mpu_min_region_order = __mpu_min_region_order();
 
 	/* How many regions are supported */
@@ -299,12 +291,12 @@ void __init adjust_lowmem_bounds_mpu(void)
 	num = allocate_region(mem_start, specified_mem_size, mem_max_regions, mem);
 
 	for (i = 0; i < num; i++) {
-		unsigned long  subreg = mem[i].size / MPU_NR_SUBREGS;
+		unsigned long  subreg = mem[i].size / PMSAv7_NR_SUBREGS;
 
 		total_mem_size += mem[i].size - subreg * hweight_long(mem[i].subreg);
 
 		pr_debug("MPU: base %pa size %pa disable subregions: %*pbl\n",
-			 &mem[i].base, &mem[i].size, MPU_NR_SUBREGS, &mem[i].subreg);
+			 &mem[i].base, &mem[i].size, PMSAv7_NR_SUBREGS, &mem[i].subreg);
 	}
 
 	if (total_mem_size != specified_mem_size) {
@@ -347,7 +339,7 @@ static int __init __mpu_min_region_order(void)
 	u32 drbar_result, irbar_result;
 
 	/* We've kept a region free for this probing */
-	rgnr_write(MPU_PROBE_REGION);
+	rgnr_write(PMSAv7_PROBE_REGION);
 	isb();
 	/*
 	 * As per ARM ARM, write 0xFFFFFFFC to DRBAR to find the minimum
@@ -386,8 +378,8 @@ static int __init mpu_setup_region(unsigned int number, phys_addr_t start,
 		return -ENOMEM;
 
 	/* Writing N to bits 5:1 (RSR_SZ)  specifies region size 2^N+1 */
-	size_data = ((size_order - 1) << MPU_RSR_SZ) | 1 << MPU_RSR_EN;
-	size_data |= subregions << MPU_RSR_SD;
+	size_data = ((size_order - 1) << PMSAv7_RSR_SZ) | 1 << PMSAv7_RSR_EN;
+	size_data |= subregions << PMSAv7_RSR_SD;
 
 	if (need_flush)
 		flush_cache_all();
@@ -422,18 +414,15 @@ static int __init mpu_setup_region(unsigned int number, phys_addr_t start,
 /*
 * Set up default MPU regions, doing nothing if there is no MPU
 */
-void __init mpu_setup(void)
+void __init pmsav7_setup(void)
 {
 	int i, region = 0, err = 0;
 
-	if (!mpu_present())
-		return;
-
 	/* Setup MPU (order is important) */
 
 	/* Background */
 	err |= mpu_setup_region(region++, 0, 32,
-				MPU_ACR_XN | MPU_RGN_STRONGLY_ORDERED | MPU_AP_PL1RW_PL0NA,
+				PMSAv7_ACR_XN | PMSAv7_RGN_STRONGLY_ORDERED | PMSAv7_AP_PL1RW_PL0NA,
 				0, false);
 
 #ifdef CONFIG_XIP_KERNEL
@@ -446,13 +435,13 @@ void __init mpu_setup(void)
                  * with BG region (which is uncachable), thus we need
                  * to clean and invalidate cache.
 		 */
-		bool need_flush = region == MPU_RAM_REGION;
+		bool need_flush = region == PMSAv7_RAM_REGION;
 
 		if (!xip[i].size)
 			continue;
 
 		err |= mpu_setup_region(region++, xip[i].base, ilog2(xip[i].size),
-					MPU_AP_PL1RO_PL0NA | MPU_RGN_NORMAL,
+					PMSAv7_AP_PL1RO_PL0NA | PMSAv7_RGN_NORMAL,
 					xip[i].subreg, need_flush);
 	}
 #endif
@@ -463,14 +452,14 @@ void __init mpu_setup(void)
 			continue;
 
 		err |= mpu_setup_region(region++, mem[i].base, ilog2(mem[i].size),
-					MPU_AP_PL1RW_PL0RW | MPU_RGN_NORMAL,
+					PMSAv7_AP_PL1RW_PL0RW | PMSAv7_RGN_NORMAL,
 					mem[i].subreg, false);
 	}
 
 	/* Vectors */
 #ifndef CONFIG_CPU_V7M
 	err |= mpu_setup_region(region++, vectors_base, ilog2(2 * PAGE_SIZE),
-				MPU_AP_PL1RW_PL0NA | MPU_RGN_NORMAL,
+				PMSAv7_AP_PL1RW_PL0NA | PMSAv7_RGN_NORMAL,
 				0, false);
 #endif
 	if (err) {
-- 
2.0.0
