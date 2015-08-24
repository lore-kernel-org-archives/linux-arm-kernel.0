From: cov@codeaurora.org (Christopher Covington)
Date: Mon, 24 Aug 2015 09:55:26 -0400
Subject: [PATCH] arm: Handle starting up in secure mode
Message-ID: <1440424572-27116-1-git-send-email-cov@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM Linux appears to have never been made aware of the ARMv7 security
extensions. When CONFIG_ARM_SEC_EXT=y, have it probe for its security
state by checking whether CNTFRQ is writeable and potentially make
mode changes based on the information. The most features are available
from hypervisor (HYP) mode, so switch to it possible. Failing that,
prefer non-secure supervisor (SVC) mode to secure supervisor mode.

Signed-off-by: Christopher Covington <cov@codeaurora.org>
---
 arch/arm/include/asm/sec.h         |  27 +++++++
 arch/arm/include/uapi/asm/ptrace.h |   1 +
 arch/arm/kernel/Makefile           |   1 +
 arch/arm/kernel/head.S             |   3 +
 arch/arm/kernel/mon-stub.S         | 158 +++++++++++++++++++++++++++++++++++++
 arch/arm/mm/Kconfig                |  20 ++++-
 6 files changed, 206 insertions(+), 4 deletions(-)
 create mode 100644 arch/arm/include/asm/sec.h
 create mode 100644 arch/arm/kernel/mon-stub.S

diff --git a/arch/arm/include/asm/sec.h b/arch/arm/include/asm/sec.h
new file mode 100644
index 0000000..4a9a573
--- /dev/null
+++ b/arch/arm/include/asm/sec.h
@@ -0,0 +1,27 @@
+/*
+ * Copyright (c) 2014, The Linux Foundation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 and
+ * only version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef SEC_H
+#define SEC_H
+
+#ifndef __ASSEMBLY__
+
+#ifdef CONFIG_ARM_SEC_EXT
+extern int __boot_cpu_secure;
+#else
+#define __boot_cpu_secure 0
+#endif
+
+#endif /* ! __ASSEMBLY__ */
+
+#endif /* SEC_H */
diff --git a/arch/arm/include/uapi/asm/ptrace.h b/arch/arm/include/uapi/asm/ptrace.h
index 5af0ed1..70ff6bf 100644
--- a/arch/arm/include/uapi/asm/ptrace.h
+++ b/arch/arm/include/uapi/asm/ptrace.h
@@ -53,6 +53,7 @@
 #endif
 #define FIQ_MODE	0x00000011
 #define IRQ_MODE	0x00000012
+#define MON_MODE	0x00000016
 #define ABT_MODE	0x00000017
 #define HYP_MODE	0x0000001a
 #define UND_MODE	0x0000001b
diff --git a/arch/arm/kernel/Makefile b/arch/arm/kernel/Makefile
index e69f7a1..a60a0f7 100644
--- a/arch/arm/kernel/Makefile
+++ b/arch/arm/kernel/Makefile
@@ -87,6 +87,7 @@ head-y			:= head$(MMUEXT).o
 obj-$(CONFIG_DEBUG_LL)	+= debug.o
 obj-$(CONFIG_EARLY_PRINTK)	+= early_printk.o
 
+obj-$(CONFIG_ARM_SEC_EXT)	+= mon-stub.o
 obj-$(CONFIG_ARM_VIRT_EXT)	+= hyp-stub.o
 ifeq ($(CONFIG_ARM_PSCI),y)
 obj-y				+= psci.o psci-call.o
diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
index 29e2991..d137ba4 100644
--- a/arch/arm/kernel/head.S
+++ b/arch/arm/kernel/head.S
@@ -85,6 +85,9 @@ ENTRY(stext)
  THUMB(	.thumb			)	@ switch to Thumb now.
  THUMB(1:			)
 
+#ifdef CONFIG_ARM_SEC_EXT
+	bl	__mon_stub_install
+#endif
 #ifdef CONFIG_ARM_VIRT_EXT
 	bl	__hyp_stub_install
 #endif
