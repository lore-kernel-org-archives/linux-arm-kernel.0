From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 18 Sep 2009 23:33:46 +0100
Subject: [PATCH] Thumb-2: Correctly handle undefined instructions in the kernel
Message-ID: <20090918223346.30806.68876.stgit@pc1117.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

VFP instructions in the kernel may trigger undefined exceptions if VFP
hardware is not present. This patch corrects the loading of such Thumb-2
instructions. It also marks the "no_fp" label as a function so that the
linker generate a Thumb address.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm/kernel/entry-armv.S |   12 +++++++++++-
 1 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
index a332bc7..0a2ba51 100644
--- a/arch/arm/kernel/entry-armv.S
+++ b/arch/arm/kernel/entry-armv.S
@@ -272,7 +272,15 @@ __und_svc:
 	@
 	@  r0 - instruction
 	@
+#ifndef	CONFIG_THUMB2_KERNEL
 	ldr	r0, [r2, #-4]
+#else
+	ldrh	r0, [r2, #-2]			@ Thumb instruction at LR - 2
+	and	r9, r0, #0xf800
+	cmp	r9, #0xe800			@ 32-bit instruction if xx >= 0
+	ldrhhs	r9, [r2]			@ bottom 16 bits
+	orrhs	r0, r9, r0, lsl #16
+#endif
 	adr	r9, BSYM(1f)
 	bl	call_fpe
 
@@ -678,7 +686,9 @@ ENTRY(fp_enter)
 	.word	no_fp
 	.previous
 
-no_fp:	mov	pc, lr
+ENTRY(no_fp)
+	mov	pc, lr
+ENDPROC(no_fp)
 
 __und_usr_unknown:
 	enable_irq
