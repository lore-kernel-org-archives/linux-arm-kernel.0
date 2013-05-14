From: jonathan.austin@arm.com (Jonathan Austin)
Date: Tue, 14 May 2013 14:04:39 +0100
Subject: [PATCH 3/8] ARM: mpu: add early bring-up code for the ARMv7
 PMSA-compliant MPU
In-Reply-To: <1368536684-13608-1-git-send-email-jonathan.austin@arm.com>
References: <1368536684-13608-1-git-send-email-jonathan.austin@arm.com>
Message-ID: <1368536684-13608-4-git-send-email-jonathan.austin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds initial support for using the MPU, which is necessary for
SMP operation on PMSAv7 processors because it is the only way to ensure
memory is shared. This is an initial patch and full SMP support is added
later in this series.

The setup of the MPU is performed in a way analagous to that for the MMU:
Very early initialisation before the C environment is brought up, followed
by a sanity check and more complete initialisation in C.

This patch provides the simplest possible memory region configuration:
MPU_PROBE_REGION: Reserved for probing MPU details, not enabled
MPU_BG_REGION: A 'background' region that specifies all memory strongly ordered
MPU_RAM_REGION: A single shared, cacheable, normal region for the valid RAM.

In this early initialisation code we simply map the whole of the address
space with the BG_REGION and (at least) the kernel with the RAM_REGION. The
MPU has region alignment constraints that require us to round past the end
of the kernel.

As region 2 has a higher priority than region 1, it overrides the strongly-
ordered behaviour for RAM only.

Subsequent patches will add more complete initialisation from the C-world
and support for bringing up secondary CPUs.

Signed-off-by: Jonathan Austin <jonathan.austin@arm.com>
Reviewed-by: Will Deacon <will.deacon@arm.com>
Cc: Hyok S. Choi <hyok.choi@samsung.com>
Cc: Nicolas Pitre <nico@linaro.org>
---
 arch/arm/include/asm/mpu.h   |    3 ++
 arch/arm/kernel/head-nommu.S |   87 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 90 insertions(+)

diff --git a/arch/arm/include/asm/mpu.h b/arch/arm/include/asm/mpu.h
index bd48c0c..0014834 100644
--- a/arch/arm/include/asm/mpu.h
+++ b/arch/arm/include/asm/mpu.h
@@ -50,6 +50,9 @@
 /* Maximum number of regions Linux is interested in */
 #define MPU_MAX_REGIONS		16
 
