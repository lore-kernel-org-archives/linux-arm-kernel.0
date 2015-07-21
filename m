From: nschichan@freebox.fr (Nicolas Schichan)
Date: Tue, 21 Jul 2015 14:16:38 +0200
Subject: [PATCH V2 next-next 1/3] ARM: net: add support for BPF_ANC |
 SKF_AD_PKTTYPE in ARM JIT.
In-Reply-To: <1437481000-22835-1-git-send-email-nschichan@freebox.fr>
References: <1437481000-22835-1-git-send-email-nschichan@freebox.fr>
Message-ID: <1437481000-22835-2-git-send-email-nschichan@freebox.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Nicolas Schichan <nschichan@freebox.fr>
---
 arch/arm/net/bpf_jit_32.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/net/bpf_jit_32.c b/arch/arm/net/bpf_jit_32.c
index 4550d24..67a2d44 100644
--- a/arch/arm/net/bpf_jit_32.c
+++ b/arch/arm/net/bpf_jit_32.c
@@ -864,6 +864,17 @@ b_epilogue:
 			else
 				OP_IMM3(ARM_AND, r_A, r_A, VLAN_TAG_PRESENT, ctx);
 			break;
+		case BPF_ANC | SKF_AD_PKTTYPE:
+			ctx->seen |= SEEN_SKB;
+			BUILD_BUG_ON(FIELD_SIZEOF(struct sk_buff,
+						  __pkt_type_offset[0]) != 1);
+			off = PKT_TYPE_OFFSET();
+			emit(ARM_LDRB_I(r_A, r_skb, off), ctx);
+			emit(ARM_AND_I(r_A, r_A, PKT_TYPE_MAX), ctx);
+#ifdef __BIG_ENDIAN_BITFIELD
+			emit(ARM_LSR_I(r_A, r_A, 5), ctx);
+#endif
+			break;
 		case BPF_ANC | SKF_AD_QUEUE:
 			ctx->seen |= SEEN_SKB;
 			BUILD_BUG_ON(FIELD_SIZEOF(struct sk_buff,
-- 
1.9.1
