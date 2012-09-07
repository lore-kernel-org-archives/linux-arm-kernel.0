From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri,  7 Sep 2012 17:55:29 +0100
Subject: [PATCH v2 2/7] ARM: virt: allow the kernel to be entered in HYP mode
In-Reply-To: <1347036934-8519-1-git-send-email-marc.zyngier@arm.com>
References: <1347036934-8519-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1347036934-8519-3-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dave Martin <dave.martin@linaro.org>

This patch does two things:

  * Ensure that asynchronous aborts are masked at kernel entry.
    The bootloader should be masking these anyway, but this reduces
    the damage window just in case it doesn't.

  * Enter svc mode via exception return to ensure that CPU state is
    properly serialised.  This does not matter when switching from
    an ordinary privileged mode ("PL1" modes in ARMv7-AR rev C
    parlance), but it potentially does matter when switching from a
    another privileged mode such as hyp mode.

This should allow the kernel to boot safely either from svc mode or
hyp mode, even if no support for use of the ARM Virtualization
Extensions is built into the kernel.

Signed-off-by: Dave Martin <dave.martin@linaro.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/include/asm/assembler.h |  28 ++++++
 arch/arm/include/asm/ptrace.h    |   1 +
 arch/arm/include/asm/virt.h      |  52 +++++++++++
 arch/arm/kernel/Makefile         |   2 +
 arch/arm/kernel/head.S           |  14 ++-
 arch/arm/kernel/hyp-stub.S       | 192 +++++++++++++++++++++++++++++++++++++++
 6 files changed, 286 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm/include/asm/virt.h
 create mode 100644 arch/arm/kernel/hyp-stub.S

diff --git a/arch/arm/include/asm/assembler.h b/arch/arm/include/asm/assembler.h
index 03fb936..658a15d 100644
--- a/arch/arm/include/asm/assembler.h
+++ b/arch/arm/include/asm/assembler.h
@@ -22,6 +22,7 @@
 
 #include <asm/ptrace.h>
 #include <asm/domain.h>
+#include <asm/opcodes-virt.h>
 
 #define IOMEM(x)	(x)
 
