From: tony@atomide.com (Tony Lindgren)
Date: Mon, 5 Mar 2012 14:55:30 -0800
Subject: [PATCH 1/3] ARM: OMAP2+: 32k-counter: Use hwmod lookup to
 check presence of 32k timer
In-Reply-To: <1326983304-14619-2-git-send-email-hvaibhav@ti.com>
References: <1326983304-14619-1-git-send-email-hvaibhav@ti.com>
 <1326983304-14619-2-git-send-email-hvaibhav@ti.com>
Message-ID: <20120305225530.GJ12083@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

* Vaibhav Hiremath <hvaibhav@ti.com> [120119 06:01]:
> OMAP device has 32k-sync timer which is currently used as a
> clocksource in the kernel (omap2plus_defconfig).
> The current implementation uses compile time selection between
> gp-timer and 32k-sync timer, which breaks multi-omap build for
> the devices like AM33xx, where 32k-sync timer is not available.
> 
> So use hwmod database lookup mechanism, through which at run-time
> we can identify availability of 32k-sync timer on the device,
> else fall back to gp-timer.
...

> --- a/arch/arm/plat-omap/counter_32k.c
> +++ b/arch/arm/plat-omap/counter_32k.c
> @@ -69,52 +69,55 @@ void read_persistent_clock(struct timespec *ts)
>  
>  int __init omap_init_clocksource_32k(void)
>  {
> -	static char err[] __initdata = KERN_ERR
> -			"%s: can't register clocksource!\n";
> -
> -	if (cpu_is_omap16xx() || cpu_class_is_omap2()) {
> -		u32 pbase;
> -		unsigned long size = SZ_4K;
> -		void __iomem *base;
> -		struct clk *sync_32k_ick;
> -
> -		if (cpu_is_omap16xx()) {
> -			pbase = OMAP16XX_TIMER_32K_SYNCHRONIZED;
> -			size = SZ_1K;
> -		} else if (cpu_is_omap2420())
> -			pbase = OMAP2420_32KSYNCT_BASE + 0x10;
> -		else if (cpu_is_omap2430())
> -			pbase = OMAP2430_32KSYNCT_BASE + 0x10;
> -		else if (cpu_is_omap34xx())
> -			pbase = OMAP3430_32KSYNCT_BASE + 0x10;
> -		else if (cpu_is_omap44xx())
> -			pbase = OMAP4430_32KSYNCT_BASE + 0x10;
> -		else
> +	u32 pbase;
> +	unsigned long size = SZ_4K;
> +	void __iomem *base;
> +	struct clk *sync_32k_ick;
> +
> +	if (cpu_is_omap16xx()) {
> +		pbase = OMAP16XX_TIMER_32K_SYNCHRONIZED;
> +		size = SZ_1K;
> +	} else if (cpu_class_is_omap2()) {
> +		struct omap_hwmod *oh;
> +		const char *oh_name = "counter_32k";
> +
> +		oh = omap_hwmod_lookup(oh_name);
> +		if (!oh || oh->slaves_cnt == 0) {
> +			pr_err("Could not lookup %s hwmod\n", oh_name);
>  			return -ENODEV;
> +		}
> +		pbase = oh->slaves[0]->addr->pa_start + 0x10;
> +	} else {
> +		return -ENODEV;
> +	}

How about have separate omap1 and omap2+ init functions that
call a common function and passes the pbase as a parameter?

That way we can get rid of the cpu_is_omapxxxx tests here.

Regards,

Tony 
