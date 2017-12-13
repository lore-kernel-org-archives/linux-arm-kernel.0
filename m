From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Wed, 13 Dec 2017 17:02:07 +0000
Subject: [RFC PATCH 5/5] ARM: NOMMU: Support PMSAv8 MPU
In-Reply-To: <1513184527-44120-1-git-send-email-vladimir.murzin@arm.com>
References: <1513184527-44120-1-git-send-email-vladimir.murzin@arm.com>
Message-ID: <1513184527-44120-6-git-send-email-vladimir.murzin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARMv8R/M architecture defines new memory protection scheme - PMSAv8
which is not compatible with PMSAv7.

Key differences to PMSAv7 are:
 - Region geometry is defined by base and limit addresses
 - Addresses need to be either 32 or 64 byte aligned
 - No region priority due to overlapping regions are not allowed
 - It is unified, i.e. no distinction between data/instruction regions
 - Memory attributes are controlled via MAIR

This patch implements support for PMSAv8 MPU defined by ARMv8R/M
architecture.

Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
---
 arch/arm/include/asm/mpu.h    |  52 ++++++-
 arch/arm/include/asm/v7m.h    |   8 ++
 arch/arm/kernel/asm-offsets.c |   2 +
 arch/arm/kernel/head-nommu.S  | 132 ++++++++++++++++++
 arch/arm/mm/Makefile          |   2 +-
 arch/arm/mm/nommu.c           |   6 +
 arch/arm/mm/pmsa-v8.c         | 307 ++++++++++++++++++++++++++++++++++++++++++
 7 files changed, 505 insertions(+), 4 deletions(-)
 create mode 100644 arch/arm/mm/pmsa-v8.c

diff --git a/arch/arm/include/asm/mpu.h b/arch/arm/include/asm/mpu.h
index fbde275..5e088c8 100644
--- a/arch/arm/include/asm/mpu.h
+++ b/arch/arm/include/asm/mpu.h
@@ -12,6 +12,7 @@
 /* ID_MMFR0 data relevant to MPU */
 #define MMFR0_PMSA		(0xF << 4)
 #define MMFR0_PMSAv7		(3 << 4)
+#define MMFR0_PMSAv8		(4 << 4)
 
 /* MPU D/I Size Register fields */
 #define PMSAv7_RSR_SZ		1
@@ -47,12 +48,43 @@
 #define PMSAv7_AP_PL1RW_PL0R0	(0x2 << 8)
 #define PMSAv7_AP_PL1RW_PL0NA	(0x1 << 8)
 
+#define PMSAv8_BAR_XN		1
+
+#define PMSAv8_LAR_EN		1
+#define PMSAv8_LAR_IDX(n)	(((n) & 0x7) << 1)
+
+
+#define PMSAv8_AP_PL1RW_PL0NA	(0 << 1)
+#define PMSAv8_AP_PL1RW_PL0RW	(1 << 1)
+#define PMSAv8_AP_PL1RO_PL0RO	(3 << 1)
+
+#ifdef CONFIG_SMP
+#define PMSAv8_RGN_SHARED	(3 << 3) // inner sharable
+#else
+#define PMSAv8_RGN_SHARED	(0 << 3)
+#endif
+
+#define PMSAv8_RGN_DEVICE_nGnRnE	0
+#define PMSAv8_RGN_NORMAL		1
+
+#define PMSAv8_MAIR(attr, mt)	((attr) << ((mt) * 8))
+
+#ifdef CONFIG_CPU_V7M
+#define PMSAv8_MINALIGN		32
+#else
+#define PMSAv8_MINALIGN		64
+#endif
+
 /* For minimal static MPU region configurations */
 #define PMSAv7_PROBE_REGION	0
 #define PMSAv7_BG_REGION	1
 #define PMSAv7_RAM_REGION	2
 #define PMSAv7_ROM_REGION	3
 
+/* Fixed for PMSAv8 only */
+#define PMSAv8_XIP_REGION	0
+#define PMSAv8_KERNEL_REGION	1
+
 /* Maximum number of regions Linux is interested in */
 #define MPU_MAX_REGIONS	16
 
