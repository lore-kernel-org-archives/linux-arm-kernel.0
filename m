From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Mon, 26 Sep 2011 15:32:41 +0100
Subject: [RFC PATCH 3/3] ARM: mm: add l2x0 suspend/resume support
In-Reply-To: <1317047561-11020-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1317047561-11020-1-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <1317047561-11020-4-git-send-email-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When suspend to RAM or cpuidle require the system to enter the deepest C
states, L2 cache logic can be lost.
This patch adds assembly hooks that allow to restore the context for
l2x0 series of L2 controllers upon system resume.

Context is saved once for all at boot time, along with the L2 physical address
and cache type.
The resume code can be called with MMU either on or off and it executes
specific code accordingly, by checking the MMU status in the SCTRL system
register.

Code is in place to check if L2 is already enabled on resume to
avoid writing L2 registers that would cause faults.

The resume hook avoids using the stack since it might be called
before the C environment is up and running and fetches data using
program counter relative addressing so that it can be run both
with MMU on or off to simplify its adoption.

Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Barry Song <Baohua.Song@csr.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 arch/arm/include/asm/hardware/cache-l2x0.h |   21 ++++-
 arch/arm/kernel/asm-offsets.c              |   12 +++
 arch/arm/mm/Makefile                       |    3 +
 arch/arm/mm/cache-l2x0.c                   |    5 +-
 arch/arm/mm/l2x0-sleep.S                   |  136 ++++++++++++++++++++++++++++
 5 files changed, 174 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm/mm/l2x0-sleep.S

diff --git a/arch/arm/include/asm/hardware/cache-l2x0.h b/arch/arm/include/asm/hardware/cache-l2x0.h
index 54bf625..05312eb 100644
--- a/arch/arm/include/asm/hardware/cache-l2x0.h
+++ b/arch/arm/include/asm/hardware/cache-l2x0.h
@@ -97,6 +97,25 @@
 extern void __init l2x0_init(void __iomem *base, void __iomem *pbase,
 		__u32 aux_val, __u32 aux_mask);
 extern int l2x0_of_init(__u32 aux_val, __u32 aux_mask);
-#endif
 
+#ifndef CONFIG_PM_SLEEP
+static inline void l2x0_resume(void) {}
+static inline void l2x0_save_context(void __iomem *pbase, __u32 cache_id) {}
+#else
+struct l2x0_regs {
+	__u32 aux_ctrl;
+	__u32 tag_latency;
+	__u32 data_latency;
+	__u32 afilter_start;
+	__u32 afilter_end;
+	__u32 debug_ctrl;
+	__u32 prefetch_ctrl;
+	__u32 power_ctrl;
+} __packed;
+
+extern struct l2x0_regs l2x0_data;
+extern void l2x0_resume(void);
+extern void l2x0_save_context(void __iomem *pbase, __u32 cache_id);
+#endif /* CONFIG_PM_SLEEP */
+#endif /* __ASSEMBLY__ */
 #endif
diff --git a/arch/arm/kernel/asm-offsets.c b/arch/arm/kernel/asm-offsets.c
index 16baba2..91d7b7b 100644
--- a/arch/arm/kernel/asm-offsets.c
+++ b/arch/arm/kernel/asm-offsets.c
@@ -20,6 +20,7 @@
 #include <asm/thread_info.h>
 #include <asm/memory.h>
 #include <asm/procinfo.h>
