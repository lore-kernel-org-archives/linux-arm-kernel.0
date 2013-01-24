From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Thu, 24 Jan 2013 01:27:45 -0500
Subject: [PATCH v2 02/16] ARM: b.L: secondary kernel entry code
In-Reply-To: <1359008879-9015-1-git-send-email-nicolas.pitre@linaro.org>
References: <1359008879-9015-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <1359008879-9015-3-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CPUs in a big.LITTLE systems have special needs when entering the kernel
due to a hotplug event, or when resuming from a deep sleep mode.

This is vectorized so multiple CPUs can enter the kernel in parallel
without serialization.

Only the basic structure is introduced here.  This will be extended
later.

TODO: MPIDR based indexing should eventually be made runtime adjusted.

Signed-off-by: Nicolas Pitre <nico@linaro.org>
---
 arch/arm/Kconfig                |  6 +++
 arch/arm/common/Makefile        |  1 +
 arch/arm/common/bL_entry.c      | 29 +++++++++++++++
 arch/arm/common/bL_head.S       | 81 +++++++++++++++++++++++++++++++++++++++++
 arch/arm/include/asm/bL_entry.h | 35 ++++++++++++++++++
 5 files changed, 152 insertions(+)
 create mode 100644 arch/arm/common/bL_entry.c
 create mode 100644 arch/arm/common/bL_head.S
 create mode 100644 arch/arm/include/asm/bL_entry.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 67874b82a4..3dd5591c79 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1584,6 +1584,12 @@ config HAVE_ARM_TWD
 	help
 	  This options enables support for the ARM timer and watchdog unit
 
+config BIG_LITTLE
+	bool "big.LITTLE support"
+	depends on CPU_V7 && SMP
+	help
+	  This option enables support for the big.LITTLE architecture.
+
 choice
 	prompt "Memory split"
 	default VMSPLIT_3G
diff --git a/arch/arm/common/Makefile b/arch/arm/common/Makefile
index e8a4e58f1b..8025899a20 100644
--- a/arch/arm/common/Makefile
+++ b/arch/arm/common/Makefile
@@ -13,3 +13,4 @@ obj-$(CONFIG_SHARP_PARAM)	+= sharpsl_param.o
 obj-$(CONFIG_SHARP_SCOOP)	+= scoop.o
 obj-$(CONFIG_PCI_HOST_ITE8152)  += it8152.o
 obj-$(CONFIG_ARM_TIMER_SP804)	+= timer-sp.o
