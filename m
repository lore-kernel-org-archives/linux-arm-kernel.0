From: yalin.wang2010@gmail.com (yalin wang)
Date: Fri, 31 Jul 2015 15:41:37 +0800
Subject: [RFC] arm64:change jump_label to use branch instruction,
 not use  NOP instr
Message-ID: <94E2034B-9DE4-4ADF-8B2F-197D38A363CF@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This change a little arch_static_branch(), use b . + 4 for false
return, why? According to aarch64 TRM, if both source and dest
instr are branch instr, can patch the instr directly, don't need
all cpu to do ISB for sync, this means we can call
aarch64_insn_patch_text_nosync() during patch_text(),
will improve the performance when change a static_key.

Signed-off-by: yalin wang <yalin.wang2010@gmail.com>
---
 arch/arm64/include/asm/jump_label.h |  2 +-
 arch/arm64/kernel/jump_label.c      | 14 ++++++++------
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/include/asm/jump_label.h b/arch/arm64/include/asm/jump_label.h
index c0e5165..25b1668 100644
--- a/arch/arm64/include/asm/jump_label.h
+++ b/arch/arm64/include/asm/jump_label.h
@@ -28,7 +28,7 @@
 
 static __always_inline bool arch_static_branch(struct static_key *key)
 {
-	asm goto("1: nop\n\t"
+	asm goto("1: b . + " __stringify(AARCH64_INSN_SIZE) "\n\t"
 		 ".pushsection __jump_table,  \"aw\"\n\t"
 		 ".align 3\n\t"
 		 ".quad 1b, %l[l_yes], %c0\n\t"
diff --git a/arch/arm64/kernel/jump_label.c b/arch/arm64/kernel/jump_label.c
index 4f1fec7..eb09868 100644
--- a/arch/arm64/kernel/jump_label.c
+++ b/arch/arm64/kernel/jump_label.c
@@ -28,13 +28,15 @@ void arch_jump_label_transform(struct jump_entry *entry,
 	void *addr = (void *)entry->code;
 	u32 insn;
 
-	if (type == JUMP_LABEL_ENABLE) {
+	if (type == JUMP_LABEL_ENABLE)
 		insn = aarch64_insn_gen_branch_imm(entry->code,
-						   entry->target,
-						   AARCH64_INSN_BRANCH_NOLINK);
-	} else {
-		insn = aarch64_insn_gen_nop();
-	}
+			entry->target,
+			AARCH64_INSN_BRANCH_NOLINK);
+	else
+		insn = aarch64_insn_gen_branch_imm(entry->code,
+			(unsigned long)addr + AARCH64_INSN_SIZE,
+			AARCH64_INSN_BRANCH_NOLINK);
+
 
 	aarch64_insn_patch_text(&addr, &insn, 1);
 }
-- 
1.9.1
