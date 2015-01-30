From: Wenyou.Yang@atmel.com (Yang, Wenyou)
Date: Fri, 30 Jan 2015 06:54:01 +0000
Subject: [PATCH v5 05/13] pm: at91: move the copying the sram function
 to the sram initializationi phase
In-Reply-To: <54CA0739.2030101@cogentembedded.com>
References: <1422513316-21509-1-git-send-email-wenyou.yang@atmel.com>
 <1422513535-23885-1-git-send-email-wenyou.yang@atmel.com>
 <54CA0739.2030101@cogentembedded.com>
Message-ID: <B256D81BAE5131468A838E5D7A243641BFD3A07F@penmbx01>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sergei,

Thank you for your review and suggestion.

> -----Original Message-----
> From: Sergei Shtylyov [mailto:sergei.shtylyov at cogentembedded.com]
> Sent: Thursday, January 29, 2015 6:11 PM
> To: Yang, Wenyou; Ferre, Nicolas; linux at arm.linux.org.uk
> Cc: linux-arm-kernel at lists.infradead.org; linux-kernel at vger.kernel.org;
> alexandre.belloni at free-electrons.com; sylvain.rochet at finsecur.com;
> peda at axentia.se; linux at maxim.org.za
> Subject: Re: [PATCH v5 05/13] pm: at91: move the copying the sram function to
> the sram initializationi phase
> 
> Hello.
> 
> On 1/29/2015 9:38 AM, Wenyou Yang wrote:
> 
> > To decrease the suspend time, move the copying the sram function to
> > the sram initialization phase, instead of every time go to suspend.
> 
> > In the meanwhile, if there is no sram allocated for PM, the PM is not supported.
> 
> > Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
> > Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> > ---
> >   arch/arm/mach-at91/pm.c |   12 +++++++-----
> >   1 file changed, 7 insertions(+), 5 deletions(-)
> 
> > diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c index
> > daa998d..6df0152 100644
> > --- a/arch/arm/mach-at91/pm.c
> > +++ b/arch/arm/mach-at91/pm.c
> > @@ -163,10 +163,6 @@ static int at91_pm_enter(suspend_state_t state)
> >   			 * turning off the main oscillator; reverse on wakeup.
> >   			 */
> >   			if (slow_clock) {
> > -#ifdef CONFIG_AT91_SLOW_CLOCK
> > -				/* copy slow_clock handler to SRAM, and call it */
> > -				memcpy(slow_clock, at91_slow_clock,
> at91_slow_clock_sz);
> > -#endif
> >   				slow_clock(at91_pmc_base, at91_ramc_base[0],
> >   					   at91_ramc_base[1],
> >   					   at91_pm_data.memctrl);
> > @@ -311,6 +307,9 @@ static void __init at91_pm_sram_init(void)
> >   	sram_pbase = gen_pool_virt_to_phys(sram_pool, sram_base);
> >   	slow_clock = __arm_ioremap_exec(sram_pbase, at91_slow_clock_sz,
> > false);
> >
> > +	/* Copy the slow_clock handler to SRAM */
> > +	memcpy(slow_clock, at91_slow_clock, at91_slow_clock_sz);
> 
>     AFAIU (looking at the code above and below), __arm_ioremap_exec() can return
> NULL and in this case memcpy() will cause kernel oops.
Will add a condition before copying 
	if (sram_pbase)

> 
> > @@ -328,7 +327,10 @@ static void __init at91_pm_init(void)
> >   	if (at91_cpuidle_device.dev.platform_data)
> >   		platform_device_register(&at91_cpuidle_device);
> >
> > -	suspend_set_ops(&at91_pm_ops);
> > +	if (slow_clock)
> > +		suspend_set_ops(&at91_pm_ops);
> > +	else
> > +		pr_info("AT91: PM : Not supported, due to no sram allocated\n");
> 
>     I'd suggest upper-casing "sram". And removing of colon after "PM".
Will change.

> 
> [...]
> 
> WBR, Sergei

Best Regards,
Wenyou Yang
