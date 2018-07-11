From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Wed, 11 Jul 2018 10:32:07 +0100
Subject: [PATCH net-next v2 08/14] ARM: net: bpf: imm12 constant conversion
In-Reply-To: <20180711093033.GP17271@n2100.armlinux.org.uk>
References: <20180711093033.GP17271@n2100.armlinux.org.uk>
Message-ID: <E1fdBTj-0001JF-Iq@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Provide a version of the imm8m() function that the compiler can optimise
when used with a constant expression.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/net/bpf_jit_32.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 49 insertions(+), 1 deletion(-)

diff --git a/arch/arm/net/bpf_jit_32.c b/arch/arm/net/bpf_jit_32.c
index 753b5b2b2e3d..2cc66aa44dfe 100644
--- a/arch/arm/net/bpf_jit_32.c
+++ b/arch/arm/net/bpf_jit_32.c
@@ -237,9 +237,55 @@ static inline void emit(u32 inst, struct jit_ctx *ctx)
 }
 
 /*
+ * This is rather horrid, but necessary to convert an integer constant
+ * to an immediate operand for the opcodes, and be able to detect at
+ * build time whether the constant can't be converted (iow, usable in
+ * BUILD_BUG_ON()).
+ */
+#define imm12val(v, s) (rol32(v, (s)) | (s) << 7)
+#define const_imm8m(x)					\
+	({ int r;					\
+	   u32 v = (x);					\
+	   if (!(v & ~0x000000ff))			\
+		r = imm12val(v, 0);			\
+	   else if (!(v & ~0xc000003f))			\
+		r = imm12val(v, 2);			\
+	   else if (!(v & ~0xf000000f))			\
+		r = imm12val(v, 4);			\
+	   else if (!(v & ~0xfc000003))			\
+		r = imm12val(v, 6);			\
+	   else if (!(v & ~0xff000000))			\
+		r = imm12val(v, 8);			\
+	   else if (!(v & ~0x3fc00000))			\
+		r = imm12val(v, 10);			\
+	   else if (!(v & ~0x0ff00000))			\
+		r = imm12val(v, 12);			\
+	   else if (!(v & ~0x03fc0000))			\
+		r = imm12val(v, 14);			\
+	   else if (!(v & ~0x00ff0000))			\
+		r = imm12val(v, 16);			\
+	   else if (!(v & ~0x003fc000))			\
+		r = imm12val(v, 18);			\
+	   else if (!(v & ~0x000ff000))			\
+		r = imm12val(v, 20);			\
+	   else if (!(v & ~0x0003fc00))			\
+		r = imm12val(v, 22);			\
+	   else if (!(v & ~0x0000ff00))			\
+		r = imm12val(v, 24);			\
+	   else if (!(v & ~0x00003fc0))			\
+		r = imm12val(v, 26);			\
+	   else if (!(v & ~0x00000ff0))			\
+		r = imm12val(v, 28);			\
+	   else if (!(v & ~0x000003fc))			\
+		r = imm12val(v, 30);			\
+	   else						\
+		r = -1;					\
+	   r; })
+
+/*
  * Checks if immediate value can be converted to imm12(12 bits) value.
  */
-static int16_t imm8m(u32 x)
+static int imm8m(u32 x)
 {
 	u32 rot;
 
@@ -249,6 +295,8 @@ static int16_t imm8m(u32 x)
 	return -1;
 }
 
+#define imm8m(x) (__builtin_constant_p(x) ? const_imm8m(x) : imm8m(x))
+
 static u32 arm_bpf_ldst_imm12(u32 op, u8 rt, u8 rn, s16 imm12)
 {
 	op |= rt << 12 | rn << 16;
-- 
2.7.4
