From: tixy@linaro.org (Jon Medhurst)
Date: Thu, 16 Mar 2017 13:53:59 +0000
Subject: [PATCH] arm: kprobes: Align stack to 8-bytes in test code
Message-ID: <20170316135359.23019-1-tixy@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

kprobes test cases need to have a stack that is aligned to an 8-byte
boundary because they call other functions (and the ARM ABI mandates
that alignment) and because test cases include 64-bit accesses to the
stack. Unfortunately, GCC doesn't ensure this alignment for inline
assembler and for the code in question seems to always misalign it by
pushing just the LR register onto the stack. We therefore need to
explicitly perform stack alignment at the start of each test case.

Without this fix, some test cases will generate alignment faults on
systems where alignment is enforced. Even if the kernel is configured to
handle these faults in software, triggering them is ugly. It also
exposes limitations in the fault handling code which doesn't cope with
writes to the stack. E.g. when handling this instruction

   strd r6, [sp, #-64]!

the fault handling code will write to a stack location below the SP
value at the point the fault occurred, which coincides with where the
exception handler has pushed the saved register context. This results in
corruption of those registers.

Signed-off-by: Jon Medhurst <tixy@linaro.org>
---

I'm assuming the fact the alignment exception handler doesn't cope with
instructions that push things to the stack isn't a problem that we need
to be concerned about, given that compiler generated code and handwitten
assembler shouldn't trigger this unless it's buggy?

Russell, this is the last of several issues [1] [2] I found when testing
Masami Hiramatsu's kprobe changes [3]. That is a total of 4 kprobes
patches and 3 fixes around code patching. Assuming these are acceptable
I can create a branch and a pull request, or feed them into the patch
tracker, let me know.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2017-March/494365.html
[2] http://lists.infradead.org/pipermail/linux-arm-kernel/2017-March/494370.html
[3] https://lkml.org/lkml/2017/2/14/709


 arch/arm/probes/kprobes/test-core.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/arm/probes/kprobes/test-core.c b/arch/arm/probes/kprobes/test-core.c
index c893726aa52d..1c98a87786ca 100644
--- a/arch/arm/probes/kprobes/test-core.c
+++ b/arch/arm/probes/kprobes/test-core.c
@@ -977,7 +977,10 @@ static void coverage_end(void)
 void __naked __kprobes_test_case_start(void)
 {
 	__asm__ __volatile__ (
-		"stmdb	sp!, {r4-r11}				\n\t"
+		"mov	r2, sp					\n\t"
+		"bic	r3, r2, #7				\n\t"
+		"mov	sp, r3					\n\t"
+		"stmdb	sp!, {r2-r11}				\n\t"
 		"sub	sp, sp, #"__stringify(TEST_MEMORY_SIZE)"\n\t"
 		"bic	r0, lr, #1  @ r0 = inline data		\n\t"
 		"mov	r1, sp					\n\t"
@@ -997,7 +1000,8 @@ void __naked __kprobes_test_case_end_32(void)
 		"movne	pc, r0					\n\t"
 		"mov	r0, r4					\n\t"
 		"add	sp, sp, #"__stringify(TEST_MEMORY_SIZE)"\n\t"
-		"ldmia	sp!, {r4-r11}				\n\t"
+		"ldmia	sp!, {r2-r11}				\n\t"
+		"mov	sp, r2					\n\t"
 		"mov	pc, r0					\n\t"
 	);
 }
@@ -1013,7 +1017,8 @@ void __naked __kprobes_test_case_end_16(void)
 		"bxne	r0					\n\t"
 		"mov	r0, r4					\n\t"
 		"add	sp, sp, #"__stringify(TEST_MEMORY_SIZE)"\n\t"
-		"ldmia	sp!, {r4-r11}				\n\t"
+		"ldmia	sp!, {r2-r11}				\n\t"
+		"mov	sp, r2					\n\t"
 		"bx	r0					\n\t"
 	);
 }
-- 
2.11.0