@@ -240,6 +241,33 @@
 #endif
 
 /*
+ * Helper macro to enter SVC mode cleanly and mask interrupts. reg is
+ * a scratch register for the macro to overwrite.
+ *
+ * This macro is intended for forcing the CPU into SVC mode at boot time.
+ * you cannot return to the original mode.
+ *
+ * Beware, it also clobers LR.
+ */
+.macro safe_svcmode_maskall reg:req
+	mrs	\reg , cpsr
+	mov	lr , \reg
+	and	lr , lr , #MODE_MASK
+	cmp	lr , #HYP_MODE
+	orr	\reg , \reg , #PSR_A_BIT | PSR_I_BIT | PSR_F_BIT
+	bic	\reg , \reg , #MODE_MASK
+	orr	\reg , \reg , #SVC_MODE
+THUMB(	orr	\reg , \reg , #PSR_T_BIT	)
+	msr	spsr_cxsf, \reg
+	adr	lr, BSYM(2f)
+	bne	1f
+	__MSR_ELR_HYP(14)
+	__ERET
+1:	movs	pc, lr
+2:
+.endm
+
+/*
  * STRT/LDRT access macros with ARM and Thumb-2 variants
  */
 #ifdef CONFIG_THUMB2_KERNEL
diff --git a/arch/arm/include/asm/ptrace.h b/arch/arm/include/asm/ptrace.h
index 355ece5..91ef6c2 100644
--- a/arch/arm/include/asm/ptrace.h
+++ b/arch/arm/include/asm/ptrace.h
@@ -44,6 +44,7 @@
 #define IRQ_MODE	0x00000012
 #define SVC_MODE	0x00000013
 #define ABT_MODE	0x00000017
+#define HYP_MODE	0x0000001a
 #define UND_MODE	0x0000001b
 #define SYSTEM_MODE	0x0000001f
 #define MODE32_BIT	0x00000010
diff --git a/arch/arm/include/asm/virt.h b/arch/arm/include/asm/virt.h
new file mode 100644
index 0000000..0a99723
--- /dev/null
+++ b/arch/arm/include/asm/virt.h
@@ -0,0 +1,52 @@
+/*
+ * Copyright (c) 2012 Linaro Limited.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+
+#ifndef VIRT_H
+#define VIRT_H
+
+#include <asm/ptrace.h>
+
+/*
+ * Flag indicating that the kernel was not entered in the same mode on every
+ * CPU.  The zImage loader stashes this value in an SPSR, so we need an
+ * architecturally defined flag bit here (the N flag, as it happens)
+ */
+#define BOOT_CPU_MODE_MISMATCH (1<<31)
+
+#ifndef __ASSEMBLY__
+
+#ifdef CONFIG_ARM_VIRT_EXT
+/*
+ * __boot_cpu_mode records what mode the primary CPU was booted in.
+ * A correctly-implemented bootloader must start all CPUs in the same mode:
+ * if it fails to do this, the flag BOOT_CPU_MODE_MISMATCH is set to indicate
+ * that some CPU(s) were booted in a different mode.
+ *
+ * This allows the kernel to flag an error when the secondaries have come up.
+ */
+extern int __boot_cpu_mode;
+
+void __hyp_set_vectors(unsigned long phys_vector_base);
+unsigned long __hyp_get_vectors(void);
+#else
+#define __boot_cpu_mode	(SVC_MODE)
+#endif
+
+#endif /* __ASSEMBLY__ */
+
+#endif /* ! VIRT_H */
diff --git a/arch/arm/kernel/Makefile b/arch/arm/kernel/Makefile
index 7ad2d5c..49b61a3 100644
--- a/arch/arm/kernel/Makefile
+++ b/arch/arm/kernel/Makefile
@@ -82,4 +82,6 @@ head-y			:= head$(MMUEXT).o
 obj-$(CONFIG_DEBUG_LL)	+= debug.o
 obj-$(CONFIG_EARLY_PRINTK)	+= early_printk.o
 
+obj-$(CONFIG_ARM_VIRT_EXT)	+= hyp-stub.o
+
 extra-y := $(head-y) vmlinux.lds
diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
index 3db960e..27093e4 100644
--- a/arch/arm/kernel/head.S
+++ b/arch/arm/kernel/head.S
@@ -83,8 +83,12 @@ ENTRY(stext)
  THUMB(	.thumb			)	@ switch to Thumb now.
  THUMB(1:			)
 
-	setmode	PSR_F_BIT | PSR_I_BIT | SVC_MODE, r9 @ ensure svc mode
-						@ and irqs disabled
+#ifdef CONFIG_ARM_VIRT_EXT
+	bl	__hyp_stub_install
+#endif
+	@ ensure svc mode and all interrupts masked
+	safe_svcmode_maskall r9
+
 	mrc	p15, 0, r9, c0, c0		@ get processor id
 	bl	__lookup_processor_type		@ r5=procinfo r9=cpuid
 	movs	r10, r5				@ invalid processor (r5=0)?
@@ -326,7 +330,11 @@ ENTRY(secondary_startup)
 	 * the processor type - there is no need to check the machine type
 	 * as it has already been validated by the primary processor.
 	 */
-	setmode	PSR_F_BIT | PSR_I_BIT | SVC_MODE, r9
+#ifdef CONFIG_ARM_VIRT_EXT
+	bl	__hyp_stub_install
+#endif
+	safe_svcmode_maskall r9
+
 	mrc	p15, 0, r9, c0, c0		@ get processor id
 	bl	__lookup_processor_type
 	movs	r10, r5				@ invalid processor?
diff --git a/arch/arm/kernel/hyp-stub.S b/arch/arm/kernel/hyp-stub.S
new file mode 100644
index 0000000..b03e924
--- /dev/null
+++ b/arch/arm/kernel/hyp-stub.S
@@ -0,0 +1,192 @@
+/*
+ * Copyright (c) 2012 Linaro Limited.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+
+#include <linux/init.h>
+#include <linux/linkage.h>
+#include <asm/assembler.h>
+#include <asm/virt.h>
+
+/*
+ * For the kernel proper, we need to find out the CPU boot mode long after
+ * boot, so we need to store it in a writable variable.
+ *
+ * This is not in .bss, because we set it sufficiently early that the boot-time
+ * zeroing of .bss would clobber it.
+ */
+.data
+ENTRY(__boot_cpu_mode)
+	.long	0
+.text
+
+	/*
+	 * Save the primary CPU boot mode. Requires 3 scratch registers.
+	 */
+	.macro	store_primary_cpu_mode	reg1, reg2, reg3
+	mrs	\reg1, cpsr
+	and	\reg1, \reg1, #MODE_MASK
+	adr	\reg2, .L__boot_cpu_mode_offset
+	ldr	\reg3, [\reg2]
+	str	\reg1, [\reg2, \reg3]
+	.endm
+
+	/*
+	 * Compare the current mode with the one saved on the primary CPU.
+	 * If they don't match, record that fact. The Z bit indicates
+	 * if there's a match or not.
+	 * Requires 3 additionnal scratch registers.
+	 */
+	.macro	compare_cpu_mode_with_primary mode, reg1, reg2, reg3
+	adr	\reg2, .L__boot_cpu_mode_offset
+	ldr	\reg3, [\reg2]
+	ldr	\reg1, [\reg2, \reg3]
+	cmp	\mode, \reg1		@ matches primary CPU boot mode?
+	orrne	r7, r7, #BOOT_CPU_MODE_MISMATCH
+	strne	r7, [r5, r6]		@ record what happened and give up
+	.endm
+
+/*
+ * Hypervisor stub installation functions.
+ *
+ * These must be called with the MMU and D-cache off.
+ * They are not ABI compliant and are only intended to be called from the kernel
+ * entry points in head.S.
+ */
+@ Call this from the primary CPU
+ENTRY(__hyp_stub_install)
+	store_primary_cpu_mode	r4, r5, r6
+ENDPROC(__hyp_stub_install)
+
+	@ fall through...
+
+@ Secondary CPUs should call here
+ENTRY(__hyp_stub_install_secondary)
+	mrs	r4, cpsr
+	and	r4, r4, #MODE_MASK
+
+	/*
+	 * If the secondary has booted with a different mode, give up
+	 * immediately.
+	 */
+	compare_cpu_mode_with_primary	r4, r5, r6, r7
+	bxne	lr
+
+	/*
+	 * Once we have given up on one CPU, we do not try to install the
+	 * stub hypervisor on the remaining ones: because the saved boot mode
+	 * is modified, it can't compare equal to the CPSR mode field any
+	 * more.
+	 *
+	 * Otherwise...
+	 */
+
+	cmp	r4, #HYP_MODE
+	bxne	lr			@ give up if the CPU is not in HYP mode
+
+/*
+ * Configure HSCTLR to set correct exception endianness/instruction set
+ * state etc.
+ * Turn off all traps
+ * Eventually, CPU-specific code might be needed -- assume not for now
+ *
+ * This code relies on the "eret" instruction to synchronize the
+ * various coprocessor accesses.
+ */
+	@ Now install the hypervisor stub:
+	adr	r7, __hyp_stub_vectors
+	mcr	p15, 4, r7, c12, c0, 0	@ set hypervisor vector base (HVBAR)
+
+	@ Disable all traps, so we don't get any nasty surprise
+	mov	r7, #0
+	mcr	p15, 4, r7, c1, c1, 0	@ HCR
+	mcr	p15, 4, r7, c1, c1, 2	@ HCPTR
+	mcr	p15, 4, r7, c1, c1, 3	@ HSTR
+
+THUMB(	orr	r7, #(1 << 30)	)	@ HSCTLR.TE
+#ifdef CONFIG_CPU_BIG_ENDIAN
+	orr	r7, #(1 << 9)		@ HSCTLR.EE
+#endif
+	mcr	p15, 4, r7, c1, c0, 0	@ HSCTLR
+
+	mrc	p15, 4, r7, c1, c1, 1	@ HDCR
+	and	r7, #0x1f		@ Preserve HPMN
+	mcr	p15, 4, r7, c1, c1, 1	@ HDCR
+
+	bic	r7, r4, #MODE_MASK
+	orr	r7, r7, #SVC_MODE
+THUMB(	orr	r7, r7, #PSR_T_BIT	)
+	msr	spsr_cxsf, r7		@ This is SPSR_hyp.
+
+	__MSR_ELR_HYP(14)		@ msr elr_hyp, lr
+	__ERET				@ return, switching to SVC mode
+					@ The boot CPU mode is left in r4.
+ENDPROC(__hyp_stub_install_secondary)
+
+__hyp_stub_do_trap:
+	cmp	r0, #-1
+	mrceq	p15, 4, r0, c12, c0, 0	@ get HVBAR
+	mcrne	p15, 4, r0, c12, c0, 0	@ set HVBAR
+	__ERET
+ENDPROC(__hyp_stub_do_trap)
+
+/*
+ * __hyp_set_vectors: Call this after boot to set the initial hypervisor
+ * vectors as part of hypervisor installation.  On an SMP system, this should
+ * be called on each CPU.
+ *
+ * r0 must be the physical address of the new vector table (which must lie in
+ * the bottom 4GB of physical address space.
+ *
+ * r0 must be 32-byte aligned.
+ *
+ * Before calling this, you must check that the stub hypervisor is installed
+ * everywhere, by waiting for any secondary CPUs to be brought up and then
+ * checking that BOOT_CPU_MODE_HAVE_HYP(__boot_cpu_mode) is true.
+ *
+ * If not, there is a pre-existing hypervisor, some CPUs failed to boot, or
+ * something else went wrong... in such cases, trying to install a new
+ * hypervisor is unlikely to work as desired.
+ *
+ * When you call into your shiny new hypervisor, sp_hyp will contain junk,
+ * so you will need to set that to something sensible@the new hypervisor's
+ * initialisation entry point.
+ */
+ENTRY(__hyp_get_vectors)
+	mov	r0, #-1
+ENDPROC(__hyp_get_vectors)
+	@ fall through
+ENTRY(__hyp_set_vectors)
+	__HVC(0)
+	bx	lr
+ENDPROC(__hyp_set_vectors)
+
+.align 2
+.L__boot_cpu_mode_offset:
+	.long	__boot_cpu_mode - .
+
+.align 5
+__hyp_stub_vectors:
+__hyp_stub_reset:	W(b)	.
+__hyp_stub_und:		W(b)	.
+__hyp_stub_svc:		W(b)	.
+__hyp_stub_pabort:	W(b)	.
+__hyp_stub_dabort:	W(b)	.
+__hyp_stub_trap:	W(b)	__hyp_stub_do_trap
+__hyp_stub_irq:		W(b)	.
+__hyp_stub_fiq:		W(b)	.
+ENDPROC(__hyp_stub_vectors)
+
-- 
1.7.12
