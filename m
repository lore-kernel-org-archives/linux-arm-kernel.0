From: tony@atomide.com (Tony Lindgren)
Date: Mon, 14 Jul 2014 04:15:36 -0700
Subject: [PATCH v4 03/11] ARM: OMAP2+: timer: Add suspend-resume
 callbacks for clkevent device
In-Reply-To: <1405047349-15101-4-git-send-email-d-gerlach@ti.com>
References: <1405047349-15101-1-git-send-email-d-gerlach@ti.com>
 <1405047349-15101-4-git-send-email-d-gerlach@ti.com>
Message-ID: <20140714111536.GC20068@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Dave Gerlach <d-gerlach@ti.com> [140710 19:59]:
> From: Vaibhav Bedia <vaibhav.bedia@ti.com>
> 
> OMAP timer code registers two timers - one as clocksource
> and one as clockevent. Since AM33XX has only one usable timer
> in the WKUP domain one of the timers needs suspend-resume
> support to restore the configuration to pre-suspend state.
> 
> commit adc78e6 (timekeeping: Add suspend and resume
> of clock event devices) introduced .suspend and .resume
> callbacks for clock event devices. Leverages these
> callbacks to have AM33XX clockevent timer which is
> in not in WKUP domain to behave properly across system
> suspend.
> 
> Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
> ---
> v3->v4:
> 	Only use for am33xx soc now.
> 
>  arch/arm/mach-omap2/timer.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
> index 43d03fb..6fc1748 100644
> --- a/arch/arm/mach-omap2/timer.c
> +++ b/arch/arm/mach-omap2/timer.c
> @@ -128,6 +128,29 @@ static void omap2_gp_timer_set_mode(enum clock_event_mode mode,
>  	}
>  }
>  
> +static void omap_clkevt_suspend(struct clock_event_device *unused)
> +{
> +	struct omap_hwmod *oh;
> +
> +	oh = omap_hwmod_lookup(clockevent_gpt.name);
> +	if (!oh)
> +		return;
> +
> +	omap_hwmod_idle(oh);
> +}
> +
> +static void omap_clkevt_resume(struct clock_event_device *unused)
> +{
> +	struct omap_hwmod *oh;
> +
> +	oh = omap_hwmod_lookup(clockevent_gpt.name);
> +	if (!oh)
> +		return;
> +
> +	omap_hwmod_enable(oh);
> +	__omap_dm_timer_int_enable(&clkev, OMAP_TIMER_INT_OVERFLOW);
> +}
> +

This is going to make moving the timer code into drivers one step
tougher to do. And you don't need to look up the hwmod entry every
time, just initialize it during the init.

> +	if (soc_is_am33xx()) {
> +		clockevent_gpt.suspend = omap_clkevt_suspend;
> +		clockevent_gpt.resume = omap_clkevt_resume;
> +	}
> +

Maybe try to set up things so we initialize the SoC specific
timer suspend and resume functions in mach-omap2/timer.c
in a way where eventually the device driver can easily use
them?

Regards,

Tony
