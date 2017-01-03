From: mirq-linux@rere.qmqm.pl (=?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?=)
Date: Tue,  3 Jan 2017 21:52:38 +0100 (CET)
Subject: [PATCH net-next v2 19/27] net/bpf_jit: ARM: split VLAN_PRESENT bit
 handling from VLAN_TCI
In-Reply-To: <cover.1483475202.git.mirq-linux@rere.qmqm.pl>
References: <cover.1483475202.git.mirq-linux@rere.qmqm.pl>
Message-ID: <15c9c9a610e892b6639b04dd5cf1523091f6ac1d.1483475202.git.mirq-linux@rere.qmqm.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Micha? Miros?aw <mirq-linux@rere.qmqm.pl>
---
 arch/arm/net/bpf_jit_32.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/arch/arm/net/bpf_jit_32.c b/arch/arm/net/bpf_jit_32.c
index 93d0b6d0b63e..6dbc60241f9d 100644
--- a/arch/arm/net/bpf_jit_32.c
+++ b/arch/arm/net/bpf_jit_32.c
@@ -915,17 +915,20 @@ static int build_body(struct jit_ctx *ctx)
 			emit(ARM_LDR_I(r_A, r_skb, off), ctx);
 			break;
 		case BPF_ANC | SKF_AD_VLAN_TAG:
-		case BPF_ANC | SKF_AD_VLAN_TAG_PRESENT:
 			ctx->seen |= SEEN_SKB;
 			BUILD_BUG_ON(FIELD_SIZEOF(struct sk_buff, vlan_tci) != 2);
 			off = offsetof(struct sk_buff, vlan_tci);
 			emit(ARM_LDRH_I(r_A, r_skb, off), ctx);
-			if (code == (BPF_ANC | SKF_AD_VLAN_TAG))
-				OP_IMM3(ARM_AND, r_A, r_A, ~VLAN_TAG_PRESENT, ctx);
-			else {
-				OP_IMM3(ARM_LSR, r_A, r_A, 12, ctx);
-				OP_IMM3(ARM_AND, r_A, r_A, 0x1, ctx);
-			}
+#ifdef VLAN_TAG_PRESENT
+			OP_IMM3(ARM_AND, r_A, r_A, ~VLAN_TAG_PRESENT, ctx);
+#endif
+			break;
+		case BPF_ANC | SKF_AD_VLAN_TAG_PRESENT:
+			off = PKT_VLAN_PRESENT_OFFSET();
+			emit(ARM_LDRB_I(r_A, r_skb, off), ctx);
+			if (PKT_VLAN_PRESENT_BIT)
+				OP_IMM3(ARM_LSR, r_A, r_A, PKT_VLAN_PRESENT_BIT, ctx);
+			OP_IMM3(ARM_AND, r_A, r_A, 0x1, ctx);
 			break;
 		case BPF_ANC | SKF_AD_PKTTYPE:
 			ctx->seen |= SEEN_SKB;
-- 
2.11.0
