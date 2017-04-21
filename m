From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Sat, 22 Apr 2017 04:03:27 +0900
Subject: [RFC PATCH 2/2] bug.h: replace __FILE__ with KBUILD_FILE for shorter
 names in log
In-Reply-To: <1492801407-26823-1-git-send-email-yamada.masahiro@socionext.com>
References: <1492801407-26823-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1492801407-26823-3-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

__FILE__ can be a long absolute path for out-of-tree build.
The output of WARN_ON() and friends depends on the location of
the object tree, like this:

WARNING: CPU: 1 PID: 1 at /path/to/build/directory/arch/arm64/kernel/foo.c:...

KBUILD_FILE is a relative from srctree, so we will always see the
same path with/without O= option.

WARNING: CPU: 1 PID: 1 at arch/arm64/kernel/foo.c:...

Note:
"git grep __FILE__" has more than 1000 hits.  Perhaps, we may want
to do 's/__FILE__/KBUILD_FILE/' tree-wide.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/alpha/include/asm/bug.h          | 2 +-
 arch/arc/include/asm/bug.h            | 2 +-
 arch/arm/include/asm/bug.h            | 4 ++--
 arch/arm64/include/asm/bug.h          | 2 +-
 arch/avr32/include/asm/bug.h          | 2 +-
 arch/blackfin/include/asm/bug.h       | 2 +-
 arch/cris/include/arch-v10/arch/bug.h | 6 +++---
 arch/cris/include/arch-v32/arch/bug.h | 2 +-
 arch/frv/include/asm/bug.h            | 2 +-
 arch/ia64/include/asm/bug.h           | 2 +-
 arch/m68k/include/asm/bug.h           | 4 ++--
 arch/mn10300/include/asm/bug.h        | 2 +-
 arch/parisc/include/asm/bug.h         | 4 ++--
 arch/powerpc/include/asm/bug.h        | 8 ++++----
 arch/s390/include/asm/bug.h           | 2 +-
 arch/score/include/asm/bug.h          | 4 ++--
 arch/sh/include/asm/bug.h             | 8 ++++----
 arch/sparc/include/asm/bug.h          | 2 +-
 arch/x86/include/asm/bug.h            | 2 +-
 include/asm-generic/bug.h             | 8 ++++----
 20 files changed, 35 insertions(+), 35 deletions(-)

diff --git a/arch/alpha/include/asm/bug.h b/arch/alpha/include/asm/bug.h
index f091682..8dd0661 100644
--- a/arch/alpha/include/asm/bug.h
+++ b/arch/alpha/include/asm/bug.h
@@ -12,7 +12,7 @@
 	__asm__ __volatile__(						\
 		"call_pal %0  # bugchk\n\t"				\
 		".long %1\n\t.8byte %2"					\
-		: : "i"(PAL_bugchk), "i"(__LINE__), "i"(__FILE__));	\
+		: : "i"(PAL_bugchk), "i"(__LINE__), "i"(KBUILD_FILE));	\
 	unreachable();							\
   } while (0)
 
diff --git a/arch/arc/include/asm/bug.h b/arch/arc/include/asm/bug.h
index ea022d4..620f03e 100644
--- a/arch/arc/include/asm/bug.h
+++ b/arch/arc/include/asm/bug.h
@@ -22,7 +22,7 @@ void show_kernel_fault_diag(const char *str, struct pt_regs *regs,
 void die(const char *str, struct pt_regs *regs, unsigned long address);
 
 #define BUG()	do {								\
-	pr_warn("BUG: failure at %s:%d/%s()!\n", __FILE__, __LINE__, __func__); \
+	pr_warn("BUG: failure at %s:%d/%s()!\n", KBUILD_FILE, __LINE__, __func__); \
 	dump_stack();								\
 } while (0)
 
diff --git a/arch/arm/include/asm/bug.h b/arch/arm/include/asm/bug.h
index 4e6e88a..8644f7d 100644
--- a/arch/arm/include/asm/bug.h
+++ b/arch/arm/include/asm/bug.h
@@ -19,13 +19,13 @@
 #endif
 
 
