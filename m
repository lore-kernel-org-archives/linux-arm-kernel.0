From: robherring2@gmail.com (Rob Herring)
Date: Tue, 26 Jun 2012 11:00:21 -0500
Subject: [PATCH 2/2] ARM: delay: allow timer-based delay implementation
 to be selected
In-Reply-To: <20120626155448.GQ27996@mudshark.cambridge.arm.com>
References: <1340377774-17173-1-git-send-email-will.deacon@arm.com>
 <1340377774-17173-3-git-send-email-will.deacon@arm.com>
 <4FE8DA7E.5040105@codeaurora.org>
 <20120626104944.GE27996@mudshark.cambridge.arm.com>
 <20120626155448.GQ27996@mudshark.cambridge.arm.com>
Message-ID: <4FE9DC95.30408@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/26/2012 10:54 AM, Will Deacon wrote:
> On Tue, Jun 26, 2012 at 11:49:44AM +0100, Will Deacon wrote:
>> On Mon, Jun 25, 2012 at 10:39:10PM +0100, Stephen Boyd wrote:
>>>
>>> It's unfortunate that we have to duplicate the same code and constants
>>> in both C and assembly. With my approach we convert delay.S into C and
>>> avoid the duplication.
>>
>> It's probably easy enough to have a #define for the multiplier, I can do
>> that for v2.
> 
> Looks like I spoke too soon :)
> 
> The reason this is slightly problematic is due to gas's inability to
> represent unsigned constants -- namely that the 'U' suffix causes it to
> barf. I can fix it with the diff below, but please let me know what you
> think.

[snip]

> +#ifndef __ASSEMBLY__
> +


> +#define UDELAY_MULT_HZ	2199023U
> +#else
> +#define UDELAY_MULT_HZ	2199023

Doesn't UL() macro do what you need?

Rob

> +#endif /* __ASSEMBLY__ */
> +
>  #endif /* defined(_ARM_DELAY_H) */
>  
> diff --git a/arch/arm/lib/delay-loop.S b/arch/arm/lib/delay-loop.S
> index 1428a8f..36b668d 100644
> --- a/arch/arm/lib/delay-loop.S
> +++ b/arch/arm/lib/delay-loop.S
> @@ -9,11 +9,11 @@
>   */
>  #include <linux/linkage.h>
>  #include <asm/assembler.h>
> -#include <asm/param.h>
> +#include <asm/delay.h>
>  		.text
>  
>  .LC0:		.word	loops_per_jiffy
> -.LC1:		.word	(2199023*HZ)>>11
> +.LC1:		.word	UDELAY_MULT
>  
>  /*
>   * r0  <= 2000
> diff --git a/arch/arm/lib/delay.c b/arch/arm/lib/delay.c
> index 2b590c3..e1030e1 100644
> --- a/arch/arm/lib/delay.c
> +++ b/arch/arm/lib/delay.c
> @@ -47,12 +47,12 @@ static void __timer_const_udelay(unsigned long xloops)
>  {
>  	unsigned long long loops = xloops;
>  	loops *= loops_per_jiffy;
> -	__timer_delay(loops >> 30);
> +	__timer_delay(loops >> UDELAY_SHIFT);
>  }
>  
>  static void __timer_udelay(unsigned long usecs)
>  {
> -	__timer_const_udelay(usecs * ((2199023U * HZ) >> 11));
> +	__timer_const_udelay(usecs * UDELAY_MULT);
>  }
>  
>  void __init init_current_timer_delay(unsigned long freq)
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
