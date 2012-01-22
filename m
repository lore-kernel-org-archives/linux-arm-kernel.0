From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Sun, 22 Jan 2012 12:13:36 +0100
Subject: [RFC PATCH 10/11] Cortex-M3: Add VFP support
In-Reply-To: <20120122111230.GB14835@pengutronix.de>
References: <20120122111230.GB14835@pengutronix.de>
Message-ID: <1327230817-12855-10-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Catalin Marinas <catalin.marinas@arm.com>

This patch adds support for the ARMv7-M VFP extension. It uses the lazy
state preservation mechanism available in hardware for the S0-S15
registers. The S16-S32 registers are saved at a context switch if the
thread being scheduled out ever used the VFP. Similarly, the S16-S31
registers are restored if the thread being scheduled in ever used the
VFP.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/Kconfig               |    7 +++
 arch/arm/include/asm/fpstate.h |    3 +
 arch/arm/kernel/Makefile       |    2 +
 arch/arm/kernel/asm-offsets.c  |    3 +
 arch/arm/kernel/entry-header.S |   14 ++++++
 arch/arm/kernel/vfp-m.c        |  102 ++++++++++++++++++++++++++++++++++++++++
 6 files changed, 131 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/kernel/vfp-m.c

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index ca9b48c..c5caeee 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -2227,6 +2227,13 @@ config NEON
 	  Say Y to include support code for NEON, the ARMv7 Advanced SIMD
 	  Extension.
 
+config VFPM
+	bool "ARMv7-M VFP Extension support"
+	depends on CPU_V7M
+	help
+	  Say Y to include support for the ARMv7-M VFP Extension
+	  (single-precision floating point hardware).
+
 endmenu
 
 menu "Userspace binary formats"
