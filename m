From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 29 Jul 2010 14:56:39 +0100
Subject: [PATCH] ARM: fix regression in RealView after the introduction
	of pclk
In-Reply-To: <1280408722-31995-1-git-send-email-linus.walleij@stericsson.com>
References: <1280408722-31995-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <20100729135639.GE18923@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 29, 2010 at 03:05:22PM +0200, Linus Walleij wrote:
> diff --git a/arch/arm/mach-realview/core.c b/arch/arm/mach-realview/core.c
> index d8179ea..154d10b 100644
> --- a/arch/arm/mach-realview/core.c
> +++ b/arch/arm/mach-realview/core.c
> @@ -359,7 +359,7 @@ static struct clk_lookup lookups[] = {
>  	}
>  };
>  
> -static int __init clk_init(void)
> +int __init realview_clk_init(void)
>  {
>  	if (machine_is_realview_pb1176())
>  		oscvco_clk.vcoreg = __io_address(REALVIEW_SYS_BASE) + REALVIEW_SYS_OSC0_OFFSET;
> @@ -370,7 +370,6 @@ static int __init clk_init(void)
>  
>  	return 0;
>  }
> -arch_initcall(clk_init);

I think this can just be made core_initcall() rather than going to the
lengths that this patch does - all we need to do is ensure that the
clocks are registered before the machine init code is called, and
core_initcall() will do that for us.
