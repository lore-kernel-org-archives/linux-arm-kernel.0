From: james.morse@arm.com (James Morse)
Date: Thu,  5 Oct 2017 20:17:57 +0100
Subject: [PATCH v3 05/20] arm64: entry.S: Remove disable_dbg
In-Reply-To: <20171005191812.5678-1-james.morse@arm.com>
References: <20171005191812.5678-1-james.morse@arm.com>
Message-ID: <20171005191812.5678-6-james.morse@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

enable_step_tsk is the only user of disable_dbg, which doesn't respect
our 'dai' order for exception masking. enable_step_tsk may enable
single-step, so previously needed to mask debug exceptions to prevent us
from single-stepping kernel_exit. enable_step_tsk is called at the end
of the ret_to_user loop, which has already masked all exceptions so this
is no longer needed.

Remove disable_dbg, add a comment that enable_step_tsk's caller should
have masked debug.

Signed-off-by: James Morse <james.morse@arm.com>
---
 arch/arm64/include/asm/assembler.h | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index 114e741ca873..1b0972046a72 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -68,13 +68,6 @@
 	msr	daif, \flags
 	.endm
 
-/*
- * Enable and disable debug exceptions.
- */
-	.macro	disable_dbg
-	msr	daifset, #8
-	.endm
-
 	.macro	enable_dbg
 	msr	daifclr, #8
 	.endm
@@ -88,9 +81,9 @@
 9990:
 	.endm
 
+	/* call with daif masked */
 	.macro	enable_step_tsk, flgs, tmp
 	tbz	\flgs, #TIF_SINGLESTEP, 9990f
-	disable_dbg
 	mrs	\tmp, mdscr_el1
 	orr	\tmp, \tmp, #1
 	msr	mdscr_el1, \tmp
-- 
2.13.3
