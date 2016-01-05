From: rabin@rab.in (Rabin Vincent)
Date: Tue,  5 Jan 2016 18:34:04 +0100
Subject: [PATCH] ARM: net: bpf: fix zero right shift
Message-ID: <1452015244-1230-1-git-send-email-rabin@rab.in>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The LSR instruction cannot be used to perform a zero right shift since a
0 as the immediate value (imm5) in the LSR instruction encoding means
that a shift of 32 is perfomed.  See DecodeIMMShift() in the ARM ARM.

Make the JIT skip generation of the LSR if a zero-shift is requested.

This was found using american fuzzy lop.

Signed-off-by: Rabin Vincent <rabin@rab.in>
---
 arch/arm/net/bpf_jit_32.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/net/bpf_jit_32.c b/arch/arm/net/bpf_jit_32.c
index e153eb065fe4..93d0b6d0b63e 100644
--- a/arch/arm/net/bpf_jit_32.c
+++ b/arch/arm/net/bpf_jit_32.c
@@ -756,7 +756,8 @@ load_ind:
 		case BPF_ALU | BPF_RSH | BPF_K:
 			if (unlikely(k > 31))
 				return -1;
-			emit(ARM_LSR_I(r_A, r_A, k), ctx);
+			if (k)
+				emit(ARM_LSR_I(r_A, r_A, k), ctx);
 			break;
 		case BPF_ALU | BPF_RSH | BPF_X:
 			update_on_xread(ctx);
-- 
2.6.4
