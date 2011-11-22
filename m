From: tixy@yxit.co.uk (Tixy)
Date: Tue, 22 Nov 2011 09:13:23 +0000
Subject: [PATCH 4/4] [RFC] Use generic ARM instruction set condition
 code checks for kprobes.
In-Reply-To: <20111121183104.28964.87120.stgit@localhost6.localdomain6>
References: <20111121183046.28964.23829.stgit@localhost6.localdomain6>
 <20111121183104.28964.87120.stgit@localhost6.localdomain6>
Message-ID: <1321953203.2557.55.camel@computer2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2011-11-21 at 18:31 +0000, Leif Lindholm wrote:
> This patch changes the kprobes implementation to use the generic ARM
> instruction set condition code checks, rather than a dedicated
> implementation.
> 
> Note, this is a direct interface change, and the resulting code is not
> the prettiest, but this is an RFC only.

It might be prettier to keep test_check_cc() but defined like:

inline unsigned long test_check_cc(int cc, unsigned long cpsr)
{
	return arm_check_condition(cc << 28, cpsr);
}

But still change to directly calling arm_check_condition() in the case
of checking ARM instructions.

> This code builds and links, but current 3.2-rc2 does not boot on my
> Versatile Express board with CONFIG_ARM_KPROBES_TEST enabled either
> with or without this patch.

What are the symptoms? Have you tried setting VERBOSE to '1' at the top
of kprobes-test.h?

Currently the test code has problems building for Thumb, there's a
patch:
http://www.mail-archive.com/linaro-dev at lists.linaro.org/msg07925.html

Also, when the test module is built-in, the tests fail near the
beginning due to an issue with Thumb symbol handling in the kernel, see
http://www.spinics.net/lists/arm-kernel/msg138283.html

But building it as a module and insmod'ing should work.

-- 
Tixy

> Cc: Tixy <tixy@yxit.co.uk>
> Signed-off-by: Leif Lindholm <leif.lindholm@arm.com>
> ---
>  arch/arm/kernel/kprobes-test.c |   71 +++-------------------------------------
>  1 files changed, 5 insertions(+), 66 deletions(-)
> 
> diff --git a/arch/arm/kernel/kprobes-test.c b/arch/arm/kernel/kprobes-test.c
> index e17cdd6..6f5328a 100644
> --- a/arch/arm/kernel/kprobes-test.c
> +++ b/arch/arm/kernel/kprobes-test.c
> @@ -202,6 +202,8 @@
>  #include <linux/slab.h>
>  #include <linux/kprobes.h>
>  
> +#include <asm/opcodes.h>
> +
>  #include "kprobes.h"
>  #include "kprobes-test.h"
>  
> @@ -1048,69 +1050,6 @@ static int test_instance;
>   */
>  #define PSR_IGNORE_BITS (PSR_A_BIT | PSR_F_BIT)
>  
> -static unsigned long test_check_cc(int cc, unsigned long cpsr)
> -{
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
> -
> -	case 0x8: /* hi */
> -		cpsr &= ~(cpsr >> 1); /* PSR_C_BIT &= ~PSR_Z_BIT */
> -		return cpsr & PSR_C_BIT;
> -
> -	case 0x9: /* ls */
> -		cpsr &= ~(cpsr >> 1); /* PSR_C_BIT &= ~PSR_Z_BIT */
> -		return (~cpsr) & PSR_C_BIT;
> -
> -	case 0xa: /* ge */
> -		cpsr ^= (cpsr << 3); /* PSR_N_BIT ^= PSR_V_BIT */
> -		return (~cpsr) & PSR_N_BIT;
> -
> -	case 0xb: /* lt */
> -		cpsr ^= (cpsr << 3); /* PSR_N_BIT ^= PSR_V_BIT */
> -		return cpsr & PSR_N_BIT;
> -
> -	case 0xc: /* gt */
> -		temp = cpsr ^ (cpsr << 3); /* PSR_N_BIT ^= PSR_V_BIT */
> -		temp |= (cpsr << 1);	   /* PSR_N_BIT |= PSR_Z_BIT */
> -		return (~temp) & PSR_N_BIT;
> -
> -	case 0xd: /* le */
> -		temp = cpsr ^ (cpsr << 3); /* PSR_N_BIT ^= PSR_V_BIT */
> -		temp |= (cpsr << 1);	   /* PSR_N_BIT |= PSR_Z_BIT */
> -		return temp & PSR_N_BIT;
> -
> -	case 0xe: /* al */
> -	case 0xf: /* unconditional */
> -		return true;
> -	}
> -	BUG();
> -	return false;
> -}
> -
>  static int is_last_scenario;
>  static int probe_should_run; /* 0 = no, 1 = yes, -1 = unknown */
>  static int memory_needs_checking;
> @@ -1128,7 +1067,7 @@ static unsigned long test_context_cpsr(int scenario)
>  
>  	if (!test_case_is_thumb) {
>  		/* Testing ARM code */
> -		probe_should_run = test_check_cc(current_instruction >> 28, cpsr) != 0;
> +		probe_should_run = arm_check_condition(current_instruction, cpsr) != 0;
>  		if (scenario == 15)
>  			is_last_scenario = true;
>  
> @@ -1136,7 +1075,7 @@ static unsigned long test_context_cpsr(int scenario)
>  		/* Testing Thumb code without setting ITSTATE */
>  		if (kprobe_test_cc_position) {
>  			int cc = (current_instruction >> kprobe_test_cc_position) & 0xf;
> -			probe_should_run = test_check_cc(cc, cpsr) != 0;
> +			probe_should_run = arm_check_condition(cc << 28, cpsr) != 0;
>  		}
>  
>  		if (scenario == 15)
> @@ -1163,7 +1102,7 @@ static unsigned long test_context_cpsr(int scenario)
>  		cpsr |= (mask & 0x8) << 23;	/* ITSTATE<1> */
>  		cpsr |= (mask & 0x10) << 21;	/* ITSTATE<0> */
>  
> -		probe_should_run = test_check_cc((cpsr >> 12) & 0xf, cpsr) != 0;
> +		probe_should_run = arm_check_condition(((cpsr >> 12) & 0xf) << 28, cpsr) != 0;
>  
>  	} else {
>  		/* Testing Thumb code with several combinations of ITSTATE */
> 
> 
