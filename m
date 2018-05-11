From: udknight@gmail.com (Wang YanQing)
Date: Fri, 11 May 2018 11:06:34 +0800
Subject: [PATCH v2] bpf, arm32: Correct check_imm24
Message-ID: <20180511030634.GB7621@udknight>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

imm24 is signed, so the right range is:
[-(1<<(24 - 1)), (1<<(24 - 1)) - 1]

Note:this patch also fix a typo.

Signed-off-by: Wang YanQing <udknight@gmail.com>
---
 Changes
 v1-v2:
 1:Rewrite the patch, I make a mistake, the v1 is wrong totally,
   reported by Russell King.

   I use the fix suggested by Russell King instead of myself which
   use the exact number range [-8388608, 8388607].
 2:Fix the error in changelog.

 Thanks!

 arch/arm/net/bpf_jit_32.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/net/bpf_jit_32.c b/arch/arm/net/bpf_jit_32.c
index caccc78..316bc08 100644
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
@@ -1199,8 +1199,8 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx)
 	s32 jmp_offset;
 
 #define check_imm(bits, imm) do {				\
-	if ((((imm) > 0) && ((imm) >> (bits))) ||		\
-	    (((imm) < 0) && (~(imm) >> (bits)))) {		\
+	if ((imm) >= (1 << ((bits) - 1)) ||			\
+	    (imm) < -(1 << ((bits) - 1))) {			\
 		pr_info("[%2d] imm=%d(0x%x) out of range\n",	\
 			i, imm, imm);				\
 		return -EINVAL;					\
-- 
1.8.5.6.2.g3d8a54e.dirty
