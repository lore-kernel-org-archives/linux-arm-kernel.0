From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Mon, 25 Sep 2017 10:05:39 +0100
Subject: [PATCH v3 3/8] ARM: NOMMU: Rework MPU to be mostly done in C
In-Reply-To: <1506330344-31556-1-git-send-email-vladimir.murzin@arm.com>
References: <1506330344-31556-1-git-send-email-vladimir.murzin@arm.com>
Message-ID: <1506330344-31556-4-git-send-email-vladimir.murzin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, there are several issues with how MPU is setup:

 1. We won't boot if MPU is missing
 2. We won't boot if use XIP
 3. Further extension of MPU setup requires asm skills

The 1st point can be relaxed, so we can continue with boot CPU even if
MPU is missed and fail boot for secondaries only. To address the 2nd
point we could create region covering CONFIG_XIP_PHYS_ADDR - _end and
that might work for the first stage of MPU enable, but due to MPU's
alignment requirement we could cover too much, IOW we need more
flexibility in how we're partitioning memory regions... and it'd be
hardly possible to archive because of the 3rd point.

This patch is trying to address 1st and 3rd issues and paves the path
for 2nd and further improvements.

The most visible change introduced with this patch is that we start
using mpu_rgn_info array (as it was supposed?), so change in MPU setup
done by boot CPU is recorded there and feed to secondaries. It
allows us to keep minimal region setup for boot CPU and do the rest in
C. Since we start programming MPU regions in C evaluation of MPU
constrains (number of regions supported and minimal region order) can
be done once, which in turn open possibility to free-up "probe"
region early.

Tested-by: Szemz? Andr?s <sza@esh.hu>
Tested-by: Alexandre TORGUE <alexandre.torgue@st.com>
Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
---
 arch/arm/include/asm/mpu.h    |  2 +-
 arch/arm/include/asm/smp.h    |  2 +-
 arch/arm/kernel/asm-offsets.c | 11 ++++++
 arch/arm/kernel/head-nommu.S  | 80 +++++++++++++++++++++++++++++++++----------
 arch/arm/kernel/smp.c         |  2 +-
 arch/arm/mm/pmsa-v7.c         | 70 +++++++++++++++++++++++++++----------
 6 files changed, 127 insertions(+), 40 deletions(-)

diff --git a/arch/arm/include/asm/mpu.h b/arch/arm/include/asm/mpu.h
index edec5cf..403462e 100644
--- a/arch/arm/include/asm/mpu.h
+++ b/arch/arm/include/asm/mpu.h
@@ -62,7 +62,7 @@ struct mpu_rgn {
 };
 
 struct mpu_rgn_info {
-	u32 mpuir;
+	unsigned int used;
 	struct mpu_rgn rgns[MPU_MAX_REGIONS];
 };
 extern struct mpu_rgn_info mpu_rgn_info;
diff --git a/arch/arm/include/asm/smp.h b/arch/arm/include/asm/smp.h
index 3d6dc8b..709a559 100644
--- a/arch/arm/include/asm/smp.h
+++ b/arch/arm/include/asm/smp.h
@@ -60,7 +60,7 @@
  */
 struct secondary_data {
 	union {
-		unsigned long mpu_rgn_szr;
+		struct mpu_rgn_info *mpu_rgn_info;
 		u64 pgdir;
 	};
 	unsigned long swapper_pg_dir;
diff --git a/arch/arm/kernel/asm-offsets.c b/arch/arm/kernel/asm-offsets.c
index 6080082..0098d3c4 100644
--- a/arch/arm/kernel/asm-offsets.c
+++ b/arch/arm/kernel/asm-offsets.c
@@ -23,6 +23,7 @@
 #include <asm/mach/arch.h>
 #include <asm/thread_info.h>
 #include <asm/memory.h>
+#include <asm/mpu.h>
 #include <asm/procinfo.h>
 #include <asm/suspend.h>
 #include <asm/vdso_datapage.h>
@@ -183,5 +184,15 @@ int main(void)
 #ifdef CONFIG_VDSO
   DEFINE(VDSO_DATA_SIZE,	sizeof(union vdso_data_store));
 #endif
+  BLANK();
+#ifdef CONFIG_ARM_MPU
+  DEFINE(MPU_RNG_INFO_RNGS,	offsetof(struct mpu_rgn_info, rgns));
+  DEFINE(MPU_RNG_INFO_USED,	offsetof(struct mpu_rgn_info, used));
+
+  DEFINE(MPU_RNG_SIZE,		sizeof(struct mpu_rgn));
+  DEFINE(MPU_RGN_DRBAR,		offsetof(struct mpu_rgn, drbar));
+  DEFINE(MPU_RGN_DRSR,		offsetof(struct mpu_rgn, drsr));
+  DEFINE(MPU_RGN_DRACR,		offsetof(struct mpu_rgn, dracr));
+#endif
   return 0; 
 }
