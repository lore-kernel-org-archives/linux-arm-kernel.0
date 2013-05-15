From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 15 May 2013 14:32:37 +0100
Subject: [PATCH] ARM: mach-moxart: platform port for MOXA ART SoC
In-Reply-To: <201305151516.52389.arnd@arndb.de>
References: <CACmBeS1NLFUYHBOVL28aCCzRrgXYGPZF9t3qj6AdcgaMkrPGoQ@mail.gmail.com>
 <201303181503.49491.arnd@arndb.de>
 <CACmBeS1empYyoaKidgTrYwUFCw447OKndxZjT98TvYfKVWB00A@mail.gmail.com>
 <201305151516.52389.arnd@arndb.de>
Message-ID: <20130515133237.GK18614@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 15, 2013 at 03:16:52PM +0200, Arnd Bergmann wrote:
> > +static void moxart_idle(void)
> > +{
> > +	/*
> > +	 * Because of broken hardware we have to enable interrupts or the CPU
> > +	 * will never wakeup... Acctualy it is not very good to enable
> > +	 * interrupts first since scheduler can miss a tick, but there is
> > +	 * no other way around this. Platforms that needs it for power saving
> > +	 * should call enable_hlt() in init code, since by default it is
> > +	 * disabled.
> > +	 */
> > +/*	local_irq_enable();
> > +	cpu_do_idle();*/
> > +}
> > +
> > +static int __init moxart_idle_init(void)
> > +{
> > +	arm_pm_idle = moxart_idle;
> > +	return 0;
> > +}
> > +
> > +arch_initcall(moxart_idle_init);
> 
> This does not seem to do anything at this point. Does the comment still
> apply?

Actually, that's probably the whole point of this - to do nothing.
This changes the behaviour of the idle loop from using the WFI to
just spinning instead with no wait-for-interrupt or anything else.
We just keep reading the need_resched flag.

That's much better than the commented out code which opens a mighty
big race condition which will then give bad scheduling behaviour,
allowing the idle task to sleep in WFI until the next interrupt while
the need_resched flag may be set.

Sure, there's better ways to do this, via the disable_hlt() stuff,
and whatever its replacement implementation is now called.  But
ultimately this workaround really is about "doing nothing" when
idle!
