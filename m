From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 12 Jan 2012 09:14:26 +0000
Subject: [PATCH 06/15] ARM: plat-versatile: convert to
 twd_local_timer_register() interface
In-Reply-To: <1326287334-1905-7-git-send-email-marc.zyngier@arm.com>
References: <1326287334-1905-1-git-send-email-marc.zyngier@arm.com>
 <1326287334-1905-7-git-send-email-marc.zyngier@arm.com>
Message-ID: <20120112091426.GH1068@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 11, 2012 at 01:08:45PM +0000, Marc Zyngier wrote:
> Add support for the new smp_twd runtime registration interface
> to the RealView/VE platforms, and remove the old compile-time support.
> Tested on EB11MP.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  arch/arm/mach-realview/realview_eb.c     |   34 ++++++++++++++++++++++++++---
>  arch/arm/mach-realview/realview_pb11mp.c |   32 ++++++++++++++++++++++++---
>  arch/arm/mach-realview/realview_pbx.c    |   31 ++++++++++++++++++++++++--
>  arch/arm/mach-vexpress/ct-ca9x4.c        |   30 +++++++++++++++++++++++--
>  arch/arm/plat-versatile/Makefile         |    1 -
>  arch/arm/plat-versatile/localtimer.c     |   27 -----------------------
>  6 files changed, 113 insertions(+), 42 deletions(-)
>  delete mode 100644 arch/arm/plat-versatile/localtimer.c
> 
> diff --git a/arch/arm/mach-realview/realview_eb.c b/arch/arm/mach-realview/realview_eb.c
> index e629621..6c5e61d 100644
> --- a/arch/arm/mach-realview/realview_eb.c
> +++ b/arch/arm/mach-realview/realview_eb.c
> @@ -36,7 +36,7 @@
>  #include <asm/pgtable.h>
>  #include <asm/hardware/gic.h>
>  #include <asm/hardware/cache-l2x0.h>
> -#include <asm/localtimer.h>
> +#include <asm/smp_twd.h>
>  
>  #include <asm/mach/arch.h>
>  #include <asm/mach/map.h>
> @@ -388,6 +388,34 @@ static void realview_eb11mp_fixup(void)
>  	realview_eb_isp1761_resources[1].end	= IRQ_EB11MP_USB;
>  }
>  
> +#ifdef CONFIG_HAVE_ARM_TWD
> +static struct twd_local_timer twd_local_timer __initdata = {
> +	.res =	{
> +		{
> +			.start	= REALVIEW_EB11MP_TWD_BASE,
> +			.end	= REALVIEW_EB11MP_TWD_BASE + 0xff,
> +			.flags	= IORESOURCE_MEM,
> +		},

DEFINE_RES_MEM() ?

> +		{
> +			.start	= IRQ_LOCALTIMER,
> +			.end	= IRQ_LOCALTIMER,
> +			.flags	= IORESOURCE_IRQ,
> +		},

DEFINE_RES_IRQ() ?

> +	},
> +};
> +
> +static void __init realview_eb_twd_init(void)
> +{
> +	if (core_tile_eb11mp() || core_tile_a9mp()) {
> +		int err = twd_local_timer_register(&twd_local_timer);
> +		if (err)
> +			pr_err("twd_local_timer_register failed %d\n", err);
> +	}
> +}
> +#else
> +#define realview_eb_twd_init	NULL
> +#endif
> +
>  static void __init realview_eb_timer_init(void)
>  {
>  	unsigned int timer_irq;
> @@ -398,9 +426,7 @@ static void __init realview_eb_timer_init(void)
>  	timer3_va_base = __io_address(REALVIEW_EB_TIMER2_3_BASE) + 0x20;
>  
>  	if (core_tile_eb11mp() || core_tile_a9mp()) {
> -#ifdef CONFIG_LOCAL_TIMERS
> -		twd_base = __io_address(REALVIEW_EB11MP_TWD_BASE);
> -#endif
> +		late_time_init = realview_eb_twd_init;

With Nicolas' IO space patches in mainline, is it still necessary to use
late_time_init() ?
