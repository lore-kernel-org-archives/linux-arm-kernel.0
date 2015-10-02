From: nschichan@freebox.fr (Nicolas Schichan)
Date: Fri,  2 Oct 2015 15:39:12 +0200
Subject: [PATCH net] ARM: net: make BPF_LD | BPF_IND instruction trigger r_X
 initialisation to 0.
Message-ID: <1443793152-8661-1-git-send-email-nschichan@freebox.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Without this patch, if the only instructions using r_X are of the
BPF_LD | BPF_IND type, r_X would not be reset to 0, using whatever
value was there when entering the jited code. With this patch, r_X
will be correctly marked as used so it will be reset to 0 in the
prologue code.

This fix also makes the test "LD_IND byte default X" pass in the
test_bpf module when the ARM JIT is enabled.

Signed-off-by: Nicolas Schichan <nschichan@freebox.fr>
---
 arch/arm/net/bpf_jit_32.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/net/bpf_jit_32.c b/arch/arm/net/bpf_jit_32.c
index 876060b..b8efb8c 100644
--- a/arch/arm/net/bpf_jit_32.c
+++ b/arch/arm/net/bpf_jit_32.c
@@ -614,6 +614,7 @@ load_common:
 		case BPF_LD | BPF_B | BPF_IND:
 			load_order = 0;
 load_ind:
+			update_on_xread(ctx);
 			OP_IMM3(ARM_ADD, r_off, r_X, k, ctx);
 			goto load_common;
 		case BPF_LDX | BPF_IMM:
-- 
1.9.1
