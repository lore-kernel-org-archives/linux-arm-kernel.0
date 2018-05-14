From: Dave.Martin@arm.com (Dave Martin)
Date: Mon, 14 May 2018 18:51:09 +0100
Subject: [PATCH] arm64/sve: Write ZCR_EL1 on context switch only if changed
Message-ID: <1526320269-27088-1-git-send-email-Dave.Martin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Writes to ZCR_EL1 are self-synchronising, and so may be expensive
in typical implementations.

This patch adopts the approach used for costly system register
writes elsewhere in the kernel: the system register write is
suppressed if it would not change the stored value.

Since the common case will be that of switching between tasks that
use the same vector length as one another, prediction hit rates on
the conditional branch should be reasonably good, with lower
expected amortised cost than the unconditional execution of a
heavyweight self-synchronising instruction.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
---
 arch/arm64/include/asm/fpsimdmacros.h | 12 +++++++-----
 arch/arm64/kernel/entry-fpsimd.S      |  2 +-
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/include/asm/fpsimdmacros.h b/arch/arm64/include/asm/fpsimdmacros.h
index e050d76..4684351 100644
--- a/arch/arm64/include/asm/fpsimdmacros.h
+++ b/arch/arm64/include/asm/fpsimdmacros.h
@@ -207,12 +207,14 @@
 		str		w\nxtmp, [\xpfpsr, #4]
 .endm
 
-.macro sve_load nxbase, xpfpsr, xvqminus1, nxtmp
+.macro sve_load nxbase, xpfpsr, xvqminus1, nxtmp, xtmp2
 		mrs_s		x\nxtmp, SYS_ZCR_EL1
-		bic		x\nxtmp, x\nxtmp, ZCR_ELx_LEN_MASK
-		orr		x\nxtmp, x\nxtmp, \xvqminus1
-		msr_s		SYS_ZCR_EL1, x\nxtmp	// self-synchronising
-
+		bic		\xtmp2, x\nxtmp, ZCR_ELx_LEN_MASK
+		orr		\xtmp2, \xtmp2, \xvqminus1
+		cmp		\xtmp2, x\nxtmp
+		b.eq		921f
+		msr_s		SYS_ZCR_EL1, \xtmp2	// self-synchronising
+921:
  _for n, 0, 31,	_sve_ldr_v	\n, \nxbase, \n - 34
 		_sve_ldr_p	0, \nxbase
 		_sve_wrffr	0
diff --git a/arch/arm64/kernel/entry-fpsimd.S b/arch/arm64/kernel/entry-fpsimd.S
index 73f17bf..12d4958 100644
--- a/arch/arm64/kernel/entry-fpsimd.S
+++ b/arch/arm64/kernel/entry-fpsimd.S
@@ -49,7 +49,7 @@ ENTRY(sve_save_state)
 ENDPROC(sve_save_state)
 
 ENTRY(sve_load_state)
-	sve_load 0, x1, x2, 3
+	sve_load 0, x1, x2, 3, x4
 	ret
 ENDPROC(sve_load_state)
 
-- 
2.1.4
