From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 23 Sep 2015 15:24:10 +0100
Subject: [PATCH 4/4] arm: Implement privileged no-access using TTBR0 page
 table walks disabling
In-Reply-To: <1443018250-22893-1-git-send-email-catalin.marinas@arm.com>
References: <1443018250-22893-1-git-send-email-catalin.marinas@arm.com>
Message-ID: <1443018250-22893-5-git-send-email-catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With LPAE enabled, privileged no-access cannot be enforced using CPU
domains as such feature is not available. This patch implements PAN
by disabling TTBR0 page table walks while in kernel mode.

The ARM architecture allows page table walks to be split between TTBR0
and TTBR1. With LPAE enabled, the split is defined by a combination of
TTBCR T0SZ and T1SZ bits. Currently, an LPAE-enabled kernel uses TTBR0
for user addresses and TTBR1 for kernel addresses with the VMSPLIT_2G
and VMSPLIT_3G configurations. The main advantage for the 3:1 split is
that TTBR1 is reduced to 2 levels, so potentially faster TLB refill
(though usually the first level entries are already cached in the TLB).

The PAN support on LPAE-enabled kernels uses TTBR0 when running in user
space or in kernel space during user access routines (TTBCR T0SZ and
T1SZ are both 0). When running user accesses are disabled in kernel
mode, TTBR0 page table walks are disabled by setting TTBCR.EPD0. TTBR1
is used for kernel accesses (including loadable modules; anything
covered by swapper_pg_dir) by reducing the TTBCR.T0SZ to the minimum
(2^(32-7) = 32MB). To avoid user accesses potentially hitting stale TLB
entries, the ASID is switched to 0 (reserved) by setting TTBCR.A1 and
using the ASID value in TTBR1. The difference from a non-PAN kernel is
that with the 3:1 memory split, TTBR1 always uses 3 levels of page
tables.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm/Kconfig                            | 22 ++++++++++++---
 arch/arm/include/asm/assembler.h            | 42 +++++++++++++++++++++++++++++
 arch/arm/include/asm/pgtable-3level-hwdef.h |  9 +++++++
 arch/arm/include/asm/uaccess.h              | 34 ++++++++++++++++++++---
 arch/arm/lib/csumpartialcopyuser.S          | 14 ++++++++++
 arch/arm/mm/fault.c                         | 10 +++++++
 6 files changed, 124 insertions(+), 7 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 72ad724c67ae..bcfe80c1036a 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1704,9 +1704,9 @@ config HIGHPTE
 	  consumed by page tables.  Setting this option will allow
 	  user-space 2nd level page tables to reside in high memory.
 
-config CPU_SW_DOMAIN_PAN
-	bool "Enable use of CPU domains to implement privileged no-access"
-	depends on MMU && !ARM_LPAE
+config ARM_PAN
+	bool "Enable privileged no-access"
+	depends on MMU
 	default y
 	help
 	  Increase kernel security by ensuring that normal kernel accesses
@@ -1715,10 +1715,26 @@ config CPU_SW_DOMAIN_PAN
 	  by ensuring that magic values (such as LIST_POISON) will always
 	  fault when dereferenced.
 
+	  The implementation uses CPU domains when !CONFIG_ARM_LPAE and
+	  disabling of TTBR0 page table walks with CONFIG_ARM_LPAE.
+
+config CPU_SW_DOMAIN_PAN
+	def_bool y
+	depends on ARM_PAN && !ARM_LPAE
+	help
+	  Enable use of CPU domains to implement privileged no-access.
+
 	  CPUs with low-vector mappings use a best-efforts implementation.
 	  Their lower 1MB needs to remain accessible for the vectors, but
 	  the remainder of userspace will become appropriately inaccessible.
 
+config CPU_TTBR0_PAN
+	def_bool y
+	depends on ARM_PAN && ARM_LPAE
+	help
+	  Enable privileged no-access by disabling TTBR0 page table walks when
+	  running in kernel mode.
+
 config HW_PERF_EVENTS
 	def_bool y
 	depends on ARM_PMU
