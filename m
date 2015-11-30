From: tony@atomide.com (Tony Lindgren)
Date: Mon, 30 Nov 2015 08:28:16 -0800
Subject: [RFC PATCH] clocksource: ti-32k: convert to platform device
In-Reply-To: <5658B8B2.5030505@ti.com>
References: <1448040129-23869-1-git-send-email-grygorii.strashko@ti.com>
 <87h9kgcz1k.fsf@saruman.tx.rr.com> <5658B8B2.5030505@ti.com>
Message-ID: <20151130162815.GA2517@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Grygorii Strashko <grygorii.strashko@ti.com> [151127 12:11]:
> Hi Felipe,
> 
> On 11/20/2015 08:21 PM, Felipe Balbi wrote:
> > Grygorii Strashko <grygorii.strashko@ti.com> writes:
> >> Since system clocksource is finally selected by Clocksource core at
> >> fs_initcall stage during boot there are no reasons to initialize
> >> ti_32k_timer at early boot stages. Hence, ti_32k_timer can be
> >> converted to use platform device/driver model and its PM can be
> >> implemented using PM runtime which is common for OMAP devices.
> >>
> >> Platform specific initialization code has to be disabled once as
> >> ti_32k_timer is converted to platform device - otherwise OMAP platform
> >> code will generate boot warnings.
> >>
> >> After this change, all counter_32k's platform code can be removed
> >> once all OMAP boards will be converted to DT.
> >>
> >> Cc: Tony Lindgren <tony@atomide.com>
> >> Cc: Felipe Balbi <balbi@ti.com>
> >> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> >> ---
> 
> [...]
> 
> >> +
> >> +static struct platform_driver ti_32k_driver __initdata = {
> >> +	.probe		= ti_32k_probe,
> >> +	.driver		= {
> >> +		.name	= "ti_32k_timer",
> >> +		.of_match_table = of_match_ptr(ti_32k_of_table),
> >> +	}
> >> +};
> >> +
> >> +static int __init ti_32k_init(void)
> >> +{
> >> +	return platform_driver_register(&ti_32k_driver);
> >>   }
> >> -CLOCKSOURCE_OF_DECLARE(ti_32k_timer, "ti,omap-counter32k",
> >> -		ti_32k_timer_init);
> >> +
> >> +subsys_initcall(ti_32k_init);
> >> +
> >> +MODULE_AUTHOR("Paul Mundt");
> >> +MODULE_AUTHOR("Juha Yrj?l?");
> >> +MODULE_DESCRIPTION("OMAP2 32k Timer");
> >> +MODULE_ALIAS("platform:ti_32k_timer");
> >> +MODULE_LICENSE("GPL v2");
> > 
> > this will break clksource_of_init(), right ? Eventually, we want that to
> > be the only thing called by our .init_time method. I'll leave it to Tony
> > to decide, but IMO this is not a good path forward for timers.
> > 
> 
> Yeh :(.  I did additional tests, and, unfortunately, this can't be used as is.
> But not because of clocksource_of_init() which will just produce boot warning.
> It can't be done because of sched_clock_register() which is expected to be
> called during early boot time only and with disabled IRQs.
> 
> It was so tempting to try :)

We should be able to make this into an early_platform_device and just
have it depend on the source clock muxes. See the omap initcall changes
patches I just posted.

Regards,

Tony
