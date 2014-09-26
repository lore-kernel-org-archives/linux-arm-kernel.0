From: tixy@linaro.org (Jon Medhurst (Tixy))
Date: Fri, 26 Sep 2014 16:04:24 +0100
Subject: [PATCH] arm: kprobes-test: Fix compile error "bad immediate value
 for offset"
Message-ID: <1411743864.1529.36.camel@linaro1.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When compiling kprobes-test-arm.c the following error has been observed

/tmp/ccoT403o.s:21439: Error: bad immediate value for offset (4168)

This is caused by the compiler spilling it's literal pool too far away
from the site which is trying to reference it with a PC relative load.
This arises because the compiler is underestimating the size of the
inline assembler code present, which apparently it approximates as 4
bytes per line or instruction.

We fix this problem by moving the operations which generate more than
4 bytes out of the text section. Specifically, moving the .ascii
directives to the .rodata section.

Signed-off-by: Jon Medhurst <tixy@linaro.org>
---

Russell, OK to add your 'reported-by' here (or should it be Olof)?

 arch/arm/kernel/kprobes-test.c | 16 +++++++++-------
 arch/arm/kernel/kprobes-test.h |  5 ++++-
 2 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/arch/arm/kernel/kprobes-test.c b/arch/arm/kernel/kprobes-test.c
index 08d7312..b206d77 100644
--- a/arch/arm/kernel/kprobes-test.c
+++ b/arch/arm/kernel/kprobes-test.c
@@ -110,10 +110,13 @@
  *
  *	@ TESTCASE_START
  *	bl	__kprobes_test_case_start
- *	@ start of inline data...
+ *	.pushsection .rodata
+ *	"10:
  *	.ascii "mov r0, r7"	@ text title for test case
  *	.byte	0
- *	.align	2, 0
+ *	.popsection
+ *	@ start of inline data...
+ *	.word	10b		@ pointer to title in .rodata section
  *
  *	@ TEST_ARG_REG
  *	.byte	ARG_TYPE_REG
@@ -971,7 +974,7 @@ void __naked __kprobes_test_case_start(void)
 	__asm__ __volatile__ (
 		"stmdb	sp!, {r4-r11}				\n\t"
 		"sub	sp, sp, #"__stringify(TEST_MEMORY_SIZE)"\n\t"
-		"bic	r0, lr, #1  @ r0 = inline title string	\n\t"
+		"bic	r0, lr, #1  @ r0 = inline data		\n\t"
 		"mov	r1, sp					\n\t"
 		"bl	kprobes_test_case_start			\n\t"
 		"bx	r0					\n\t"
@@ -1349,15 +1352,14 @@ static unsigned long next_instruction(unsigned long pc)
 	return pc + 4;
 }
 
-static uintptr_t __used kprobes_test_case_start(const char *title, void *stack)
+static uintptr_t __used kprobes_test_case_start(const char **title, void *stack)
 {
 	struct test_arg *args;
 	struct test_arg_end *end_arg;
 	unsigned long test_code;
 
-	args = (struct test_arg *)PTR_ALIGN(title + strlen(title) + 1, 4);
-
-	current_title = title;
+	current_title = *title++;
+	args = (struct test_arg *)title;
 	current_args = args;
 	current_stack = stack;
 
diff --git a/arch/arm/kernel/kprobes-test.h b/arch/arm/kernel/kprobes-test.h
index eecc90a..4430990 100644
--- a/arch/arm/kernel/kprobes-test.h
+++ b/arch/arm/kernel/kprobes-test.h
@@ -111,11 +111,14 @@ struct test_arg_end {
 #define TESTCASE_START(title)					\
 	__asm__ __volatile__ (					\
 	"bl	__kprobes_test_case_start		\n\t"	\
+	".pushsection .rodata				\n\t"	\
+	"10:						\n\t"	\
 	/* don't use .asciz here as 'title' may be */		\
 	/* multiple strings to be concatenated.  */		\
 	".ascii "#title"				\n\t"	\
 	".byte	0					\n\t"	\
-	".align	2, 0					\n\t"
+	".popsection					\n\t"	\
+	".word	10b					\n\t"
 
 #define	TEST_ARG_REG(reg, val)					\
 	".byte	"__stringify(ARG_TYPE_REG)"		\n\t"	\
-- 
2.1.0