diff --git a/arch/arm/include/asm/assembler.h b/arch/arm/include/asm/assembler.h
index 26b4c697c857..8dccd8916172 100644
--- a/arch/arm/include/asm/assembler.h
+++ b/arch/arm/include/asm/assembler.h
@@ -25,6 +25,7 @@
 #include <asm/opcodes-virt.h>
 #include <asm/asm-offsets.h>
 #include <asm/page.h>
+#include <asm/pgtable.h>
 #include <asm/thread_info.h>
 
 #define IOMEM(x)	(x)
@@ -485,6 +486,47 @@ THUMB(	orr	\reg , \reg , #PSR_T_BIT	)
 	mcr	p15, 0, r0, c3, c0, 0
 	.endm
 
+#elif defined(CONFIG_CPU_TTBR0_PAN)
+
+	.macro	uaccess_disable, tmp, isb=1
+	/*
+	 * Disable TTBR0 page table walks (EDP0 = 1), use the reserved ASID
+	 * from TTBR1 (A1 = 1) and enable TTBR1 page table walks for kernel
+	 * addresses by reducing TTBR0 range to 32MB (T0SZ = 7).
+	 */
+	mrc	p15, 0, \tmp, c2, c0, 2
+	orr	\tmp, \tmp, #TTBCR_EPD0 | TTBCR_T0SZ_MASK
+	orr	\tmp, \tmp, #TTBCR_A1
+	mcr	p15, 0, \tmp, c2, c0, 2
+	.if	\isb
+	instr_sync
+	.endif
+	.endm
+
+	.macro	uaccess_enable, tmp, isb=1
+	/*
+	 * Enable TTBR0 page table walks (T0SZ = 0, EDP0 = 0) and ASID from
+	 * TTBR0 (A1 = 0).
+	 */
+	mrc	p15, 0, \tmp, c2, c0, 2
+	bic	\tmp, \tmp, #TTBCR_EPD0 | TTBCR_T0SZ_MASK
+	bic	\tmp, \tmp, #TTBCR_A1
+	mcr	p15, 0, \tmp, c2, c0, 2
+	.if	\isb
+	instr_sync
+	.endif
+	.endm
+
+	.macro	uaccess_save, tmp
+	mrc	p15, 0, \tmp, c2, c0, 2
+	str	\tmp, [sp, #S_FRAME_SIZE]
+	.endm
+
+	.macro	uaccess_restore
+	ldr	r0, [sp, #S_FRAME_SIZE]
+	mcr	p15, 0, r0, c2, c0, 2
+	.endm
+
 #else
 
 	.macro	uaccess_disable, tmp, isb=1
diff --git a/arch/arm/include/asm/pgtable-3level-hwdef.h b/arch/arm/include/asm/pgtable-3level-hwdef.h
index 3ed7965106e3..92fee5f79e0f 100644
--- a/arch/arm/include/asm/pgtable-3level-hwdef.h
+++ b/arch/arm/include/asm/pgtable-3level-hwdef.h
@@ -85,6 +85,7 @@
 #define PHYS_MASK_SHIFT		(40)
 #define PHYS_MASK		((1ULL << PHYS_MASK_SHIFT) - 1)
 
+#ifndef CONFIG_CPU_TTBR0_PAN
 /*
  * TTBR0/TTBR1 split (PAGE_OFFSET):
  *   0x40000000: T0SZ = 2, T1SZ = 0 (not used)
@@ -104,6 +105,14 @@
 #endif
 
 #define TTBR1_SIZE	(((PAGE_OFFSET >> 30) - 1) << 16)
+#else
+/*
+ * With CONFIG_CPU_TTBR0_PAN enabled, TTBR1 is only used during uaccess
+ * disabled regions when TTBR0 is disabled.
+ */
+#define TTBR1_OFFSET	0			/* pointing to swapper_pg_dir */
+#define TTBR1_SIZE	0			/* TTBR1 size controlled via TTBCR.T0SZ */
+#endif
 
 /*
  * TTBCR register bits.
diff --git a/arch/arm/include/asm/uaccess.h b/arch/arm/include/asm/uaccess.h
index 711c9877787b..bbc4e97c1951 100644
--- a/arch/arm/include/asm/uaccess.h
+++ b/arch/arm/include/asm/uaccess.h
@@ -16,6 +16,8 @@
 #include <asm/errno.h>
 #include <asm/memory.h>
 #include <asm/domain.h>
+#include <asm/pgtable.h>
+#include <asm/proc-fns.h>
 #include <asm/unified.h>
 #include <asm/compiler.h>
 
@@ -74,21 +76,45 @@ static inline void uaccess_restore(unsigned int flags)
 	set_domain(flags);
 }
 
-
-#else
+#elif defined(CONFIG_CPU_TTBR0_PAN)
 
 static inline unsigned int uaccess_save_and_enable(void)
 {
-	return 0;
+	unsigned int old_ttbcr = cpu_get_ttbcr();
+
+	/*
+	 * Enable TTBR0 page table walks (T0SZ = 0, EDP0 = 0) and ASID from
+	 * TTBR0 (A1 = 0).
+	 */
+	cpu_set_ttbcr(old_ttbcr & ~(TTBCR_A1 | TTBCR_EPD0 | TTBCR_T0SZ_MASK));
+	isb();
+
+	return old_ttbcr;
 }
 
 static inline void uaccess_restore(unsigned int flags)
 {
+	cpu_set_ttbcr(flags);
+	isb();
 }
 
 static inline bool uaccess_disabled(struct pt_regs *regs)
 {
-	return false;
+	/* uaccess state saved above pt_regs on SVC exception entry */
+	unsigned int ttbcr = *(unsigned int *)(regs + 1);
+
+	return ttbcr & TTBCR_EPD0;
+}
+
+#else
+
+static inline unsigned int uaccess_save_and_enable(void)
+{
+	return 0;
+}
+
+static inline void uaccess_restore(unsigned int flags)
+{
 }
 
 #endif
diff --git a/arch/arm/lib/csumpartialcopyuser.S b/arch/arm/lib/csumpartialcopyuser.S
index d50fe3c07615..4ef2515f051a 100644
--- a/arch/arm/lib/csumpartialcopyuser.S
+++ b/arch/arm/lib/csumpartialcopyuser.S
@@ -31,6 +31,20 @@
 		ret	lr
 		.endm
 
+#elif defined(CONFIG_CPU_TTBR0_PAN)
+
+		.macro	save_regs
+		mrc	p15, 0, ip, c2, c0, 2
+		stmfd	sp!, {r1, r2, r4 - r8, ip, lr}
+		uaccess_enable ip
+		.endm
+
+		.macro	load_regs
+		ldmfd	sp!, {r1, r2, r4 - r8, ip, lr}
+		mcr	p15, 0, ip, c2, c0, 2
+		ret	lr
+		.endm
+
 #else
 
 		.macro	save_regs
diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index 0d629b8f973f..a16de0635de2 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -284,6 +284,16 @@ do_page_fault(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 	if (fsr & FSR_WRITE)
 		flags |= FAULT_FLAG_WRITE;
 
+#ifdef CONFIG_CPU_TTBR0_PAN
+	/*
+	 * Privileged access aborts with CONFIG_CPU_TTBR0_PAN enabled are
+	 * routed via the translation fault mechanism. Check whether uaccess
+	 * is disabled while in kernel mode.
+	 */
+	if (!user_mode(regs) && uaccess_disabled(regs))
+		goto no_context;
+#endif
+
 	/*
 	 * As per x86, we may deadlock here.  However, since the kernel only
 	 * validly references user space from well defined areas of the code,