diff --git a/arch/arm/kernel/head-nommu.S b/arch/arm/kernel/head-nommu.S
index 4b9e8da..f242ae5 100644
--- a/arch/arm/kernel/head-nommu.S
+++ b/arch/arm/kernel/head-nommu.S
@@ -13,6 +13,7 @@
  */
 #include <linux/linkage.h>
 #include <linux/init.h>
+#include <linux/errno.h>
 
 #include <asm/assembler.h>
 #include <asm/ptrace.h>
@@ -131,8 +132,8 @@ ENTRY(secondary_startup)
 
 #ifdef CONFIG_ARM_MPU
 	/* Use MPU region info supplied by __cpu_up */
-	ldr	r6, [r7]			@ get secondary_data.mpu_szr
-	bl      __setup_mpu			@ Initialize the MPU
+	ldr	r6, [r7]			@ get secondary_data.mpu_rgn_info
+	bl      __secondary_setup_mpu		@ Initialize the MPU
 #endif
 
 	badr	lr, 1f				@ return (PIC) address
@@ -225,13 +226,13 @@ ENTRY(__setup_mpu)
 	mrc	p15, 0, r0, c0, c1, 4		@ Read ID_MMFR0
 	and	r0, r0, #(MMFR0_PMSA)		@ PMSA field
 	teq	r0, #(MMFR0_PMSAv7)		@ PMSA v7
-	bne	__error_p			@ Fail: ARM_MPU on NOT v7 PMSA
+	bxne	lr
 
 	/* Determine whether the D/I-side memory map is unified. We set the
 	 * flags here and continue to use them for the rest of this function */
 	mrc	p15, 0, r0, c0, c0, 4		@ MPUIR
 	ands	r5, r0, #MPUIR_DREGION_SZMASK	@ 0 size d region => No MPU
-	beq	__error_p			@ Fail: ARM_MPU and no MPU
+	bxeq	lr
 	tst	r0, #MPUIR_nU			@ MPUIR_nU = 0 for unified
 
 	/* Setup second region first to free up r6 */
@@ -259,27 +260,70 @@ ENTRY(__setup_mpu)
 	setup_region r0, r5, r6, MPU_INSTR_SIDE @ 0x0, BG region, enabled
 2:	isb
 
