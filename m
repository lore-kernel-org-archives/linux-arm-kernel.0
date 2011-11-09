From: jon.medhurst@linaro.org (Jon Medhurst (Tixy))
Date: Wed, 09 Nov 2011 10:36:15 +0000
Subject: [PATCH] ARM: kprobes: Fix build error in test code
In-Reply-To: <1319017634.2183.19.camel@linaro1>
References: <1319017634.2183.19.camel@linaro1>
Message-ID: <1320834975.2427.7.camel@linaro1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2011-10-19 at 10:47 +0100, Jon Medhurst (Tixy) wrote:
> When compiling kprobes-test-thumb.c an error like below may occur:
> 
> /tmp/ccKcuJcG.s:19179: Error: offset out of range
> 
> This is caused by the compiler underestimating the size of the inline
> assembler instructions containing ".space 0x1000" and failing to spill
> the literal pool in time to prevent the generation of PC relative load
> instruction with invalid offsets.
> 
> The fix implemented by this patch is to replace a single large .space
> directive by a number of 4 byte .space's. This requires splitting the
> macros which generate test cases for branch instructions into two forms:
> one with, and one without support for inserting extra code between
> branch and target.
> 
> Signed-off-by: Jon Medhurst <jon.medhurst@linaro.org>
> ---

Nicolas, I noticed that you put this patch into the Linaro kernel tree,
can I take that as an Acked-by? ;-)

-- 
Tixy

