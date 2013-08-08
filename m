From: khilman@linaro.org (Kevin Hilman)
Date: Thu, 08 Aug 2013 11:25:41 -0700
Subject: [PATCHv3 6/9] ARM: OMAP2+: timer: Add suspend-resume callbacks
 for clkevent device
In-Reply-To: <1375811376-49985-7-git-send-email-d-gerlach@ti.com> (Dave
 Gerlach's message of "Tue, 6 Aug 2013 12:49:33 -0500")
References: <1375811376-49985-1-git-send-email-d-gerlach@ti.com>
 <1375811376-49985-7-git-send-email-d-gerlach@ti.com>
Message-ID: <8738qkhwey.fsf@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dave Gerlach <d-gerlach@ti.com> writes:

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
>  arch/arm/mach-omap2/timer.c |   32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
>
> diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
> index b37e1fc..cce5d39 100644
> --- a/arch/arm/mach-omap2/timer.c
> +++ b/arch/arm/mach-omap2/timer.c
> @@ -118,11 +118,43 @@ static void omap2_gp_timer_set_mode(enum clock_event_mode mode,
>  	}
>  }
>  
> +static void omap_clkevt_suspend(struct clock_event_device *unused)
> +{
> +	char name[10];
> +	struct omap_hwmod *oh;
> +
> +	sprintf(name, "timer%d", clkev.id);
> +	oh = omap_hwmod_lookup(name);

/me stops reviewing here.  This should be a one-time thing.

Seeing things *again* in patches that I've already reviewed (multiple
times) is very frustrating.  It also increases the likelihood of future
patches to be "filtered."  (in this case, you get a pass since you seem
to have inherited Vaibhav's code, but please take care to address all
reviewer comments, or at least explain why you didn'.)

Kevin
