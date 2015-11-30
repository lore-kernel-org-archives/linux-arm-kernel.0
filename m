From: kamal@canonical.com (Kamal Mostafa)
Date: Mon, 30 Nov 2015 14:10:08 -0800
Subject: [3.19.y-ckt stable] Patch "arm64: bpf: fix div-by-zero case" has been
 added to staging queue
Message-ID: <1448921408-11379-1-git-send-email-kamal@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a note to let you know that I have just added a patch titled

    arm64: bpf: fix div-by-zero case

to the linux-3.19.y-queue branch of the 3.19.y-ckt extended stable tree 
which can be found at:

    http://kernel.ubuntu.com/git/ubuntu/linux.git/log/?h=linux-3.19.y-queue

This patch is scheduled to be released in version 3.19.8-ckt11.

If you, or anyone else, feels it should not be added to this tree, please 
reply to this email.

For more information about the 3.19.y-ckt tree, see
https://wiki.ubuntu.com/Kernel/Dev/ExtendedStable

Thanks.
-Kamal

------

>From eb0c40a4a3aef5b7997b29196511e36cd9234915 Mon Sep 17 00:00:00 2001
From: Zi Shen Lim <zlim.lnx@gmail.com>
Date: Tue, 3 Nov 2015 22:56:44 -0800
Subject: arm64: bpf: fix div-by-zero case

commit 251599e1d6906621f49218d7b474ddd159e58f3b upstream.

In the case of division by zero in a BPF program:
	A = A / X;  (X == 0)
the expected behavior is to terminate with return value 0.

This is confirmed by the test case introduced in commit 86bf1721b226
("test_bpf: add tests checking that JIT/interpreter sets A and X to 0.").

Reported-by: Yang Shi <yang.shi@linaro.org>
Tested-by: Yang Shi <yang.shi@linaro.org>
CC: Xi Wang <xi.wang@gmail.com>
CC: Alexei Starovoitov <ast@plumgrid.com>
CC: linux-arm-kernel at lists.infradead.org
CC: linux-kernel at vger.kernel.org
Fixes: e54bcde3d69d ("arm64: eBPF JIT compiler")
Signed-off-by: Zi Shen Lim <zlim.lnx@gmail.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Kamal Mostafa <kamal@canonical.com>
---
 arch/arm64/net/bpf_jit.h      |  3 ++-
 arch/arm64/net/bpf_jit_comp.c | 37 +++++++++++++++++++++++++------------
 2 files changed, 27 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/net/bpf_jit.h b/arch/arm64/net/bpf_jit.h
index 98a26ce..aee5637 100644
--- a/arch/arm64/net/bpf_jit.h
+++ b/arch/arm64/net/bpf_jit.h
@@ -1,7 +1,7 @@
 /*
  * BPF JIT compiler for ARM64
  *
- * Copyright (C) 2014 Zi Shen Lim <zlim.lnx@gmail.com>
+ * Copyright (C) 2014-2015 Zi Shen Lim <zlim.lnx@gmail.com>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -35,6 +35,7 @@
 	aarch64_insn_gen_comp_branch_imm(0, offset, Rt, A64_VARIANT(sf), \
 		AARCH64_INSN_BRANCH_COMP_##type)
 #define A64_CBZ(sf, Rt, imm19) A64_COMP_BRANCH(sf, Rt, (imm19) << 2, ZERO)
+#define A64_CBNZ(sf, Rt, imm19) A64_COMP_BRANCH(sf, Rt, (imm19) << 2, NONZERO)

 /* Conditional branch (immediate) */
 #define A64_COND_BRANCH(cond, offset) \
diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index c047598..9ae6f23 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -1,7 +1,7 @@
 /*
  * BPF JIT compiler for ARM64
  *
- * Copyright (C) 2014 Zi Shen Lim <zlim.lnx@gmail.com>
+ * Copyright (C) 2014-2015 Zi Shen Lim <zlim.lnx@gmail.com>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -225,6 +225,17 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx)
 	u8 jmp_cond;
 	s32 jmp_offset;

+#define check_imm(bits, imm) do {				\
+	if ((((imm) > 0) && ((imm) >> (bits))) ||		\
+	    (((imm) < 0) && (~(imm) >> (bits)))) {		\
+		pr_info("[%2d] imm=%d(0x%x) out of range\n",	\
+			i, imm, imm);				\
+		return -EINVAL;					\
+	}							\
+} while (0)
+#define check_imm19(imm) check_imm(19, imm)
+#define check_imm26(imm) check_imm(26, imm)
+
 	switch (code) {
 	/* dst = src */
 	case BPF_ALU | BPF_MOV | BPF_X:
@@ -258,8 +269,21 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx)
 		break;
 	case BPF_ALU | BPF_DIV | BPF_X:
 	case BPF_ALU64 | BPF_DIV | BPF_X:
+	{
+		const u8 r0 = bpf2a64[BPF_REG_0];
+
+		/* if (src == 0) return 0 */
+		jmp_offset = 3; /* skip ahead to else path */
+		check_imm19(jmp_offset);
+		emit(A64_CBNZ(is64, src, jmp_offset), ctx);
+		emit(A64_MOVZ(1, r0, 0, 0), ctx);
+		jmp_offset = epilogue_offset(ctx);
+		check_imm26(jmp_offset);
+		emit(A64_B(jmp_offset), ctx);
+		/* else */
 		emit(A64_UDIV(is64, dst, dst, src), ctx);
 		break;
+	}
 	case BPF_ALU | BPF_MOD | BPF_X:
 	case BPF_ALU64 | BPF_MOD | BPF_X:
 		ctx->tmp_used = 1;
@@ -393,17 +417,6 @@ emit_bswap_uxt:
 		emit(A64_ASR(is64, dst, dst, imm), ctx);
 		break;

-#define check_imm(bits, imm) do {				\
-	if ((((imm) > 0) && ((imm) >> (bits))) ||		\
-	    (((imm) < 0) && (~(imm) >> (bits)))) {		\
-		pr_info("[%2d] imm=%d(0x%x) out of range\n",	\
-			i, imm, imm);				\
-		return -EINVAL;					\
-	}							\
-} while (0)
-#define check_imm19(imm) check_imm(19, imm)
-#define check_imm26(imm) check_imm(26, imm)
-
 	/* JUMP off */
 	case BPF_JMP | BPF_JA:
 		jmp_offset = bpf2a64_offset(i + off, i, ctx);
--
1.9.1
