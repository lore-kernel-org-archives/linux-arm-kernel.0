From: nschichan@freebox.fr (Nicolas Schichan)
Date: Wed,  6 May 2015 18:31:56 +0200
Subject: [PATCH v2] ARM: net fix emit_udiv() for BPF_ALU | BPF_DIV | BPF_K
 intruction.
Message-ID: <1430929916-15852-1-git-send-email-nschichan@freebox.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In that case, emit_udiv() will be called with rn == ARM_R0 (r_scratch)
and loading rm first into ARM_R0 will result in jit_udiv() function
being called the same dividend and divisor. Fix that by loading rn
first into ARM_R1 and then rm into ARM_R0.

Signed-off-by: Nicolas Schichan <nschichan@freebox.fr>
Cc: <stable@vger.kernel.org> # v3.13+
Fixes: aee636c4809f (bpf: do not use reciprocal divide)
---
 arch/arm/net/bpf_jit_32.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

This patch was part of a serie adding support to JITed seccomp filters
to ARM but as it is an unrelated fix, it is more appropriate to send
it separately.

Changes from previous version: add a comment clarifying how
emit_udiv() is called when translating BPF_ALU | BPF_DIV | BPF_K and
BPF_ALU | BPF_DIV | BPF_X with respect to the rm and rn parameters.

diff --git a/arch/arm/net/bpf_jit_32.c b/arch/arm/net/bpf_jit_32.c
index e1268f9..f412b53 100644
--- a/arch/arm/net/bpf_jit_32.c
+++ b/arch/arm/net/bpf_jit_32.c
@@ -449,10 +449,21 @@ static inline void emit_udiv(u8 rd, u8 rm, u8 rn, struct jit_ctx *ctx)
 		return;
 	}
 #endif
-	if (rm != ARM_R0)
-		emit(ARM_MOV_R(ARM_R0, rm), ctx);
+
+	/*
+	 * For BPF_ALU | BPF_DIV | BPF_K instructions, rm is ARM_R4
+	 * (r_A) and rn is ARM_R0 (r_scratch) so load rn first into
+	 * ARM_R1 to avoid accidentally overwriting ARM_R0 with rm
+	 * before using it as a source for ARM_R1.
+	 *
+	 * For BPF_ALU | BPF_DIV | BPF_X rm is ARM_R4 (r_A) and rn is
+	 * ARM_R5 (r_X) so there is no particular register overlap
+	 * issues.
+	 */
 	if (rn != ARM_R1)
 		emit(ARM_MOV_R(ARM_R1, rn), ctx);
+	if (rm != ARM_R0)
+		emit(ARM_MOV_R(ARM_R0, rm), ctx);
 
 	ctx->seen |= SEEN_CALL;
 	emit_mov_i(ARM_R3, (u32)jit_udiv, ctx);
-- 
1.9.1
