From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 18 Sep 2018 23:51:44 -0700
Subject: [PATCH v3 9/9] s390/jump_label: switch to relative references
In-Reply-To: <20180919065144.25010-1-ard.biesheuvel@linaro.org>
References: <20180919065144.25010-1-ard.biesheuvel@linaro.org>
Message-ID: <20180919065144.25010-10-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Enable support for relative references in jump_label entries.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/s390/Kconfig                  |  1 +
 arch/s390/include/asm/jump_label.h | 40 ++++++++------------
 arch/s390/kernel/jump_label.c      | 11 +++---
 3 files changed, 23 insertions(+), 29 deletions(-)

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 9a9c7a6fe925..12dc4c1af96c 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -120,6 +120,7 @@ config S390
 	select HAVE_ALIGNED_STRUCT_PAGE if SLUB
 	select HAVE_ARCH_AUDITSYSCALL
 	select HAVE_ARCH_JUMP_LABEL
+	select HAVE_ARCH_JUMP_LABEL_RELATIVE
 	select CPU_NO_EFFICIENT_FFS if !HAVE_MARCH_Z9_109_FEATURES
 	select HAVE_ARCH_SECCOMP_FILTER
 	select HAVE_ARCH_SOFT_DIRTY
diff --git a/arch/s390/include/asm/jump_label.h b/arch/s390/include/asm/jump_label.h
index 40f651292aa7..e2d3e6c43395 100644
--- a/arch/s390/include/asm/jump_label.h
+++ b/arch/s390/include/asm/jump_label.h
@@ -14,41 +14,33 @@
  * We use a brcl 0,2 instruction for jump labels at compile time so it
  * can be easily distinguished from a hotpatch generated instruction.
  */
-static __always_inline bool arch_static_branch(struct static_key *key, bool branch)
+static inline bool arch_static_branch(struct static_key *key, bool branch)
 {
-	asm_volatile_goto("0:	brcl 0,"__stringify(JUMP_LABEL_NOP_OFFSET)"\n"
-		".pushsection __jump_table, \"aw\"\n"
-		".balign 8\n"
-		".quad 0b, %l[label], %0\n"
-		".popsection\n"
-		: : "X" (&((char *)key)[branch]) : : label);
-
+	asm_volatile_goto("0:	brcl	0,"__stringify(JUMP_LABEL_NOP_OFFSET)"\n"
+			  ".pushsection __jump_table,\"aw\"\n"
+			  ".balign	8\n"
+			  ".long	0b-.,%l[label]-.\n"
+			  ".quad	%0-.\n"
+			  ".popsection\n"
+			  : : "X" (&((char *)key)[branch]) : : label);
 	return false;
 label:
 	return true;
 }
 
-static __always_inline bool arch_static_branch_jump(struct static_key *key, bool branch)
+static inline bool arch_static_branch_jump(struct static_key *key, bool branch)
 {
-	asm_volatile_goto("0:	brcl 15, %l[label]\n"
-		".pushsection __jump_table, \"aw\"\n"
-		".balign 8\n"
-		".quad 0b, %l[label], %0\n"
-		".popsection\n"
-		: : "X" (&((char *)key)[branch]) : : label);
-
+	asm_volatile_goto("0:	brcl 15,%l[label]\n"
+			  ".pushsection __jump_table,\"aw\"\n"
+			  ".balign	8\n"
+			  ".long	0b-.,%l[label]-.\n"
+			  ".quad	%0-.\n"
+			  ".popsection\n"
+			  : : "X" (&((char *)key)[branch]) : : label);
 	return false;
 label:
 	return true;
 }
 
-typedef unsigned long jump_label_t;
-
-struct jump_entry {
-	jump_label_t code;
-	jump_label_t target;
-	jump_label_t key;
-};
-
 #endif  /* __ASSEMBLY__ */
 #endif
diff --git a/arch/s390/kernel/jump_label.c b/arch/s390/kernel/jump_label.c
index 43f8430fb67d..50a1798604a8 100644
--- a/arch/s390/kernel/jump_label.c
+++ b/arch/s390/kernel/jump_label.c
@@ -33,13 +33,13 @@ static void jump_label_make_branch(struct jump_entry *entry, struct insn *insn)
 {
 	/* brcl 15,offset */
 	insn->opcode = 0xc0f4;
-	insn->offset = (entry->target - entry->code) >> 1;
+	insn->offset = (jump_entry_target(entry) - jump_entry_code(entry)) >> 1;
 }
 
 static void jump_label_bug(struct jump_entry *entry, struct insn *expected,
 			   struct insn *new)
 {
-	unsigned char *ipc = (unsigned char *)entry->code;
+	unsigned char *ipc = (unsigned char *)jump_entry_code(entry);
 	unsigned char *ipe = (unsigned char *)expected;
 	unsigned char *ipn = (unsigned char *)new;
 
@@ -59,6 +59,7 @@ static void __jump_label_transform(struct jump_entry *entry,
 				   enum jump_label_type type,
 				   int init)
 {
+	void *code = (void *)jump_entry_code(entry);
 	struct insn old, new;
 
 	if (type == JUMP_LABEL_JMP) {
@@ -69,13 +70,13 @@ static void __jump_label_transform(struct jump_entry *entry,
 		jump_label_make_nop(entry, &new);
 	}
 	if (init) {
-		if (memcmp((void *)entry->code, &orignop, sizeof(orignop)))
+		if (memcmp(code, &orignop, sizeof(orignop)))
 			jump_label_bug(entry, &orignop, &new);
 	} else {
-		if (memcmp((void *)entry->code, &old, sizeof(old)))
+		if (memcmp(code, &old, sizeof(old)))
 			jump_label_bug(entry, &old, &new);
 	}
-	s390_kernel_write((void *)entry->code, &new, sizeof(new));
+	s390_kernel_write(code, &new, sizeof(new));
 }
 
 static int __sm_arch_jump_label_transform(void *data)
-- 
2.17.1
