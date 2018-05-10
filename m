From: udknight@gmail.com (Wang YanQing)
Date: Thu, 10 May 2018 11:20:13 +0800
Subject: [PATCH] bpf, arm32: Correct check_imm24
Message-ID: <20180510032013.GB26016@udknight>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

imm24 is signed, so the right range is:
[-(2<<(24 - 1)), (2<<(24 - 1)) - 1]

Note:this patch also fix a typo.

Signed-off-by: Wang YanQing <udknight@gmail.com>
---
 arch/arm/net/bpf_jit_32.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/arm/net/bpf_jit_32.c b/arch/arm/net/bpf_jit_32.c
index c0b4124..19c6d77 100644
--- a/arch/arm/net/bpf_jit_32.c
+++ b/arch/arm/net/bpf_jit_32.c
@@ -84,7 +84,7 @@
  *
  * 1. First argument is passed using the arm 32bit registers and rest of the
  * arguments are passed on stack scratch space.
- * 2. First callee-saved arugument is mapped to arm 32 bit registers and rest
+ * 2. First callee-saved argument is mapped to arm 32 bit registers and rest
  * arguments are mapped to scratch space on stack.
  * 3. We need two 64 bit temp registers to do complex operations on eBPF
  * registers.
@@ -1198,15 +1198,14 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx)
 	u8 rd, rt, rm, rn;
 	s32 jmp_offset;
 
-#define check_imm(bits, imm) do {				\
-	if ((((imm) > 0) && ((imm) >> (bits))) ||		\
-	    (((imm) < 0) && (~(imm) >> (bits)))) {		\
-		pr_info("[%2d] imm=%d(0x%x) out of range\n",	\
-			i, imm, imm);				\
+#define check_imm_range(min, max, imm) do {			\
+	if (imm < min || imm > max) {				\
+		pr_info("[%2d] imm=%d is out of range\n",	\
+			i, imm);				\
 		return -EINVAL;					\
 	}							\
 } while (0)
-#define check_imm24(imm) check_imm(24, imm)
+#define check_imm24(imm) check_imm_range(-16777216, 16777215, imm)
 
 	switch (code) {
 	/* ALU operations */
-- 
1.8.5.6.2.g3d8a54e.dirty
