From: luc.vanoostenryck@gmail.com (Luc Van Oostenryck)
Date: Wed, 28 Jun 2017 16:56:00 +0200
Subject: [PATCH] arm64: fix endianness annotation for reloc_insn_movw() &
 reloc_insn_imm()
Message-ID: <20170628145600.24498-1-luc.vanoostenryck@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here the functions reloc_insn_movw() & reloc_insn_imm() are used
to read, modify and write back ARM instructions, which are always
stored in memory in little-endian order. These values are thus
correctly converted to/from native order but the pointers used to
hold their addresses are declared as for native order values.

Fix this by declaring the pointers as __le32* and remove the
casts that are now unneeded.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 arch/arm64/kernel/module.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/kernel/module.c b/arch/arm64/kernel/module.c
index f035ff6fb..864725d9e 100644
--- a/arch/arm64/kernel/module.c
+++ b/arch/arm64/kernel/module.c
@@ -74,7 +74,7 @@ enum aarch64_reloc_op {
 	RELOC_OP_PAGE,
 };
 
-static u64 do_reloc(enum aarch64_reloc_op reloc_op, void *place, u64 val)
+static u64 do_reloc(enum aarch64_reloc_op reloc_op, __le32 *place, u64 val)
 {
 	switch (reloc_op) {
 	case RELOC_OP_ABS:
@@ -121,12 +121,12 @@ enum aarch64_insn_movw_imm_type {
 	AARCH64_INSN_IMM_MOVKZ,
 };
 
-static int reloc_insn_movw(enum aarch64_reloc_op op, void *place, u64 val,
+static int reloc_insn_movw(enum aarch64_reloc_op op, __le32 *place, u64 val,
 			   int lsb, enum aarch64_insn_movw_imm_type imm_type)
 {
 	u64 imm;
 	s64 sval;
-	u32 insn = le32_to_cpu(*(u32 *)place);
+	u32 insn = le32_to_cpu(*place);
 
 	sval = do_reloc(op, place, val);
 	imm = sval >> lsb;
@@ -154,7 +154,7 @@ static int reloc_insn_movw(enum aarch64_reloc_op op, void *place, u64 val,
 
 	/* Update the instruction with the new encoding. */
 	insn = aarch64_insn_encode_immediate(AARCH64_INSN_IMM_16, insn, imm);
-	*(u32 *)place = cpu_to_le32(insn);
+	*place = cpu_to_le32(insn);
 
 	if (imm > U16_MAX)
 		return -ERANGE;
@@ -162,12 +162,12 @@ static int reloc_insn_movw(enum aarch64_reloc_op op, void *place, u64 val,
 	return 0;
 }
 
-static int reloc_insn_imm(enum aarch64_reloc_op op, void *place, u64 val,
+static int reloc_insn_imm(enum aarch64_reloc_op op, __le32 *place, u64 val,
 			  int lsb, int len, enum aarch64_insn_imm_type imm_type)
 {
 	u64 imm, imm_mask;
 	s64 sval;
-	u32 insn = le32_to_cpu(*(u32 *)place);
+	u32 insn = le32_to_cpu(*place);
 
 	/* Calculate the relocation value. */
 	sval = do_reloc(op, place, val);
@@ -179,7 +179,7 @@ static int reloc_insn_imm(enum aarch64_reloc_op op, void *place, u64 val,
 
 	/* Update the instruction's immediate field. */
 	insn = aarch64_insn_encode_immediate(imm_type, insn, imm);
-	*(u32 *)place = cpu_to_le32(insn);
+	*place = cpu_to_le32(insn);
 
 	/*
 	 * Extract the upper value bits (including the sign bit) and
-- 
2.13.0
