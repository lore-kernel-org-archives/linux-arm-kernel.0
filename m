From: broonie@kernel.org (Mark Brown)
Date: Tue, 16 Sep 2014 09:42:33 -0700
Subject: [PATCH] arm64: insn: Add return statements after BUG_ON()
Message-ID: <1410885753-25025-1-git-send-email-broonie@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Following a recent series of enhancements to the insn code the ARMv8
allnoconfig build has been generating a large number of warnings in the
form of:

arch/arm64/kernel/insn.c:689:8: warning: 'insn' may be used uninitialized in this function [-Wmaybe-uninitialized]

This is because BUG() and related macros can be compiled out so we get
execution paths which normally result in a panic compiling out to noops
instead.

I wasn't able to immediately identify a sensible return value to use in
these cases so just return 0 - this is all "should never happen" code so
hopefully it never has a practical impact.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/kernel/insn.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm64/kernel/insn.c b/arch/arm64/kernel/insn.c
index 0668ee5..7af35f3 100644
--- a/arch/arm64/kernel/insn.c
+++ b/arch/arm64/kernel/insn.c
@@ -388,6 +388,7 @@ u32 __kprobes aarch64_insn_gen_branch_imm(unsigned long pc, unsigned long addr,
 		break;
 	default:
 		BUG_ON(1);
+		return 0;
 	}
 
 	return aarch64_insn_encode_immediate(AARCH64_INSN_IMM_26, insn,
@@ -413,6 +414,7 @@ u32 aarch64_insn_gen_comp_branch_imm(unsigned long pc, unsigned long addr,
 		break;
 	default:
 		BUG_ON(1);
+		return 0;
 	}
 
 	switch (variant) {
@@ -423,6 +425,7 @@ u32 aarch64_insn_gen_comp_branch_imm(unsigned long pc, unsigned long addr,
 		break;
 	default:
 		BUG_ON(1);
+		return 0;
 	}
 
 	insn = aarch64_insn_encode_register(AARCH64_INSN_REGTYPE_RT, insn, reg);
@@ -475,6 +478,7 @@ u32 aarch64_insn_gen_branch_reg(enum aarch64_insn_register reg,
 		break;
 	default:
 		BUG_ON(1);
+		return 0;
 	}
 
 	return aarch64_insn_encode_register(AARCH64_INSN_REGTYPE_RN, insn, reg);
@@ -497,6 +501,7 @@ u32 aarch64_insn_gen_load_store_reg(enum aarch64_insn_register reg,
 		break;
 	default:
 		BUG_ON(1);
+		return 0;
 	}
 
 	insn = aarch64_insn_encode_ldst_size(size, insn);
@@ -535,6 +540,7 @@ u32 aarch64_insn_gen_load_store_pair(enum aarch64_insn_register reg1,
 		break;
 	default:
 		BUG_ON(1);
+		return 0;
 	}
 
 	switch (variant) {
@@ -553,6 +559,7 @@ u32 aarch64_insn_gen_load_store_pair(enum aarch64_insn_register reg1,
 		break;
 	default:
 		BUG_ON(1);
+		return 0;
 	}
 
 	insn = aarch64_insn_encode_register(AARCH64_INSN_REGTYPE_RT, insn,
@@ -590,6 +597,7 @@ u32 aarch64_insn_gen_add_sub_imm(enum aarch64_insn_register dst,
 		break;
 	default:
 		BUG_ON(1);
+		return 0;
 	}
 
 	switch (variant) {
@@ -600,6 +608,7 @@ u32 aarch64_insn_gen_add_sub_imm(enum aarch64_insn_register dst,
 		break;
 	default:
 		BUG_ON(1);
+		return 0;
 	}
 
 	BUG_ON(imm & ~(SZ_4K - 1));
@@ -632,6 +641,7 @@ u32 aarch64_insn_gen_bitfield(enum aarch64_insn_register dst,
 		break;
 	default:
 		BUG_ON(1);
+		return 0;
 	}
 
 	switch (variant) {
@@ -644,6 +654,7 @@ u32 aarch64_insn_gen_bitfield(enum aarch64_insn_register dst,
 		break;
 	default:
 		BUG_ON(1);
+		return 0;
 	}
 
 	BUG_ON(immr & ~mask);
@@ -677,6 +688,7 @@ u32 aarch64_insn_gen_movewide(enum aarch64_insn_register dst,
 		break;
 	default:
 		BUG_ON(1);
+		return 0;
 	}
 
 	BUG_ON(imm & ~(SZ_64K - 1));
@@ -692,6 +704,7 @@ u32 aarch64_insn_gen_movewide(enum aarch64_insn_register dst,
 		break;
 	default:
 		BUG_ON(1);
+		return 0;
 	}
 
 	insn |= (shift >> 4) << 21;
@@ -725,6 +738,7 @@ u32 aarch64_insn_gen_add_sub_shifted_reg(enum aarch64_insn_register dst,
 		break;
 	default:
 		BUG_ON(1);
+		return 0;
 	}
 
 	switch (variant) {
@@ -737,6 +751,7 @@ u32 aarch64_insn_gen_add_sub_shifted_reg(enum aarch64_insn_register dst,
 		break;
 	default:
 		BUG_ON(1);
+		return 0;
 	}
 
 
@@ -769,6 +784,7 @@ u32 aarch64_insn_gen_data1(enum aarch64_insn_register dst,
 		break;
 	default:
 		BUG_ON(1);
+		return 0;
 	}
 
 	switch (variant) {
@@ -779,6 +795,7 @@ u32 aarch64_insn_gen_data1(enum aarch64_insn_register dst,
 		break;
 	default:
 		BUG_ON(1);
+		return 0;
 	}
 
 	insn = aarch64_insn_encode_register(AARCH64_INSN_REGTYPE_RD, insn, dst);
@@ -815,6 +832,7 @@ u32 aarch64_insn_gen_data2(enum aarch64_insn_register dst,
 		break;
 	default:
 		BUG_ON(1);
+		return 0;
 	}
 
 	switch (variant) {
@@ -825,6 +843,7 @@ u32 aarch64_insn_gen_data2(enum aarch64_insn_register dst,
 		break;
 	default:
 		BUG_ON(1);
+		return 0;
 	}
 
 	insn = aarch64_insn_encode_register(AARCH64_INSN_REGTYPE_RD, insn, dst);
@@ -852,6 +871,7 @@ u32 aarch64_insn_gen_data3(enum aarch64_insn_register dst,
 		break;
 	default:
 		BUG_ON(1);
+		return 0;
 	}
 
 	switch (variant) {
@@ -862,6 +882,7 @@ u32 aarch64_insn_gen_data3(enum aarch64_insn_register dst,
 		break;
 	default:
 		BUG_ON(1);
+		return 0;
 	}
 
 	insn = aarch64_insn_encode_register(AARCH64_INSN_REGTYPE_RD, insn, dst);
@@ -911,6 +932,7 @@ u32 aarch64_insn_gen_logical_shifted_reg(enum aarch64_insn_register dst,
 		break;
 	default:
 		BUG_ON(1);
+		return 0;
 	}
 
 	switch (variant) {
@@ -923,6 +945,7 @@ u32 aarch64_insn_gen_logical_shifted_reg(enum aarch64_insn_register dst,
 		break;
 	default:
 		BUG_ON(1);
+		return 0;
 	}
 
 
-- 
2.1.0
