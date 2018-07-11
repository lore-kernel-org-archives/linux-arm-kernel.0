From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Wed, 11 Jul 2018 10:32:17 +0100
Subject: [PATCH net-next v2 10/14] ARM: net: bpf: use ldr instructions with
 shifted rm register
In-Reply-To: <20180711093033.GP17271@n2100.armlinux.org.uk>
References: <20180711093033.GP17271@n2100.armlinux.org.uk>
Message-ID: <E1fdBTt-0001JT-Qu@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rather than pre-shifting the rm register for the ldr in the tail call,
shift it in the load instruction.  This eliminates one unnecessary
instruction.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/net/bpf_jit_32.c | 3 +--
 arch/arm/net/bpf_jit_32.h | 4 ++++
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm/net/bpf_jit_32.c b/arch/arm/net/bpf_jit_32.c
index 645653e1931e..e22dc828420c 100644
--- a/arch/arm/net/bpf_jit_32.c
+++ b/arch/arm/net/bpf_jit_32.c
@@ -1096,8 +1096,7 @@ static int emit_bpf_tail_call(struct jit_ctx *ctx)
 	r_array = arm_bpf_get_reg32(r2[1], tmp2[1], ctx);
 	emit(ARM_ADD_I(tmp[1], r_array, off), ctx);
 	r_index = arm_bpf_get_reg32(r3[1], tmp2[1], ctx);
-	emit(ARM_MOV_SI(tmp[0], r_index, SRTYPE_ASL, 2), ctx);
-	emit(ARM_LDR_R(tmp[1], tmp[1], tmp[0]), ctx);
+	emit(ARM_LDR_R_SI(tmp[1], tmp[1], r_index, SRTYPE_ASL, 2), ctx);
 	emit(ARM_CMP_I(tmp[1], 0), ctx);
 	_emit(ARM_COND_EQ, ARM_B(jmp_offset), ctx);
 
diff --git a/arch/arm/net/bpf_jit_32.h b/arch/arm/net/bpf_jit_32.h
index dee8a76fb0bc..e541a7a6139a 100644
--- a/arch/arm/net/bpf_jit_32.h
+++ b/arch/arm/net/bpf_jit_32.h
@@ -188,6 +188,10 @@
 #define ARM_LDR_R(rt, rn, rm)	(ARM_INST_LDR_R | ARM_INST_LDST__U \
 				 | (rt) << 12 | (rn) << 16 \
 				 | (rm))
+#define ARM_LDR_R_SI(rt, rn, rm, type, imm) \
+				(ARM_INST_LDR_R | ARM_INST_LDST__U \
+				 | (rt) << 12 | (rn) << 16 \
+				 | (imm) << 7 | (type) << 5 | (rm))
 #define ARM_LDRB_R(rt, rn, rm)	(ARM_INST_LDRB_R | ARM_INST_LDST__U \
 				 | (rt) << 12 | (rn) << 16 \
 				 | (rm))
-- 
2.7.4
