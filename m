From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 05 Feb 2013 00:21:58 -0500
Subject: [PATCH v4 01/15] ARM: multi-cluster PM: secondary kernel entry code
In-Reply-To: <1360041732-17936-1-git-send-email-nicolas.pitre@linaro.org>
References: <1360041732-17936-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <1360041732-17936-2-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CPUs in cluster based systems, such as big.LITTLE, have special needs
when entering the kernel due to a hotplug event, or when resuming from
a deep sleep mode.

This is vectorized so multiple CPUs can enter the kernel in parallel
without serialization.

The mcpm prefix stands for "multi cluster power management", however
this is usable on single cluster systems as well.  Only the basic
structure is introduced here.  This will be extended with later patches.

In order not to complexify things more than they currently have to,
the planned work to make runtime adjusted MPIDR based indexing and
dynamic memory allocation for cluster states is postponed to a later
cycle. The MAX_NR_CLUSTERS and MAX_CPUS_PER_CLUSTER static definitions
should be sufficient for those systems expected to be available in the
near future.

Signed-off-by: Nicolas Pitre <nico@linaro.org>
Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Reviewed-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/Kconfig                  |  8 ++++
 arch/arm/common/Makefile          |  1 +
 arch/arm/common/mcpm_entry.c      | 29 +++++++++++++
 arch/arm/common/mcpm_head.S       | 86 +++++++++++++++++++++++++++++++++++++++
 arch/arm/include/asm/mcpm_entry.h | 35 ++++++++++++++++
 5 files changed, 159 insertions(+)
 create mode 100644 arch/arm/common/mcpm_entry.c
 create mode 100644 arch/arm/common/mcpm_head.S
 create mode 100644 arch/arm/include/asm/mcpm_entry.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 67874b82a4..200f559c1c 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1584,6 +1584,14 @@ config HAVE_ARM_TWD
 	help
 	  This options enables support for the ARM timer and watchdog unit
 
+config CLUSTER_PM
+	bool "Cluster Power Management Infrastructure"
+	depends on CPU_V7 && SMP
+	help
+	  This option provides the common power management infrastructure
+	  for (multi-)cluster based systems, such as big.LITTLE based
+	  systems.
+
 choice
 	prompt "Memory split"
 	default VMSPLIT_3G
diff --git a/arch/arm/common/Makefile b/arch/arm/common/Makefile
index e8a4e58f1b..23e85b1fae 100644
--- a/arch/arm/common/Makefile
+++ b/arch/arm/common/Makefile
@@ -13,3 +13,4 @@ obj-$(CONFIG_SHARP_PARAM)	+= sharpsl_param.o
 obj-$(CONFIG_SHARP_SCOOP)	+= scoop.o
 obj-$(CONFIG_PCI_HOST_ITE8152)  += it8152.o
 obj-$(CONFIG_ARM_TIMER_SP804)	+= timer-sp.o