-#define BUG() _BUG(__FILE__, __LINE__, BUG_INSTR_VALUE)
+#define BUG() _BUG(KBUILD_FILE, __LINE__, BUG_INSTR_VALUE)
 #define _BUG(file, line, value) __BUG(file, line, value)
 
 #ifdef CONFIG_DEBUG_BUGVERBOSE
 
 /*
- * The extra indirection is to ensure that the __FILE__ string comes through
+ * The extra indirection is to ensure that the KBUILD_FILE string comes through
  * OK. Many version of gcc do not support the asm %c parameter which would be
  * preferable to this unpleasantness. We use mergeable string sections to
  * avoid multiple copies of the string appearing in the kernel image.
diff --git a/arch/arm64/include/asm/bug.h b/arch/arm64/include/asm/bug.h
index 561190d..3d8826e 100644
--- a/arch/arm64/include/asm/bug.h
+++ b/arch/arm64/include/asm/bug.h
@@ -42,7 +42,7 @@
 		".pushsection __bug_table,\"a\"\n\t"	\
 		".align 2\n\t"				\
 	"0:	.long 1f - 0b\n\t"			\
-_BUGVERBOSE_LOCATION(__FILE__, __LINE__)		\
+_BUGVERBOSE_LOCATION(KBUILD_FILE, __LINE__)		\
 		".short " #flags "\n\t"			\
 		".popsection\n"				\
 							\
diff --git a/arch/avr32/include/asm/bug.h b/arch/avr32/include/asm/bug.h
index 85a92d0..b9b610c 100644
--- a/arch/avr32/include/asm/bug.h
+++ b/arch/avr32/include/asm/bug.h
@@ -29,7 +29,7 @@
 		"	.org	2b + %4\n"				\
 		"	.previous"					\
 		:							\
-		: "i"(AVR32_BUG_OPCODE), "i"(__FILE__),			\
+		: "i"(AVR32_BUG_OPCODE), "i"(KBUILD_FILE),			\
 		  "i"(__LINE__), "i"(flags),				\
 		  "i"(sizeof(struct bug_entry)))
 
diff --git a/arch/blackfin/include/asm/bug.h b/arch/blackfin/include/asm/bug.h
index 8d9b1eb..c64a48e 100644
--- a/arch/blackfin/include/asm/bug.h
+++ b/arch/blackfin/include/asm/bug.h
@@ -29,7 +29,7 @@
 		"	.org	2b + %4\n"				\
 		"	.previous"					\
 		:							\
-		: "i"(BFIN_BUG_OPCODE), "i"(__FILE__),			\
+		: "i"(BFIN_BUG_OPCODE), "i"(KBUILD_FILE),			\
 		  "i"(__LINE__), "i"(flags),				\
 		  "i"(sizeof(struct bug_entry)))
 
diff --git a/arch/cris/include/arch-v10/arch/bug.h b/arch/cris/include/arch-v10/arch/bug.h
index 3485d6b..f190d12 100644
--- a/arch/cris/include/arch-v10/arch/bug.h
+++ b/arch/cris/include/arch-v10/arch/bug.h
@@ -35,11 +35,11 @@ struct bug_frame {
 	__asm__ __volatile__ ("clear.d [" __stringify(BUG_MAGIC) "]\n\t"\
 				"movu.w %0,$r0\n\t"			\
 				"jump %1\n\t"				\
-				: : "i" (__LINE__), "i" (__FILE__))
+				: : "i" (__LINE__), "i" (KBUILD_FILE))
 #else
 /* This version will have to do for now, until the compiler is fixed.
  * The drawbacks of this version are that the file name will appear multiple
- * times in the .rodata section, and that __LINE__ and __FILE__ can probably
+ * times in the .rodata section, and that __LINE__ and KBUILD_FILE can probably
  * not be used like this with newer versions of gcc.
  */
 #define BUG()								\
@@ -47,7 +47,7 @@ struct bug_frame {
 			      "movu.w " __stringify(__LINE__) ",$r0\n\t"\
 			      "jump 0f\n\t"				\
 			      ".section .rodata\n"			\
-			      "0:\t.string \"" __FILE__ "\"\n\t"	\
+			      "0:\t.string \"" KBUILD_FILE "\"\n\t"	\
 			      ".previous")
 #endif
 
diff --git a/arch/cris/include/arch-v32/arch/bug.h b/arch/cris/include/arch-v32/arch/bug.h
index fb59faa..e0eeeff 100644
--- a/arch/cris/include/arch-v32/arch/bug.h
+++ b/arch/cris/include/arch-v32/arch/bug.h
@@ -22,7 +22,7 @@ do {									\
 			      ".section __ex_table,\"a\"\n\t"		\
 			      ".dword 0b, 1b\n\t"			\
 			      ".previous\n\t"				\
-			      : : "ri" (__FILE__), "i" (__LINE__));	\
+			      : : "ri" (KBUILD_FILE), "i" (__LINE__));	\
 	unreachable();				\
 } while (0)
 #else