diff --git a/arch/arm/include/asm/fpstate.h b/arch/arm/include/asm/fpstate.h
index 3ad4c10..e18c3d9 100644
--- a/arch/arm/include/asm/fpstate.h
+++ b/arch/arm/include/asm/fpstate.h
@@ -43,6 +43,9 @@ struct vfp_hard_struct {
 #ifdef CONFIG_SMP
 	__u32 cpu;
 #endif
+#ifdef CONFIG_VFPM
+	__u32 clean;
+#endif
 };
 
 union vfp_state {
diff --git a/arch/arm/kernel/Makefile b/arch/arm/kernel/Makefile
index 32e96e6..66d6c92 100644
--- a/arch/arm/kernel/Makefile
+++ b/arch/arm/kernel/Makefile
@@ -81,6 +81,8 @@ obj-$(CONFIG_HW_PERF_EVENTS)	+= perf_event.o
 AFLAGS_iwmmxt.o			:= -Wa,-mcpu=iwmmxt
 obj-$(CONFIG_ARM_CPU_TOPOLOGY)  += topology.o
 
+obj-$(CONFIG_VFPM)		+= vfp-m.o
+
 ifneq ($(CONFIG_ARCH_EBSA110),y)
   obj-y		+= io.o
 endif
diff --git a/arch/arm/kernel/asm-offsets.c b/arch/arm/kernel/asm-offsets.c
index e861849..10ec416 100644
--- a/arch/arm/kernel/asm-offsets.c
+++ b/arch/arm/kernel/asm-offsets.c
@@ -60,6 +60,9 @@ int main(void)
   DEFINE(TI_TP_VALUE,		offsetof(struct thread_info, tp_value));
   DEFINE(TI_FPSTATE,		offsetof(struct thread_info, fpstate));
   DEFINE(TI_VFPSTATE,		offsetof(struct thread_info, vfpstate));
+#ifdef CONFIG_VFPM
+  DEFINE(TI_VFPSTATE_CLEAN,	offsetof(struct thread_info, vfpstate.hard.clean));
+#endif
 #ifdef CONFIG_SMP
   DEFINE(VFP_CPU,		offsetof(union vfp_state, hard.cpu));
 #endif
diff --git a/arch/arm/kernel/entry-header.S b/arch/arm/kernel/entry-header.S
index 8050d9b..cb38aff 100644
--- a/arch/arm/kernel/entry-header.S
+++ b/arch/arm/kernel/entry-header.S
@@ -72,7 +72,15 @@
  */
 	.macro	v7m_exception_entry
 	cpsid	i
+#ifdef CONFIG_VFPM
+	get_thread_info r0
+	and	r1, lr, #1 << 4		@ VFP clean state
+	str	r1, [r0, #TI_VFPSTATE_CLEAN]
+#endif
 	cmp	lr, #0xfffffffd		@ check the return stack
+#ifdef CONFIG_VFPM
+	cmpne	lr, #0xffffffed
+#endif
 	beq	1f			@ exception on process stack
 	add	r12, sp, #32		@ MSP before exception
 	stmdb	sp!, {r4-r12, lr}	@ push unsaved registers
@@ -90,6 +98,9 @@
 	.macro	v7m_exception_fast_exit
 	ldmia	sp!, {r4-r12, lr}	@ restore previously saved state
 	cmp	lr, #0xfffffffd		@ check the return stack
+#ifdef CONFIG_VFPM
+	cmpne	lr, #0xffffffed
+#endif
 	addeq	sp, #32			@ returning to PSP, just restore MSP
 	cpsie	i
 	bx	lr
@@ -99,6 +110,9 @@
 	cpsid	i
 	ldr	lr, [sp, #S_EXC_LR]	@ read exception LR
 	cmp	lr, #0xfffffffd		@ check the return stack
+#ifdef CONFIG_VFPM
+	cmpne	lr, #0xffffffed
+#endif
 	beq	1f			@ returning to PSP
 	@ Prepare the MSP stack
 	ldmia	sp, {r4-r11}		@ restore previously saved state
diff --git a/arch/arm/kernel/vfp-m.c b/arch/arm/kernel/vfp-m.c
new file mode 100644
index 0000000..0528189
--- /dev/null
+++ b/arch/arm/kernel/vfp-m.c
@@ -0,0 +1,102 @@
+/*
+ * arch/arm/kernel/vfp-m.c
+ *
+ * Copyright (C) 2010 ARM Limited
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/string.h>
+
+#include <asm/thread_notify.h>
+
+static union vfp_state *last_vfp_context;
+
+static void save_vfp_context(union vfp_state *vfp)
+{
+	/* vstmia %0!, {d8-d15} */
+	asm("	stc	p11, cr8, [%0], #16*4\n" : : "r" (vfp) : "cc");
+}
+
+static void load_vfp_context(union vfp_state *vfp)
+{
+	/* vldmia %0!, {d8-d15} */
+	asm("	ldc	p11, cr8, [%0], #16*4\n" : : "r" (vfp) : "cc");
+}
+
+static int vfpm_notifier(struct notifier_block *self, unsigned long cmd,
+			 void *t)
+{
+	struct thread_info *thread = t;
+	union vfp_state *vfp = &thread->vfpstate;
+	union vfp_state *old_vfp = &current_thread_info()->vfpstate;
+	u32 *fpccr = (u32 *)0xe000ef34;
+
+	switch (cmd) {
+	case THREAD_NOTIFY_FLUSH:
+		memset(vfp, 0, sizeof(*vfp));
+		vfp->hard.clean = 1;
+		/* fall through */
+
+	case THREAD_NOTIFY_EXIT:
+		if (last_vfp_context == vfp) {
+			/* disable lazy state saving */
+			*fpccr &= ~1;
+			last_vfp_context = NULL;
+		}
+		break;
+
+	case THREAD_NOTIFY_SWITCH:
+		if (!old_vfp->hard.clean) {
+			save_vfp_context(last_vfp_context);
+			last_vfp_context = old_vfp;
+		}
+		if (!vfp->hard.clean && last_vfp_context != vfp) {
+			load_vfp_context(vfp);
+			last_vfp_context = vfp;
+		}
+		break;
+	}
+
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block vfpm_notifier_block = {
+	.notifier_call	= vfpm_notifier,
+};
+
+static int __init vfpm_init(void)
+{
+	u32 *cpacr = (u32 *)0xe000ed88;
+	u32 *mvfr0 = (u32 *)0xe000ef40;
+	u32 *fpccr = (u32 *)0xe000ef34;
+
+	/* check for single-precision VFP operations */
+	if ((*mvfr0 & 0xf0) != 0x20)
+		return 0;
+
+	printk(KERN_INFO "ARMv7-M VFP Extension supported\n");
+
+	*cpacr |= 0xf << 20;		/* coprocessor access */
+	*fpccr |= 3 << 30;		/* automatic lazy state preservation */
+
+	elf_hwcap |= HWCAP_VFP;
+	thread_register_notifier(&vfpm_notifier_block);
+
+	return 0;
+}
+
+late_initcall(vfpm_init);
-- 
1.7.8.3
