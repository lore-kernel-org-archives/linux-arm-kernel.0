From: Wenyou.Yang@atmel.com (Yang, Wenyou)
Date: Fri, 30 Jan 2015 06:59:58 +0000
Subject: [PATCH v4 05/13] pm: at91: move the copying the sram function
 to the sram initializationi phase
In-Reply-To: <20150129112800.GV26493@n2100.arm.linux.org.uk>
References: <1422409172-24178-1-git-send-email-wenyou.yang@atmel.com>
 <1422409396-24394-1-git-send-email-wenyou.yang@atmel.com>
 <20150129112800.GV26493@n2100.arm.linux.org.uk>
Message-ID: <B256D81BAE5131468A838E5D7A243641BFD3A091@penmbx01>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

Thank you for your review.

> -----Original Message-----
> From: Russell King - ARM Linux [mailto:linux at arm.linux.org.uk]
> Sent: Thursday, January 29, 2015 7:28 PM
> To: Yang, Wenyou
> Cc: Ferre, Nicolas; linux-arm-kernel at lists.infradead.org; linux-
> kernel at vger.kernel.org; alexandre.belloni at free-electrons.com;
> sylvain.rochet at finsecur.com; peda at axentia.se;
> sergei.shtylyov at cogentembedded.com; linux at maxim.org.za
> Subject: Re: [PATCH v4 05/13] pm: at91: move the copying the sram function to
> the sram initializationi phase
> 
> On Wed, Jan 28, 2015 at 09:43:16AM +0800, Wenyou Yang wrote:
> > -#ifdef CONFIG_AT91_SLOW_CLOCK
> > -				/* copy slow_clock handler to SRAM, and call it */
> > -				memcpy(slow_clock, at91_slow_clock,
> at91_slow_clock_sz);
> > -#endif
> >  				slow_clock(at91_pmc_base, at91_ramc_base[0],
> >  					   at91_ramc_base[1],
> >  					   at91_pm_data.memctrl);
> > @@ -272,6 +268,9 @@ static void __init at91_pm_sram_init(void)
> >  	sram_pbase = gen_pool_virt_to_phys(sram_pool, sram_base);
> >  	slow_clock = __arm_ioremap_exec(sram_pbase, at91_slow_clock_sz,
> > false);
> >
> > +	/* Copy the slow_clock handler to SRAM */
> > +	memcpy(slow_clock, at91_slow_clock, at91_slow_clock_sz);
> > +
> 
> Why is this code not using the fncpy() support for copying functions.
At first, used the fncpy(), but it work not well on the some chip. I will check it again.

> Why is it not checking the return code from __arm_ioremap_exec() or
> gen_pool_virt_to_phys() for failure?
> 
> This looks like quite a massive review failure when this code was originally merged.
> It needs fixing.
I will fix it.

> 
> --
> FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
> according to speedtest.net.

Best Regards,
Wenyou Yang
