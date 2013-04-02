From: tixy@linaro.org (Jon Medhurst (Tixy))
Date: Tue, 02 Apr 2013 15:19:13 +0100
Subject: [PATCH] ARM: kprobes: fix test coverage missing failures
In-Reply-To: <1364871884-28252-1-git-send-email-kpark3469@gmail.com>
References: <1364871884-28252-1-git-send-email-kpark3469@gmail.com>
Message-ID: <1364912353.3650.91.camel@linaro1.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2013-04-02 at 12:04 +0900, kpark3469 at gmail.com wrote:
> From: Sahara <keun-o.park@windriver.com>
> 
> If kprobe tests run on ARMv6k or ARMv6, there're a number of test
> coverage missing failures like:

The tests only fail (return an error code) for the coverage tests when
compiled for ARMv7 because, obviously, that's the only architecture that
can cover all the combinations of instructions. Perhaps we should just
disabled the coverage tests pre-ARMv7 kernels to avoid the noisy output
you see.

I think the best way to look at it is that the coverage tests are test
code for the test code, and should only be of concern to people updating
the test code.

If we go down the route that this patch follows of conditional
compilation then we are making the main kernel code more messy in order
to support test code and I'm not sure that is a good idea. It will be
much worse should someone want to do the same for ARMv5.

There is also the problem that once you #ifdef things for ARMv6 then you
need an ARMv6 system to test that combination of data structures,
whereas at the moment an ARMv7 board will cover everything.

-- 
Tixy

