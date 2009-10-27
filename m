From: mikpe@it.uu.se (Mikael Pettersson)
Date: Tue, 27 Oct 2009 11:52:46 +0100
Subject: [PATCH v3 4/4] iop: implement sched_clock()
In-Reply-To: <1256582040.11080.14.camel@dwillia2-linux.ch.intel.com>
References: <19160.60691.72229.932486@pilspetsen.it.uu.se>
	<e9c3a7c20910221449i6a9f8bc6y6b3af1f2f7fe1c44@mail.gmail.com>
	<19168.55801.851167.570526@pilspetsen.it.uu.se>
	<19169.39885.258937.672777@pilspetsen.it.uu.se>
	<1256582040.11080.14.camel@dwillia2-linux.ch.intel.com>
Message-ID: <19174.53502.967101.548629@pilspetsen.it.uu.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dan Williams writes:
 > On Fri, 2009-10-23 at 05:04 -0700, Mikael Pettersson wrote:
 > > Hmm, even with CONFIG_PRINTK_TIME I can't reproduce any crashes,
 > > all that happens is that sched_clock() returns 0 until shortly
 > > after the clocksource is initialized.
 > > 
 > > Do you have any local patches in that kernel, in particular anything
 > > that might depend on sched_clock()?
 > > 
 > > Can you send me your .config?
 > > 
 > > And finally, can you boot your kernel (with the sched_clock() patch)
 > > with Sascha Hauer's earlyprintk patch(*) applied and enabled(**), and
 > > capture the boot messages?
 > > 
 > > (*) http://lists.arm.linux.org.uk/lurker/message/20090129.153915.ed65e33d.en.html
 > > (**) CONFIG_DEBUG_LL=y and CONFIG_DEBUG_LL_CONSOLE=y, append "earlyprintk" to boot params
 > 
 > Very helpful, why is this patch not upstream?

I don't know why it's not upstream. I found it invaluable while debugging
the recent USB PCI quirk change that killed at least two ARM IOP platforms
early during boot, so early that the regular printk didn't work yet.

 >  We are getting an
 > undefined instruction error most likely due to the fact that access to
 > cp6 has not been established.  I suspect your bootloader is leaving cp6
 > access enabled when handing off to the kernel, while it is disabled in
 > mine.  We would need to delay sched_clock() usage until after the cp6
 > undefined instruction handler is registered which is after interrupts
 > are enabled (iop_init_cp6_handler()).
...
 > The following patch works for me, but it presumes the order of irq
 > versus time init.
 > 
 > diff --git a/arch/arm/plat-iop/time.c b/arch/arm/plat-iop/time.c
 > index 6c8a02a..d222561 100644
 > --- a/arch/arm/plat-iop/time.c
 > +++ b/arch/arm/plat-iop/time.c
 > @@ -39,7 +39,6 @@ static cycle_t iop_clocksource_read(struct clocksource *unused)
 >  static struct clocksource iop_clocksource = {
 >  	.name 		= "iop_timer1",
 >  	.rating		= 300,
 > -	.read		= iop_clocksource_read,
 >  	.mask		= CLOCKSOURCE_MASK(32),
 >  	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
 >  };
 > @@ -70,9 +69,17 @@ static void __init iop_clocksource_set_hz(struct clocksource *cs, unsigned int h
 >   */
 >  unsigned long long sched_clock(void)
 >  {
 > -	cycle_t cyc = iop_clocksource_read(NULL);
 >  	struct clocksource *cs = &iop_clocksource;
 > +	cycle_t cyc;
 >  
 > +	/* wait for init */
 > +	if (unlikely(!cs->read))
 > +		return 0;
 > +
 > +	/* call iop_clocksource_read() instead of dereferencing
 > +	 * cs->read() to save an indirect branch penalty
 > +	 */
 > +	cyc = iop_clocksource_read(NULL);
 >  	return clocksource_cyc2ns(cyc, cs->mult, cs->shift);
 >  }
 >  
 > @@ -208,5 +215,6 @@ void __init iop_init_time(unsigned long tick_rate)
 >  	write_tcr1(0xffffffff);
 >  	write_tmr1(timer_ctl);
 >  	iop_clocksource_set_hz(&iop_clocksource, tick_rate);
 > +	iop_clocksource.read = iop_clocksource_read;
 >  	clocksource_register(&iop_clocksource);
 >  }

Thanks. Looks sane to me, although the extra load in sched_clock() does
bother me.

I wonder if the exception could be handled by an exception handler
that just forces the return value to zero, similar to how the x86
kernel handles bad get_user/put_user calls or accesses to potentially
invalid (x86) MSRs?

Why whould anyone want to prevent the kernel from accessing cp6?

/Mikael
