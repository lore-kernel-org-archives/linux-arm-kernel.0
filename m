From: nschichan@freebox.fr (Nicolas Schichan)
Date: Thu,  7 May 2015 15:00:13 +0200
Subject: [PATCH v2] ARM: net: add JIT support for loads from struct
 seccomp_data.
Message-ID: <1431003613-16554-1-git-send-email-nschichan@freebox.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Nicolas Schichan <nschichan@freebox.fr>
---

This patch was first sent as part of a serie modifying the core
seccomp code to allow the use of the classic BPF JIT. As the core
changes have been submitted to netdev by Daniel Borkmann, it is now
time to re-submit this patch separately.

While not physically dependent of the core seccomp changes they are
needed for the code added in this patch to be triggered.

 arch/arm/net/bpf_jit_32.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/net/bpf_jit_32.c b/arch/arm/net/bpf_jit_32.c
index f412b53..6bda637 100644
--- a/arch/arm/net/bpf_jit_32.c
+++ b/arch/arm/net/bpf_jit_32.c
@@ -863,6 +863,16 @@ b_epilogue:
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