+#include <asm/hardware/cache-l2x0.h>
 #include <linux/kbuild.h>
 
 /*
@@ -128,6 +129,17 @@ int main(void)
 #ifdef MULTI_CACHE
   DEFINE(CACHE_FLUSH_KERN_ALL,	offsetof(struct cpu_cache_fns, flush_kern_all));
 #endif
+#ifdef CONFIG_CACHE_L2X0
+  DEFINE(L2X0_REGS_SZ,		sizeof(struct l2x0_regs));
+  DEFINE(L2X0_R_AUX_CTRL,	offsetof(struct l2x0_regs, aux_ctrl));
+  DEFINE(L2X0_R_TAG_LATENCY,	offsetof(struct l2x0_regs, tag_latency));
+  DEFINE(L2X0_R_DATA_LATENCY,	offsetof(struct l2x0_regs, data_latency));
+  DEFINE(L2X0_R_AFILTER_START,	offsetof(struct l2x0_regs, afilter_start));
+  DEFINE(L2X0_R_AFILTER_END,	offsetof(struct l2x0_regs, afilter_end));
+  DEFINE(L2X0_R_DEBUG_CTRL,	offsetof(struct l2x0_regs, debug_ctrl));
+  DEFINE(L2X0_R_PREFETCH_CTRL,	offsetof(struct l2x0_regs, prefetch_ctrl));
+  DEFINE(L2X0_R_POWER_CTRL,	offsetof(struct l2x0_regs, power_ctrl));
+#endif
   BLANK();
   DEFINE(DMA_BIDIRECTIONAL,	DMA_BIDIRECTIONAL);
   DEFINE(DMA_TO_DEVICE,		DMA_TO_DEVICE);
diff --git a/arch/arm/mm/Makefile b/arch/arm/mm/Makefile
index bca7e61..5936d6b 100644
--- a/arch/arm/mm/Makefile
+++ b/arch/arm/mm/Makefile
@@ -98,5 +98,8 @@ AFLAGS_proc-v7.o	:=-Wa,-march=armv7-a
 
 obj-$(CONFIG_CACHE_FEROCEON_L2)	+= cache-feroceon-l2.o
 obj-$(CONFIG_CACHE_L2X0)	+= cache-l2x0.o
+ifeq ($(CONFIG_PM_SLEEP),y)
+obj-$(CONFIG_CACHE_L2X0)	+= l2x0-sleep.o
+endif
 obj-$(CONFIG_CACHE_XSC3L2)	+= cache-xsc3l2.o
 obj-$(CONFIG_CACHE_TAUROS2)	+= cache-tauros2.o
diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index 46a507a..9b9d619 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -28,7 +28,7 @@
 
 #define CACHE_LINE_SIZE		32
 
-static void __iomem *l2x0_base;
+void __iomem *l2x0_base;
 static DEFINE_SPINLOCK(l2x0_lock);
 static uint32_t l2x0_way_mask;	/* Bitmask of active ways */
 static uint32_t l2x0_size;
@@ -358,7 +358,7 @@ void __init l2x0_init(void __iomem *base, void __iomem *pbase,
 		writel_relaxed(aux, l2x0_base + L2X0_AUX_CTRL);
 
 		l2x0_inv_all();
-
+		l2x0_save_context(pbase, cache_id & L2X0_CACHE_ID_PART_MASK);
 		/* enable L2X0 */
 		writel_relaxed(1, l2x0_base + L2X0_CTRL);
 	}
