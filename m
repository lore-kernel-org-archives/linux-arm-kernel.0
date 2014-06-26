From: will.deacon@arm.com (Will Deacon)
Date: Thu, 26 Jun 2014 18:34:22 +0100
Subject: [PATCH] arm64: fpsimd: avoid restoring fpcr if the contents haven't
 changed
Message-ID: <1403804062-22239-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Writing to the FPCR is commonly implemented as a self-synchronising
operation in the CPU, so avoid writing to the register when the saved
value matches that in the hardware already.

Reviewed-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/fpsimdmacros.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/include/asm/fpsimdmacros.h b/arch/arm64/include/asm/fpsimdmacros.h
index 768414d55e64..137c0f45b0a8 100644
--- a/arch/arm64/include/asm/fpsimdmacros.h
+++ b/arch/arm64/include/asm/fpsimdmacros.h
@@ -40,6 +40,7 @@
 	str	w\tmpnr, [\state, #16 * 2 + 4]
 .endm
 
+/* Clobbers \state */
 .macro fpsimd_restore state, tmpnr
 	ldp	q0, q1, [\state, #16 * 0]
 	ldp	q2, q3, [\state, #16 * 2]
@@ -60,7 +61,15 @@
 	ldr	w\tmpnr, [\state, #16 * 2]
 	msr	fpsr, x\tmpnr
 	ldr	w\tmpnr, [\state, #16 * 2 + 4]
+	/*
+	 * Writes to fpcr may be self-synchronising, so avoid restoring
+	 * the register if it hasn't changed.
+	 */
+	mrs	\state, fpcr
+	cmp	x\tmpnr, \state
+	b.eq	9999f
 	msr	fpcr, x\tmpnr
+9999:
 .endm
 
 .altmacro
-- 
2.0.0
