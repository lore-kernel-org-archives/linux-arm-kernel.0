From: tixy@linaro.org (Jon Medhurst (Tixy))
Date: Fri, 03 Jan 2014 15:53:06 +0000
Subject: [PATCH 2/5] ARM: kprobes-test: use <asm/opcodes.h> for
 instruction accesses
In-Reply-To: <1387815579-15677-3-git-send-email-taras.kondratiuk@linaro.org>
References: <1387815579-15677-1-git-send-email-taras.kondratiuk@linaro.org>
 <1387815579-15677-3-git-send-email-taras.kondratiuk@linaro.org>
Message-ID: <1388764386.3430.10.camel@linaro1.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2013-12-23 at 18:19 +0200, Taras Kondratiuk wrote:
> From: Ben Dooks <ben.dooks@codethink.co.uk>
> 
> Ensure we read instructions in the correct endian-ness by using
> the <asm/opcodes.h> helper to transform them as necessary.
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> [taras.kondratiuk at linaro.org: fix next_instruction() function]
> Signed-off-by: Taras Kondratiuk <taras.kondratiuk@linaro.org>
> ---

Apart from the spurious line removal (see below) then:

Acked-by: Jon Medhurst <tixy@linaro.org>

and you can include an ACK for the other patches in this series too.

Thanks.


>  arch/arm/kernel/kprobes-test.c |   12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/kernel/kprobes-test.c b/arch/arm/kernel/kprobes-test.c
> index 0cd63d0..96e3dbc 100644
> --- a/arch/arm/kernel/kprobes-test.c
> +++ b/arch/arm/kernel/kprobes-test.c
> @@ -1329,7 +1329,8 @@ static void test_case_failed(const char *message)
>  static unsigned long next_instruction(unsigned long pc)
>  {
>  #ifdef CONFIG_THUMB2_KERNEL
> -	if ((pc & 1) && !is_wide_instruction(*(u16 *)(pc - 1)))
> +	if ((pc & 1) &&
> +	    !is_wide_instruction(__mem_to_opcode_thumb16(*(u16 *)(pc - 1))))
>  		return pc + 2;
>  	else
>  #endif
> @@ -1374,13 +1375,13 @@ static uintptr_t __used kprobes_test_case_start(const char *title, void *stack)
>  
>  	if (test_case_is_thumb) {
>  		u16 *p = (u16 *)(test_code & ~1);
> -		current_instruction = p[0];
> +		current_instruction = __mem_to_opcode_thumb16(p[0]);
>  		if (is_wide_instruction(current_instruction)) {
> -			current_instruction <<= 16;
> -			current_instruction |= p[1];
> +			u16 instr2 = __mem_to_opcode_thumb16(p[1]);
> +			current_instruction = __opcode_thumb32_compose(current_instruction, instr2);
>  		}
>  	} else {
> -		current_instruction = *(u32 *)test_code;
> +		current_instruction = __mem_to_opcode_arm(*(u32 *)test_code);
>  	}
>  
>  	if (current_title[0] == '.')
> @@ -1593,7 +1594,6 @@ static int run_test_cases(void (*tests)(void), const union decode_item *table)
>  	return 0;
>  }
>  
> -

I know the above blank line isn't needed but I believe the convention is
to avoid doing unrelated white-space clean-ups in patches.

>  static int __init run_all_tests(void)
>  {
>  	int ret = 0;