diff --git a/arch/arm/kernel/mon-stub.S b/arch/arm/kernel/mon-stub.S
new file mode 100644
index 0000000..ab1a361
--- /dev/null
+++ b/arch/arm/kernel/mon-stub.S
@@ -0,0 +1,158 @@
+/*
+ * Copyright (c) 2014, The Linux Foundation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 and
+ * only version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/linkage.h>
+#include <asm/assembler.h>
+#include <asm/sec.h>
+
+.data
+ENTRY(__boot_cpu_secure)
+	.long	0
+.text
+
+/*
+ * ARM Linux has the most features available in hypervisor mode and
+ * running in non-secure mode is recommended. Thus, try to get into
+ * hypervisor mode if we're not already there, or failing that, try
+ * to get into non-secure supervisor mode.
+ */
+ENTRY(__mon_stub_install)
+	/*
+	 * Store the mode field of the CPSR in r4 and return early if we're
+	 * already in hypervisor mode.
+	 */
+	mrs	r4, cpsr
+	and	r4, r4, #MODE_MASK
+	cmp	r4, #HYP_MODE
+	reteq	lr
+
+	/*
+	 * Save the link register in a non-banked register, r5, so that we
+	 * still have access to it after mode switches.
+	 */
+	mov	r5, lr
+
+	/*
+	 * Read ID_PFR1 and store the value in r6. This register indicates
+	 * the presence of the security and virtualization extensions. The
+	 * former is interesting because we must traverse secure monitor mode
+	 * to get to hypervisor mode and it allows easy manipulation of
+	 * exception vectors via the Vector Base Address Register (VBAR).
+	 *
+	 * ID_PFR1 also indicates whether the generic timer is present, which
+	 * has a handy register for our purposes, CNTFRQ. Accesses won't trap
+	 * even with higher exception levels in AArch64 and writes will only
+	 * succeed from the highest exception level on a system (the undefined
+	 * exception from a failed write is used as a branch).
+	 */
+
+	mrc   p15, 0, r6, c0, c1, 1	@ ID_PFR1
+
+	/*
+	 * If we're in monitor mode then we know the security setting and can
+	 * begin the transition to hypervisor or non-secure supervisor mode
+	 * immediately.
+	 */
+
+	cmp	r4, #MON_MODE
+	beq	monitor
+
+	/*
+	 * Check that the security extensions and generic timer are present.
+	 */
+	and	r7, r6, #0xf0
+	cmp	r7, #0x10
+	cmpne	r7, #0x20
+	retne	lr
+	and	r8, r6, #0xf0000
+	cmp	r8, #0x10000
+	retne	lr
+
+	/*
+	 * Set things up so that if a CNTFRQ access causes an undefined
+	 * instruction exception, we return to the address indicated in r5
+	 * in the mode indicated in r4.
+	 */
+	adr	r7, __mon_stub_vectors
+	mcr	p15, 0, r7, c12, c0, 0	@ set vector base address (VBAR)
+
+	mrc	p15, 0, r7, c14, c0, 0	@ CNTFRQ
+	mcr	p15, 0, r7, c14, c0, 0	@ CNTFRQ
+
+	/*
+	 * If we got this far, switch to monitor mode and prepare for further
+	 * switching.
+	 */
+	cps	#MON_MODE
+
+monitor:
+	/*
+	 * TODO: Handle SIF and separate secure physical memory in general
+	 */
+	mrc	p15, 0, r8, c1, c1, 0	@ get secure configuration (SCR)
+	orr	r8, r8, #1		@ non-secure (NS)
+
+	mov	r8, #1
+	ldr	r7, =__boot_cpu_secure
+	str	r8, [r7]
+
+	/*
+	 * See whether the switch will be to hypervisor or supervisor.
+	 */
+	and	r7, r6, #0xf000
+	cmp	r7, #0x1000
+	mcrne	p15, 0, r8, c1, c1, 0	@ set secure configuration (SCR)
+	bne	supervise
+
+	orr	r8, r8, #0x100		@ hypercall enable (HCE)
+	mcr	p15, 0, r8, c1, c1, 0	@ set secure configuration (SCR)
+
+	mov	lr, r5
+	msr	spsr, #HYP_MODE
+	__ERET
+
+supervise:
+	/*
+	 * Switch to supervisor mode and return using a non-banked register,
+	 * in case we're not in the mode we started out in.
+	 */
+	cps	#SVC_MODE
+	ret	r5
+ENDPROC(__mon_stub_install)
+
+ENTRY(__mon_stub_do_undef)
+	/*
+	 * Return to the address at r5 with the mode in r4. If there is an
+	 * illegal or unimplemented mode in r4 the cpsr write will cause an
+	 * undefined exception, recursing. To avoid that, put the current
+	 * mode in r4 before performing the write.
+	 */
+	mrs	r6, cpsr
+	bic	r7, r6, #MODE_MASK
+	orr	r7, r7, r4
+	and	r4, r6, #MODE_MASK
+	msr	cpsr, r7
+	ret	r5
+ENDPROC(__mon_stub_do_undef)
+
+.align 5
+__mon_stub_vectors:
+__mon_stub_reset:	W(b)	.
+__mon_stub_und:		W(b)	__mon_stub_do_undef
+__mon_stub_call:	W(b)	.
+__mon_stub_pabort:	W(b)	.
+__mon_stub_dabort:	W(b)	.
+__mon_stub_trap:	W(b)	.
+__mon_stub_irq:		W(b)	.
+__mon_stub_fiq:		W(b)	.
+ENDPROC(__mon_stub_vectors)
diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index 7c6b976..32fa451 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -676,7 +676,7 @@ config ARM_THUMBEE
 	  make use of it. Say N for code that can run on CPUs without ThumbEE.
 
 config ARM_VIRT_EXT
-	bool
+	bool "Support for Virtualization Extensions"
 	depends on MMU
 	default y if CPU_V7
 	help
@@ -684,9 +684,21 @@ config ARM_VIRT_EXT
 	  Extensions to install hypervisors without run-time firmware
 	  assistance.
 
-	  A compliant bootloader is required in order to make maximum
-	  use of this feature.  Refer to Documentation/arm/Booting for
-	  details.
+	  A compliant bootloader or enabling ARM_SEC_EXT is required in
+	  order to make maximum use of this feature. Refer to
+	  Documentation/arm/Booting for details.
+
+config ARM_SEC_EXT
+	bool "Support for Security Extensions"
+	depends on MMU
+	default n
+	help
+	  Say Y to have the kernel check for the presence of the ARM Security
+	  Extensions and where possible, use them to switch to preferred
+	  security and mode settings. This decreases the kernel's dependency
+	  on bootloaders.
+
+	  If unsure, say N.
 
 config SWP_EMULATE
 	bool "Emulate SWP/SWPB instructions" if !SMP
-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