@@ -63,9 +95,18 @@
 
 struct mpu_rgn {
 	/* Assume same attributes for d/i-side  */
-	u32 drbar;
-	u32 drsr;
-	u32 dracr;
+	union {
+		u32 drbar;   /* PMSAv7 */
+		u32 prbar;   /* PMSAv8 */
+	};
+	union {
+		u32 drsr;   /* PMSAv7 */
+		u32 prlar;  /* PMSAv8 */
+	};
+	union {
+		u32 dracr;  /* PMSAv7 */
+		u32 unused; /* not used in PMSAv8 */
+	};
 };
 
 struct mpu_rgn_info {
@@ -76,10 +117,15 @@ extern struct mpu_rgn_info mpu_rgn_info;
 
 #ifdef CONFIG_ARM_MPU
 extern void __init pmsav7_adjust_lowmem_bounds(void);
+extern void __init pmsav8_adjust_lowmem_bounds(void);
+
 extern void __init pmsav7_setup(void);
+extern void __init pmsav8_setup(void);
 #else
 static inline void pmsav7_adjust_lowmem_bounds(void) {};
+static inline void pmsav8_adjust_lowmem_bounds(void) {};
 static inline void pmsav7_setup(void) {};
+static inline void pmsav8_setup(void) {};
 #endif
 
 #endif /* __ASSEMBLY__ */
diff --git a/arch/arm/include/asm/v7m.h b/arch/arm/include/asm/v7m.h
index aba49e0..187ccf6 100644
--- a/arch/arm/include/asm/v7m.h
+++ b/arch/arm/include/asm/v7m.h
@@ -68,6 +68,14 @@
 #define PMSAv7_RBAR		0x9c
 #define PMSAv7_RASR		0xa0
 
+#define PMSAv8_RNR		0x98
+#define PMSAv8_RBAR		0x9c
+#define PMSAv8_RLAR		0xa0
+#define PMSAv8_RBAR_A(n)	(PMSAv8_RBAR + 8*(n))
+#define PMSAv8_RLAR_A(n)	(PMSAv8_RLAR + 8*(n))
+#define PMSAv8_MAIR0		0xc0
+#define PMSAv8_MAIR1		0xc4
+
 /* Cache opeartions */
 #define	V7M_SCB_ICIALLU		0x250	/* I-cache invalidate all to PoU */
 #define	V7M_SCB_ICIMVAU		0x258	/* I-cache invalidate by MVA to PoU */
diff --git a/arch/arm/kernel/asm-offsets.c b/arch/arm/kernel/asm-offsets.c
index 250a985..27c5381 100644
--- a/arch/arm/kernel/asm-offsets.c
+++ b/arch/arm/kernel/asm-offsets.c
@@ -197,6 +197,8 @@ int main(void)
   DEFINE(MPU_RGN_DRBAR,	offsetof(struct mpu_rgn, drbar));
   DEFINE(MPU_RGN_DRSR,	offsetof(struct mpu_rgn, drsr));
   DEFINE(MPU_RGN_DRACR,	offsetof(struct mpu_rgn, dracr));
+  DEFINE(MPU_RGN_PRBAR,	offsetof(struct mpu_rgn, prbar));
+  DEFINE(MPU_RGN_PRLAR,	offsetof(struct mpu_rgn, prlar));
 #endif
   return 0; 
 }
diff --git a/arch/arm/kernel/head-nommu.S b/arch/arm/kernel/head-nommu.S
index 482936a..cdc1177 100644
--- a/arch/arm/kernel/head-nommu.S
+++ b/arch/arm/kernel/head-nommu.S
@@ -132,6 +132,25 @@ M_CLASS(ldr	r3, [r12, 0x50])
 AR_CLASS(mrc	p15, 0, r3, c0, c1, 4)          @ Read ID_MMFR0
 	and	r3, r3, #(MMFR0_PMSA)           @ PMSA field
 	teq	r3, #(MMFR0_PMSAv7)             @ PMSA v7