>  arch/arm/kernel/kprobes-test.h       |  100 ++++++++++++++++++++++++----------
>  arch/arm/kernel/kprobes-test-thumb.c |   16 +++---
>  2 files changed, 78 insertions(+), 38 deletions(-)
> 
> diff --git a/arch/arm/kernel/kprobes-test.h b/arch/arm/kernel/kprobes-test.h
> index 0dc5d77..e28a869 100644
> --- a/arch/arm/kernel/kprobes-test.h
> +++ b/arch/arm/kernel/kprobes-test.h
> @@ -149,23 +149,31 @@ struct test_arg_end {
>  	"1:	"instruction"				\n\t"	\
>  	"	nop					\n\t"
>  
> -#define TEST_BRANCH_F(instruction, xtra_dist)			\
> +#define TEST_BRANCH_F(instruction)				\
>  	TEST_INSTRUCTION(instruction)				\
> -	".if "#xtra_dist"				\n\t"	\
>  	"	b	99f				\n\t"	\
> -	".space "#xtra_dist"				\n\t"	\
> -	".endif						\n\t"	\
> +	"2:	nop					\n\t"
> +
> +#define TEST_BRANCH_B(instruction)				\
> +	"	b	50f				\n\t"	\
> +	"	b	99f				\n\t"	\
> +	"2:	nop					\n\t"	\
> +	"	b	99f				\n\t"	\
> +	TEST_INSTRUCTION(instruction)
> +
> +#define TEST_BRANCH_FX(instruction, codex)			\
> +	TEST_INSTRUCTION(instruction)				\
> +	"	b	99f				\n\t"	\
> +	codex"						\n\t"	\
>  	"	b	99f				\n\t"	\
>  	"2:	nop					\n\t"
>  
> -#define TEST_BRANCH_B(instruction, xtra_dist)			\
> +#define TEST_BRANCH_BX(instruction, codex)			\
>  	"	b	50f				\n\t"	\
>  	"	b	99f				\n\t"	\
>  	"2:	nop					\n\t"	\
>  	"	b	99f				\n\t"	\
> -	".if "#xtra_dist"				\n\t"	\
> -	".space "#xtra_dist"				\n\t"	\
> -	".endif						\n\t"	\
> +	codex"						\n\t"	\
>  	TEST_INSTRUCTION(instruction)
>  
>  #define TESTCASE_END						\
> @@ -301,47 +309,60 @@ struct test_arg_end {
>  	TESTCASE_START(code1 #reg1 code2)	\
>  	TEST_ARG_PTR(reg1, val1)		\
>  	TEST_ARG_END("")			\
> -	TEST_BRANCH_F(code1 #reg1 code2, 0)	\
> +	TEST_BRANCH_F(code1 #reg1 code2)	\
>  	TESTCASE_END
>  
> -#define TEST_BF_X(code, xtra_dist)		\
> +#define TEST_BF(code)				\
>  	TESTCASE_START(code)			\
>  	TEST_ARG_END("")			\
> -	TEST_BRANCH_F(code, xtra_dist)		\
> +	TEST_BRANCH_F(code)			\
>  	TESTCASE_END
>  
> -#define TEST_BB_X(code, xtra_dist)		\
> +#define TEST_BB(code)				\
>  	TESTCASE_START(code)			\
>  	TEST_ARG_END("")			\
> -	TEST_BRANCH_B(code, xtra_dist)		\
> +	TEST_BRANCH_B(code)			\
>  	TESTCASE_END
>  
> -#define TEST_BF_RX(code1, reg, val, code2, xtra_dist)	\
> -	TESTCASE_START(code1 #reg code2)		\
> -	TEST_ARG_REG(reg, val)				\
> -	TEST_ARG_END("")				\
> -	TEST_BRANCH_F(code1 #reg code2, xtra_dist)	\
> +#define TEST_BF_R(code1, reg, val, code2)	\
> +	TESTCASE_START(code1 #reg code2)	\
> +	TEST_ARG_REG(reg, val)			\
> +	TEST_ARG_END("")			\
> +	TEST_BRANCH_F(code1 #reg code2)		\
>  	TESTCASE_END
>  
> -#define TEST_BB_RX(code1, reg, val, code2, xtra_dist)	\
> -	TESTCASE_START(code1 #reg code2)		\
> -	TEST_ARG_REG(reg, val)				\
> -	TEST_ARG_END("")				\
> -	TEST_BRANCH_B(code1 #reg code2, xtra_dist)	\
> +#define TEST_BB_R(code1, reg, val, code2)	\
> +	TESTCASE_START(code1 #reg code2)	\
> +	TEST_ARG_REG(reg, val)			\
> +	TEST_ARG_END("")			\
> +	TEST_BRANCH_B(code1 #reg code2)		\
>  	TESTCASE_END
>  
> -#define TEST_BF(code)	TEST_BF_X(code, 0)
> -#define TEST_BB(code)	TEST_BB_X(code, 0)
> -
> -#define TEST_BF_R(code1, reg, val, code2) TEST_BF_RX(code1, reg, val, code2, 0)
> -#define TEST_BB_R(code1, reg, val, code2) TEST_BB_RX(code1, reg, val, code2, 0)
> -
>  #define TEST_BF_RR(code1, reg1, val1, code2, reg2, val2, code3)	\
>  	TESTCASE_START(code1 #reg1 code2 #reg2 code3)		\
>  	TEST_ARG_REG(reg1, val1)				\
>  	TEST_ARG_REG(reg2, val2)				\
>  	TEST_ARG_END("")					\
> -	TEST_BRANCH_F(code1 #reg1 code2 #reg2 code3, 0)		\
> +	TEST_BRANCH_F(code1 #reg1 code2 #reg2 code3)		\
> +	TESTCASE_END
> +
> +#define TEST_BF_X(code, codex)			\
> +	TESTCASE_START(code)			\
> +	TEST_ARG_END("")			\
> +	TEST_BRANCH_FX(code, codex)		\
> +	TESTCASE_END
> +
> +#define TEST_BB_X(code, codex)			\
> +	TESTCASE_START(code)			\
> +	TEST_ARG_END("")			\
> +	TEST_BRANCH_BX(code, codex)		\
> +	TESTCASE_END
> +
> +#define TEST_BF_RX(code1, reg, val, code2, codex)	\
> +	TESTCASE_START(code1 #reg code2)		\
> +	TEST_ARG_REG(reg, val)				\
> +	TEST_ARG_END("")				\
> +	TEST_BRANCH_FX(code1 #reg code2, codex)		\
>  	TESTCASE_END
>  
>  #define TEST_X(code, codex)			\
> @@ -372,6 +393,25 @@ struct test_arg_end {
>  	TESTCASE_END
>  
> 
> +/*
> + * Macros for defining space directives spread over multiple lines.
> + * These are required so the compiler guesses better the length of inline asm
> + * code and will spill the literal pool early enough to avoid generating PC
> + * relative loads with out of range offsets.
> + */
> +#define TWICE(x)	x x
> +#define SPACE_0x8	TWICE(".space 4\n\t")
> +#define SPACE_0x10	TWICE(SPACE_0x8)
> +#define SPACE_0x20	TWICE(SPACE_0x10)
> +#define SPACE_0x40	TWICE(SPACE_0x20)
> +#define SPACE_0x80	TWICE(SPACE_0x40)
> +#define SPACE_0x100	TWICE(SPACE_0x80)
> +#define SPACE_0x200	TWICE(SPACE_0x100)
> +#define SPACE_0x400	TWICE(SPACE_0x200)
> +#define SPACE_0x800	TWICE(SPACE_0x400)
> +#define SPACE_0x1000	TWICE(SPACE_0x800)
> +
> +
>  /* Various values used in test cases... */
>  #define N(val)	(val ^ 0xffffffff)
>  #define VAL1	0x12345678
> diff --git a/arch/arm/kernel/kprobes-test-thumb.c b/arch/arm/kernel/kprobes-test-thumb.c
> index 5e726c3..5d8b857 100644
> --- a/arch/arm/kernel/kprobes-test-thumb.c
> +++ b/arch/arm/kernel/kprobes-test-thumb.c
> @@ -222,8 +222,8 @@ void kprobe_thumb16_test_cases(void)
>  DONT_TEST_IN_ITBLOCK(
>  	TEST_BF_R(  "cbnz	r",0,0, ", 2f")
>  	TEST_BF_R(  "cbz	r",2,-1,", 2f")
> -	TEST_BF_RX( "cbnz	r",4,1, ", 2f",0x20)
> -	TEST_BF_RX( "cbz	r",7,0, ", 2f",0x40)
> +	TEST_BF_RX( "cbnz	r",4,1, ", 2f", SPACE_0x20)
> +	TEST_BF_RX( "cbz	r",7,0, ", 2f", SPACE_0x40)
>  )
>  	TEST_R("sxth	r0, r",7, HH1,"")
>  	TEST_R("sxth	r7, r",0, HH2,"")
> @@ -246,7 +246,7 @@ DONT_TEST_IN_ITBLOCK(
>  	TESTCASE_START(code)		\
>  	TEST_ARG_PTR(13, offset)	\
>  	TEST_ARG_END("")		\
> -	TEST_BRANCH_F(code,0)		\
> +	TEST_BRANCH_F(code)		\
>  	TESTCASE_END
>  
>  	TEST("push	{r0}")
> @@ -319,8 +319,8 @@ CONDITION_INSTRUCTIONS(8,
>  
>  	TEST_BF(  "b	2f")
>  	TEST_BB(  "b	2b")
> -	TEST_BF_X("b	2f", 0x400)
> -	TEST_BB_X("b	2b", 0x400)
> +	TEST_BF_X("b	2f", SPACE_0x400)
> +	TEST_BB_X("b	2b", SPACE_0x400)
>  
>  	TEST_GROUP("Testing instructions in IT blocks")
>  
> @@ -746,7 +746,7 @@ CONDITION_INSTRUCTIONS(22,
>  	TEST_BB("bne.w	2b")
>  	TEST_BF("bgt.w	2f")
>  	TEST_BB("blt.w	2b")
> -	TEST_BF_X("bpl.w	2f",0x1000)
> +	TEST_BF_X("bpl.w	2f", SPACE_0x1000)
>  )
>  
>  	TEST_UNSUPPORTED("msr	cpsr, r0")
> @@ -786,11 +786,11 @@ CONDITION_INSTRUCTIONS(22,
>  
>  	TEST_BF(  "b.w	2f")
>  	TEST_BB(  "b.w	2b")
> -	TEST_BF_X("b.w	2f", 0x1000)
> +	TEST_BF_X("b.w	2f", SPACE_0x1000)
>  
>  	TEST_BF(  "bl.w	2f")
>  	TEST_BB(  "bl.w	2b")
> -	TEST_BB_X("bl.w	2b", 0x1000)
> +	TEST_BB_X("bl.w	2b", SPACE_0x1000)
>  
>  	TEST_X(	"blx	__dummy_arm_subroutine",
>  		".arm				\n\t"