diff --git a/arch/frv/include/asm/bug.h b/arch/frv/include/asm/bug.h
index dd01bcf..6a46dde 100644
--- a/arch/frv/include/asm/bug.h
+++ b/arch/frv/include/asm/bug.h
@@ -23,7 +23,7 @@ extern asmlinkage void __debug_bug_trap(int signr);
 #define	_debug_bug_printk()
 #else
 extern void __debug_bug_printk(const char *file, unsigned line);
-#define	_debug_bug_printk() __debug_bug_printk(__FILE__, __LINE__)
+#define	_debug_bug_printk() __debug_bug_printk(KBUILD_FILE, __LINE__)
 #endif
 
 #define _debug_bug_trap(signr)			\
diff --git a/arch/ia64/include/asm/bug.h b/arch/ia64/include/asm/bug.h
index 823616b..3cabfa3 100644
--- a/arch/ia64/include/asm/bug.h
+++ b/arch/ia64/include/asm/bug.h
@@ -3,7 +3,7 @@
 
 #ifdef CONFIG_BUG
 #define ia64_abort()	__builtin_trap()
-#define BUG() do { printk("kernel BUG at %s:%d!\n", __FILE__, __LINE__); ia64_abort(); } while (0)
+#define BUG() do { printk("kernel BUG at %s:%d!\n", KBUILD_FILE, __LINE__); ia64_abort(); } while (0)
 
 /* should this BUG be made generic? */
 #define HAVE_ARCH_BUG
diff --git a/arch/m68k/include/asm/bug.h b/arch/m68k/include/asm/bug.h
index 5bc8d91..46ad49f 100644
--- a/arch/m68k/include/asm/bug.h
+++ b/arch/m68k/include/asm/bug.h
@@ -6,12 +6,12 @@
 #ifdef CONFIG_DEBUG_BUGVERBOSE
 #ifndef CONFIG_SUN3
 #define BUG() do { \
-	pr_crit("kernel BUG at %s:%d!\n", __FILE__, __LINE__); \
+	pr_crit("kernel BUG at %s:%d!\n", KBUILD_FILE, __LINE__); \
 	__builtin_trap(); \
 } while (0)
 #else
 #define BUG() do { \
-	pr_crit("kernel BUG at %s:%d!\n", __FILE__, __LINE__); \
+	pr_crit("kernel BUG at %s:%d!\n", KBUILD_FILE, __LINE__); \
 	panic("BUG!"); \
 } while (0)
 #endif
diff --git a/arch/mn10300/include/asm/bug.h b/arch/mn10300/include/asm/bug.h
index aa6a388..d5de3b8 100644
--- a/arch/mn10300/include/asm/bug.h
+++ b/arch/mn10300/include/asm/bug.h
@@ -25,7 +25,7 @@ do {								\
 		"	.long 0b,%0,%1			\n"	\
 		"	.previous			\n"	\
 		:						\
-		: "i"(__FILE__), "i"(__LINE__)			\
+		: "i"(KBUILD_FILE), "i"(__LINE__)			\
 		);						\
 } while (1)
 
diff --git a/arch/parisc/include/asm/bug.h b/arch/parisc/include/asm/bug.h
index 62a3333..3b8e71f 100644
--- a/arch/parisc/include/asm/bug.h
+++ b/arch/parisc/include/asm/bug.h
@@ -32,7 +32,7 @@
 			     "\t.short %c1, %c2\n"			\
 			     "\t.org 2b+%c3\n"				\
 			     "\t.popsection"				\
-			     : : "i" (__FILE__), "i" (__LINE__),	\
+			     : : "i" (KBUILD_FILE), "i" (__LINE__),	\
 			     "i" (0), "i" (sizeof(struct bug_entry)) ); \
 		unreachable();						\
 	} while(0)
@@ -55,7 +55,7 @@
 			     "\t.short %c1, %c2\n"			\
 			     "\t.org 2b+%c3\n"				\
 			     "\t.popsection"				\
-			     : : "i" (__FILE__), "i" (__LINE__),	\
+			     : : "i" (KBUILD_FILE), "i" (__LINE__),	\
 			     "i" (BUGFLAG_TAINT(taint)), 		\
 			     "i" (sizeof(struct bug_entry)) );		\
 	} while(0)
