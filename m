From: murzin.v@gmail.com (Vladimir Murzin)
Date: Wed, 28 Aug 2013 02:52:32 +0400
Subject: [PATCH] arm: bpf_jit: support MOD operation
Message-ID: <1377643952-10388-1-git-send-email-murzin.v@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

commit b6069a9570 (filter: add MOD operation) added generic
support for modulus operation in BPF.

This patch brings JIT support for ARM.

Signed-off-by: Vladimir Murzin <murzin.v@gmail.com>
---
 arch/arm/net/bpf_jit_32.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/net/bpf_jit_32.c b/arch/arm/net/bpf_jit_32.c
index f50d223..0bfff55 100644
--- a/arch/arm/net/bpf_jit_32.c
+++ b/arch/arm/net/bpf_jit_32.c
@@ -636,6 +636,24 @@ load_ind:
 			update_on_xread(ctx);
 			emit(ARM_MUL(r_A, r_A, r_X), ctx);
 			break;
+		case BPF_S_ALU_MOD_X: /* A %= X; */
+			update_on_xread(ctx);
+			emit(ARM_CMP_I(r_X, 0), ctx);
+			emit_err_ret(ARM_COND_EQ, ctx);
+			emit_udiv(r_scratch, r_A, r_X, ctx);
+			emit(ARM_MUL(r_scratch, r_X, r_scratch), ctx);
+			emit(ARM_SUB_R(r_A, r_A, r_scratch), ctx);
+			break;
+		case BPF_S_ALU_MOD_K: /* A %= K; */
+			/*
+			 * reuse ARM_R1 as the temp register - it should be safe
+			 * as soon as udiv may touch it too.
+			 */
+			emit_mov_i(ARM_R1, k, ctx);
+			emit_udiv(r_scratch, r_A, ARM_R1, ctx);
+			emit(ARM_MUL(r_scratch, ARM_R1, r_scratch), ctx);
+			emit(ARM_SUB_R(r_A, r_A, r_scratch), ctx);
+			break;
 		case BPF_S_ALU_DIV_K:
 			/* current k == reciprocal_value(userspace k) */
 			emit_mov_i(r_scratch, k, ctx);
-- 
1.8.1.5
