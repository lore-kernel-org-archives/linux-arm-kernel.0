From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Tue, 10 Jul 2018 13:36:14 +0100
Subject: [PATCH net-next 02/13] ARM: net: bpf: provide load/store ops with
 negative immediates
In-Reply-To: <20180710123340.GK17271@n2100.armlinux.org.uk>
References: <20180710123340.GK17271@n2100.armlinux.org.uk>
Message-ID: <E1fcrsM-0005UR-2D@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Provide a set of load/store opcode generators that work with negative
immediates as well as positive ones.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/net/bpf_jit_32.c | 28 ++++++++++++++++++++++++++++
 arch/arm/net/bpf_jit_32.h | 35 +++++++++++++----------------------
 2 files changed, 41 insertions(+), 22 deletions(-)

diff --git a/arch/arm/net/bpf_jit_32.c b/arch/arm/net/bpf_jit_32.c
index f2e6ffe57788..c81da1a50834 100644
--- a/arch/arm/net/bpf_jit_32.c
+++ b/arch/arm/net/bpf_jit_32.c
@@ -239,6 +239,34 @@ static int16_t imm8m(u32 x)
 	return -1;
 }
 
+static u32 arm_bpf_ldst_imm12(u32 op, u8 rt, u8 rn, s16 imm12)
+{
+	op |= rt << 12 | rn << 16;
+	if (imm12 >= 0)
+		op |= ARM_INST_LDST__U;
+	else
+		imm12 = -imm12;
+	return op | (imm12 & 0xfff);
+}
+
+static u32 arm_bpf_ldst_imm8(u32 op, u8 rt, u8 rn, s16 imm8)
+{
+	op |= rt << 12 | rn << 16;
+	if (imm8 >= 0)
+		op |= ARM_INST_LDST__U;
+	else
+		imm8 = -imm8;
+	return op | (imm8 & 0xf0) << 4 | (imm8 & 0x0f);
+}
+
+#define ARM_LDR_I(rt, rn, off)	arm_bpf_ldst_imm12(ARM_INST_LDR_I, rt, rn, off)
+#define ARM_LDRB_I(rt, rn, off)	arm_bpf_ldst_imm12(ARM_INST_LDRB_I, rt, rn, off)
+#define ARM_LDRH_I(rt, rn, off)	arm_bpf_ldst_imm8(ARM_INST_LDRH_I, rt, rn, off)
+
+#define ARM_STR_I(rt, rn, off)	arm_bpf_ldst_imm12(ARM_INST_STR_I, rt, rn, off)
+#define ARM_STRB_I(rt, rn, off)	arm_bpf_ldst_imm12(ARM_INST_STRB_I, rt, rn, off)
+#define ARM_STRH_I(rt, rn, off)	arm_bpf_ldst_imm8(ARM_INST_STRH_I, rt, rn, off)
+
 /*
  * Initializes the JIT space with undefined instructions.
  */
diff --git a/arch/arm/net/bpf_jit_32.h b/arch/arm/net/bpf_jit_32.h
index d5cf5f6208aa..c55bc39d3e22 100644
--- a/arch/arm/net/bpf_jit_32.h
+++ b/arch/arm/net/bpf_jit_32.h
@@ -77,11 +77,12 @@
 #define ARM_INST_EOR_R		0x00200000
 #define ARM_INST_EOR_I		0x02200000
 
-#define ARM_INST_LDRB_I		0x05d00000
+#define ARM_INST_LDST__U	0x00800000
+#define ARM_INST_LDRB_I		0x05500000
 #define ARM_INST_LDRB_R		0x07d00000
-#define ARM_INST_LDRH_I		0x01d000b0
+#define ARM_INST_LDRH_I		0x015000b0
 #define ARM_INST_LDRH_R		0x019000b0
-#define ARM_INST_LDR_I		0x05900000
+#define ARM_INST_LDR_I		0x05100000
 #define ARM_INST_LDR_R		0x07900000
 
 #define ARM_INST_LDM		0x08900000
