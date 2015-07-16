From: nschichan@freebox.fr (Nicolas Schichan)
Date: Thu, 16 Jul 2015 18:46:32 +0200
Subject: [PATCH 3/6] ARM: net: fix vlan access instructions in ARM JIT.
In-Reply-To: <1437065195-10887-1-git-send-email-nschichan@freebox.fr>
References: <1437065195-10887-1-git-send-email-nschichan@freebox.fr>
Message-ID: <1437065195-10887-4-git-send-email-nschichan@freebox.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This makes BPF_ANC | SKF_AD_VLAN_TAG and BPF_ANC | SKF_AD_VLAN_TAG_PRESENT
have the same behaviour as the in kernel VM and makes the test_bpf LD_VLAN_TAG
and LD_VLAN_TAG_PRESENT tests pass.

Signed-off-by: Nicolas Schichan <nschichan@freebox.fr>
---
 arch/arm/net/bpf_jit_32.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm/net/bpf_jit_32.c b/arch/arm/net/bpf_jit_32.c
index d9b2524..c011e22 100644
--- a/arch/arm/net/bpf_jit_32.c
+++ b/arch/arm/net/bpf_jit_32.c
@@ -889,9 +889,11 @@ b_epilogue:
 			off = offsetof(struct sk_buff, vlan_tci);
 			emit(ARM_LDRH_I(r_A, r_skb, off), ctx);
 			if (code == (BPF_ANC | SKF_AD_VLAN_TAG))
-				OP_IMM3(ARM_AND, r_A, r_A, VLAN_VID_MASK, ctx);
-			else
-				OP_IMM3(ARM_AND, r_A, r_A, VLAN_TAG_PRESENT, ctx);
+				OP_IMM3(ARM_AND, r_A, r_A, ~VLAN_TAG_PRESENT, ctx);
+			else {
+				OP_IMM3(ARM_LSR, r_A, r_A, 12, ctx);
+				OP_IMM3(ARM_AND, r_A, r_A, 0x1, ctx);
+			}
 			break;
 		case BPF_ANC | SKF_AD_QUEUE:
 			ctx->seen |= SEEN_SKB;
-- 
1.9.1
