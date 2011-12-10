From: tixy@yxit.co.uk (Tixy)
Date: Sat, 10 Dec 2011 09:19:00 +0000
Subject: [PATCH 4/4] Use generic ARM instruction set condition code
 checks for kprobes.
In-Reply-To: <20111209185503.19655.37484.stgit@localhost6.localdomain6>
References: <20111209185302.19655.36481.stgit@localhost6.localdomain6>
 <20111209185503.19655.37484.stgit@localhost6.localdomain6>
Message-ID: <1323508740.2307.1.camel@computer2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2011-12-09 at 18:55 +0000, Leif Lindholm wrote:
> This patch changes the kprobes implementation to use the generic ARM
> instruction set condition code checks, rather than a dedicated
> implementation.
> 
> Signed-off-by: Leif Lindholm <leif.lindholm@arm.com>

Acked-by: Jon Medhurst <tixy@yxit.co.uk>

> ---
> Tixy's ACK removed as patch modified.
> 
>  arch/arm/kernel/kprobes-test.c |   66 ++++------------------------------------
>  1 files changed, 7 insertions(+), 59 deletions(-)
> 
> diff --git a/arch/arm/kernel/kprobes-test.c b/arch/arm/kernel/kprobes-test.c
> index e17cdd6..1862d8f 100644
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
> @@ -1050,65 +1052,9 @@ static int test_instance;
>  
>  static unsigned long test_check_cc(int cc, unsigned long cpsr)
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
>  
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
> +	return (ret != ARM_OPCODE_CONDTEST_FAIL);
>  }
>  
>  static int is_last_scenario;
> @@ -1128,7 +1074,9 @@ static unsigned long test_context_cpsr(int scenario)
>  
>  	if (!test_case_is_thumb) {
>  		/* Testing ARM code */
> -		probe_should_run = test_check_cc(current_instruction >> 28, cpsr) != 0;
> +		int cc = current_instruction >> 28;
> +
> +		probe_should_run = test_check_cc(cc, cpsr) != 0;
>  		if (scenario == 15)
>  			is_last_scenario = true;
>  
> 
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
