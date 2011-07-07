From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Thu,  7 Jul 2011 16:50:22 +0100
Subject: [RFC PATCH 09/17] ARM: kernel: v7 resets support
In-Reply-To: <1310053830-23779-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1310053830-23779-1-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <1310053830-23779-10-git-send-email-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch provides reset entry point for A9, A8, A5 processors.

The reset functions invalidate I$ and D$ depending on the processor needs
and jump to the save/restore entry point in sr_entry.S.

The reset address is obtained through the arch_reset_handler() function that
returns a function pointer, detected dynamically through cpu id.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 arch/arm/kernel/reset_v7.S |  109 ++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 109 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/kernel/reset_v7.S

diff --git a/arch/arm/kernel/reset_v7.S b/arch/arm/kernel/reset_v7.S
new file mode 100644
index 0000000..287074c
--- /dev/null
+++ b/arch/arm/kernel/reset_v7.S
@@ -0,0 +1,109 @@
+/*
+ * Copyright (c) 2008-2011 ARM Ltd
+ * Author(s): Jon Callan, Lorenzo Pieralisi
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#include <linux/linkage.h>
+#include "sr.h"
+
+#define	SCTLR_I (1<<12)
+#define	SCTLR_Z (1<<11)
+
+ENTRY(platform_a8_reset_handler)
+	b	sr_reset_entry_point
+ENDPROC(platform_a8_reset_handler)
+
+ENTRY(invalidate_icache_v7_pou)
+	mov     r0, #0
+	mcr     p15, 0, r0, c7, c5, 0           @ iciallu
+	bx	lr
+ENDPROC(invalidate_icache_v7_pou)
+
+ENTRY(invalidate_dcache_v7_all)
+	@ must iterate over the caches in order to synthesise a complete
+	@ invalidation of data/unified cache
+	mrc     p15, 1, r0, c0, c0, 1           @ read clidr
+	ands    r3, r0, #0x7000000              @ extract loc from clidr
+	mov     r3, r3, lsr #23                 @ left align loc bit field
+	beq     finished                        @ if loc is 0, then no need to
+						@ clean
+	mov     r10, #0                         @ start clean@cache level 0
+						@ (in r10)
+loop1:
+	add     r2, r10, r10, lsr #1            @ work out 3x current cache
+						@ level
+	mov     r12, r0, lsr r2                 @ extract cache type bits from
+						@ clidr
+	and     r12, r12, #7                    @ mask of bits for current
+						@ cache only
+	cmp     r12, #2                         @ see what cache we have at
+						@ this level
+	blt     skip                            @ skip if no cache, or just
+						@ i-cache
+	mcr     p15, 2, r10, c0, c0, 0          @ select current cache level
+						@ in cssr
+	mov     r12, #0
+	mcr     p15, 0, r12, c7, c5, 4          @ prefetchflush to sync new
+						@ cssr&csidr
+	mrc     p15, 1, r12, c0, c0, 0          @ read the new csidr
+	and     r2, r12, #7                     @ extract the length of the
+						@ cache lines
+	add     r2, r2, #4                      @ add 4 (line length offset)
+	ldr     r6, =0x3ff
+	ands    r6, r6, r12, lsr #3             @ find maximum number on the
+						@ way size
+	clz     r5, r6                          @ find bit pos of way size
+						@ increment
+	ldr     r7, =0x7fff
+	ands    r7, r7, r12, lsr #13            @ extract max number of the
+						@ index size
+loop2:
+	mov     r8, r6                          @ create working copy of max
+						@ way size
+loop3:
+	orr     r11, r10, r8, lsl r5            @ factor way and cache number
+						@ into r11
+	orr     r11, r11, r7, lsl r2            @ factor index number into r11
+	mcr     p15, 0, r11, c7, c6, 2          @ invalidate by set/way
+	subs    r8, r8, #1                      @ decrement the way
+	bge     loop3
+	subs    r7, r7, #1                      @ decrement the index
+	bge     loop2
+skip:
+	add     r10, r10, #2                    @ increment cache number
+	cmp     r3, r10
+	bgt     loop1
+finished:
+	mov     r10, #0
+
+	mcr     p15, 0, r10, c7, c10, 4         @ drain write buffer
+	mcr     p15, 0, r10, c8, c7, 0          @ invalidate i + d tlbs
+	mcr     p15, 0, r10, c2, c0, 2          @ ttb control register
+	bx      lr
+ENDPROC(invalidate_dcache_v7_all)
+
+ENTRY(platform_a9_reset_handler)
+	@ Work out whether caches need to be invalidated: A9 - yes, A5 - no
+	mrc	p15, 0, r0, c0, c0, 0
+	ldr	r1, =CPU_A5
+	cmp	r0, r1
+	beq	icache
+
+	bl	invalidate_icache_v7_pou
+
+	@ Turn I cache and branch prediction on
+icache:
+	mrc     p15, 0, r0, c1, c0, 0
+	orr	r0, r0, #(SCTLR_I  |  SCTLR_Z)
+	mcr     p15, 0, r0, c1, c0, 0
+
+	@ Clear all data cache levels visible to CPU
+	blne	invalidate_dcache_v7_all
+
+	b	sr_reset_entry_point
+ENDPROC(platform_a9_reset_handler)
-- 
1.7.4.4
