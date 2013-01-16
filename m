From: robherring2@gmail.com (Rob Herring)
Date: Wed, 16 Jan 2013 13:17:20 -0600
Subject: [PATCH] [RFC] ARM: compile fix for DEBUG_LL=y && MMU=n
In-Reply-To: <1358346726-27199-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1358346726-27199-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <50F6FCC0.6040204@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/16/2013 08:32 AM, Uwe Kleine-K?nig wrote:
> debug_ll_addr is only used on machines with an MMU so it can be #ifdef'ed
> out safely. This fixes:
> 
> arch/arm/kernel/debug.S: Assembler messages:
> arch/arm/kernel/debug.S:104: Error: too many positional arguments
> 
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> Cc: Rob Herring <rob.herring@calxeda.com>
> Cc: Stephen Warren <swarren@nvidia.com>
> Cc: Olof Johansson <olof@lixom.net>
> ---
> The obvious alternative fix is to make addruart on !MMU take 3
> arguments, too.

We never envision a need to get the uart address from C code on !MMU?

Either way:

Acked-by: Rob Herring <rob.herring@calxeda.com>

> 
> The problem was introduced in
> 
> 	e5c5f2a (ARM: implement debug_ll_io_init())
> 
> which appeared in v3.8-rc1.
> ---
>  arch/arm/kernel/debug.S |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/kernel/debug.S b/arch/arm/kernel/debug.S
> index 6809200..14f7c3b 100644
> --- a/arch/arm/kernel/debug.S
> +++ b/arch/arm/kernel/debug.S
> @@ -100,12 +100,14 @@ ENTRY(printch)
>  		b	1b
>  ENDPROC(printch)
>  
> +#ifdef CONFIG_MMU
>  ENTRY(debug_ll_addr)
>  		addruart r2, r3, ip
>  		str	r2, [r0]
>  		str	r3, [r1]
>  		mov	pc, lr
>  ENDPROC(debug_ll_addr)
> +#endif
>  
>  #else
>  
> 
