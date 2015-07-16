From: nschichan@freebox.fr (Nicolas Schichan)
Date: Thu, 16 Jul 2015 18:46:34 +0200
Subject: [PATCH 5/6] ARM: net: add support for BPF_ANC | SKF_AD_PAY_OFFSET in
 ARM JIT.
In-Reply-To: <1437065195-10887-1-git-send-email-nschichan@freebox.fr>
References: <1437065195-10887-1-git-send-email-nschichan@freebox.fr>
Message-ID: <1437065195-10887-6-git-send-email-nschichan@freebox.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Nicolas Schichan <nschichan@freebox.fr>
---
 arch/arm/net/bpf_jit_32.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/net/bpf_jit_32.c b/arch/arm/net/bpf_jit_32.c
index 6ff248c..3c73caf 100644
--- a/arch/arm/net/bpf_jit_32.c
+++ b/arch/arm/net/bpf_jit_32.c
@@ -915,6 +915,14 @@ b_epilogue:
 			off = offsetof(struct sk_buff, queue_mapping);
 			emit(ARM_LDRH_I(r_A, r_skb, off), ctx);
 			break;
+		case BPF_ANC | SKF_AD_PAY_OFFSET:
+			ctx->seen |= SEEN_SKB | SEEN_CALL;
+
+			emit(ARM_MOV_R(ARM_R0, r_skb), ctx);
+			emit_mov_i(ARM_R3, (unsigned int)skb_get_poff, ctx);
+			emit_blx_r(ARM_R3, ctx);
+			emit(ARM_MOV_R(r_A, ARM_R0), ctx);
+			break;
 		case BPF_LDX | BPF_W | BPF_ABS:
 			/*
 			 * load a 32bit word from struct seccomp_data.
-- 
1.9.1
