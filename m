From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 18 Sep 2018 23:51:41 -0700
Subject: [PATCH v3 6/9] x86/kernel: jump_table: use relative references
In-Reply-To: <20180919065144.25010-1-ard.biesheuvel@linaro.org>
References: <20180919065144.25010-1-ard.biesheuvel@linaro.org>
Message-ID: <20180919065144.25010-7-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Similar to the arm64 case, 64-bit x86 can benefit from using relative
references rather than absolute ones when emitting struct jump_entry
instances. Not only does this reduce the memory footprint of the entries
themselves by 33%, it also removes the need for carrying relocation
metadata on relocatable builds (i.e., for KASLR) which saves a fair
chunk of .init space as well (although the savings are not as dramatic
as on arm64)

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/x86/Kconfig                  |  1 +
 arch/x86/include/asm/jump_label.h | 24 +++++++-------------
 tools/objtool/special.c           |  4 ++--
 3 files changed, 11 insertions(+), 18 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 1a0be022f91d..603f374f871d 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -119,6 +119,7 @@ config X86
 	select HAVE_ARCH_AUDITSYSCALL
 	select HAVE_ARCH_HUGE_VMAP		if X86_64 || X86_PAE
 	select HAVE_ARCH_JUMP_LABEL
+	select HAVE_ARCH_JUMP_LABEL_RELATIVE
 	select HAVE_ARCH_KASAN			if X86_64
 	select HAVE_ARCH_KGDB
 	select HAVE_ARCH_MMAP_RND_BITS		if MMU
diff --git a/arch/x86/include/asm/jump_label.h b/arch/x86/include/asm/jump_label.h
index 8c0de4282659..21efc9d07ed9 100644
--- a/arch/x86/include/asm/jump_label.h
+++ b/arch/x86/include/asm/jump_label.h
@@ -37,7 +37,8 @@ static __always_inline bool arch_static_branch(struct static_key *key, bool bran
 		".byte " __stringify(STATIC_KEY_INIT_NOP) "\n\t"
 		".pushsection __jump_table,  \"aw\" \n\t"
 		_ASM_ALIGN "\n\t"
-		_ASM_PTR "1b, %l[l_yes], %c0 + %c1 \n\t"
+		".long 1b - ., %l[l_yes] - . \n\t"
+		_ASM_PTR "%c0 + %c1 - .\n\t"
 		".popsection \n\t"
 		: :  "i" (key), "i" (branch) : : l_yes);
 
@@ -53,7 +54,8 @@ static __always_inline bool arch_static_branch_jump(struct static_key *key, bool
 		"2:\n\t"
 		".pushsection __jump_table,  \"aw\" \n\t"
 		_ASM_ALIGN "\n\t"
-		_ASM_PTR "1b, %l[l_yes], %c0 + %c1 \n\t"
+		".long 1b - ., %l[l_yes] - . \n\t"
+		_ASM_PTR "%c0 + %c1 - .\n\t"
 		".popsection \n\t"
 		: :  "i" (key), "i" (branch) : : l_yes);
 
@@ -62,18 +64,6 @@ static __always_inline bool arch_static_branch_jump(struct static_key *key, bool
 	return true;
 }
 
-#ifdef CONFIG_X86_64
-typedef u64 jump_label_t;
-#else
-typedef u32 jump_label_t;
-#endif
-
-struct jump_entry {
-	jump_label_t code;
-	jump_label_t target;
-	jump_label_t key;
-};
-
 #else	/* __ASSEMBLY__ */
 
 .macro STATIC_JUMP_IF_TRUE target, key, def
@@ -88,7 +78,8 @@ struct jump_entry {
 	.endif
 	.pushsection __jump_table, "aw"
 	_ASM_ALIGN
-	_ASM_PTR	.Lstatic_jump_\@, \target, \key
+	.long		.Lstatic_jump_\@ - ., \target - .
+	_ASM_PTR	\key - .
 	.popsection
 .endm
 
@@ -104,7 +95,8 @@ struct jump_entry {
 	.endif
 	.pushsection __jump_table, "aw"
 	_ASM_ALIGN
-	_ASM_PTR	.Lstatic_jump_\@, \target, \key + 1
+	.long		.Lstatic_jump_\@ - ., \target - .
+	_ASM_PTR	\key + 1 - .
 	.popsection
 .endm
 
diff --git a/tools/objtool/special.c b/tools/objtool/special.c
index 84f001d52322..50af4e1274b3 100644
--- a/tools/objtool/special.c
+++ b/tools/objtool/special.c
@@ -30,9 +30,9 @@
 #define EX_ORIG_OFFSET		0
 #define EX_NEW_OFFSET		4
 
-#define JUMP_ENTRY_SIZE		24
+#define JUMP_ENTRY_SIZE		16
 #define JUMP_ORIG_OFFSET	0
-#define JUMP_NEW_OFFSET		8
+#define JUMP_NEW_OFFSET		4
 
 #define ALT_ENTRY_SIZE		13
 #define ALT_ORIG_OFFSET		0
-- 
2.17.1