@@ -124,9 +125,9 @@
 #define ARM_INST_SBC_R		0x00c00000
 #define ARM_INST_SBCS_R		0x00d00000
 
-#define ARM_INST_STR_I		0x05800000
-#define ARM_INST_STRB_I		0x05c00000
-#define ARM_INST_STRH_I		0x01c000b0
+#define ARM_INST_STR_I		0x05000000
+#define ARM_INST_STRB_I		0x05400000
+#define ARM_INST_STRH_I		0x014000b0
 
 #define ARM_INST_TST_R		0x01100000
 #define ARM_INST_TST_I		0x03100000
@@ -183,17 +184,14 @@
 #define ARM_EOR_R(rd, rn, rm)	_AL3_R(ARM_INST_EOR, rd, rn, rm)
 #define ARM_EOR_I(rd, rn, imm)	_AL3_I(ARM_INST_EOR, rd, rn, imm)
 
-#define ARM_LDR_I(rt, rn, off)	(ARM_INST_LDR_I | (rt) << 12 | (rn) << 16 \
-				 | ((off) & 0xfff))
-#define ARM_LDR_R(rt, rn, rm)	(ARM_INST_LDR_R | (rt) << 12 | (rn) << 16 \
+#define ARM_LDR_R(rt, rn, rm)	(ARM_INST_LDR_R | ARM_INST_LDST__U \
+				 | (rt) << 12 | (rn) << 16 \
 				 | (rm))
-#define ARM_LDRB_I(rt, rn, off)	(ARM_INST_LDRB_I | (rt) << 12 | (rn) << 16 \
-				 | (off))
-#define ARM_LDRB_R(rt, rn, rm)	(ARM_INST_LDRB_R | (rt) << 12 | (rn) << 16 \
+#define ARM_LDRB_R(rt, rn, rm)	(ARM_INST_LDRB_R | ARM_INST_LDST__U \
+				 | (rt) << 12 | (rn) << 16 \
 				 | (rm))
-#define ARM_LDRH_I(rt, rn, off)	(ARM_INST_LDRH_I | (rt) << 12 | (rn) << 16 \
-				 | (((off) & 0xf0) << 4) | ((off) & 0xf))
-#define ARM_LDRH_R(rt, rn, rm)	(ARM_INST_LDRH_R | (rt) << 12 | (rn) << 16 \
+#define ARM_LDRH_R(rt, rn, rm)	(ARM_INST_LDRH_R | ARM_INST_LDST__U \
+				 | (rt) << 12 | (rn) << 16 \
 				 | (rm))
 
 #define ARM_LDM(rn, regs)	(ARM_INST_LDM | (rn) << 16 | (regs))
@@ -254,13 +252,6 @@
 #define ARM_SUBS_I(rd, rn, imm)	_AL3_I(ARM_INST_SUBS, rd, rn, imm)
 #define ARM_SBC_I(rd, rn, imm)	_AL3_I(ARM_INST_SBC, rd, rn, imm)
 
-#define ARM_STR_I(rt, rn, off)	(ARM_INST_STR_I | (rt) << 12 | (rn) << 16 \
-				 | ((off) & 0xfff))
-#define ARM_STRH_I(rt, rn, off)	(ARM_INST_STRH_I | (rt) << 12 | (rn) << 16 \
-				 | (((off) & 0xf0) << 4) | ((off) & 0xf))
-#define ARM_STRB_I(rt, rn, off)	(ARM_INST_STRB_I | (rt) << 12 | (rn) << 16 \
-				 | (((off) & 0xf0) << 4) | ((off) & 0xf))
-
 #define ARM_TST_R(rn, rm)	_AL3_R(ARM_INST_TST, 0, rn, rm)
 #define ARM_TST_I(rn, imm)	_AL3_I(ARM_INST_TST, 0, rn, imm)
 
-- 
2.7.4
