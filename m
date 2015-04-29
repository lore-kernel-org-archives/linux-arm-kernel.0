From: nschichan@freebox.fr (Nicolas Schichan)
Date: Wed, 29 Apr 2015 15:37:36 +0200
Subject: [PATCH 3/4] ARM: net: add JIT support for loads from struct
 seccomp_data.
In-Reply-To: <1430314657-2552-1-git-send-email-nschichan@freebox.fr>
References: <1430314657-2552-1-git-send-email-nschichan@freebox.fr>
Message-ID: <1430314657-2552-4-git-send-email-nschichan@freebox.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Nicolas Schichan <nschichan@freebox.fr>
---
 arch/arm/net/bpf_jit_32.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/net/bpf_jit_32.c b/arch/arm/net/bpf_jit_32.c
index e1268f9..b5f470d 100644
--- a/arch/arm/net/bpf_jit_32.c
+++ b/arch/arm/net/bpf_jit_32.c
@@ -852,6 +852,16 @@ b_epilogue:
 			off = offsetof(struct sk_buff, queue_mapping);
 			emit(ARM_LDRH_I(r_A, r_skb, off), ctx);
 			break;
+		case BPF_LDX | BPF_W | BPF_ABS:
+			/*
+			 * load a 32bit word from struct seccomp_data.
+			 * seccomp_check_filter() will already have checked
+			 * that k is 32bit aligned and lies within the
+			 * struct seccomp_data.
+			 */
+			ctx->seen |= SEEN_SKB;
+			emit(ARM_LDR_I(r_A, r_skb, k), ctx);
+			break;
 		default:
 			return -1;
 		}
-- 
1.9.1