> FAIL: Register test coverage missing for 0ff000f0 00600090 (04404)
> FAIL: Test coverage entry missing for 0ff000f0 00600090
> FAIL: Test coverage entry missing for 0f200090 00200090
> FAIL: Register test coverage missing for 0fb00000 03000000 (05000)
> FAIL: Test coverage entry missing for 0fb00000 03000000
> FAIL: Test coverage entry missing for 0fff00ff 03200001
> FAIL: Test coverage entry missing for 0fff00ff 03200004
> FAIL: Test coverage entry missing for 0fff00fc 03200000
> FAIL: Test coverage entry missing for 0fb00010 06000010
> FAIL: Test coverage entry missing for 0f8000f0 060000b0
> FAIL: Test coverage entry missing for 0f8000f0 060000d0
> FAIL: Register test coverage missing for 0f800010 06000010 (55005)
> FAIL: Test coverage entry missing for 0f800010 06000010
> FAIL: Test coverage entry missing for 0ff000f0 07f000f0
> FAIL: Register test coverage missing for 0fa00070 07a00050 (05005)
> FAIL: Test coverage entry missing for 0fa00070 07a00050
> FAIL: Register test coverage missing for 0fe0007f 07c0001f (05000)
> FAIL: Test coverage entry missing for 0fe0007f 07c0001f
> FAIL: Register test coverage missing for 0fe00070 07c00010 (05001)
> FAIL: Test coverage entry missing for 0fe00070 07c00010
> 
> Some instructions (like yield, sev, nop, and so on) are available in
> ARMv6k or ARMv7, which we can test by checking the __LINUX_ARM_ARCH__
> or checking the CONFIG_CPU_32v6K.
> While MLS is excluded on ARMv6, more TEST_UNSUPPORTED coverages for
> MLA is needed.
> NOP instruction is used in several predefined macros, and these will
> lead us to get a lot of INSN_REJECTED errors since the nop instruction
> is not included in kprobe_decode_arm_table on ARMv6. By checking the
> __LINUX_ARM_ARCH__ or the CONFIG_CPU_32v6K, 'nop' or 'mov r0,r0' will
> be selected.
> 
> Signed-off-by: Sahara <keun-o.park@windriver.com>
> ---
>  arch/arm/kernel/kprobes-arm.c      |   20 ++++++++++++++++++--
>  arch/arm/kernel/kprobes-test-arm.c |    3 +++
>  arch/arm/kernel/kprobes-test.c     |    2 +-
>  arch/arm/kernel/kprobes-test.h     |   18 ++++++++++++------
>  4 files changed, 34 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/arm/kernel/kprobes-arm.c b/arch/arm/kernel/kprobes-arm.c
> index 8a30c89..324fd22 100644
> --- a/arch/arm/kernel/kprobes-arm.c
> +++ b/arch/arm/kernel/kprobes-arm.c
> @@ -495,10 +495,13 @@ static const union decode_item arm_cccc_0000_____1001_table[] = {
>  
>  	/* MLA			cccc 0000 0010 xxxx xxxx xxxx 1001 xxxx */
>  	/* MLAS			cccc 0000 0011 xxxx xxxx xxxx 1001 xxxx */
> -	DECODE_OR	(0x0fe000f0, 0x00200090),
> +	DECODE_EMULATEX	(0x0fe000f0, 0x00200090, emulate_rd16rn12rm0rs8_rwflags_nopc,
> +						 REGS(NOPC, NOPC, NOPC, 0, NOPC)),
> +#if __LINUX_ARM_ARCH__ >= 7
>  	/* MLS			cccc 0000 0110 xxxx xxxx xxxx 1001 xxxx */
>  	DECODE_EMULATEX	(0x0ff000f0, 0x00600090, emulate_rd16rn12rm0rs8_rwflags_nopc,
>  						 REGS(NOPC, NOPC, NOPC, 0, NOPC)),
> +#endif
>  
>  	/* UMAAL		cccc 0000 0100 xxxx xxxx xxxx 1001 xxxx */
>  	DECODE_OR	(0x0ff000f0, 0x00400090),
> @@ -533,12 +536,14 @@ static const union decode_item arm_cccc_0001_____1001_table[] = {
>  static const union decode_item arm_cccc_000x_____1xx1_table[] = {
>  	/* Extra load/store instructions				*/
>  
> +#if __LINUX_ARM_ARCH__ >= 7
>  	/* STRHT		cccc 0000 xx10 xxxx xxxx xxxx 1011 xxxx */
>  	/* ???			cccc 0000 xx10 xxxx xxxx xxxx 11x1 xxxx */
>  	/* LDRHT		cccc 0000 xx11 xxxx xxxx xxxx 1011 xxxx */
>  	/* LDRSBT		cccc 0000 xx11 xxxx xxxx xxxx 1101 xxxx */
>  	/* LDRSHT		cccc 0000 xx11 xxxx xxxx xxxx 1111 xxxx */
>  	DECODE_REJECT	(0x0f200090, 0x00200090),
> +#endif
>  
>  	/* LDRD/STRD lr,pc,{...	cccc 000x x0x0 xxxx 111x xxxx 1101 xxxx */
>  	DECODE_REJECT	(0x0e10e0d0, 0x0000e0d0),
> @@ -641,11 +646,14 @@ static const union decode_item arm_cccc_000x_table[] = {
>  static const union decode_item arm_cccc_001x_table[] = {
>  	/* Data-processing (immediate)					*/
>  
> +#if __LINUX_ARM_ARCH__ >= 7
>  	/* MOVW			cccc 0011 0000 xxxx xxxx xxxx xxxx xxxx */
>  	/* MOVT			cccc 0011 0100 xxxx xxxx xxxx xxxx xxxx */
>  	DECODE_EMULATEX	(0x0fb00000, 0x03000000, emulate_rd12rm0_noflags_nopc,
>  						 REGS(0, NOPC, 0, 0, 0)),
> +#endif
>  
> +#if (__LINUX_ARM_ARCH__ >= 7) || defined(CONFIG_CPU_32v6K)
>  	/* YIELD		cccc 0011 0010 0000 xxxx xxxx 0000 0001 */
>  	DECODE_OR	(0x0fff00ff, 0x03200001),
>  	/* SEV			cccc 0011 0010 0000 xxxx xxxx 0000 0100 */
> @@ -654,7 +662,9 @@ static const union decode_item arm_cccc_001x_table[] = {
>  	/* WFE			cccc 0011 0010 0000 xxxx xxxx 0000 0010 */
>  	/* WFI			cccc 0011 0010 0000 xxxx xxxx 0000 0011 */
>  	DECODE_SIMULATE	(0x0fff00fc, 0x03200000, kprobe_simulate_nop),
> -	/* DBG			cccc 0011 0010 0000 xxxx xxxx ffff xxxx */
> +	/* DBG			cccc 0011 0010 0000 xxxx xxxx 1111 xxxx */
> +	DECODE_REJECT	(0x0fb000f0, 0x032000f0),
> +#endif
>  	/* unallocated hints	cccc 0011 0010 0000 xxxx xxxx xxxx xxxx */
>  	/* MSR (immediate)	cccc 0011 0x10 xxxx xxxx xxxx xxxx xxxx */
>  	DECODE_REJECT	(0x0fb00000, 0x03200000),
> @@ -712,6 +722,7 @@ static const union decode_item arm_cccc_0110_____xxx1_table[] = {
>  	DECODE_EMULATEX	(0x0fb00070, 0x06b00030, emulate_rd12rm0_noflags_nopc,
>  						 REGS(0, NOPC, 0, 0, NOPC)),
>  
> +#if __LINUX_ARM_ARCH__ >= 7
>  	/* ???			cccc 0110 0x00 xxxx xxxx xxxx xxx1 xxxx */
>  	DECODE_REJECT	(0x0fb00010, 0x06000010),
>  	/* ???			cccc 0110 0xxx xxxx xxxx xxxx 1011 xxxx */
> @@ -756,6 +767,7 @@ static const union decode_item arm_cccc_0110_____xxx1_table[] = {
>  	/* UHSUB8		cccc 0110 0111 xxxx xxxx xxxx 1111 xxxx */
>  	DECODE_EMULATEX	(0x0f800010, 0x06000010, emulate_rd12rn16rm0_rwflags_nopc,
>  						 REGS(NOPC, NOPC, 0, 0, NOPC)),
> +#endif
>  
>  	/* PKHBT		cccc 0110 1000 xxxx xxxx xxxx x001 xxxx */
>  	/* PKHTB		cccc 0110 1000 xxxx xxxx xxxx x101 xxxx */
> @@ -790,8 +802,10 @@ static const union decode_item arm_cccc_0110_____xxx1_table[] = {
>  static const union decode_item arm_cccc_0111_____xxx1_table[] = {
>  	/* Media instructions						*/
>  
> +#if __LINUX_ARM_ARCH__ >= 7
>  	/* UNDEFINED		cccc 0111 1111 xxxx xxxx xxxx 1111 xxxx */
>  	DECODE_REJECT	(0x0ff000f0, 0x07f000f0),
> +#endif
>  
>  	/* SMLALD		cccc 0111 0100 xxxx xxxx xxxx 00x1 xxxx */
>  	/* SMLSLD		cccc 0111 0100 xxxx xxxx xxxx 01x1 xxxx */
> @@ -820,6 +834,7 @@ static const union decode_item arm_cccc_0111_____xxx1_table[] = {
>  	DECODE_EMULATEX	(0x0ff000d0, 0x075000d0, emulate_rd16rn12rm0rs8_rwflags_nopc,
>  						 REGS(NOPC, NOPC, NOPC, 0, NOPC)),
>  
> +#if __LINUX_ARM_ARCH__ >= 7
>  	/* SBFX			cccc 0111 101x xxxx xxxx xxxx x101 xxxx */
>  	/* UBFX			cccc 0111 111x xxxx xxxx xxxx x101 xxxx */
>  	DECODE_EMULATEX	(0x0fa00070, 0x07a00050, emulate_rd12rm0_noflags_nopc,
> @@ -832,6 +847,7 @@ static const union decode_item arm_cccc_0111_____xxx1_table[] = {
>  	/* BFI			cccc 0111 110x xxxx xxxx xxxx x001 xxxx */
>  	DECODE_EMULATEX	(0x0fe00070, 0x07c00010, emulate_rd12rm0_noflags_nopc,
>  						 REGS(0, NOPC, 0, 0, NOPCX)),
> +#endif
>  
>  	DECODE_END
>  };
> diff --git a/arch/arm/kernel/kprobes-test-arm.c b/arch/arm/kernel/kprobes-test-arm.c
> index 8393129..850b7b9 100644
> --- a/arch/arm/kernel/kprobes-test-arm.c
> +++ b/arch/arm/kernel/kprobes-test-arm.c
> @@ -353,6 +353,9 @@ void kprobe_arm_test_cases(void)
>  	TEST_RRR(    "mlahi	r7, r",8, VAL3,", r",9, VAL1,", r",10, VAL2,"")
>  	TEST_RR(     "mla	lr, r",1, VAL2,", r",2, VAL3,", r13")
>  	TEST_UNSUPPORTED(".word 0xe02f3291 @ mla pc, r1, r2, r3")
> +	TEST_UNSUPPORTED(".word 0xe020329f @ mla r0, pc, r2, r3")
> +	TEST_UNSUPPORTED(".word 0xe0203f91 @ mla r0, r1, pc, r3")
> +	TEST_UNSUPPORTED(".word 0xe020f291 @ mla r0, r1, r2, pc")
>  	TEST_RRR(    "mlas	r0, r",1, VAL1,", r",2, VAL2,", r",3,  VAL3,"")
>  	TEST_RRR(    "mlahis	r7, r",8, VAL3,", r",9, VAL1,", r",10, VAL2,"")
>  	TEST_RR(     "mlas	lr, r",1, VAL2,", r",2, VAL3,", r13")
> diff --git a/arch/arm/kernel/kprobes-test.c b/arch/arm/kernel/kprobes-test.c
> index 0cd63d0..0651fd6 100644
> --- a/arch/arm/kernel/kprobes-test.c
> +++ b/arch/arm/kernel/kprobes-test.c
> @@ -478,7 +478,7 @@ static int run_api_tests(long (*func)(long, long))
>  static void __naked benchmark_nop(void)
>  {
>  	__asm__ __volatile__ (
> -		"nop		\n\t"
> +		NOP"		\n\t"
>  		"bx	lr"
>  	);
>  }
> diff --git a/arch/arm/kernel/kprobes-test.h b/arch/arm/kernel/kprobes-test.h
> index e28a869..24822f0 100644
> --- a/arch/arm/kernel/kprobes-test.h
> +++ b/arch/arm/kernel/kprobes-test.h
> @@ -144,20 +144,26 @@ struct test_arg_end {
>  	".code "TEST_ISA"				\n\t"	\
>  	"0:						\n\t"
>  
> +#if (__LINUX_ARM_ARCH__ >= 7) || defined(CONFIG_CPU_32v6K)
> +#define NOP "nop"
> +#else
> +#define NOP "mov	r0, r0"
> +#endif
> +
>  #define TEST_INSTRUCTION(instruction)				\
> -	"50:	nop					\n\t"	\
> +	"50:	"NOP"					\n\t"	\
>  	"1:	"instruction"				\n\t"	\
> -	"	nop					\n\t"
> +	"	"NOP"					\n\t"
>  
>  #define TEST_BRANCH_F(instruction)				\
>  	TEST_INSTRUCTION(instruction)				\
>  	"	b	99f				\n\t"	\
> -	"2:	nop					\n\t"
> +	"2:	"NOP"					\n\t"
>  
>  #define TEST_BRANCH_B(instruction)				\
>  	"	b	50f				\n\t"	\
>  	"	b	99f				\n\t"	\
> -	"2:	nop					\n\t"	\
> +	"2:	"NOP"					\n\t"	\
>  	"	b	99f				\n\t"	\
>  	TEST_INSTRUCTION(instruction)
>  
> @@ -166,12 +172,12 @@ struct test_arg_end {
>  	"	b	99f				\n\t"	\
>  	codex"						\n\t"	\
>  	"	b	99f				\n\t"	\
> -	"2:	nop					\n\t"
> +	"2:	"NOP"					\n\t"
>  
>  #define TEST_BRANCH_BX(instruction, codex)			\
>  	"	b	50f				\n\t"	\
>  	"	b	99f				\n\t"	\
> -	"2:	nop					\n\t"	\
> +	"2:	"NOP"					\n\t"	\
>  	"	b	99f				\n\t"	\
>  	codex"						\n\t"	\
>  	TEST_INSTRUCTION(instruction)
