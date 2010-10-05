From: dwalker@codeaurora.org (Daniel Walker)
Date: Tue, 05 Oct 2010 10:29:38 -0700
Subject: [PATCH 2/3] [ARM] Allow machines to override __delay()
In-Reply-To: <1285644827-6846-3-git-send-email-sboyd@codeaurora.org>
References: <1285644827-6846-1-git-send-email-sboyd@codeaurora.org>
	<1285644827-6846-3-git-send-email-sboyd@codeaurora.org>
Message-ID: <1286299778.18791.18.camel@c-dwalke-linux.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2010-09-27 at 20:33 -0700, Stephen Boyd wrote:
> Some machines want to implement their own __delay() routine based
> on fixed timers. Expose functionality to set the __delay()
> routine at runtime. This should allow two machines with different
> __delay() routines to happily co-exist within the same kernel
> with minimal overhead.

Say "This allows developers to implement their own __delay() ..."

> Russell expressed concern that using a timer based __delay()
> would cause problems where an iomapped device isn't mapped in
> before a delay call was made (see
> http://article.gmane.org/gmane.linux.ports.arm.kernel/78543 for
> more info). We can sidestep that issue with this approach since
> the __delay() routine _should_ only be pointed to a timer based
> delay once the timer has been properly mapped. Up until that
> point __delay() and udelay() will use delay_loop() which is
> always safe to call.
> 
> This patch is inspired by x86's delay.c
> 
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> Reviewed-by: Saravana Kannan <skannan@codeaurora.org>
> ---
>  arch/arm/include/asm/delay.h |    2 ++
>  arch/arm/lib/delay.c         |   21 ++++++++++++++++++---
>  2 files changed, 20 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/include/asm/delay.h b/arch/arm/include/asm/delay.h
> index ccc5ed5..7c732b5 100644
> --- a/arch/arm/include/asm/delay.h
> +++ b/arch/arm/include/asm/delay.h
> @@ -40,5 +40,7 @@ extern void __const_udelay(unsigned long);
>  			__const_udelay((n) * ((2199023U*HZ)>>11))) :	\
>  	  __udelay(n))
>  
> +extern void set_delay_fn(void (*fn)(unsigned long));
> +
>  #endif /* defined(_ARM_DELAY_H) */
>  
> diff --git a/arch/arm/lib/delay.c b/arch/arm/lib/delay.c
> index 5ee0adc..b307fcc 100644
> --- a/arch/arm/lib/delay.c
> +++ b/arch/arm/lib/delay.c
> @@ -3,6 +3,8 @@
>   *
>   *  Copyright (C) 1995, 1996 Russell King
>   *  Copyright (c) 2010, Code Aurora Forum. All rights reserved.
> + *  Copyright (C) 1993 Linus Torvalds
> + *  Copyright (C) 1997 Martin Mares <mj@atrey.karlin.mff.cuni.cz>

Who is Martin Mares? Why are you adding these?

Daniel

-- 

Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
