From: will.deacon@arm.com (Will Deacon)
Date: Fri, 9 Dec 2011 15:54:50 +0000
Subject: [PATCH 4/4] Use generic ARM instruction set condition code
 checks for kprobes.
In-Reply-To: <20111208173212.7572.16210.stgit@localhost6.localdomain6>
References: <20111208173100.7572.9099.stgit@localhost6.localdomain6>
 <20111208173212.7572.16210.stgit@localhost6.localdomain6>
Message-ID: <20111209155450.GI5196@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

DISCLAIMER: I'm not a kprobes expert!

On Thu, Dec 08, 2011 at 05:32:13PM +0000, Leif Lindholm wrote:
> diff --git a/arch/arm/kernel/kprobes-test.c b/arch/arm/kernel/kprobes-test.c
> index e17cdd6..f81c2b4 100644
> --- a/arch/arm/kernel/kprobes-test.c
> +++ b/arch/arm/kernel/kprobes-test.c
> @@ -202,6 +202,8 @@
>  #include <linux/slab.h>
>  #include <linux/kprobes.h>
>  
> +#include <asm/opcodes.h>
> +

[...]

> -static unsigned long test_check_cc(int cc, unsigned long cpsr)
> +inline unsigned long test_check_cc(int cc, unsigned long cpsr)

Not sure why you make this change, surely you can just leave it as static?

>  {
> -	unsigned long temp;
> -
> -	switch (cc) {
> -	case 0x0: /* eq */
> -		return cpsr & PSR_Z_BIT;
> -
> -	case 0x1: /* ne */
> -		return (~cpsr) & PSR_Z_BIT;
> -
> -	case 0x2: /* cs */
> -		return cpsr & PSR_C_BIT;
> -
> -	case 0x3: /* cc */
> -		return (~cpsr) & PSR_C_BIT;
> -
> -	case 0x4: /* mi */
> -		return cpsr & PSR_N_BIT;
> -
> -	case 0x5: /* pl */
> -		return (~cpsr) & PSR_N_BIT;
> -
> -	case 0x6: /* vs */
> -		return cpsr & PSR_V_BIT;
> -
> -	case 0x7: /* vc */
> -		return (~cpsr) & PSR_V_BIT;
> +	int ret = arm_check_condition(cc << 28, cpsr);

[...]

Maybe it's best just to change all of the callers to call
arm_check_condition directly, like you have done below for the ARM case. For
the Thumb cases will it work if you make sure that you put the condition
code in the top bits?

> @@ -1128,7 +1074,7 @@ static unsigned long test_context_cpsr(int scenario)
>  
>  	if (!test_case_is_thumb) {
>  		/* Testing ARM code */
> -		probe_should_run = test_check_cc(current_instruction >> 28, cpsr) != 0;
> +		probe_should_run = arm_check_condition(current_instruction, cpsr) != ARM_OPCODE_CONDTEST_FAIL;
>  		if (scenario == 15)
>  			is_last_scenario = true;

Will
