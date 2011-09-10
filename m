From: tixy@yxit.co.uk (Tixy)
Date: Sat, 10 Sep 2011 12:04:59 +0100
Subject: [PATCH v2 03/10] ARM: kprobes: Framework for instruction set test
	cases
In-Reply-To: <1315652706-2900-1-git-send-email-tixy@yxit.co.uk>
References: <1315652706-2900-1-git-send-email-tixy@yxit.co.uk>
Message-ID: <1315652706-2900-4-git-send-email-tixy@yxit.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jon Medhurst <tixy@yxit.co.uk>

On ARM we have to simulate/emulate CPU instructions in order to
singlestep them. This patch adds a framework which can be used to
construct test cases for different instruction forms. It is described in
detail in the in-source comments of kprobes-test.c

Signed-off-by: Jon Medhurst <tixy@yxit.co.uk>
---
 arch/arm/kernel/kprobes-test.h |  384 ++++++++++++++++++
 arch/arm/kernel/kprobes-test.c |  840 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 1224 insertions(+), 0 deletions(-)

diff --git a/arch/arm/kernel/kprobes-test.h b/arch/arm/kernel/kprobes-test.h
new file mode 100644
index 0000000..50ecc2a
--- /dev/null
+++ b/arch/arm/kernel/kprobes-test.h
@@ -0,0 +1,384 @@
+/*
+ * arch/arm/kernel/kprobes-test.h
+ *
+ * Copyright (C) 2011 Jon Medhurst <tixy@yxit.co.uk>.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#define VERBOSE 0 /* Set to '1' for more logging of test cases */
+
+#ifdef CONFIG_THUMB2_KERNEL
+#define NORMAL_ISA "16"
+#else
+#define NORMAL_ISA "32"
+#endif
+
+
+/* Flags used in kprobe_test_flags */
+#define TEST_FLAG_NO_ITBLOCK	(1<<0)
+#define TEST_FLAG_FULL_ITBLOCK	(1<<1)
+#define TEST_FLAG_NARROW_INSTR	(1<<2)
+
+extern int kprobe_test_flags;
+extern int kprobe_test_cc_position;
+
+
+#define TEST_MEMORY_SIZE 256
+
+
+/*
+ * Test case structures.
+ *
+ * The arguments given to test cases can be one of three types.
+ *
+ *   ARG_TYPE_REG
+ *	Load a register with the given value.
+ *
+ *   ARG_TYPE_PTR
+ *	Load a register with a pointer into the stack buffer (SP + given value).
+ *
+ *   ARG_TYPE_MEM
+ *	Store the given value into the stack buffer at [SP+index].
+ *
+ */
+
+#define	ARG_TYPE_END	0
+#define	ARG_TYPE_REG	1
+#define	ARG_TYPE_PTR	2
+#define	ARG_TYPE_MEM	3
+
+#define ARG_FLAG_UNSUPPORTED	0x01
+#define ARG_FLAG_SUPPORTED	0x02
+#define ARG_FLAG_THUMB		0x10	/* Must be 16 so TEST_ISA can be used */
+#define ARG_FLAG_ARM		0x20	/* Must be 32 so TEST_ISA can be used */
+
+struct test_arg {
+	u8	type;		/* ARG_TYPE_x */
+	u8	_padding[7];
+};
+
+struct test_arg_regptr {
+	u8	type;		/* ARG_TYPE_REG or ARG_TYPE_PTR */
+	u8	reg;
+	u8	_padding[2];
+	u32	val;
+};
+
+struct test_arg_mem {
+	u8	type;		/* ARG_TYPE_MEM */
+	u8	index;
+	u8	_padding[2];
+	u32	val;
+};
+
+struct test_arg_end {
+	u8	type;		/* ARG_TYPE_END */
+	u8	flags;		/* ARG_FLAG_x */
+	u16	code_offset;
+	u16	branch_offset;
+	u16	end_offset;
+};
+
+
+/*
+ * Building blocks for test cases.
+ *
+ * Each test case is wrapped between TESTCASE_START and TESTCASE_END.
+ *
+ * To specify arguments for a test case the TEST_ARG_{REG,PTR,MEM} macros are
+ * used followed by a terminating TEST_ARG_END.
+ *
+ * After this, the instruction to be tested is defined with TEST_INSTRUCTION.
+ * Or for branches, TEST_BRANCH_B and TEST_BRANCH_F (branch forwards/backwards).
+ *
+ * Some specific test cases may make use of other custom constructs.
+ */
+
+#if VERBOSE
+#define verbose(fmt, ...) pr_info(fmt, ##__VA_ARGS__)
+#else
+#define verbose(fmt, ...)
+#endif
+
+#define TEST_GROUP(title)					\
+	verbose("\n");						\
+	verbose(title"\n");					\
+	verbose("---------------------------------------------------------\n");
+
+#define TESTCASE_START(title)					\
+	__asm__ __volatile__ (					\
+	"bl	__kprobes_test_case_start		\n\t"	\
+	/* don't use .asciz here as 'title' may be */		\
+	/* multiple strings to be concatenated.  */		\
+	".ascii "#title"				\n\t"	\
+	".byte	0					\n\t"	\
+	".align	2					\n\t"
+
+#define	TEST_ARG_REG(reg, val)					\
+	".byte	"__stringify(ARG_TYPE_REG)"		\n\t"	\
+	".byte	"#reg"					\n\t"	\
+	".short	0					\n\t"	\
+	".word	"#val"					\n\t"
+
+#define	TEST_ARG_PTR(reg, val)					\
+	".byte	"__stringify(ARG_TYPE_PTR)"		\n\t"	\
+	".byte	"#reg"					\n\t"	\
+	".short	0					\n\t"	\
+	".word	"#val"					\n\t"
+
+#define	TEST_ARG_MEM(index, val)				\
+	".byte	"__stringify(ARG_TYPE_MEM)"		\n\t"	\
+	".byte	"#index"				\n\t"	\
+	".short	0					\n\t"	\
+	".word	"#val"					\n\t"
+
+#define	TEST_ARG_END(flags)					\
+	".byte	"__stringify(ARG_TYPE_END)"		\n\t"	\
+	".byte	"TEST_ISA flags"			\n\t"	\
+	".short	50f-0f					\n\t"	\
+	".short	2f-0f					\n\t"	\
+	".short	99f-0f					\n\t"	\
+	".code "TEST_ISA"				\n\t"	\
+	"0:						\n\t"
+
+#define TEST_INSTRUCTION(instruction)				\
+	"50:	nop					\n\t"	\
+	"1:	"instruction"				\n\t"	\
+	"	nop					\n\t"
+
+#define TEST_BRANCH_F(instruction, xtra_dist)			\
+	TEST_INSTRUCTION(instruction)				\
+	".if "#xtra_dist"				\n\t"	\
+	"	b	99f				\n\t"	\
+	".space "#xtra_dist"				\n\t"	\
+	".endif						\n\t"	\
+	"	b	99f				\n\t"	\
+	"2:	nop					\n\t"
+
+#define TEST_BRANCH_B(instruction, xtra_dist)			\
+	"	b	50f				\n\t"	\
+	"	b	99f				\n\t"	\
+	"2:	nop					\n\t"	\
+	"	b	99f				\n\t"	\
+	".if "#xtra_dist"				\n\t"	\
+	".space "#xtra_dist"				\n\t"	\
+	".endif						\n\t"	\
+	TEST_INSTRUCTION(instruction)
+
+#define TESTCASE_END						\
+	"2:						\n\t"	\
+	"99:						\n\t"	\
+	"	bl __kprobes_test_case_end_"TEST_ISA"	\n\t"	\
+	".code "NORMAL_ISA"				\n\t"	\
+	: :							\
+	: "r0", "r1", "r2", "r3", "ip", "lr", "memory", "cc"	\
+	);
+
+
+/*
+ * Macros to define test cases.
+ *
+ * Those of the form TEST_{R,P,M}* can be used to define test cases
+ * which take combinations of the three basic types of arguments. E.g.
+ *
+ *   TEST_R	One register argument
+ *   TEST_RR	Two register arguments
+ *   TEST_RPR	A register, a pointer, then a register argument
+ *
+ * For testing instructions which may branch, there are macros TEST_BF_*
+ * and TEST_BB_* for branching forwards and backwards.
+ *
+ * TEST_SUPPORTED and TEST_UNSUPPORTED don't cause the code to be executed,
+ * the just verify that a kprobe is or is not allowed on the given instruction.
+ */
+
+#define TEST(code)				\
+	TESTCASE_START(code)			\
+	TEST_ARG_END("")			\
+	TEST_INSTRUCTION(code)			\
+	TESTCASE_END
+
+#define TEST_UNSUPPORTED(code)					\
+	TESTCASE_START(code)					\
+	TEST_ARG_END("|"__stringify(ARG_FLAG_UNSUPPORTED))	\
+	TEST_INSTRUCTION(code)					\
+	TESTCASE_END
+
+#define TEST_SUPPORTED(code)					\
+	TESTCASE_START(code)					\
+	TEST_ARG_END("|"__stringify(ARG_FLAG_SUPPORTED))	\
+	TEST_INSTRUCTION(code)					\
+	TESTCASE_END
+
+#define TEST_R(code1, reg, val, code2)			\
+	TESTCASE_START(code1 #reg code2)		\
+	TEST_ARG_REG(reg, val)				\
+	TEST_ARG_END("")				\
+	TEST_INSTRUCTION(code1 #reg code2)		\
+	TESTCASE_END
+
+#define TEST_RR(code1, reg1, val1, code2, reg2, val2, code3)	\
+	TESTCASE_START(code1 #reg1 code2 #reg2 code3)		\
+	TEST_ARG_REG(reg1, val1)				\
+	TEST_ARG_REG(reg2, val2)				\
+	TEST_ARG_END("")					\
+	TEST_INSTRUCTION(code1 #reg1 code2 #reg2 code3)		\
+	TESTCASE_END
+
+#define TEST_RRR(code1, reg1, val1, code2, reg2, val2, code3, reg3, val3, code4)\
+	TESTCASE_START(code1 #reg1 code2 #reg2 code3 #reg3 code4)		\
+	TEST_ARG_REG(reg1, val1)						\
+	TEST_ARG_REG(reg2, val2)						\
+	TEST_ARG_REG(reg3, val3)						\
+	TEST_ARG_END("")							\
+	TEST_INSTRUCTION(code1 #reg1 code2 #reg2 code3 #reg3 code4)		\
+	TESTCASE_END
+
+#define TEST_RRRR(code1, reg1, val1, code2, reg2, val2, code3, reg3, val3, code4, reg4, val4)	\
+	TESTCASE_START(code1 #reg1 code2 #reg2 code3 #reg3 code4 #reg4)		\
+	TEST_ARG_REG(reg1, val1)						\
+	TEST_ARG_REG(reg2, val2)						\
+	TEST_ARG_REG(reg3, val3)						\
+	TEST_ARG_REG(reg4, val4)						\
+	TEST_ARG_END("")							\
+	TEST_INSTRUCTION(code1 #reg1 code2 #reg2 code3 #reg3 code4 #reg4)	\
+	TESTCASE_END
+
+#define TEST_P(code1, reg1, val1, code2)	\
+	TESTCASE_START(code1 #reg1 code2)	\
+	TEST_ARG_PTR(reg1, val1)		\
+	TEST_ARG_END("")			\
+	TEST_INSTRUCTION(code1 #reg1 code2)	\
+	TESTCASE_END
+
+#define TEST_PR(code1, reg1, val1, code2, reg2, val2, code3)	\
+	TESTCASE_START(code1 #reg1 code2 #reg2 code3)		\
+	TEST_ARG_PTR(reg1, val1)				\
+	TEST_ARG_REG(reg2, val2)				\
+	TEST_ARG_END("")					\
+	TEST_INSTRUCTION(code1 #reg1 code2 #reg2 code3)		\
+	TESTCASE_END
+
+#define TEST_RP(code1, reg1, val1, code2, reg2, val2, code3)	\
+	TESTCASE_START(code1 #reg1 code2 #reg2 code3)		\
+	TEST_ARG_REG(reg1, val1)				\
+	TEST_ARG_PTR(reg2, val2)				\
+	TEST_ARG_END("")					\
+	TEST_INSTRUCTION(code1 #reg1 code2 #reg2 code3)		\
+	TESTCASE_END
+
+#define TEST_PRR(code1, reg1, val1, code2, reg2, val2, code3, reg3, val3, code4)\
+	TESTCASE_START(code1 #reg1 code2 #reg2 code3 #reg3 code4)		\
+	TEST_ARG_PTR(reg1, val1)						\
+	TEST_ARG_REG(reg2, val2)						\
+	TEST_ARG_REG(reg3, val3)						\
+	TEST_ARG_END("")							\
+	TEST_INSTRUCTION(code1 #reg1 code2 #reg2 code3 #reg3 code4)		\
+	TESTCASE_END
+
+#define TEST_RPR(code1, reg1, val1, code2, reg2, val2, code3, reg3, val3, code4)\
+	TESTCASE_START(code1 #reg1 code2 #reg2 code3 #reg3 code4)		\
+	TEST_ARG_REG(reg1, val1)						\
+	TEST_ARG_PTR(reg2, val2)						\
+	TEST_ARG_REG(reg3, val3)						\
+	TEST_ARG_END("")							\
+	TEST_INSTRUCTION(code1 #reg1 code2 #reg2 code3 #reg3 code4)		\
+	TESTCASE_END
+
+#define TEST_RRP(code1, reg1, val1, code2, reg2, val2, code3, reg3, val3, code4)\
+	TESTCASE_START(code1 #reg1 code2 #reg2 code3 #reg3 code4)		\
+	TEST_ARG_REG(reg1, val1)						\
+	TEST_ARG_REG(reg2, val2)						\
+	TEST_ARG_PTR(reg3, val3)						\
+	TEST_ARG_END("")							\
+	TEST_INSTRUCTION(code1 #reg1 code2 #reg2 code3 #reg3 code4)		\
+	TESTCASE_END
+
+#define TEST_BF_P(code1, reg1, val1, code2)	\
+	TESTCASE_START(code1 #reg1 code2)	\
+	TEST_ARG_PTR(reg1, val1)		\
+	TEST_ARG_END("")			\
+	TEST_BRANCH_F(code1 #reg1 code2, 0)	\
+	TESTCASE_END
+
+#define TEST_BF_X(code, xtra_dist)		\
+	TESTCASE_START(code)			\
+	TEST_ARG_END("")			\
+	TEST_BRANCH_F(code, xtra_dist)		\
+	TESTCASE_END
+
+#define TEST_BB_X(code, xtra_dist)		\
+	TESTCASE_START(code)			\
+	TEST_ARG_END("")			\
+	TEST_BRANCH_B(code, xtra_dist)		\
+	TESTCASE_END
+
+#define TEST_BF_RX(code1, reg, val, code2, xtra_dist)	\
+	TESTCASE_START(code1 #reg code2)		\
+	TEST_ARG_REG(reg, val)				\
+	TEST_ARG_END("")				\
+	TEST_BRANCH_F(code1 #reg code2, xtra_dist)	\
+	TESTCASE_END
+
+#define TEST_BB_RX(code1, reg, val, code2, xtra_dist)	\
+	TESTCASE_START(code1 #reg code2)		\
+	TEST_ARG_REG(reg, val)				\
+	TEST_ARG_END("")				\
+	TEST_BRANCH_B(code1 #reg code2, xtra_dist)	\
+	TESTCASE_END
+
+#define TEST_BF(code)	TEST_BF_X(code, 0)
+#define TEST_BB(code)	TEST_BB_X(code, 0)
+
+#define TEST_BF_R(code1, reg, val, code2) TEST_BF_RX(code1, reg, val, code2, 0)
+#define TEST_BB_R(code1, reg, val, code2) TEST_BB_RX(code1, reg, val, code2, 0)
+
+#define TEST_BF_RR(code1, reg1, val1, code2, reg2, val2, code3)	\
+	TESTCASE_START(code1 #reg1 code2 #reg2 code3)		\
+	TEST_ARG_REG(reg1, val1)				\
+	TEST_ARG_REG(reg2, val2)				\
+	TEST_ARG_END("")					\
+	TEST_BRANCH_F(code1 #reg1 code2 #reg2 code3, 0)		\
+	TESTCASE_END
+
+#define TEST_X(code, codex)			\
+	TESTCASE_START(code)			\
+	TEST_ARG_END("")			\
+	TEST_INSTRUCTION(code)			\
+	"	b	99f		\n\t"	\
+	"	"codex"			\n\t"	\
+	TESTCASE_END
+
+#define TEST_RX(code1, reg, val, code2, codex)		\
+	TESTCASE_START(code1 #reg code2)		\
+	TEST_ARG_REG(reg, val)				\
+	TEST_ARG_END("")				\
+	TEST_INSTRUCTION(code1 __stringify(reg) code2)	\
+	"	b	99f		\n\t"		\
+	"	"codex"			\n\t"		\
+	TESTCASE_END
+
+#define TEST_RRX(code1, reg1, val1, code2, reg2, val2, code3, codex)		\
+	TESTCASE_START(code1 #reg1 code2 #reg2 code3)				\
+	TEST_ARG_REG(reg1, val1)						\
+	TEST_ARG_REG(reg2, val2)						\
+	TEST_ARG_END("")							\
+	TEST_INSTRUCTION(code1 __stringify(reg1) code2 __stringify(reg2) code3)	\
+	"	b	99f		\n\t"					\
+	"	"codex"			\n\t"					\
+	TESTCASE_END
+
+
+/* Various values used in test cases... */
+#define N(val)	(val ^ 0xffffffff)
+#define VAL1	0x12345678
+#define VAL2	N(VAL1)
+#define VAL3	0xa5f801
+#define VAL4	N(VAL3)
+#define VALM	0x456789ab
+#define VALR	0xdeaddead
+#define HH1	0x0123fecb
+#define HH2	0xa9874567
diff --git a/arch/arm/kernel/kprobes-test.c b/arch/arm/kernel/kprobes-test.c
index 9fff044..23c485d 100644
--- a/arch/arm/kernel/kprobes-test.c
+++ b/arch/arm/kernel/kprobes-test.c
@@ -8,11 +8,180 @@
  * published by the Free Software Foundation.
  */
 
+/*
+ * TESTING METHODOLOGY
+ * -------------------
+ *
+ * The methodology used to test an ARM instruction 'test_insn' is to use
+ * inline assembler like:
+ *
+ * test_before: nop
+ * test_case:	test_insn
+ * test_after:	nop
+ *
+ * When the test case is run a kprobe is placed of each nop. The
+ * post-handler of the test_before probe is used to modify the saved CPU
+ * register context to that which we require for the test case. The
+ * pre-handler of the of the test_after probe saves a copy of the CPU
+ * register context. In this way we can execute test_insn with a specific
+ * register context and see the results afterwards.
+ *
+ * To actually test the kprobes instruction emulation we perform the above
+ * step a second time but with an additional kprobe on the test_case
+ * instruction itself. If the emulation is accurate then the results seen
+ * by the test_after probe will be identical to the first run which didn't
+ * have a probe on test_case.
+ *
+ * Each test case is run several times with a variety of variations in the
+ * flags value of stored in CPSR, and for Thumb code, different ITState.
+ *
+ * For instructions which can modify PC, a second test_after probe is used
+ * like this:
+ *
+ * test_before: nop
+ * test_case:	test_insn
+ * test_after:	nop
+ *		b test_done
+ * test_after2: nop
+ * test_done:
+ *
+ * The test case is constructed such that test_insn branches to
+ * test_after2, or, if testing a conditional instruction, it may just
+ * continue to test_after. The probes inserted@both locations let us
+ * determine which happened. A similar approach is used for testing
+ * backwards branches...
+ *
+ *		b test_before
+ *		b test_done  @ helps to cope with off by 1 branches
+ * test_after2: nop
+ *		b test_done
+ * test_before: nop
+ * test_case:	test_insn
+ * test_after:	nop
+ * test_done:
+ *
+ * The macros used to generate the assembler instructions describe above
+ * are TEST_INSTRUCTION, TEST_BRANCH_F (branch forwards) and TEST_BRANCH_B
+ * (branch backwards). In these, the local variables numbered 1, 50, 2 and
+ * 99 represent: test_before, test_case, test_after2 and test_done.
+ *
+ * FRAMEWORK
+ * ---------
+ *
+ * Each test case is wrapped between the pair of macros TESTCASE_START and
+ * TESTCASE_END. As well as performing the inline assembler boilerplate,
+ * these call out to the kprobes_test_case_start() and
+ * kprobes_test_case_end() functions which drive the execution of the test
+ * case. The specific arguments to use for each test case are stored as
+ * inline data constructed using the various TEST_ARG_* macros. Putting
+ * this all together, a simple test case may look like:
+ *
+ *	TESTCASE_START("Testing mov r0, r7")
+ *	TEST_ARG_REG(7, 0x12345678) // Set r7=0x12345678
+ *	TEST_ARG_END("")
+ *	TEST_INSTRUCTION("mov r0, r7")
+ *	TESTCASE_END
+ *
+ * Note, in practice the single convenience macro TEST_R would be used for this
+ * instead.
+ *
+ * The above would expand to assembler looking something like:
+ *
+ *	@ TESTCASE_START
+ *	bl	__kprobes_test_case_start
+ *	@ start of inline data...
+ *	.ascii "mov r0, r7"	@ text title for test case
+ *	.byte	0
+ *	.align	2
+ *
+ *	@ TEST_ARG_REG
+ *	.byte	ARG_TYPE_REG
+ *	.byte	7
+ *	.short	0
+ *	.word	0x1234567
+ *
+ *	@ TEST_ARG_END
+ *	.byte	ARG_TYPE_END
+ *	.byte	TEST_ISA	@ flags, including ISA being tested
+ *	.short	50f-0f		@ offset of 'test_before'
+ *	.short	2f-0f		@ offset of 'test_after2' (if relevent)
+ *	.short	99f-0f		@ offset of 'test_done'
+ *	@ start of test case code...
+ *	0:
+ *	.code	TEST_ISA	@ switch to ISA being tested
+ *
+ *	@ TEST_INSTRUCTION
+ *	50:	nop		@ location for 'test_before' probe
+ *	1:	mov r0, r7	@ the test case instruction 'test_insn'
+ *		nop		@ location for 'test_after' probe
+ *
+ *	// TESTCASE_END
+ *	2:
+ *	99:	bl __kprobes_test_case_end_##TEST_ISA
+ *	.code	NONMAL_ISA
+ *
+ * When the above is execute the following happens...
+ *
+ * __kprobes_test_case_start() is an assembler wrapper which sets up space
+ * for a stack buffer and calls the C function kprobes_test_case_start().
+ * This C function will do some initial processing of the inline data and
+ * setup some global state. It then inserts the test_before and test_after
+ * kprobes and returns a value which causes the assembler wrapper to jump
+ * to the start of the test case code, (local label '0').
+ *
+ * When the test case code executes, the test_before probe will be hit and
+ * test_before_post_handler will call setup_test_context(). This fills the
+ * stack buffer and CPU registers with a test pattern and then processes
+ * the test case arguments. In our example there is one TEST_ARG_REG which
+ * indicates that R7 should be loaded with the value 0x12345678.
+ *
+ * When the test_before probe ends, the test case continues and executes
+ * the "mov r0, r7" instruction. It then hits the test_after probe and the
+ * pre-handler for this (test_after_pre_handler) will save a copy of the
+ * CPU register context. This should now have R0 holding the same value as
+ * R7.
+ *
+ * Finally we get to the call to __kprobes_test_case_end_{32,16}. This is
+ * an assembler wrapper which switches back to the ISA used by the test
+ * code and calls the C function kprobes_test_case_end().
+ *
+ * For each run through the test case, test_case_run_count is incremented
+ * by one. For even runs, kprobes_test_case_end() saves a copy of the
+ * register and stack buffer contents from the test case just run. It then
+ * inserts a kprobe on the test case instruction 'test_insn' and returns a
+ * value to cause the test case code to be re-run.
+ *
+ * For odd numbered runs, kprobes_test_case_end() compares the register and
+ * stack buffer contents to those that were saved on the previous even
+ * numbered run (the one without the kprobe on test_insn). These should be
+ * the same if the kprobe instruction simulation routine is correct.
+ *
+ * Th pair of test case runs is repeated with different combinations of
+ * flag values in CPSR and, for Thumb, different ITState. This is
+ * controlled by test_context_cpsr().
+ *
+ * BUILDING TEST CASES
+ * -------------------
+ *
+ *
+ * As an aid to building test cases, the stack buffer is initialised with
+ * some special values:
+ *
+ *   [SP+13*4]	Contains SP+120. This can be used to test instructions
+ *		which load a value into SP.
+ *
+ *   [SP+15*4]	When testing branching instructions using TEST_BRANCH_{F,B},
+ *		this holds the target address of the branch, 'test_after2'.
+ *		This can be used to test instructions which load a PC value
+ *		from memory.
+ */
+
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/kprobes.h>
 
 #include "kprobes.h"
+#include "kprobes-test.h"
 
 
 /*
@@ -274,6 +443,677 @@ static int run_api_tests(long (*func)(long, long))
 
 
 /*
+ * Framework for instruction set test cases
+ */
+
+void __naked __kprobes_test_case_start(void)
+{
+	__asm__ __volatile__ (
+		"stmdb	sp!, {r4-r11}				\n\t"
+		"sub	sp, sp, #"__stringify(TEST_MEMORY_SIZE)"\n\t"
+		"bic	r0, lr, #1  @ r0 = inline title string	\n\t"
+		"mov	r1, sp					\n\t"
+		"bl	kprobes_test_case_start			\n\t"
+		"bx	r0					\n\t"
+	);
+}
+
+#ifndef CONFIG_THUMB2_KERNEL
+
+void __naked __kprobes_test_case_end_32(void)
+{
+	__asm__ __volatile__ (
+		"mov	r4, lr					\n\t"
+		"bl	kprobes_test_case_end			\n\t"
+		"cmp	r0, #0					\n\t"
+		"movne	pc, r0					\n\t"
+		"mov	r0, r4					\n\t"
+		"add	sp, sp, #"__stringify(TEST_MEMORY_SIZE)"\n\t"
+		"ldmia	sp!, {r4-r11}				\n\t"
+		"mov	pc, r0					\n\t"
+	);
+}
+
+#else /* CONFIG_THUMB2_KERNEL */
+
+void __naked __kprobes_test_case_end_16(void)
+{
+	__asm__ __volatile__ (
+		"mov	r4, lr					\n\t"
+		"bl	kprobes_test_case_end			\n\t"
+		"cmp	r0, #0					\n\t"
+		"bxne	r0					\n\t"
+		"mov	r0, r4					\n\t"
+		"add	sp, sp, #"__stringify(TEST_MEMORY_SIZE)"\n\t"
+		"ldmia	sp!, {r4-r11}				\n\t"
+		"bx	r0					\n\t"
+	);
+}
+
+void __naked __kprobes_test_case_end_32(void)
+{
+	__asm__ __volatile__ (
+		".arm						\n\t"
+		"orr	lr, lr, #1  @ will return to Thumb code	\n\t"
+		"ldr	pc, 1f					\n\t"
+		"1:						\n\t"
+		".word	__kprobes_test_case_end_16		\n\t"
+	);
+}
+
+#endif
+
+
+int kprobe_test_flags;
+int kprobe_test_cc_position;
+
+static int test_try_count;
+static int test_pass_count;
+static int test_fail_count;
+
+static struct pt_regs initial_regs;
+static struct pt_regs expected_regs;
+static struct pt_regs result_regs;
+
+static u32 expected_memory[TEST_MEMORY_SIZE/sizeof(u32)];
+
+static const char *current_title;
+static struct test_arg *current_args;
+static u32 *current_stack;
+static uintptr_t current_branch_target;
+
+static uintptr_t current_code_start;
+static kprobe_opcode_t current_instruction;
+
+
+#define TEST_CASE_PASSED -1
+#define TEST_CASE_FAILED -2
+
+static int test_case_run_count;
+static bool test_case_is_thumb;
+static int test_instance;
+
+/*
+ * We ignore the state of the imprecise abort disable flag (CPSR.A) because this
+ * can change randomly as the kernel doesn't take care to preserve or initialise
+ * this across context switches. Also, with Security Extentions, the flag may
+ * not be under control of the kernel; for this reason we ignore the state of
+ * the FIQ disable flag CPSR.F as well.
+ */
+#define PSR_IGNORE_BITS (PSR_A_BIT | PSR_F_BIT)
+
+static unsigned long test_check_cc(int cc, unsigned long cpsr)
+{
+	unsigned long temp;
+
+	switch (cc) {
+	case 0x0: /* eq */
+		return cpsr & PSR_Z_BIT;
+
+	case 0x1: /* ne */
+		return (~cpsr) & PSR_Z_BIT;
+
+	case 0x2: /* cs */
+		return cpsr & PSR_C_BIT;
+
+	case 0x3: /* cc */
+		return (~cpsr) & PSR_C_BIT;
+
+	case 0x4: /* mi */
+		return cpsr & PSR_N_BIT;
+
+	case 0x5: /* pl */
+		return (~cpsr) & PSR_N_BIT;
+
+	case 0x6: /* vs */
+		return cpsr & PSR_V_BIT;
+
+	case 0x7: /* vc */
+		return (~cpsr) & PSR_V_BIT;
+
+	case 0x8: /* hi */
+		cpsr &= ~(cpsr >> 1); /* PSR_C_BIT &= ~PSR_Z_BIT */
+		return cpsr & PSR_C_BIT;
+
+	case 0x9: /* ls */
+		cpsr &= ~(cpsr >> 1); /* PSR_C_BIT &= ~PSR_Z_BIT */
+		return (~cpsr) & PSR_C_BIT;
+
+	case 0xa: /* ge */
+		cpsr ^= (cpsr << 3); /* PSR_N_BIT ^= PSR_V_BIT */
+		return (~cpsr) & PSR_N_BIT;
+
+	case 0xb: /* lt */
+		cpsr ^= (cpsr << 3); /* PSR_N_BIT ^= PSR_V_BIT */
+		return cpsr & PSR_N_BIT;
+
+	case 0xc: /* gt */
+		temp = cpsr ^ (cpsr << 3); /* PSR_N_BIT ^= PSR_V_BIT */
+		temp |= (cpsr << 1);	   /* PSR_N_BIT |= PSR_Z_BIT */
+		return (~temp) & PSR_N_BIT;
+
+	case 0xd: /* le */
+		temp = cpsr ^ (cpsr << 3); /* PSR_N_BIT ^= PSR_V_BIT */
+		temp |= (cpsr << 1);	   /* PSR_N_BIT |= PSR_Z_BIT */
+		return temp & PSR_N_BIT;
+
+	case 0xe: /* al */
+	case 0xf: /* unconditional */
+		return true;
+	}
+	BUG();
+	return false;
+}
+
+static int is_last_scenario;
+static int probe_should_run; /* 0 = no, 1 = yes, -1 = unknown */
+static int memory_needs_checking;
+
+static unsigned long test_context_cpsr(int scenario)
+{
+	unsigned long cpsr;
+
+	probe_should_run = 1;
+
+	/* Default case is that we cycle through 16 combinations of flags */
+	cpsr  = (scenario & 0xf) << 28; /* N,Z,C,V flags */
+	cpsr |= (scenario & 0xf) << 16; /* GE flags */
+	cpsr |= (scenario & 0x1) << 27; /* Toggle Q flag */
+
+	if (!test_case_is_thumb) {
+		/* Testing ARM code */
+		probe_should_run = test_check_cc(current_instruction >> 28, cpsr) != 0;
+		if (scenario == 15)
+			is_last_scenario = true;
+
+	} else if (kprobe_test_flags & TEST_FLAG_NO_ITBLOCK) {
+		/* Testing Thumb code without setting ITSTATE */
+		if (kprobe_test_cc_position) {
+			int cc = (current_instruction >> kprobe_test_cc_position) & 0xf;
+			probe_should_run = test_check_cc(cc, cpsr) != 0;
+		}
+
+		if (scenario == 15)
+			is_last_scenario = true;
+
+	} else if (kprobe_test_flags & TEST_FLAG_FULL_ITBLOCK) {
+		/* Testing Thumb code with all combinations of ITSTATE */
+		unsigned x = (scenario >> 4);
+		unsigned cond_base = x % 7; /* ITSTATE<7:5> */
+		unsigned mask = x / 7 + 2;  /* ITSTATE<4:0>, bits reversed */
+
+		if (mask > 0x1f) {
+			/* Finish by testing state from instruction 'itt al' */
+			cond_base = 7;
+			mask = 0x4;
+			if ((scenario & 0xf) == 0xf)
+				is_last_scenario = true;
+		}
+
+		cpsr |= cond_base << 13;	/* ITSTATE<7:5> */
+		cpsr |= (mask & 0x1) << 12;	/* ITSTATE<4> */
+		cpsr |= (mask & 0x2) << 10;	/* ITSTATE<3> */
+		cpsr |= (mask & 0x4) << 8;	/* ITSTATE<2> */
+		cpsr |= (mask & 0x8) << 23;	/* ITSTATE<1> */
+		cpsr |= (mask & 0x10) << 21;	/* ITSTATE<0> */
+
+		probe_should_run = test_check_cc((cpsr >> 12) & 0xf, cpsr) != 0;
+
+	} else {
+		/* Testing Thumb code with several combinations of ITSTATE */
+		switch (scenario) {
+		case 16: /* Clear NZCV flags and 'it eq' state (false as Z=0) */
+			cpsr = 0x00000800;
+			probe_should_run = 0;
+			break;
+		case 17: /* Set NZCV flags and 'it vc' state (false as V=1) */
+			cpsr = 0xf0007800;
+			probe_should_run = 0;
+			break;
+		case 18: /* Clear NZCV flags and 'it ls' state (true as C=0) */
+			cpsr = 0x00009800;
+			break;
+		case 19: /* Set NZCV flags and 'it cs' state (true as C=1) */
+			cpsr = 0xf0002800;
+			is_last_scenario = true;
+			break;
+		}
+	}
+
+	return cpsr;
+}
+
+static void setup_test_context(struct pt_regs *regs)
+{
+	int scenario = test_case_run_count>>1;
+	unsigned long val;
+	struct test_arg *args;
+	int i;
+
+	is_last_scenario = false;
+	memory_needs_checking = false;
+
+	/* Initialise test memory on stack */
+	val = (scenario & 1) ? VALM : ~VALM;
+	for (i = 0; i < TEST_MEMORY_SIZE / sizeof(current_stack[0]); ++i)
+		current_stack[i] = val + (i << 8);
+	/* Put target of branch on stack for tests which load PC from memory */
+	if (current_branch_target)
+		current_stack[15] = current_branch_target;
+	/* Put a value for SP on stack for tests which load SP from memory */
+	current_stack[13] = (u32)current_stack + 120;
+
+	/* Initialise register values to their default state */
+	val = (scenario & 2) ? VALR : ~VALR;
+	for (i = 0; i < 13; ++i)
+		regs->uregs[i] = val ^ (i << 8);
+	regs->ARM_lr = val ^ (14 << 8);
+	regs->ARM_cpsr &= ~(APSR_MASK | PSR_IT_MASK);
+	regs->ARM_cpsr |= test_context_cpsr(scenario);
+
+	/* Perform testcase specific register setup  */
+	args = current_args;
+	for (; args[0].type != ARG_TYPE_END; ++args)
+		switch (args[0].type) {
+		case ARG_TYPE_REG: {
+			struct test_arg_regptr *arg =
+				(struct test_arg_regptr *)args;
+			regs->uregs[arg->reg] = arg->val;
+			break;
+		}
+		case ARG_TYPE_PTR: {
+			struct test_arg_regptr *arg =
+				(struct test_arg_regptr *)args;
+			regs->uregs[arg->reg] =
+				(unsigned long)current_stack + arg->val;
+			memory_needs_checking = true;
+			break;
+		}
+		case ARG_TYPE_MEM: {
+			struct test_arg_mem *arg = (struct test_arg_mem *)args;
+			current_stack[arg->index] = arg->val;
+			break;
+		}
+		default:
+			break;
+		}
+}
+
+struct test_probe {
+	struct kprobe	kprobe;
+	bool		registered;
+	int		hit;
+};
+
+static void unregister_test_probe(struct test_probe *probe)
+{
+	if (probe->registered) {
+		unregister_kprobe(&probe->kprobe);
+		probe->kprobe.flags = 0; /* Clear disable flag to allow reuse */
+	}
+	probe->registered = false;
+}
+
+static int register_test_probe(struct test_probe *probe)
+{
+	int ret;
+
+	if (probe->registered)
+		BUG();
+
+	ret = register_kprobe(&probe->kprobe);
+	if (ret >= 0) {
+		probe->registered = true;
+		probe->hit = -1;
+	}
+	return ret;
+}
+
+static int __kprobes
+test_before_pre_handler(struct kprobe *p, struct pt_regs *regs)
+{
+	container_of(p, struct test_probe, kprobe)->hit = test_instance;
+	return 0;
+}
+
+static void __kprobes
+test_before_post_handler(struct kprobe *p, struct pt_regs *regs,
+							unsigned long flags)
+{
+	setup_test_context(regs);
+	initial_regs = *regs;
+	initial_regs.ARM_cpsr &= ~PSR_IGNORE_BITS;
+}
+
+static int __kprobes
+test_case_pre_handler(struct kprobe *p, struct pt_regs *regs)
+{
+	container_of(p, struct test_probe, kprobe)->hit = test_instance;
+	return 0;
+}
+
+static int __kprobes
+test_after_pre_handler(struct kprobe *p, struct pt_regs *regs)
+{
+	if (container_of(p, struct test_probe, kprobe)->hit == test_instance)
+		return 0; /* Already run for this test instance */
+
+	result_regs = *regs;
+	result_regs.ARM_cpsr &= ~PSR_IGNORE_BITS;
+
+	/* Undo any changes done to SP by the test case */
+	regs->ARM_sp = (unsigned long)current_stack;
+
+	container_of(p, struct test_probe, kprobe)->hit = test_instance;
+	return 0;
+}
+
+static struct test_probe test_before_probe = {
+	.kprobe.pre_handler	= test_before_pre_handler,
+	.kprobe.post_handler	= test_before_post_handler,
+};
+
+static struct test_probe test_case_probe = {
+	.kprobe.pre_handler	= test_case_pre_handler,
+};
+
+static struct test_probe test_after_probe = {
+	.kprobe.pre_handler	= test_after_pre_handler,
+};
+
+static struct test_probe test_after2_probe = {
+	.kprobe.pre_handler	= test_after_pre_handler,
+};
+
+static void test_case_cleanup(void)
+{
+	unregister_test_probe(&test_before_probe);
+	unregister_test_probe(&test_case_probe);
+	unregister_test_probe(&test_after_probe);
+	unregister_test_probe(&test_after2_probe);
+}
+
+static void print_registers(struct pt_regs *regs)
+{
+	pr_err("r0  %08lx | r1  %08lx | r2  %08lx | r3  %08lx\n",
+		regs->ARM_r0, regs->ARM_r1, regs->ARM_r2, regs->ARM_r3);
+	pr_err("r4  %08lx | r5  %08lx | r6  %08lx | r7  %08lx\n",
+		regs->ARM_r4, regs->ARM_r5, regs->ARM_r6, regs->ARM_r7);
+	pr_err("r8  %08lx | r9  %08lx | r10 %08lx | r11 %08lx\n",
+		regs->ARM_r8, regs->ARM_r9, regs->ARM_r10, regs->ARM_fp);
+	pr_err("r12 %08lx | sp  %08lx | lr  %08lx | pc  %08lx\n",
+		regs->ARM_ip, regs->ARM_sp, regs->ARM_lr, regs->ARM_pc);
+	pr_err("cpsr %08lx\n", regs->ARM_cpsr);
+}
+
+static void print_memory(u32 *mem, size_t size)
+{
+	int i;
+	for (i = 0; i < size / sizeof(u32); i += 4)
+		pr_err("%08x %08x %08x %08x\n", mem[i], mem[i+1],
+						mem[i+2], mem[i+3]);
+}
+
+static size_t expected_memory_size(u32 *sp)
+{
+	size_t size = sizeof(expected_memory);
+	int offset = (uintptr_t)sp - (uintptr_t)current_stack;
+	if (offset > 0)
+		size -= offset;
+	return size;
+}
+
+static void test_case_failed(const char *message)
+{
+	test_case_cleanup();
+
+	pr_err("FAIL: %s\n", message);
+	pr_err("FAIL: Test %s\n", current_title);
+	pr_err("FAIL: Scenario %d\n", test_case_run_count >> 1);
+}
+
+static unsigned long next_instruction(unsigned long pc)
+{
+#ifdef CONFIG_THUMB2_KERNEL
+	if ((pc & 1) && !is_wide_instruction(*(u16 *)(pc - 1)))
+		return pc + 2;
+	else
+#endif
+	return pc + 4;
+}
+
+static uintptr_t __used kprobes_test_case_start(const char *title, void *stack)
+{
+	struct test_arg *args;
+	struct test_arg_end *end_arg;
+	unsigned long test_code;
+
+	args = (struct test_arg *)PTR_ALIGN(title + strlen(title) + 1, 4);
+
+	current_title = title;
+	current_args = args;
+	current_stack = stack;
+
+	++test_try_count;
+
+	while (args->type != ARG_TYPE_END)
+		++args;
+	end_arg = (struct test_arg_end *)args;
+
+	test_code = (unsigned long)(args + 1); /* Code starts after args */
+
+	test_case_is_thumb = end_arg->flags & ARG_FLAG_THUMB;
+	if (test_case_is_thumb)
+		test_code |= 1;
+
+	current_code_start = test_code;
+
+	current_branch_target = 0;
+	if (end_arg->branch_offset != end_arg->end_offset)
+		current_branch_target = test_code + end_arg->branch_offset;
+
+	test_code += end_arg->code_offset;
+	test_before_probe.kprobe.addr = (kprobe_opcode_t *)test_code;
+
+	test_code = next_instruction(test_code);
+	test_case_probe.kprobe.addr = (kprobe_opcode_t *)test_code;
+
+	if (test_case_is_thumb) {
+		u16 *p = (u16 *)(test_code & ~1);
+		current_instruction = p[0];
+		if (is_wide_instruction(current_instruction)) {
+			current_instruction <<= 16;
+			current_instruction |= p[1];
+		}
+	} else {
+		current_instruction = *(u32 *)test_code;
+	}
+
+	if (current_title[0] == '.')
+		verbose("%s\n", current_title);
+	else
+		verbose("%s\t@ %0*x\n", current_title,
+					test_case_is_thumb ? 4 : 8,
+					current_instruction);
+
+	test_code = next_instruction(test_code);
+	test_after_probe.kprobe.addr = (kprobe_opcode_t *)test_code;
+
+	if (kprobe_test_flags & TEST_FLAG_NARROW_INSTR) {
+		if (!test_case_is_thumb ||
+			is_wide_instruction(current_instruction)) {
+				test_case_failed("expected 16-bit instruction");
+				goto fail;
+		}
+	} else {
+		if (test_case_is_thumb &&
+			!is_wide_instruction(current_instruction)) {
+				test_case_failed("expected 32-bit instruction");
+				goto fail;
+		}
+	}
+
+	if (end_arg->flags & ARG_FLAG_UNSUPPORTED) {
+		if (register_test_probe(&test_case_probe) < 0)
+			goto pass;
+		test_case_failed("registered probe for unsupported instruction");
+		goto fail;
+	}
+
+	if (end_arg->flags & ARG_FLAG_SUPPORTED) {
+		if (register_test_probe(&test_case_probe) >= 0)
+			goto pass;
+		test_case_failed("couldn't register probe for supported instruction");
+		goto fail;
+	}
+
+	if (register_test_probe(&test_before_probe) < 0) {
+		test_case_failed("register test_before_probe failed");
+		goto fail;
+	}
+	if (register_test_probe(&test_after_probe) < 0) {
+		test_case_failed("register test_after_probe failed");
+		goto fail;
+	}
+	if (current_branch_target) {
+		test_after2_probe.kprobe.addr =
+				(kprobe_opcode_t *)current_branch_target;
+		if (register_test_probe(&test_after2_probe) < 0) {
+			test_case_failed("register test_after2_probe failed");
+			goto fail;
+		}
+	}
+
+	/* Start first run of test case */
+	test_case_run_count = 0;
+	++test_instance;
+	return current_code_start;
+pass:
+	test_case_run_count = TEST_CASE_PASSED;
+	return (uintptr_t)test_after_probe.kprobe.addr;
+fail:
+	test_case_run_count = TEST_CASE_FAILED;
+	return (uintptr_t)test_after_probe.kprobe.addr;
+}
+
+static bool check_test_results(void)
+{
+	size_t mem_size = 0;
+	u32 *mem = 0;
+
+	if (memcmp(&expected_regs, &result_regs, sizeof(expected_regs))) {
+		test_case_failed("registers differ");
+		goto fail;
+	}
+
+	if (memory_needs_checking) {
+		mem = (u32 *)result_regs.ARM_sp;
+		mem_size = expected_memory_size(mem);
+		if (memcmp(expected_memory, mem, mem_size)) {
+			test_case_failed("test memory differs");
+			goto fail;
+		}
+	}
+
+	return true;
+
+fail:
+	pr_err("initial_regs:\n");
+	print_registers(&initial_regs);
+	pr_err("expected_regs:\n");
+	print_registers(&expected_regs);
+	pr_err("result_regs:\n");
+	print_registers(&result_regs);
+
+	if (mem) {
+		pr_err("current_stack=%p\n", current_stack);
+		pr_err("expected_memory:\n");
+		print_memory(expected_memory, mem_size);
+		pr_err("result_memory:\n");
+		print_memory(mem, mem_size);
+	}
+
+	return false;
+}
+
+static uintptr_t __used kprobes_test_case_end(void)
+{
+	if (test_case_run_count < 0) {
+		if (test_case_run_count == TEST_CASE_PASSED)
+			/* kprobes_test_case_start did all the needed testing */
+			goto pass;
+		else
+			/* kprobes_test_case_start failed */
+			goto fail;
+	}
+
+	if (test_before_probe.hit != test_instance) {
+		test_case_failed("test_before_handler not run");
+		goto fail;
+	}
+
+	if (test_after_probe.hit != test_instance &&
+				test_after2_probe.hit != test_instance) {
+		test_case_failed("test_after_handler not run");
+		goto fail;
+	}
+
+	/*
+	 * Even numbered test runs ran without a probe on the test case so
+	 * we can gather reference results. The subsequent odd numbered run
+	 * will have the probe inserted.
+	*/
+	if ((test_case_run_count & 1) == 0) {
+		/* Save results from run without probe */
+		u32 *mem = (u32 *)result_regs.ARM_sp;
+		expected_regs = result_regs;
+		memcpy(expected_memory, mem, expected_memory_size(mem));
+
+		/* Insert probe onto test case instruction */
+		if (register_test_probe(&test_case_probe) < 0) {
+			test_case_failed("register test_case_probe failed");
+			goto fail;
+		}
+	} else {
+		/* Check probe ran as expected */
+		if (probe_should_run == 1) {
+			if (test_case_probe.hit != test_instance) {
+				test_case_failed("test_case_handler not run");
+				goto fail;
+			}
+		} else if (probe_should_run == 0) {
+			if (test_case_probe.hit == test_instance) {
+				test_case_failed("test_case_handler ran");
+				goto fail;
+			}
+		}
+
+		/* Remove probe for any subsequent reference run */
+		unregister_test_probe(&test_case_probe);
+
+		if (!check_test_results())
+			goto fail;
+
+		if (is_last_scenario)
+			goto pass;
+	}
+
+	/* Do next test run */
+	++test_case_run_count;
+	++test_instance;
+	return current_code_start;
+fail:
+	++test_fail_count;
+	goto end;
+pass:
+	++test_pass_count;
+end:
+	test_case_cleanup();
+	return 0;
+}
+
+
+/*
  * Top level test functions
  */
 
-- 
1.7.2.5
