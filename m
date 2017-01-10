From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue, 10 Jan 2017 17:30:37 +0100
Subject: [PATCH 1/3] ARM: at91: flush the L2 cache before entering cpu idle
In-Reply-To: <20170110161821.vp673jyfqx6s76pg@piout.net>
References: <20170106065947.30631-1-wenyou.yang@atmel.com>
 <20170106065947.30631-2-wenyou.yang@atmel.com>
 <20170110161821.vp673jyfqx6s76pg@piout.net>
Message-ID: <20170110163037.kuvnsqbhonjkzox5@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/01/2017 at 17:18:21 +0100, Alexandre Belloni wrote :
> I though a bit more about it, and I don't really like the new compatible
> string. I don't feel this should be necessary.
> 
> What about the following:
> 
> diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
> index b4332b727e9c..0333aca63e44 100644
> --- a/arch/arm/mach-at91/pm.c
> +++ b/arch/arm/mach-at91/pm.c
> @@ -53,6 +53,7 @@ extern void at91_pinctrl_gpio_resume(void);
>  static struct {
>  	unsigned long uhp_udp_mask;
>  	int memctrl;
> +	bool has_l2_cache;
>  } at91_pm_data;
>  
>  void __iomem *at91_ramc_base[2];
> @@ -267,6 +268,11 @@ static void at91_ddr_standby(void)
>  	u32 lpr0, lpr1 = 0;
>  	u32 saved_lpr0, saved_lpr1 = 0;
>  
> +	if (at91_pm_data.has_l2_cache) {
> +		flush_cache_all();
> +		outer_disable();
> +	}
> +
>  	if (at91_ramc_base[1]) {
>  		saved_lpr1 = at91_ramc_read(1, AT91_DDRSDRC_LPR);
>  		lpr1 = saved_lpr1 & ~AT91_DDRSDRC_LPCB;
> @@ -287,6 +293,9 @@ static void at91_ddr_standby(void)
>  	at91_ramc_write(0, AT91_DDRSDRC_LPR, saved_lpr0);
>  	if (at91_ramc_base[1])
>  		at91_ramc_write(1, AT91_DDRSDRC_LPR, saved_lpr1);
> +
> +	if (at91_pm_data.has_l2_cache)
> +		outer_resume();
>  }
>  
>  /* We manage both DDRAM/SDRAM controllers, we need more than one value
>  * to
> @@ -353,6 +362,11 @@ static __init void at91_dt_ramc(void)
>  		return;
>  	}
>  
> +	np = of_find_compatible_node(NULL, NULL, "arm,pl310-cache");
> +	if (np)
> +		at91_pm_data.has_l2_cache = true;
> +	of_node_put(np);
> +
>  	at91_pm_set_standby(standby);
>  }
> 
> 
> This has the following benefits:
>  - everybody will have the fix, regardless of whether the dtb is updated
>  - has_l2_cache can be used later in at91_pm_suspend instead of calling
>    it unconditionnaly (I'll send a patch)
> 

I forgot to add that the added latency on at91sam9 and sama5d3 is exactly 5 instructions.

> 
> On 06/01/2017 at 14:59:45 +0800, Wenyou Yang wrote :
> > For the SoCs such as SAMA5D2 and SAMA5D4 which have L2 cache,
> > flush the L2 cache first before entering the cpu idle.
> > 
> > Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
> > ---
> > 
> >  arch/arm/mach-at91/pm.c       | 19 +++++++++++++++++++
> >  drivers/memory/atmel-sdramc.c |  1 +
> >  2 files changed, 20 insertions(+)
> > 
> > diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
> > index b4332b727e9c..1a60dede1a01 100644
> > --- a/arch/arm/mach-at91/pm.c
> > +++ b/arch/arm/mach-at91/pm.c
> > @@ -289,6 +289,24 @@ static void at91_ddr_standby(void)
> >  		at91_ramc_write(1, AT91_DDRSDRC_LPR, saved_lpr1);
> >  }
> >  
> > +static void at91_ddr_cache_standby(void)
> > +{
> > +	u32 saved_lpr;
> > +
> > +	flush_cache_all();
> > +	outer_disable();
> > +
> > +	saved_lpr = at91_ramc_read(0, AT91_DDRSDRC_LPR);
> > +	at91_ramc_write(0, AT91_DDRSDRC_LPR, (saved_lpr &
> > +			(~AT91_DDRSDRC_LPCB)) | AT91_DDRSDRC_LPCB_SELF_REFRESH);
> > +
> > +	cpu_do_idle();
> > +
> > +	at91_ramc_write(0, AT91_DDRSDRC_LPR, saved_lpr);
> > +
> > +	outer_resume();
> > +}
> > +
> >  /* We manage both DDRAM/SDRAM controllers, we need more than one value to
> >   * remember.
> >   */
> > @@ -324,6 +342,7 @@ static const struct of_device_id const ramc_ids[] __initconst = {
> >  	{ .compatible = "atmel,at91sam9260-sdramc", .data = at91sam9_sdram_standby },
> >  	{ .compatible = "atmel,at91sam9g45-ddramc", .data = at91_ddr_standby },
> >  	{ .compatible = "atmel,sama5d3-ddramc", .data = at91_ddr_standby },
> > +	{ .compatible = "atmel,sama5d4-ddramc", .data = at91_ddr_cache_standby },
> >  	{ /*sentinel*/ }
> >  };
> >  
> > diff --git a/drivers/memory/atmel-sdramc.c b/drivers/memory/atmel-sdramc.c
> > index b418b39af180..7e5c5c6c1348 100644
> > --- a/drivers/memory/atmel-sdramc.c
> > +++ b/drivers/memory/atmel-sdramc.c
> > @@ -48,6 +48,7 @@ static const struct of_device_id atmel_ramc_of_match[] = {
> >  	{ .compatible = "atmel,at91sam9260-sdramc", .data = &at91rm9200_caps, },
> >  	{ .compatible = "atmel,at91sam9g45-ddramc", .data = &at91sam9g45_caps, },
> >  	{ .compatible = "atmel,sama5d3-ddramc", .data = &sama5d3_caps, },
> > +	{ .compatible = "atmel,sama5d4-ddramc", .data = &sama5d3_caps, },
> >  	{},
> >  };
> >  
> > -- 
> > 2.11.0
> > 
> 
> -- 
> Alexandre Belloni, Free Electrons
> Embedded Linux and Kernel engineering
> http://free-electrons.com

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
