From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Thu, 25 Jul 2013 22:08:57 +0100
Subject: [PATCH 4/4] ARM: kprobes-test: move to using a pointer to the title
 text
In-Reply-To: <1374786537-10726-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1374786537-10726-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <1374786537-10726-5-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When testing the kprobes test code with BE8, there is either an
issue with the linker or how the code is being built. The issue
is with embedding the title text as the first part of the test.

Change to placing a pointer to .rodata with the text title in it
for the test which seems to stop the issue of the alignment of
the data following it being changed arbitrarily by the linker.

The proper thing to do here is to fix the linker, however this
patch also makes the output much easier to read as there are no
variable length data items here any more.

CC: Jon Medhurst <tixy@yxit.co.uk>
Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 arch/arm/kernel/kprobes-test.c |   12 +++++-------
 arch/arm/kernel/kprobes-test.h |    6 ++++--
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm/kernel/kprobes-test.c b/arch/arm/kernel/kprobes-test.c
index 6cfa04d..a915ac3 100644
--- a/arch/arm/kernel/kprobes-test.c
+++ b/arch/arm/kernel/kprobes-test.c
@@ -111,9 +111,7 @@
  *	@ TESTCASE_START
  *	bl	__kprobes_test_case_start
  *	@ start of inline data...
- *	.ascii "mov r0, r7"	@ text title for test case
- *	.byte	0
- *	.align	2
+ *	.word	title_addr	 @ text title for test case
  *
  *	@ TEST_ARG_REG
  *	.byte	ARG_TYPE_REG
@@ -959,7 +957,7 @@ void __naked __kprobes_test_case_start(void)
 	__asm__ __volatile__ (
 		"stmdb	sp!, {r4-r11}				\n\t"
 		"sub	sp, sp, #"__stringify(TEST_MEMORY_SIZE)"\n\t"
-		"bic	r0, lr, #1  @ r0 = inline title string	\n\t"
+		"bic	r0, lr, #3  @ r0 = inline title block	\n\t"
 		"mov	r1, sp					\n\t"
 		"bl	kprobes_test_case_start			\n\t"
 		"bx	r0					\n\t"
@@ -1336,15 +1334,15 @@ static unsigned long next_instruction(unsigned long pc)
 	return pc + 4;
 }
 
-static uintptr_t __used kprobes_test_case_start(const char *title, void *stack)
+static uintptr_t __used kprobes_test_case_start(const char **title, void *stack)
 {
 	struct test_arg *args;
 	struct test_arg_end *end_arg;
 	unsigned long test_code;
 
-	args = (struct test_arg *)PTR_ALIGN(title + strlen(title) + 1, 4);
+	args = (struct test_arg *)(title + 1);
 
-	current_title = title;
+	current_title = *title;
 	current_args = args;
 	current_stack = stack;
 
diff --git a/arch/arm/kernel/kprobes-test.h b/arch/arm/kernel/kprobes-test.h
index e28a869..a71db09 100644
--- a/arch/arm/kernel/kprobes-test.h
+++ b/arch/arm/kernel/kprobes-test.h
@@ -113,9 +113,11 @@ struct test_arg_end {
 	"bl	__kprobes_test_case_start		\n\t"	\
 	/* don't use .asciz here as 'title' may be */		\
 	/* multiple strings to be concatenated.  */		\
-	".ascii "#title"				\n\t"	\
+	".pushsection .rodata				\n\t"	\
+	"9999: .ascii "#title"				\n\t"	\
 	".byte	0					\n\t"	\
-	".align	2					\n\t"
+	".popsection					\n\t"	\
+	".word	9999b					\n\t"
 
 #define	TEST_ARG_REG(reg, val)					\
 	".byte	"__stringify(ARG_TYPE_REG)"		\n\t"	\
-- 
1.7.10.4
