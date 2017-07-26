From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 26 Jul 2017 19:18:25 +0100
Subject: [PATCHv2 2/7] arm64: consistently use bl for C exception entry
In-Reply-To: <1501093110-3844-1-git-send-email-mark.rutland@arm.com>
References: <1501093110-3844-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1501093110-3844-3-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In most cases, our exception entry assembly branches to C handlers with
a BL instruction, but in cases where we do not expect to return, we use
B instead.

While this is correct today, it means that backtraces for fatal
exceptions miss the entry assembly (as the LR is stale at the point we
call C code), while non-fatal exceptions have the entry assembly in the
LR. In subsequent patches, we will need the LR to be set in these cases
in order to backtrace reliably.

This patch updates these sites to use a BL, ensuring consistency, and
preparing for backtrace rework. An ASM_BUG() is added after each of
these new BLs, which both catches unexpected returns, and ensures that
the LR value doesn't point to another function label.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: James Morse <james.morse@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/kernel/entry.S | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index b738880..660612a 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -351,7 +351,8 @@ END(vectors)
 	mov	x0, sp
 	mov	x1, #\reason
 	mrs	x2, esr_el1
-	b	bad_mode
+	bl	bad_mode
+	ASM_BUG()
 	.endm
 
 el0_sync_invalid:
@@ -448,14 +449,16 @@ el1_sp_pc:
 	mrs	x0, far_el1
 	enable_dbg
 	mov	x2, sp
-	b	do_sp_pc_abort
+	bl	do_sp_pc_abort
+	ASM_BUG()
 el1_undef:
 	/*
 	 * Undefined instruction
 	 */
 	enable_dbg
 	mov	x0, sp
-	b	do_undefinstr
+	bl	do_undefinstr
+	ASM_BUG()
 el1_dbg:
 	/*
 	 * Debug exception handling
@@ -473,7 +476,8 @@ el1_inv:
 	mov	x0, sp
 	mov	x2, x1
 	mov	x1, #BAD_SYNC
-	b	bad_mode
+	bl	bad_mode
+	ASM_BUG()
 ENDPROC(el1_sync)
 
 	.align	6
-- 
1.9.1
