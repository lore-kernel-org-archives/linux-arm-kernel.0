From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon,  4 Apr 2016 16:52:17 +0200
Subject: [PATCH 1/8] arm64/kernel: use literal for relocated address of
 __secondary_switched
In-Reply-To: <1459781544-14310-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1459781544-14310-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1459781544-14310-2-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We can simply use a relocated 64-bit literal to store the address of
__secondary_switched(), and the relocation code will ensure that it
holds the correct value at secondary entry time, as long as we make sure
that the literal value is visible to the secondaries before they enable
their MMUs. So place the literal next to kimage_vaddr, and set the alignment
so that it is covered by the same cacheline that we already have to clean
for a similar purpose.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/kernel/head.S | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 4203d5f257bc..69b33535911e 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -471,7 +471,8 @@ __mmap_switched:
 	b	0b
 
 2:	adr_l	x8, kimage_vaddr		// make relocated kimage_vaddr
-	dc	cvac, x8			// value visible to secondaries
+						// and __secondary_switched
+	dc	cvac, x8			// values visible to secondaries
 	dsb	sy				// with MMU off
 #endif
 
@@ -506,10 +507,12 @@ ENDPROC(__mmap_switched)
  * end early head section, begin head code that is also used for
  * hotplug and needs to have the same protections as the text region
  */
-	.section ".text","ax"
-
+	.section	".text","ax"
+	.align		4
 ENTRY(kimage_vaddr)
 	.quad		_text - TEXT_OFFSET
+.L__secondary_switched:
+	.quad		__secondary_switched
 
 /*
  * If we're fortunate enough to boot at EL2, ensure that the world is
@@ -701,12 +704,9 @@ ENTRY(secondary_startup)
 	adrp	x26, swapper_pg_dir
 	bl	__cpu_setup			// initialise processor
 
-	ldr	x8, kimage_vaddr
-	ldr	w9, 0f
-	sub	x27, x8, w9, sxtw		// address to jump to after enabling the MMU
+	ldr	x27, .L__secondary_switched
 	b	__enable_mmu
 ENDPROC(secondary_startup)
-0:	.long	(_text - TEXT_OFFSET) - __secondary_switched
 
 ENTRY(__secondary_switched)
 	adr_l	x5, vectors
-- 
2.5.0