+obj-$(CONFIG_BIG_LITTLE)	+= bL_head.o bL_entry.o
diff --git a/arch/arm/common/bL_entry.c b/arch/arm/common/bL_entry.c
new file mode 100644
index 0000000000..4e1044612d
--- /dev/null
+++ b/arch/arm/common/bL_entry.c
@@ -0,0 +1,29 @@
+/*
+ * arch/arm/common/bL_entry.c -- big.LITTLE kernel re-entry point
+ *
+ * Created by:  Nicolas Pitre, March 2012
+ * Copyright:   (C) 2012-2013  Linaro Limited
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+
+#include <asm/bL_entry.h>
+#include <asm/barrier.h>
+#include <asm/proc-fns.h>
+#include <asm/cacheflush.h>
+
+extern volatile unsigned long bL_entry_vectors[BL_MAX_CLUSTERS][BL_MAX_CPUS_PER_CLUSTER];
+
+void bL_set_entry_vector(unsigned cpu, unsigned cluster, void *ptr)
+{
+	unsigned long val = ptr ? virt_to_phys(ptr) : 0;
+	bL_entry_vectors[cluster][cpu] = val;
+	__cpuc_flush_dcache_area((void *)&bL_entry_vectors[cluster][cpu], 4);
+	outer_clean_range(__pa(&bL_entry_vectors[cluster][cpu]),
+			  __pa(&bL_entry_vectors[cluster][cpu + 1]));
+}
diff --git a/arch/arm/common/bL_head.S b/arch/arm/common/bL_head.S
new file mode 100644
index 0000000000..072a13da20
--- /dev/null
+++ b/arch/arm/common/bL_head.S
@@ -0,0 +1,81 @@
+/*
+ * arch/arm/common/bL_head.S -- big.LITTLE kernel re-entry point
+ *
+ * Created by:  Nicolas Pitre, March 2012
+ * Copyright:   (C) 2012-2013  Linaro Limited
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/linkage.h>
+#include <asm/bL_entry.h>
+
+	.macro	pr_dbg	cpu, string
+#if defined(CONFIG_DEBUG_LL) && defined(DEBUG)
+	b	1901f
+1902:	.ascii	"CPU 0: \0CPU 1: \0CPU 2: \0CPU 3: \0"
+	.ascii	"CPU 4: \0CPU 5: \0CPU 6: \0CPU 7: \0"
+1903:	.asciz	"\string"
+	.align
+1901:	adr	r0, 1902b
+	add	r0, r0, \cpu, lsl #3
+	bl	printascii
+	adr	r0, 1903b
+	bl	printascii
+#endif
+	.endm
+
+	.arm
+	.align
+
+ENTRY(bL_entry_point)
+
+ THUMB(	adr	r12, BSYM(1f)	)
+ THUMB(	bx	r12		)
+ THUMB(	.thumb			)
+1:
+	mrc	p15, 0, r0, c0, c0, 5		@ MPIDR
+	ubfx	r9, r0, #0, #4			@ r9 = cpu
+	ubfx	r10, r0, #8, #4			@ r10 = cluster
+	mov	r3, #BL_MAX_CPUS_PER_CLUSTER
+	mla	r4, r3, r10, r9			@ r4 = canonical CPU index
+	cmp	r4, #(BL_MAX_CPUS_PER_CLUSTER * BL_MAX_CLUSTERS)
+	blo	2f
+
+	/* We didn't expect this CPU.  Try to cheaply make it quiet. */
+1:	wfi
+	wfe
+	b	1b
+
+2:	pr_dbg	r4, "kernel bL_entry_point\n"
+
+	/*
+	 * MMU is off so we need to get to bL_entry_vectors in a
+	 * position independent way.
+	 */
+	adr	r5, 3f
+	ldr	r6, [r5]
+	add	r6, r5, r6			@ r6 = bL_entry_vectors
+
+bL_entry_gated:
+	ldr	r5, [r6, r4, lsl #2]		@ r5 = CPU entry vector
+	cmp	r5, #0
+	wfeeq
+	beq	bL_entry_gated
+	pr_dbg	r4, "released\n"
+	bx	r5
+
+	.align	2
+
+3:	.word	bL_entry_vectors - .
+
+ENDPROC(bL_entry_point)
+
+	.bss
+	.align	5
+
+	.type	bL_entry_vectors, #object
+ENTRY(bL_entry_vectors)
+	.space	4 * BL_MAX_CLUSTERS * BL_MAX_CPUS_PER_CLUSTER
diff --git a/arch/arm/include/asm/bL_entry.h b/arch/arm/include/asm/bL_entry.h
new file mode 100644
index 0000000000..7525614243
--- /dev/null
+++ b/arch/arm/include/asm/bL_entry.h
@@ -0,0 +1,35 @@
+/*
+ * arch/arm/include/asm/bL_entry.h
+ *
+ * Created by:  Nicolas Pitre, April 2012
+ * Copyright:   (C) 2012-2013  Linaro Limited
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef BL_ENTRY_H
+#define BL_ENTRY_H
+
+#define BL_MAX_CPUS_PER_CLUSTER	4
+#define BL_MAX_CLUSTERS		2
+
+#ifndef __ASSEMBLY__
+
+/*
+ * Platform specific code should use this symbol to set up secondary
+ * entry location for processors to use when released from reset.
+ */
+extern void bL_entry_point(void);
+
+/*
+ * This is used to indicate where the given CPU from given cluster should
+ * branch once it is ready to re-enter the kernel using ptr, or NULL if it
+ * should be gated.  A gated CPU is held in a WFE loop until its vector
+ * becomes non NULL.
+ */
+void bL_set_entry_vector(unsigned cpu, unsigned cluster, void *ptr);
+
+#endif /* ! __ASSEMBLY__ */
+#endif
-- 
1.8.0