diff --git a/arch/powerpc/include/asm/bug.h b/arch/powerpc/include/asm/bug.h
index 3a39283..55b803c 100644
--- a/arch/powerpc/include/asm/bug.h
+++ b/arch/powerpc/include/asm/bug.h
@@ -66,7 +66,7 @@
 	__asm__ __volatile__(					\
 		"1:	twi 31,0,0\n"				\
 		_EMIT_BUG_ENTRY					\
-		: : "i" (__FILE__), "i" (__LINE__),		\
+		: : "i" (KBUILD_FILE), "i" (__LINE__),		\
 		    "i" (0), "i"  (sizeof(struct bug_entry)));	\
 	unreachable();						\
 } while (0)
@@ -79,7 +79,7 @@
 		__asm__ __volatile__(				\
 		"1:	"PPC_TLNEI"	%4,0\n"			\
 		_EMIT_BUG_ENTRY					\
-		: : "i" (__FILE__), "i" (__LINE__), "i" (0),	\
+		: : "i" (KBUILD_FILE), "i" (__LINE__), "i" (0),	\
 		  "i" (sizeof(struct bug_entry)),		\
 		  "r" ((__force long)(x)));			\
 	}							\
@@ -89,7 +89,7 @@
 	__asm__ __volatile__(					\
 		"1:	twi 31,0,0\n"				\
 		_EMIT_BUG_ENTRY					\
-		: : "i" (__FILE__), "i" (__LINE__),		\
+		: : "i" (KBUILD_FILE), "i" (__LINE__),		\
 		  "i" (BUGFLAG_TAINT(taint)),			\
 		  "i" (sizeof(struct bug_entry)));		\
 } while (0)
@@ -103,7 +103,7 @@
 		__asm__ __volatile__(				\
 		"1:	"PPC_TLNEI"	%4,0\n"			\
 		_EMIT_BUG_ENTRY					\
-		: : "i" (__FILE__), "i" (__LINE__),		\
+		: : "i" (KBUILD_FILE), "i" (__LINE__),		\
 		  "i" (BUGFLAG_TAINT(TAINT_WARN)),		\
 		  "i" (sizeof(struct bug_entry)),		\
 		  "r" (__ret_warn_on));				\
diff --git a/arch/s390/include/asm/bug.h b/arch/s390/include/asm/bug.h
index bf90d1f..23638f4 100644
--- a/arch/s390/include/asm/bug.h
+++ b/arch/s390/include/asm/bug.h
@@ -12,7 +12,7 @@
 		"0:	j	0b+2\n"				\
 		"1:\n"						\
 		".section .rodata.str,\"aMS\", at progbits,1\n"	\
-		"2:	.asciz	\""__FILE__"\"\n"		\
+		"2:	.asciz	\""KBUILD_FILE"\"\n"		\
 		".previous\n"					\
 		".section __bug_table,\"a\"\n"			\
 		"3:	.long	1b-3b,2b-3b\n"			\
diff --git a/arch/score/include/asm/bug.h b/arch/score/include/asm/bug.h
index fd7164a..3b8373b 100644
--- a/arch/score/include/asm/bug.h
+++ b/arch/score/include/asm/bug.h
@@ -10,8 +10,8 @@ extern void __die_if_kernel(const char *, struct pt_regs *, const char *,
 	const char *, unsigned long);
 
 #define die(msg, regs)							\
-	__die(msg, regs, __FILE__ ":", __func__, __LINE__)
+	__die(msg, regs, KBUILD_FILE ":", __func__, __LINE__)
 #define die_if_kernel(msg, regs)					\
-	__die_if_kernel(msg, regs, __FILE__ ":", __func__, __LINE__)
+	__die_if_kernel(msg, regs, KBUILD_FILE ":", __func__, __LINE__)
 
 #endif /* _ASM_SCORE_BUG_H */