+#define MPU_DATA_SIDE		0
+#define MPU_INSTR_SIDE		1
+
 #ifndef __ASSEMBLY__
 
 struct mpu_rgn {
diff --git a/arch/arm/kernel/head-nommu.S b/arch/arm/kernel/head-nommu.S
index 2d4bf12..0b0751f 100644
--- a/arch/arm/kernel/head-nommu.S
+++ b/arch/arm/kernel/head-nommu.S
@@ -17,8 +17,10 @@
 #include <asm/assembler.h>
 #include <asm/ptrace.h>
 #include <asm/asm-offsets.h>
+#include <asm/memory.h>
 #include <asm/cp15.h>
 #include <asm/thread_info.h>
+#include <asm/mpu.h>
 
 /*
  * Kernel startup entry point.
@@ -59,6 +61,17 @@ ENTRY(stext)
 	movs	r10, r5				@ invalid processor (r5=0)?
 	beq	__error_p				@ yes, error 'p'
 
+#ifdef CONFIG_ARM_MPU
+	/* Calculate the size of a region covering just the kernel */
+	ldr	r5, =PHYS_OFFSET		@ Region start: PHYS_OFFSET
+	ldr     r6, =(_end)			@ Cover whole kernel
+	sub	r6, r6, r5			@ Minimum size of region to map
+	clz	r6, r6				@ Region size must be 2^N...
+	rsb	r6, r6, #31			@ ...so round up region size
+	lsl	r6, r6, #MPU_RSR_SZ		@ Put size in right field
+	orr	r6, r6, #(1 << MPU_RSR_EN)	@ Set region enabled bit
+	bl	__setup_mpu
+#endif
 	ldr	r13, =__mmap_switched		@ address to jump to after
 						@ initialising sctlr
 	adr	lr, BSYM(1f)			@ return (PIC) address
@@ -143,4 +156,78 @@ __after_proc_init:
 ENDPROC(__after_proc_init)
 	.ltorg
 
+#ifdef CONFIG_ARM_MPU
+
+
+/* Set which MPU region should be programmed */
+.macro set_region_nr tmp, rgnr
+	mov	\tmp, \rgnr			@ Use static region numbers
+	mcr	p15, 0, \tmp, c6, c2, 0		@ Write RGNR
+.endm
+
+/* Setup a single MPU region, either D or I side (D-side for unified) */
+.macro setup_region bar, acr, sr, side = MPU_DATA_SIDE
+	mcr	p15, 0, \bar, c6, c1, (0 + \side)	@ I/DRBAR
+	mcr	p15, 0, \acr, c6, c1, (4 + \side)	@ I/DRACR
+	mcr	p15, 0, \sr, c6, c1, (2 + \side)		@ I/DRSR
+.endm
+
+/*
+ * Setup the MPU and initial MPU Regions. We create the following regions:
+ * Region 0: Use this for probing the MPU details, so leave disabled.
+ * Region 1: Background region - covers the whole of RAM as strongly ordered
+ * Region 2: Normal, Shared, cacheable for RAM. From PHYS_OFFSET, size from r6
+ *
+ * r6: Value to be written to DRSR (and IRSR if required) for MPU_RAM_REGION
+*/
+
+ENTRY(__setup_mpu)
+
+	/* Probe for v7 PMSA compliance */
+	mrc	p15, 0, r0, c0, c1, 4		@ Read ID_MMFR0
+	and	r0, r0, #(MMFR0_PMSA)		@ PMSA field
+	teq	r0, #(MMFR0_PMSAv7)		@ PMSA v7
+	bne	__error_p			@ Fail: ARM_MPU on NOT v7 PMSA
+
+	/* Determine whether the D/I-side memory map is unified. We set the
+	 * flags here and continue to use them for the rest of this function */
+	mrc	p15, 0, r0, c0, c0, 4		@ MPUIR
+	ands	r5, r0, #MPUIR_DREGION_SZMASK	@ 0 size d region => No MPU
+	beq	__error_p			@ Fail: ARM_MPU and no MPU
+	tst	r0, #MPUIR_nU			@ MPUIR_nU = 0 for unified
+
+	/* Setup second region first to free up r6 */
+	set_region_nr r0, #MPU_RAM_REGION
+	isb
+	/* Full access from PL0, PL1, shared for CONFIG_SMP, cacheable */
+	ldr	r0, =PHYS_OFFSET		@ RAM starts at PHYS_OFFSET
+	ldr	r5,=(MPU_AP_PL1RW_PL0RW | MPU_RGN_NORMAL)
+
+	setup_region r0, r5, r6, MPU_DATA_SIDE	@ PHYS_OFFSET, shared, enabled
+	beq	1f				@ Memory-map not unified
+	setup_region r0, r5, r6, MPU_INSTR_SIDE @ PHYS_OFFSET, shared, enabled
+1:	isb
+
+	/* First/background region */
+	set_region_nr r0, #MPU_BG_REGION
+	isb
+	/* Execute Never,  strongly ordered, inaccessible to PL0, rw PL1  */
+	mov	r0, #0				@ BG region starts at 0x0
+	ldr	r5,=(MPU_ACR_XN | MPU_RGN_STRONGLY_ORDERED | MPU_AP_PL1RW_PL0NA)
+	mov	r6, #MPU_RSR_ALL_MEM		@ 4GB region, enabled
+
+	setup_region r0, r5, r6, MPU_DATA_SIDE	@ 0x0, BG region, enabled
+	beq	2f				@ Memory-map not unified
+	setup_region r0, r5, r6, MPU_INSTR_SIDE @ 0x0, BG region, enabled
+2:	isb
+
+	/* Enable the MPU */
+	mrc	p15, 0, r0, c1, c0, 0		@ Read SCTLR
+	bic     r0, r0, #CR_BR			@ Disable the 'default mem-map'
+	orr	r0, r0, #CR_M			@ Set SCTRL.M (MPU on)
+	mcr	p15, 0, r0, c1, c0, 0		@ Enable MPU
+	isb
+	mov pc,lr
+ENDPROC(__setup_mpu)
+#endif
 #include "head-common.S"
-- 
1.7.9.5