+	beq	1f
+	teq	r3, #(MMFR0_PMSAv8)		@ PMSA v8
+	/*
+	 * Memory region attributes for PMSAv8:
+	 *
+	 *   n = AttrIndx[2:0]
+	 *                      n       MAIR
+	 *   DEVICE_nGnRnE      000     00000000
+	 *   NORMAL             001     11111111
+	 */
+	ldreq	r3, =PMSAv8_MAIR(0x00, PMSAv8_RGN_DEVICE_nGnRnE) | \
+		     PMSAv8_MAIR(0xff, PMSAv8_RGN_NORMAL)
+AR_CLASS(mcreq	p15, 0, r3, c10, c2, 0)		@ MAIR 0
+M_CLASS(streq	r3, [r12, #PMSAv8_MAIR0])
+	moveq	r3, #0
+AR_CLASS(mcreq	p15, 0, r3, c10, c2, 1)		@ MAIR 1
+M_CLASS(streq	r3, [r12, #PMSAv8_MAIR1])
+
+1:
 #endif
 #ifdef CONFIG_CPU_CP15
 	/*
@@ -235,6 +254,8 @@ M_CLASS(ldr	r0, [r12, 0x50])
 	and	r0, r0, #(MMFR0_PMSA)		@ PMSA field
 	teq	r0, #(MMFR0_PMSAv7)		@ PMSA v7
 	beq	__setup_pmsa_v7
+	teq	r0, #(MMFR0_PMSAv8)		@ PMSA v8
+	beq	__setup_pmsa_v8
 
 	ret	lr
 ENDPROC(__setup_mpu)
@@ -304,6 +325,88 @@ M_CLASS(ldr    r0, [r12, #MPU_TYPE])
 	ret	lr
 ENDPROC(__setup_pmsa_v7)
 
+ENTRY(__setup_pmsa_v8)
+	mov	r0, #0
+AR_CLASS(mcr	p15, 0, r0, c6, c2, 1)		@ PRSEL
+M_CLASS(str	r0, [r12, #PMSAv8_RNR])
+	isb
+
+#ifdef CONFIG_XIP_KERNEL
+	ldr	r5, =CONFIG_XIP_PHYS_ADDR		@ ROM start
+	ldr     r6, =(_exiprom)				@ ROM end
+	sub	r6, r6, #1
+	bic	r6, r6, #(PMSAv8_MINALIGN - 1)
+
+	orr	r5, r5, #(PMSAv8_AP_PL1RW_PL0NA | PMSAv8_RGN_SHARED)
+	orr	r6, r6, #(PMSAv8_LAR_IDX(PMSAv8_RGN_NORMAL) | PMSAv8_LAR_EN)
+
+AR_CLASS(mcr	p15, 0, r5, c6, c8, 0)			@ PRBAR0
+AR_CLASS(mcr	p15, 0, r6, c6, c8, 1)			@ PRLAR0
+M_CLASS(str	r5, [r12, #PMSAv8_RBAR_A(0)])
+M_CLASS(str	r6, [r12, #PMSAv8_RLAR_A(0)])
+#endif
+
+	ldr	r5, =KERNEL_START
+	ldr	r6, =KERNEL_END
+	sub	r6, r6, #1
+	bic	r6, r6, #(PMSAv8_MINALIGN - 1)
+
+	orr	r5, r5, #(PMSAv8_AP_PL1RW_PL0NA | PMSAv8_RGN_SHARED)
+	orr	r6, r6, #(PMSAv8_LAR_IDX(PMSAv8_RGN_NORMAL) | PMSAv8_LAR_EN)
+
+AR_CLASS(mcr	p15, 0, r5, c6, c8, 4)			@ PRBAR1
+AR_CLASS(mcr	p15, 0, r6, c6, c8, 5)			@ PRLAR1
+M_CLASS(str	r5, [r12, #PMSAv8_RBAR_A(1)])
+M_CLASS(str	r6, [r12, #PMSAv8_RLAR_A(1)])
+
+	/* Setup Background: 0x0 - min(KERNEL_START, XIP_PHYS_ADDR) */
+#ifdef CONFIG_XIP_KERNEL
+	ldr	r6, =KERNEL_START
+	ldr	r5, =CONFIG_XIP_PHYS_ADDR
+	cmp	r6, r5
+	movcs	r6, r5
+#else
+	ldr	r6, =KERNEL_START
+#endif
+	cmp	r6, #0
+	beq	1f
+
+	mov	r5, #0
+	sub	r6, r6, #1
+	bic	r6, r6, #(PMSAv8_MINALIGN - 1)
+
+	orr	r5, r5, #(PMSAv8_AP_PL1RW_PL0NA | PMSAv8_RGN_SHARED | PMSAv8_BAR_XN)
+	orr	r6, r6, #(PMSAv8_LAR_IDX(PMSAv8_RGN_DEVICE_nGnRnE) | PMSAv8_LAR_EN)
+
+AR_CLASS(mcr	p15, 0, r5, c6, c9, 0)			@ PRBAR2
+AR_CLASS(mcr	p15, 0, r6, c6, c9, 1)			@ PRLAR2
+M_CLASS(str	r5, [r12, #PMSAv8_RBAR_A(2)])
+M_CLASS(str	r6, [r12, #PMSAv8_RLAR_A(2)])
+
+1:
+	/* Setup Background: max(KERNEL_END, _exiprom) - 0xffffffff */
+#ifdef CONFIG_XIP_KERNEL
+	ldr	r5, =KERNEL_END
+	ldr	r6, =(_exiprom)
+	cmp	r5, r6
+	movcc	r5, r6
+#else
+	ldr	r5, =KERNEL_END
+#endif
+	mov	r6, #0xffffffff
+	bic	r6, r6, #(PMSAv8_MINALIGN - 1)
+
+	orr	r5, r5, #(PMSAv8_AP_PL1RW_PL0NA | PMSAv8_RGN_SHARED | PMSAv8_BAR_XN)
+	orr	r6, r6, #(PMSAv8_LAR_IDX(PMSAv8_RGN_DEVICE_nGnRnE) | PMSAv8_LAR_EN)
+
+AR_CLASS(mcr	p15, 0, r5, c6, c9, 4)			@ PRBAR3
+AR_CLASS(mcr	p15, 0, r6, c6, c9, 5)			@ PRLAR3
+M_CLASS(str	r5, [r12, #PMSAv8_RBAR_A(3)])
+M_CLASS(str	r6, [r12, #PMSAv8_RLAR_A(3)])
+
+	ret	lr
+ENDPROC(__setup_pmsa_v8)
+
 #ifdef CONFIG_SMP
 /*
  * r6: pointer@mpu_rgn_info
@@ -319,6 +422,8 @@ ENTRY(__secondary_setup_mpu)
 	and	r0, r0, #(MMFR0_PMSA)		@ PMSA field
 	teq	r0, #(MMFR0_PMSAv7)		@ PMSA v7
 	beq	__secondary_setup_pmsa_v7
+	teq	r0, #(MMFR0_PMSAv8)		@ PMSA v8
+	beq	__secondary_setup_pmsa_v8
  	b	__error_p
 ENDPROC(__secondary_setup_mpu)
 
@@ -361,6 +466,33 @@ ENTRY(__secondary_setup_pmsa_v7)
 	ret	lr
 ENDPROC(__secondary_setup_pmsa_v7)
 
+ENTRY(__secondary_setup_pmsa_v8)
+	ldr	r4, [r6, #MPU_RNG_INFO_USED]
+#ifndef CONFIG_XIP_KERNEL
+	add	r4, r4, #1
+#endif
+	mov	r5, #MPU_RNG_SIZE
+	add	r3, r6, #MPU_RNG_INFO_RNGS
+	mla	r3, r4, r5, r3
+
+1:
+	sub	r3, r3, #MPU_RNG_SIZE
+	sub	r4, r4, #1
+
+	mcr	p15, 0, r4, c6, c2, 1		@ PRSEL
+	isb
+
+	ldr	r5, [r3, #MPU_RGN_PRBAR]
+	ldr	r6, [r3, #MPU_RGN_PRLAR]
+
+	mcr	p15, 0, r5, c6, c3, 0		@ PRBAR
+	mcr	p15, 0, r6, c6, c3, 1           @ PRLAR
+
+	cmp	r4, #0
+	bgt	1b
+
+	ret	lr
+ENDPROC(__secondary_setup_pmsa_v8)
 #endif /* CONFIG_SMP */
 #endif /* CONFIG_ARM_MPU */
 #include "head-common.S"
diff --git a/arch/arm/mm/Makefile b/arch/arm/mm/Makefile
index 01bcc33..9a9741c 100644
--- a/arch/arm/mm/Makefile
+++ b/arch/arm/mm/Makefile
@@ -10,7 +10,7 @@ obj-$(CONFIG_MMU)		+= fault-armv.o flush.o idmap.o ioremap.o \
 
 ifneq ($(CONFIG_MMU),y)
 obj-y				+= nommu.o
-obj-$(CONFIG_ARM_MPU)		+= pmsa-v7.o
+obj-$(CONFIG_ARM_MPU)		+= pmsa-v7.o pmsa-v8.o
 endif
 
 obj-$(CONFIG_ARM_PTDUMP)	+= dump.o
diff --git a/arch/arm/mm/nommu.c b/arch/arm/mm/nommu.c
index 7534885..885b106 100644
--- a/arch/arm/mm/nommu.c
+++ b/arch/arm/mm/nommu.c
@@ -108,6 +108,9 @@ static void __init adjust_lowmem_bounds_mpu(void)
 	case MMFR0_PMSAv7:
 		pmsav7_adjust_lowmem_bounds();
 		break;
+	case MMFR0_PMSAv8:
+		pmsav8_adjust_lowmem_bounds();
+		break;
 	default:
 		break;
 	}
@@ -121,6 +124,9 @@ static void __init mpu_setup(void)
 	case MMFR0_PMSAv7:
 		pmsav7_setup();
 		break;
+	case MMFR0_PMSAv8:
+		pmsav8_setup();
+		break;
 	default:
 		break;
 	}
diff --git a/arch/arm/mm/pmsa-v8.c b/arch/arm/mm/pmsa-v8.c
new file mode 100644
index 0000000..64ae405
--- /dev/null
+++ b/arch/arm/mm/pmsa-v8.c
@@ -0,0 +1,307 @@
+/*
+ * Based on linux/arch/arm/pmsa-v7.c
+ *
+ * ARM PMSAv8 supporting functions.
+ */
+
+#include <linux/memblock.h>
+#include <linux/range.h>
+
+#include <asm/cp15.h>
+#include <asm/cputype.h>
+#include <asm/mpu.h>
+
+#include <asm/memory.h>
+#include <asm/sections.h>
+
+#include "mm.h"
+
+#ifndef CONFIG_CPU_V7M
+
+#define PRSEL	__ACCESS_CP15(c6, 0, c2, 1)
+#define PRBAR	__ACCESS_CP15(c6, 0, c3, 0)
+#define PRLAR	__ACCESS_CP15(c6, 0, c3, 1)
+
+static inline u32 prlar_read(void)
+{
+	return read_sysreg(PRLAR);
+}
+
+static inline u32 prbar_read(void)
+{
+	return read_sysreg(PRBAR);
+}
+
+static inline void prsel_write(u32 v)
+{
+	write_sysreg(v, PRSEL);
+}
+
+static inline void prbar_write(u32 v)
+{
+	write_sysreg(v, PRBAR);
+}
+
+static inline void prlar_write(u32 v)
+{
+	write_sysreg(v, PRLAR);
+}
+#else
+
+static inline u32 prlar_read(void)
+{
+	return readl_relaxed(BASEADDR_V7M_SCB + PMSAv8_RLAR);
+}
+
+static inline u32 prbar_read(void)
+{
+	return readl_relaxed(BASEADDR_V7M_SCB + PMSAv8_RBAR);
+}
+
+static inline void prsel_write(u32 v)
+{
+	writel_relaxed(v, BASEADDR_V7M_SCB + PMSAv8_RNR);
+}
+
+static inline void prbar_write(u32 v)
+{
+	writel_relaxed(v, BASEADDR_V7M_SCB + PMSAv8_RBAR);
+}
+
+static inline void prlar_write(u32 v)
+{
+	writel_relaxed(v, BASEADDR_V7M_SCB + PMSAv8_RLAR);
+}
+
+#endif
+
+static struct range __initdata io[MPU_MAX_REGIONS];
+static struct range __initdata mem[MPU_MAX_REGIONS];
+
+static unsigned int __initdata mpu_max_regions;
+
+static __init bool is_region_reserved(int number)
+{
+	switch (number) {
+	case PMSAv8_XIP_REGION:
+	case PMSAv8_KERNEL_REGION:
+		return true;
+	default:
+		return false;
+	}
+}
+
+void __init pmsav8_adjust_lowmem_bounds(void)
+{
+	phys_addr_t mem_end;
+	struct memblock_region *reg;
+	bool first = true;
+
+	for_each_memblock(memory, reg) {
+		if (first) {
+			phys_addr_t phys_offset = PHYS_OFFSET;
+
+			/*
+			 * Initially only use memory continuous from
+			 * PHYS_OFFSET */
+			if (reg->base != phys_offset)
+				panic("First memory bank must be contiguous from PHYS_OFFSET");
+			mem_end = reg->base + reg->size;
+			first = false;
+		} else {
+			/*
+			 * memblock auto merges contiguous blocks, remove
+			 * all blocks afterwards in one go (we can't remove
+			 * blocks separately while iterating)
+			 */
+			pr_notice("Ignoring RAM after %pa, memory at %pa ignored\n",
+				  &mem_end, &reg->base);
+			memblock_remove(reg->base, 0 - reg->base);
+			break;
+		}
+	}
+}
+
+static int __init __mpu_max_regions(void)
+{
+	static int max_regions;
+	u32 mpuir;
+
+	if (max_regions)
+		return max_regions;
+
+	mpuir = read_cpuid_mputype();
+
+	max_regions  = (mpuir & MPUIR_DREGION_SZMASK) >> MPUIR_DREGION;
+
+	return max_regions;
+}
+
+static int __init __pmsav8_setup_region(unsigned int number, u32 bar, u32 lar)
+{
+	if (number > mpu_max_regions
+	    || number >= MPU_MAX_REGIONS)
+		return -ENOENT;
+
+	dsb();
+	prsel_write(number);
+	isb();
+	prbar_write(bar);
+	prlar_write(lar);
+
+	mpu_rgn_info.rgns[number].prbar = bar;
+	mpu_rgn_info.rgns[number].prlar = lar;
+
+	mpu_rgn_info.used++;
+
+	return 0;
+}
+
+static int __init pmsav8_setup_ram(unsigned int number, phys_addr_t start,phys_addr_t end)
+{
+	u32 bar, lar;
+
+	if (is_region_reserved(number))
+		return -EINVAL;
+
+	bar = start;
+	lar = (end - 1) & ~(PMSAv8_MINALIGN - 1);;
+
+	bar |= PMSAv8_AP_PL1RW_PL0RW | PMSAv8_RGN_SHARED;
+	lar |= PMSAv8_LAR_IDX(PMSAv8_RGN_NORMAL) | PMSAv8_LAR_EN;
+
+	return __pmsav8_setup_region(number, bar, lar);
+}
+
+static int __init pmsav8_setup_io(unsigned int number, phys_addr_t start,phys_addr_t end)
+{
+	u32 bar, lar;
+
+	if (is_region_reserved(number))
+		return -EINVAL;
+
+	bar = start;
+	lar = (end - 1) & ~(PMSAv8_MINALIGN - 1);;
+
+	bar |= PMSAv8_AP_PL1RW_PL0RW | PMSAv8_RGN_SHARED | PMSAv8_BAR_XN;
+	lar |= PMSAv8_LAR_IDX(PMSAv8_RGN_DEVICE_nGnRnE) | PMSAv8_LAR_EN;
+
+	return __pmsav8_setup_region(number, bar, lar);
+}
+
+static int __init pmsav8_setup_reserved(unsigned int number, phys_addr_t start,phys_addr_t end)
+{
+	u32 bar, lar;
+
+	if (!is_region_reserved(number))
+		return -EINVAL;
+
+	bar = start;
+	lar = (end - 1) & ~(PMSAv8_MINALIGN - 1);
+
+	bar |= PMSAv8_AP_PL1RW_PL0NA | PMSAv8_RGN_SHARED;
+	lar |= PMSAv8_LAR_IDX(PMSAv8_RGN_NORMAL) | PMSAv8_LAR_EN;
+
+	prsel_write(number);
+	isb();
+
+	if (prbar_read() != bar || prlar_read() != lar)
+		return -EINVAL;
+
+	/* Reserved region was set up early, we just need a record for secondaries */
+	mpu_rgn_info.rgns[number].prbar = bar;
+	mpu_rgn_info.rgns[number].prlar = lar;
+
+	mpu_rgn_info.used++;
+
+	return 0;
+}
+
+#ifndef CONFIG_CPU_V7M
+static int __init pmsav8_setup_vector(unsigned int number, phys_addr_t start,phys_addr_t end)
+{
+	u32 bar, lar;
+
+	if (number == PMSAv8_KERNEL_REGION)
+		return -EINVAL;
+
+	bar = start;
+	lar = (end - 1) & ~(PMSAv8_MINALIGN - 1);
+
+	bar |= PMSAv8_AP_PL1RW_PL0NA | PMSAv8_RGN_SHARED;
+	lar |= PMSAv8_LAR_IDX(PMSAv8_RGN_NORMAL) | PMSAv8_LAR_EN;
+
+	return __pmsav8_setup_region(number, bar, lar);
+}
+#endif
+
+void __init pmsav8_setup(void)
+{
+	int i, err = 0;
+	int region = PMSAv8_KERNEL_REGION;
+
+	/* How many regions are supported ? */
+	mpu_max_regions = __mpu_max_regions();
+
+	/* RAM: single chunk of memory */
+	add_range(mem,  ARRAY_SIZE(mem), 0,  memblock.memory.regions[0].base,
+		  memblock.memory.regions[0].base + memblock.memory.regions[0].size);
+
+	/* IO: cover full 4G range */
+	add_range(io, ARRAY_SIZE(io), 0, 0, 0xffffffff);
+
+	/* RAM and IO: exclude kernel */
+	subtract_range(mem, ARRAY_SIZE(mem), __pa(KERNEL_START), __pa(KERNEL_END));
+	subtract_range(io, ARRAY_SIZE(io),  __pa(KERNEL_START), __pa(KERNEL_END));
+
+#ifdef CONFIG_XIP_KERNEL
+	/* RAM and IO: exclude xip */
+	subtract_range(mem, ARRAY_SIZE(mem), CONFIG_XIP_PHYS_ADDR, __pa(_exiprom));
+	subtract_range(io, ARRAY_SIZE(io), CONFIG_XIP_PHYS_ADDR, __pa(_exiprom));
+#endif
+
+#ifndef CONFIG_CPU_V7M
+	/* RAM and IO: exclude vectors */
+	subtract_range(mem, ARRAY_SIZE(mem),  vectors_base, vectors_base + 2 * PAGE_SIZE);
+	subtract_range(io, ARRAY_SIZE(io),  vectors_base, vectors_base + 2 * PAGE_SIZE);
+#endif
+	/* IO: exclude RAM */
+	for (i = 0; i < ARRAY_SIZE(mem); i++)
+		subtract_range(io, ARRAY_SIZE(io), mem[i].start, mem[i].end);
+
+	/* Now program MPU */
+
+#ifdef CONFIG_XIP_KERNEL
+	/* ROM */
+	err |= pmsav8_setup_reserved(PMSAv8_XIP_REGION, CONFIG_XIP_PHYS_ADDR, __pa(_exiprom));
+#endif
+	/* Kernel */
+	err |= pmsav8_setup_reserved(region++, __pa(KERNEL_START), __pa(KERNEL_END));
+
+
+	/* IO */
+	for (i = 0; i < ARRAY_SIZE(io); i++) {
+		if (!io[i].end)
+			continue;
+
+		err |= pmsav8_setup_io(region++, io[i].start, io[i].end);
+	}
+
+	/* RAM */
+	for (i = 0; i < ARRAY_SIZE(mem); i++) {
+		if (!mem[i].end)
+			continue;
+
+		err |= pmsav8_setup_ram(region++, mem[i].start, mem[i].end);
+	}
+
+	/* Vectors */
+#ifndef CONFIG_CPU_V7M
+	err |= pmsav8_setup_vector(region++, vectors_base, vectors_base + 2 * PAGE_SIZE);
+#endif
+	if (err)
+		pr_warn("MPU region initialization failure! %d", err);
+	else
+		pr_info("Using ARM PMSAv8 Compliant MPU. Used %d of %d regions\n",
+			mpu_rgn_info.used, mpu_max_regions);
+}
-- 
2.0.0