-	/* Vectors region */
-	set_region_nr r0, #MPU_VECTORS_REGION
+	/* Enable the MPU */
+	mrc	p15, 0, r0, c1, c0, 0		@ Read SCTLR
+	bic	r0, r0, #CR_BR			@ Disable the 'default mem-map'
+	orr	r0, r0, #CR_M			@ Set SCTRL.M (MPU on)
+	mcr	p15, 0, r0, c1, c0, 0		@ Enable MPU
+	isb
+
+	ret	lr
+ENDPROC(__setup_mpu)
+
+#ifdef CONFIG_SMP
+/*
+ * r6: pointer at mpu_rgn_info
+ */
+
+ENTRY(__secondary_setup_mpu)
+	/* Probe for v7 PMSA compliance */
+	mrc	p15, 0, r0, c0, c1, 4		@ Read ID_MMFR0
+	and	r0, r0, #(MMFR0_PMSA)		@ PMSA field
+	teq	r0, #(MMFR0_PMSAv7)		@ PMSA v7
+	bne	__error_p
+
+	/* Determine whether the D/I-side memory map is unified. We set the
+	 * flags here and continue to use them for the rest of this function */
+	mrc	p15, 0, r0, c0, c0, 4		@ MPUIR
+	ands	r5, r0, #MPUIR_DREGION_SZMASK	@ 0 size d region => No MPU
+	beq	__error_p
+
+	ldr	r4, [r6, #MPU_RNG_INFO_USED]
+	mov	r5, #MPU_RNG_SIZE
+	add	r3, r6, #MPU_RNG_INFO_RNGS
+	mla	r3, r4, r5, r3
+
+1:
+	tst	r0, #MPUIR_nU			@ MPUIR_nU = 0 for unified
+	sub	r3, r3, #MPU_RNG_SIZE
+	sub	r4, r4, #1
+
+	set_region_nr r0, r4
 	isb
-	/* Shared, inaccessible to PL0, rw PL1 */
-	mov	r0, #CONFIG_VECTORS_BASE	@ Cover from VECTORS_BASE
-	ldr	r5,=(MPU_AP_PL1RW_PL0NA | MPU_RGN_NORMAL)
-	/* Writing N to bits 5:1 (RSR_SZ) --> region size 2^N+1 */
-	mov	r6, #(((2 * PAGE_SHIFT - 1) << MPU_RSR_SZ) | 1 << MPU_RSR_EN)
 
-	setup_region r0, r5, r6, MPU_DATA_SIDE	@ VECTORS_BASE, PL0 NA, enabled
-	beq	3f				@ Memory-map not unified
-	setup_region r0, r5, r6, MPU_INSTR_SIDE	@ VECTORS_BASE, PL0 NA, enabled
-3:	isb
+	ldr	r0, [r3, #MPU_RGN_DRBAR]
+	ldr	r6, [r3, #MPU_RGN_DRSR]
+	ldr	r5, [r3, #MPU_RGN_DRACR]
+
+	setup_region r0, r5, r6, MPU_DATA_SIDE
+	beq	2f
+	setup_region r0, r5, r6, MPU_INSTR_SIDE
+2:	isb
+
+	mrc	p15, 0, r0, c0, c0, 4		@ Reevaluate the MPUIR
+	cmp	r4, #0
+	bgt	1b
 
 	/* Enable the MPU */
 	mrc	p15, 0, r0, c1, c0, 0		@ Read SCTLR
-	bic     r0, r0, #CR_BR			@ Disable the 'default mem-map'
+	bic	r0, r0, #CR_BR			@ Disable the 'default mem-map'
 	orr	r0, r0, #CR_M			@ Set SCTRL.M (MPU on)
 	mcr	p15, 0, r0, c1, c0, 0		@ Enable MPU
 	isb
+
 	ret	lr
-ENDPROC(__setup_mpu)
-#endif
+ENDPROC(__secondary_setup_mpu)
+
+#endif /* CONFIG_SMP */
+#endif /* CONFIG_ARM_MPU */
 #include "head-common.S"
diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index c9a0a52..b4fbf00 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -114,7 +114,7 @@ int __cpu_up(unsigned int cpu, struct task_struct *idle)
 	 */
 	secondary_data.stack = task_stack_page(idle) + THREAD_START_SP;
 #ifdef CONFIG_ARM_MPU
-	secondary_data.mpu_rgn_szr = mpu_rgn_info.rgns[MPU_RAM_REGION].drsr;
+	secondary_data.mpu_rgn_info = &mpu_rgn_info;
 #endif
 
 #ifdef CONFIG_MMU
diff --git a/arch/arm/mm/pmsa-v7.c b/arch/arm/mm/pmsa-v7.c
index 5b55f8f..029d204 100644
--- a/arch/arm/mm/pmsa-v7.c
+++ b/arch/arm/mm/pmsa-v7.c
@@ -12,6 +12,9 @@
 
 #include "mm.h"
 
+static unsigned int __initdata mpu_min_region_order;
+static unsigned int __initdata mpu_max_regions;
+
 #define DRBAR	__ACCESS_CP15(c6, 0, c1, 0)
 #define IRBAR	__ACCESS_CP15(c6, 0, c1, 1)
 #define DRSR	__ACCESS_CP15(c6, 0, c1, 2)
@@ -75,6 +78,11 @@ static inline u32 irbar_read(void)
 	return read_sysreg(IRBAR);
 }
 
+static int __init mpu_present(void)
+{
+	return ((read_cpuid_ext(CPUID_EXT_MMFR0) & MMFR0_PMSA) == MMFR0_PMSAv7);
+}
+
 /* MPU initialisation functions */
 void __init adjust_lowmem_bounds_mpu(void)
 {
@@ -85,6 +93,9 @@ void __init adjust_lowmem_bounds_mpu(void)
 	phys_addr_t mem_start;
 	phys_addr_t mem_end;
 
+	if (!mpu_present())
+		return;
+
 	for_each_memblock(memory, reg) {
 		if (first) {
 			/*
@@ -146,12 +157,7 @@ void __init adjust_lowmem_bounds_mpu(void)
 
 }
 
-static int mpu_present(void)
-{
-	return ((read_cpuid_ext(CPUID_EXT_MMFR0) & MMFR0_PMSA) == MMFR0_PMSAv7);
-}
-
-static int mpu_max_regions(void)
+static int __init __mpu_max_regions(void)
 {
 	/*
 	 * We don't support a different number of I/D side regions so if we
@@ -159,6 +165,7 @@ static int mpu_max_regions(void)
 	 * whichever side has a smaller number of supported regions.
 	 */
 	u32 dregions, iregions, mpuir;
+
 	mpuir = read_cpuid(CPUID_MPUIR);
 
 	dregions = iregions = (mpuir & MPUIR_DREGION_SZMASK) >> MPUIR_DREGION;
@@ -171,15 +178,16 @@ static int mpu_max_regions(void)
 	return min(dregions, iregions);
 }
 
-static int mpu_iside_independent(void)
+static int __init mpu_iside_independent(void)
 {
 	/* MPUIR.nU specifies whether there is *not* a unified memory map */
 	return read_cpuid(CPUID_MPUIR) & MPUIR_nU;
 }
 
-static int mpu_min_region_order(void)
+static int __init __mpu_min_region_order(void)
 {
 	u32 drbar_result, irbar_result;
+
 	/* We've kept a region free for this probing */
 	rgnr_write(MPU_PROBE_REGION);
 	isb();
@@ -198,22 +206,24 @@ static int mpu_min_region_order(void)
 	}
 	isb(); /* Ensure that MPU region operations have completed */
 	/* Return whichever result is larger */
+
 	return __ffs(max(drbar_result, irbar_result));
 }
 
-static int mpu_setup_region(unsigned int number, phys_addr_t start,
+static int __init mpu_setup_region(unsigned int number, phys_addr_t start,
 			unsigned int size_order, unsigned int properties)
 {
 	u32 size_data;
 
 	/* We kept a region free for probing resolution of MPU regions*/
-	if (number > mpu_max_regions() || number == MPU_PROBE_REGION)
+	if (number > mpu_max_regions
+	    || number >= MPU_MAX_REGIONS)
 		return -ENOENT;
 
 	if (size_order > 32)
 		return -ENOMEM;
 
-	if (size_order < mpu_min_region_order())
+	if (size_order < mpu_min_region_order)
 		return -ENOMEM;
 
 	/* Writing N to bits 5:1 (RSR_SZ)  specifies region size 2^N+1 */
@@ -240,6 +250,9 @@ static int mpu_setup_region(unsigned int number, phys_addr_t start,
 	mpu_rgn_info.rgns[number].dracr = properties;
 	mpu_rgn_info.rgns[number].drbar = start;
 	mpu_rgn_info.rgns[number].drsr = size_data;
+
+	mpu_rgn_info.used++;
+
 	return 0;
 }
 
@@ -248,19 +261,38 @@ static int mpu_setup_region(unsigned int number, phys_addr_t start,
 */
 void __init mpu_setup(void)
 {
-	int region_err;
+	int region = 0, err = 0;
+
 	if (!mpu_present())
 		return;
 
-	region_err = mpu_setup_region(MPU_RAM_REGION, PHYS_OFFSET,
-					ilog2(memblock.memory.regions[0].size),
-					MPU_AP_PL1RW_PL0RW | MPU_RGN_NORMAL);
-	if (region_err) {
-		panic("MPU region initialization failure! %d", region_err);
+	/* Free-up MPU_PROBE_REGION */
+	mpu_min_region_order = __mpu_min_region_order();
+
+	/* How many regions are supported */
+	mpu_max_regions = __mpu_max_regions();
+
+	/* Now setup MPU (order is important) */
+
+	/* Background */
+	err |= mpu_setup_region(region++, 0, 32,
+				MPU_ACR_XN | MPU_RGN_STRONGLY_ORDERED | MPU_AP_PL1RW_PL0NA);
+
+	/* RAM */
+	err |= mpu_setup_region(region++, PHYS_OFFSET,
+				ilog2(memblock.memory.regions[0].size),
+				MPU_AP_PL1RW_PL0RW | MPU_RGN_NORMAL);
+
+	/* Vectors */
+	err |= mpu_setup_region(region++, vectors_base,
+				ilog2(2 * PAGE_SIZE),
+				MPU_AP_PL1RW_PL0NA | MPU_RGN_NORMAL);
+	if (err) {
+		panic("MPU region initialization failure! %d", err);
 	} else {
 		pr_info("Using ARMv7 PMSA Compliant MPU. "
-			 "Region independence: %s, Max regions: %d\n",
+			 "Region independence: %s, Used %d of %d regions\n",
 			mpu_iside_independent() ? "Yes" : "No",
-			mpu_max_regions());
+			mpu_rgn_info.used, mpu_max_regions);
 	}
 }
-- 
1.9.1
