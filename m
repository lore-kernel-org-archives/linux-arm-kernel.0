From: dxchgb@gmail.com (Daniel Borkmann)
Date: Thu, 8 Nov 2012 02:31:02 +0100
Subject: [PATCH net-next 2/2] ARM: net: bpf_jit_32: add VLAN instructions
 for BPF JIT
Message-ID: <20121108013101.GB23143@thinkbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch is a follow-up for patch "net: filter: add vlan tag access"
to support the new VLAN_TAG/VLAN_TAG_PRESENT accessors in BPF JIT.

Signed-off-by: Daniel Borkmann <daniel.borkmann@tik.ee.ethz.ch>
Cc: Mircea Gherzan <mgherzan@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/net/bpf_jit_32.c |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/arch/arm/net/bpf_jit_32.c b/arch/arm/net/bpf_jit_32.c
index 8be702d..9af9a69 100644
--- a/arch/arm/net/bpf_jit_32.c
+++ b/arch/arm/net/bpf_jit_32.c
@@ -16,6 +16,7 @@
 #include <linux/netdevice.h>
 #include <linux/string.h>
 #include <linux/slab.h>
+#include <linux/if_vlan.h>
 #include <asm/cacheflush.h>
 #include <asm/hwcap.h>
 
@@ -168,6 +169,8 @@ static inline bool is_load_to_a(u16 inst)
 	case BPF_S_ANC_MARK:
 	case BPF_S_ANC_PROTOCOL:
 	case BPF_S_ANC_RXHASH:
+	case BPF_S_ANC_VLAN_TAG:
+	case BPF_S_ANC_VLAN_TAG_PRESENT:
 	case BPF_S_ANC_QUEUE:
 		return true;
 	default:
@@ -815,6 +818,17 @@ b_epilogue:
 			off = offsetof(struct sk_buff, rxhash);
 			emit(ARM_LDR_I(r_A, r_skb, off), ctx);
 			break;
+		case BPF_S_ANC_VLAN_TAG:
+		case BPF_S_ANC_VLAN_TAG_PRESENT:
+			ctx->seen |= SEEN_SKB;
+			BUILD_BUG_ON(FIELD_SIZEOF(struct sk_buff, vlan_tci) != 2);
+			off = offsetof(struct sk_buff, vlan_tci);
+			emit(ARM_LDRH_I(r_A, r_skb, off), ctx);
+			if (inst->code == BPF_S_ANC_VLAN_TAG)
+				OP_IMM3(ARM_AND, r_A, r_A, VLAN_VID_MASK, ctx);
+			else
+				OP_IMM3(ARM_AND, r_A, r_A, VLAN_TAG_PRESENT, ctx);
+			break;
 		case BPF_S_ANC_QUEUE:
 			ctx->seen |= SEEN_SKB;
 			BUILD_BUG_ON(FIELD_SIZEOF(struct sk_buff,
