From: will.deacon@arm.com (Will Deacon)
Date: Fri, 27 Jun 2014 16:53:19 +0100
Subject: [PATCH v2] arm64: fpsimd: avoid restoring fpcr if the contents
 haven't changed
Message-ID: <1403884399-16359-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Writing to the FPCR is commonly implemented as a self-synchronising
operation in the CPU, so avoid writing to the register when the saved
value matches that in the hardware already.

Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Reviewed-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---

v1 -> v2 : Move FPCR restoration out into a macro and update partial
           restore code too. 

 arch/arm64/include/asm/fpsimdmacros.h | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/fpsimdmacros.h b/arch/arm64/include/asm/fpsimdmacros.h
index 768414d55e64..f6b3eb5f4517 100644
--- a/arch/arm64/include/asm/fpsimdmacros.h
+++ b/arch/arm64/include/asm/fpsimdmacros.h
@@ -40,6 +40,19 @@
 	str	w\tmpnr, [\state, #16 * 2 + 4]
 .endm
 
+.macro fpsimd_restore_fpcr state, tmp
+	/*
+	 * Writes to fpcr may be self-synchronising, so avoid restoring
+	 * the register if it hasn't changed.
+	 */
+	mrs	\tmp, fpcr
+	cmp	\tmp, \state
+	b.eq	9999f
+	msr	fpcr, \state
+9999:
+.endm
+
+/* Clobbers \state */
 .macro fpsimd_restore state, tmpnr
 	ldp	q0, q1, [\state, #16 * 0]
 	ldp	q2, q3, [\state, #16 * 2]
@@ -60,7 +73,7 @@
 	ldr	w\tmpnr, [\state, #16 * 2]
 	msr	fpsr, x\tmpnr
 	ldr	w\tmpnr, [\state, #16 * 2 + 4]
-	msr	fpcr, x\tmpnr
+	fpsimd_restore_fpcr x\tmpnr, \state
 .endm
 
 .altmacro
@@ -84,7 +97,7 @@
 .macro fpsimd_restore_partial state, tmpnr1, tmpnr2
 	ldp	w\tmpnr1, w\tmpnr2, [\state]
 	msr	fpsr, x\tmpnr1
-	msr	fpcr, x\tmpnr2
+	fpsimd_restore_fpcr x\tmpnr1, x\tmpnr2
 	adr	x\tmpnr1, 0f
 	ldr	w\tmpnr2, [\state, #8]
 	add	\state, \state, x\tmpnr2, lsl #4
-- 
2.0.0
