From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 18 Apr 2016 17:09:42 +0200
Subject: [PATCH 2/8] arm64: kernel: use literal for relocated address of
 __secondary_switched
In-Reply-To: <1460992188-23295-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1460992188-23295-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1460992188-23295-3-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We can simply use a relocated 64-bit literal to store the address of
__secondary_switched(), and the relocation code will ensure that it
holds the correct value at secondary entry time, as long as we make sure
that the literal is not dereferenced until after we have enabled the MMU.

So jump via a small __secondary_switch() function covered by the ID map
that performs the literal load and branch-to-register.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/kernel/head.S | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index ac27d8d937b2..f13276d4ca91 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -468,9 +468,7 @@ __mmap_switched:
 	str	x15, [x11, x23]
 	b	0b
 
-2:	adr_l	x8, kimage_vaddr		// make relocated kimage_vaddr
-	dc	cvac, x8			// value visible to secondaries
-	dsb	sy				// with MMU off
+2:
 #endif
 
 	adr_l	sp, initial_sp, x4
@@ -699,12 +697,9 @@ secondary_startup:
 	adrp	x26, swapper_pg_dir
 	bl	__cpu_setup			// initialise processor
 
-	ldr	x8, kimage_vaddr
-	ldr	w9, 0f
-	sub	x27, x8, w9, sxtw		// address to jump to after enabling the MMU
+	adr_l	x27, __secondary_switch		// address to jump to after enabling the MMU
 	b	__enable_mmu
 ENDPROC(secondary_startup)
-0:	.long	(_text - TEXT_OFFSET) - __secondary_switched
 
 __secondary_switched:
 	adr_l	x5, vectors
@@ -806,3 +801,8 @@ __no_granule_support:
 	wfi
 	b 1b
 ENDPROC(__no_granule_support)
+
+__secondary_switch:
+	ldr	x8, =__secondary_switched
+	br	x8
+ENDPROC(__secondary_switch)
-- 
2.5.0