+obj-$(CONFIG_CLUSTER_PM)	+= mcpm_head.o mcpm_entry.o
diff --git a/arch/arm/common/mcpm_entry.c b/arch/arm/common/mcpm_entry.c
new file mode 100644
index 0000000000..3a6d7e70fd
--- /dev/null
+++ b/arch/arm/common/mcpm_entry.c
@@ -0,0 +1,29 @@
+/*
+ * arch/arm/common/mcpm_entry.c -- entry point for multi-cluster PM
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
+#include <asm/mcpm_entry.h>
+#include <asm/barrier.h>
+#include <asm/proc-fns.h>
+#include <asm/cacheflush.h>
+
+extern volatile unsigned long mcpm_entry_vectors[MAX_NR_CLUSTERS][MAX_CPUS_PER_CLUSTER];
+
+void mcpm_set_entry_vector(unsigned cpu, unsigned cluster, void *ptr)
+{
+	unsigned long val = ptr ? virt_to_phys(ptr) : 0;
+	mcpm_entry_vectors[cluster][cpu] = val;
+	__cpuc_flush_dcache_area((void *)&mcpm_entry_vectors[cluster][cpu], 4);
+	outer_clean_range(__pa(&mcpm_entry_vectors[cluster][cpu]),
+			  __pa(&mcpm_entry_vectors[cluster][cpu + 1]));
+}
diff --git a/arch/arm/common/mcpm_head.S b/arch/arm/common/mcpm_head.S
new file mode 100644
index 0000000000..cda65f200b
--- /dev/null
+++ b/arch/arm/common/mcpm_head.S
@@ -0,0 +1,86 @@
+/*
+ * arch/arm/common/mcpm_head.S -- kernel entry point for multi-cluster PM
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
+#include <asm/mcpm_entry.h>
+
+	.macro	pr_dbg	string
+#if defined(CONFIG_DEBUG_LL) && defined(DEBUG)
+	b	1901f
+1902:	.asciz	"CPU"
+1903:	.asciz	" cluster"
+1904:	.asciz	": \string"
+	.align
+1901:	adr	r0, 1902b
+	bl	printascii
+	mov	r0, r9
+	bl	printhex8
+	adr	r0, 1903b
+	bl	printascii
+	mov	r0, r10
+	bl	printhex8
+	adr	r0, 1904b
+	bl	printascii
+#endif
+	.endm
+
+	.arm
+	.align
+
+ENTRY(mcpm_entry_point)
+
+ THUMB(	adr	r12, BSYM(1f)	)
+ THUMB(	bx	r12		)
+ THUMB(	.thumb			)
+1:
+	mrc	p15, 0, r0, c0, c0, 5		@ MPIDR
+	ubfx	r9, r0, #0, #8			@ r9 = cpu
+	ubfx	r10, r0, #8, #8			@ r10 = cluster
+	mov	r3, #MAX_CPUS_PER_CLUSTER
+	mla	r4, r3, r10, r9			@ r4 = canonical CPU index
+	cmp	r4, #(MAX_CPUS_PER_CLUSTER * MAX_NR_CLUSTERS)
+	blo	2f
+
+	/* We didn't expect this CPU.  Try to cheaply make it quiet. */
+1:	wfi
+	wfe
+	b	1b
+
+2:	pr_dbg	"kernel mcpm_entry_point\n"
+
+	/*
+	 * MMU is off so we need to get to mcpm_entry_vectors in a
+	 * position independent way.
+	 */
+	adr	r5, 3f
+	ldr	r6, [r5]
+	add	r6, r5, r6			@ r6 = mcpm_entry_vectors
+
+mcpm_entry_gated:
+	ldr	r5, [r6, r4, lsl #2]		@ r5 = CPU entry vector
+	cmp	r5, #0
+	wfeeq
+	beq	mcpm_entry_gated
+	pr_dbg	"released\n"
+	bx	r5
+
+	.align	2
+
+3:	.word	mcpm_entry_vectors - .
+
+ENDPROC(mcpm_entry_point)
+
+	.bss
+	.align	5
+
+	.type	mcpm_entry_vectors, #object
+ENTRY(mcpm_entry_vectors)
+	.space	4 * MAX_NR_CLUSTERS * MAX_CPUS_PER_CLUSTER
diff --git a/arch/arm/include/asm/mcpm_entry.h b/arch/arm/include/asm/mcpm_entry.h
new file mode 100644
index 0000000000..cc10ebbd2e
--- /dev/null
+++ b/arch/arm/include/asm/mcpm_entry.h
@@ -0,0 +1,35 @@
+/*
+ * arch/arm/include/asm/mcpm_entry.h
+ *
+ * Created by:  Nicolas Pitre, April 2012
+ * Copyright:   (C) 2012-2013  Linaro Limited
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef MCPM_ENTRY_H
+#define MCPM_ENTRY_H
+
+#define MAX_CPUS_PER_CLUSTER	4
+#define MAX_NR_CLUSTERS		2
+
+#ifndef __ASSEMBLY__
+
+/*
+ * Platform specific code should use this symbol to set up secondary
+ * entry location for processors to use when released from reset.
+ */
+extern void mcpm_entry_point(void);
+
+/*
+ * This is used to indicate where the given CPU from given cluster should
+ * branch once it is ready to re-enter the kernel using ptr, or NULL if it
+ * should be gated.  A gated CPU is held in a WFE loop until its vector
+ * becomes non NULL.
+ */
+void mcpm_set_entry_vector(unsigned cpu, unsigned cluster, void *ptr);
+
+#endif /* ! __ASSEMBLY__ */
+#endif
-- 
1.8.1.2