@@ -371,6 +371,7 @@ void __init l2x0_init(void __iomem *base, void __iomem *pbase,
 	outer_cache.inv_all = l2x0_inv_all;
 	outer_cache.disable = l2x0_disable;
 	outer_cache.set_debug = l2x0_set_debug;
+	outer_cache.resume = l2x0_resume;
 
 	printk(KERN_INFO "%s cache controller enabled\n", type);
 	printk(KERN_INFO "l2x0: %d ways, CACHE_ID 0x%08x, AUX_CTRL 0x%08x, Cache size: %d B\n",
diff --git a/arch/arm/mm/l2x0-sleep.S b/arch/arm/mm/l2x0-sleep.S
new file mode 100644
index 0000000..ac4998a
--- /dev/null
+++ b/arch/arm/mm/l2x0-sleep.S
@@ -0,0 +1,136 @@
+/*
+ *  Copyright (C) 2011 ARM Ltd
+ *  Author: Lorenzo Pieralisi
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/init.h>
+#include <linux/linkage.h>
+#include <asm/asm-offsets.h>
+#include <asm/hardware/cache-l2x0.h>
+
+	__INIT
+
+save_l210:
+	ldr	r4, [r1, #L2X0_AUX_CTRL]
+	str	r4, [r0], #4
+	ldmnefd	sp!, {r4 - r11, pc}			@ if l210 returns
+save_l310:
+	ldr	r5, [r1, #L2X0_TAG_LATENCY_CTRL]
+	ldr	r6, [r1, #L2X0_DATA_LATENCY_CTRL]
+	ldr	r7, [r1, #L2X0_ADDR_FILTER_START]
+	ldr	r8, [r1, #L2X0_ADDR_FILTER_END]
+	ldr	r9, [r1, #L2X0_DEBUG_CTRL]
+	ldr	r10, [r1, #L2X0_PREFETCH_CTRL]
+	ldr	r11, [r1, #L2X0_POWER_CTRL]
+	stmia	r0, {r5 - r11}
+	ldmfd	sp!, {r4 - r11, pc}
+
+/*
+ * Save L2x0 registers depending on L2 HW configuration.
+ * A check on cache type is carried out and registers are saved
+ * accordingly, once for all at boot time. L2 is off so there is no
+ * need to clean L2 cache lines containing reg values to DRAM.
+ * r0 = L2 physical base address
+ * r1 = cache type
+ */
+
+ENTRY(l2x0_save_context)
+	stmfd	sp!, {r4 - r11, lr}
+	ldr	r2, =l2x0_phys_base
+	str	r0, [r2]				@ save physical address
+	ldr	r0, =l2x0_base				@ get L2 base address
+	mov	r2, r1					@ stash cache type
+	ldr	r1, [r0]
+	ldr	r0, =l2x0_data				@ get context pointer
+	ldr 	r3, =l2x0_type
+	str	r2, [r3]				@ save cache type
+	cmp	r2, #L2X0_CACHE_ID_PART_L310		@ jump table
+	b 	save_l210
+ENDPROC(l2x0_save_context)
+
+	__FINIT
+/*
+ * Function entered with flags set by jump table in l2x0_resume
+ * If zero flag is set this is a pl310
+ * r0 = l2x0_data
+ * r1 = L2 address
+ */
+resume_l210:
+	ldr	r2, [r0], #4				@ just use scratch regs
+	str	r2, [r1, #L2X0_AUX_CTRL]
+	mov	r3, #0
+	mov	r12, #L2X0_LOCKDOWN_WAY_D_BASE
+	mov	r2, r12
+	str	r3, [r1, r2]
+	add	r2, r2, #4
+	str	r3, [r1, r2]
+	movne	r0, #0x1				@ if l210 we are done
+	strne	r0, [r1, #L2X0_CTRL]			@ enable L2
+	movne	pc, lr
+resume_l310:
+	add	r12, r12, r1
+	add	r12, r12, #L2X0_LOCKDOWN_STRIDE		@ start D lock
+	mov	r2, #0
+	mov	r3, #7
+unlock:
+	str	r2, [r12, #4]				@ I lock
+	str	r2, [r12], #L2X0_LOCKDOWN_STRIDE	@ D lock and increment
+	subs	r3, r3, #1
+	bne 	unlock
+	ldmia	r0!, {r2, r3, r12}
+	str	r2, [r1, #L2X0_TAG_LATENCY_CTRL]
+	str	r3, [r1, #L2X0_DATA_LATENCY_CTRL]
+	str	r12, [r1, #L2X0_ADDR_FILTER_START]
+	ldmia	r0!, {r2, r3, r12}
+	str	r2, [r1, #L2X0_ADDR_FILTER_END]
+	str	r3, [r1, #L2X0_DEBUG_CTRL]
+	str	r12, [r1, #L2X0_PREFETCH_CTRL]
+	ldr	r2, [r0]
+	str	r2, [r1, #L2X0_POWER_CTRL]
+	mov	r0, #0x1
+	str	r0, [r1, #L2X0_CTRL]			@ enable L2
+	mov	pc, lr
+
+/*
+ * Resume function does not use any stack since it might be called
+ * when C environment is not set up yet. It checks the MMU status, and
+ * loads the L2 base address accordingly. Only data accessed if MMU is off is
+ * through PC relative loads, to avoid fetching data from virtual addresses
+ * that would wreak havoc.
+ */
+
+	.data
+	.align
+ENTRY(l2x0_resume)
+	mrc	p15, 0, r2, c1, c0, 0			@ check if MMU is on
+	tst	r2, #0x1
+	ldrne	r0, =l2x0_base
+	adr	r1, l2x0_phys_base
+	ldreq	r1, [r1]				@ it is not r1 = L2 phys
+	ldrne	r1, [r0]				@ it is r1 = L2 virt
+	ldr	r0, [r1, #L2X0_CTRL]			@ L2 enabled ?
+	tst	r0, #0x1
+	movne	pc, lr					@ yes, bug out
+	adr	r0, l2x0_data
+	adr	r2, l2x0_type				@ check L2 type
+	ldr	r2, [r2]
+	cmp	r2, #L2X0_CACHE_ID_PART_L310		@ jump table
+	b 	resume_l210
+ENDPROC(l2x0_restore_context)
+
+l2x0_phys_base:
+	.long 0
+
+l2x0_type:
+	.long 0
+
+	.align
+	.globl	l2x0_data
+	.type	l2x0_data, %object
+l2x0_data:
+	.space	L2X0_REGS_SZ
+	.size	l2x0_data, . - l2x0_data
-- 
1.7.4.4