diff --git a/arch/sh/include/asm/bug.h b/arch/sh/include/asm/bug.h
index dcf2780..ee1e59d 100644
--- a/arch/sh/include/asm/bug.h
+++ b/arch/sh/include/asm/bug.h
@@ -12,7 +12,7 @@
 
 /**
  * _EMIT_BUG_ENTRY
- * %1 - __FILE__
+ * %1 - KBUILD_FILE
  * %2 - __LINE__
  * %3 - trap type
  * %4 - sizeof(struct bug_entry)
@@ -45,7 +45,7 @@ do {							\
 		_EMIT_BUG_ENTRY				\
 		 :					\
 		 : "n" (TRAPA_BUG_OPCODE),		\
-		   "i" (__FILE__),			\
+		   "i" (KBUILD_FILE),			\
 		   "i" (__LINE__), "i" (0),		\
 		   "i" (sizeof(struct bug_entry)));	\
 } while (0)
@@ -57,7 +57,7 @@ do {							\
 		 _EMIT_BUG_ENTRY			\
 		 :					\
 		 : "n" (TRAPA_BUG_OPCODE),		\
-		   "i" (__FILE__),			\
+		   "i" (KBUILD_FILE),			\
 		   "i" (__LINE__),			\
 		   "i" (BUGFLAG_TAINT(taint)),		\
 		   "i" (sizeof(struct bug_entry)));	\
@@ -82,7 +82,7 @@ do {							\
 		_EMIT_BUG_ENTRY				\
 		 :					\
 		 : "n" (TRAPA_BUG_OPCODE),		\
-		   "i" (__FILE__),			\
+		   "i" (KBUILD_FILE),			\
 		   "i" (__LINE__),			\
 		   "i" (BUGFLAG_UNWINDER),		\
 		   "i" (sizeof(struct bug_entry)));	\
diff --git a/arch/sparc/include/asm/bug.h b/arch/sparc/include/asm/bug.h
index eaa8f8d..c619219 100644
--- a/arch/sparc/include/asm/bug.h
+++ b/arch/sparc/include/asm/bug.h
@@ -7,7 +7,7 @@
 #ifdef CONFIG_DEBUG_BUGVERBOSE
 void do_BUG(const char *file, int line);
 #define BUG() do {					\
-	do_BUG(__FILE__, __LINE__);			\
+	do_BUG(KBUILD_FILE, __LINE__);			\
 	__builtin_trap();				\
 } while (0)
 #else
diff --git a/arch/x86/include/asm/bug.h b/arch/x86/include/asm/bug.h
index ba38ebb..2af438d 100644
--- a/arch/x86/include/asm/bug.h
+++ b/arch/x86/include/asm/bug.h
@@ -19,7 +19,7 @@ do {								\
 		     "\t.word %c1, 0\n"				\
 		     "\t.org 2b+%c2\n"				\
 		     ".popsection"				\
-		     : : "i" (__FILE__), "i" (__LINE__),	\
+		     : : "i" (KBUILD_FILE), "i" (__LINE__),	\
 		     "i" (sizeof(struct bug_entry)));		\
 	unreachable();						\
 } while (0)
diff --git a/include/asm-generic/bug.h b/include/asm-generic/bug.h
index 6f96247..04e50b3 100644
--- a/include/asm-generic/bug.h
+++ b/include/asm-generic/bug.h
@@ -46,7 +46,7 @@ struct bug_entry {
  */
 #ifndef HAVE_ARCH_BUG
 #define BUG() do { \
-	printk("BUG: failure at %s:%d/%s()!\n", __FILE__, __LINE__, __func__); \
+	printk("BUG: failure at %s:%d/%s()!\n", KBUILD_FILE, __LINE__, __func__); \
 	panic("BUG!"); \
 } while (0)
 #endif
@@ -70,10 +70,10 @@ void warn_slowpath_fmt_taint(const char *file, const int line, unsigned taint,
 			     const char *fmt, ...);
 extern void warn_slowpath_null(const char *file, const int line);
 #define WANT_WARN_ON_SLOWPATH
-#define __WARN()		warn_slowpath_null(__FILE__, __LINE__)
-#define __WARN_printf(arg...)	warn_slowpath_fmt(__FILE__, __LINE__, arg)
+#define __WARN()		warn_slowpath_null(KBUILD_FILE, __LINE__)
+#define __WARN_printf(arg...)	warn_slowpath_fmt(KBUILD_FILE, __LINE__, arg)
 #define __WARN_printf_taint(taint, arg...)				\
-	warn_slowpath_fmt_taint(__FILE__, __LINE__, taint, arg)
+	warn_slowpath_fmt_taint(KBUILD_FILE, __LINE__, taint, arg)
 #else
 #define __WARN()		__WARN_TAINT(TAINT_WARN)
 #define __WARN_printf(arg...)	do { printk(arg); __WARN(); } while (0)
-- 
2.7.4
