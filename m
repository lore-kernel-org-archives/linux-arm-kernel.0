From: aaro.koskinen@nokia.com (Aaro Koskinen)
Date: Tue, 29 Sep 2009 10:08:21 +0300
Subject: [PATCH v2 4/4] iop: implement sched_clock()
In-Reply-To: <19134.28906.783581.37290@pilspetsen.it.uu.se>
References: <19134.28906.783581.37290@pilspetsen.it.uu.se>
Message-ID: <4AC1B265.7060902@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

Mikael Pettersson wrote:
> This adds a better sched_clock() to the IOP platform,
> implemented using its new clocksource support.
> 
> Tested on n2100, compile-tested for all plat-iop machines.
> 
> Signed-off-by: Mikael Pettersson <mikpe@it.uu.se>
> ---
> Changes v1 -> v2:
> * implemented sched_clock()
> 
>  arch/arm/plat-iop/time.c |    8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff -rupN linux-2.6.31.arm-iop-3-generictime-v2/arch/arm/plat-iop/time.c linux-2.6.31.arm-iop-4-sched_clock/arch/arm/plat-iop/time.c
> --- linux-2.6.31.arm-iop-3-generictime-v2/arch/arm/plat-iop/time.c	2009-09-26 17:25:09.000000000 +0200
> +++ linux-2.6.31.arm-iop-4-sched_clock/arch/arm/plat-iop/time.c	2009-09-26 17:24:29.000000000 +0200
> @@ -66,6 +66,14 @@ static void __init iop_clocksource_set_h
>  }
>  
>  /*
> + * IOP sched_clock() implementation via its clocksource.
> + */
> +unsigned long long sched_clock(void)
> +{
> +	return cyc2ns(&iop_clocksource, iop_clocksource_read(NULL));
> +}
> +
> +/*

This may not work properly on 2.6.31 because the multiplier may be adjusted. If you want
to run these patches on top of 2.6.31, check the OMAP sched_clock() which uses mult_orig,
or maybe drop this patch.

You could also rebase onto current mainline, and use clocksource_cyc2ns().

See commits 80ea3bac3a47bc73efa334d0dd57099d0ff14216 and
0a54419836254a27baecd9037103171bcbabaf67 for more info.

A.
