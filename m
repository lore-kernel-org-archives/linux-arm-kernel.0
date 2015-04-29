From: nschichan@freebox.fr (Nicolas Schichan)
Date: Wed, 29 Apr 2015 15:37:37 +0200
Subject: [PATCH 4/4] ARM: net fix emit_udiv() for BPF_ALU | BPF_DIV | BPF_K
 intruction.
In-Reply-To: <1430314657-2552-1-git-send-email-nschichan@freebox.fr>
References: <1430314657-2552-1-git-send-email-nschichan@freebox.fr>
Message-ID: <1430314657-2552-5-git-send-email-nschichan@freebox.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In that case, emit_udiv() will be called with rn == ARM_R0 (r_scratch)
and loading rm first into ARM_R0 will result in jit_udiv() function
being called the same dividend and divisor. Fix that by loading rn
first into ARM_R1 and then rm into ARM_R0.

Signed-off-by: Nicolas Schichan <nschichan@freebox.fr>
---
 arch/arm/net/bpf_jit_32.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/net/bpf_jit_32.c b/arch/arm/net/bpf_jit_32.c
index b5f470d..ffaf311 100644
--- a/arch/arm/net/bpf_jit_32.c
+++ b/arch/arm/net/bpf_jit_32.c
@@ -449,10 +449,10 @@ static inline void emit_udiv(u8 rd, u8 rm, u8 rn, struct jit_ctx *ctx)
 		return;
 	}
 #endif
-	if (rm != ARM_R0)
-		emit(ARM_MOV_R(ARM_R0, rm), ctx);
 	if (rn != ARM_R1)
 		emit(ARM_MOV_R(ARM_R1, rn), ctx);
+	if (rm != ARM_R0)
+		emit(ARM_MOV_R(ARM_R0, rm), ctx);
 
 	ctx->seen |= SEEN_CALL;
 	emit_mov_i(ARM_R3, (u32)jit_udiv, ctx);
-- 
1.9.1
