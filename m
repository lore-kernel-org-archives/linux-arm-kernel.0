From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Fri, 2 Jul 2010 22:21:53 +0530
Subject: [patch 2/2] arm: Implement l2x0 cache disable function
In-Reply-To: <alpine.LFD.2.00.1007021835512.2525@localhost.localdomain>
References: <alpine.LFD.2.00.1007021658300.2525@localhost.localdomain>
	<1278087010.10162.271.camel@e102109-lin.cambridge.arm.com>
	<alpine.LFD.2.00.1007021835512.2525@localhost.localdomain>
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C5ECEEDC@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: linux-arm-kernel-bounces at lists.infradead.org [mailto:linux-arm-
> kernel-bounces at lists.infradead.org] On Behalf Of Thomas Gleixner
> Sent: Friday, July 02, 2010 10:10 PM
> To: Catalin Marinas
> Cc: Tony Lindgren; LAK
> Subject: Re: [patch 2/2] arm: Implement l2x0 cache disable function
> 
> On Fri, 2 Jul 2010, Catalin Marinas wrote:
> 
> > On Fri, 2010-07-02 at 16:29 +0100, Thomas Gleixner wrote:
> > > On Fri, 2 Jul 2010, Catalin Marinas wrote:
> > >
> > > > On Thu, 2010-07-01 at 17:05 +0100, Thomas Gleixner wrote:
> > > > > This function is called from kexec code before the inner caches
> are
> > > > > disabled to prevent random crashes in the new kernel.
> > > > >
> > > > > Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> > > > > Index: linux-2.6/arch/arm/mm/cache-l2x0.c
> > > > >
> ===================================================================
> > > > > --- linux-2.6.orig/arch/arm/mm/cache-l2x0.c
> > > > > +++ linux-2.6/arch/arm/mm/cache-l2x0.c
> > > > > @@ -206,6 +206,12 @@ static void l2x0_flush_range(unsigned lo
> > > > >         spin_unlock_irqrestore(&l2x0_lock, flags);
> > > > >  }
> > > > >
> > > > > +static void l2x0_cache_disable(void)
> > > > > +{
> > > > > +       l2x0_inv_all();
> > > > > +       writel(0, l2x0_base + L2X0_CTRL);
> > > > > +}
> > > >
> > > > Even if we go this route, we need an l2x0_flush_all() rather than
> > > > invalidate here as the latter removes dirty cache lines without
> evicting
> > > > them first.
> > >
> > > True, but that's an implementation detail. What's more important is to
> > > make a decision how to solve the problem as kexec is completely
> > > unusable for all L2 systems right now.
> >
> > My view is that we should try to find why cache flushing doesn't work
> > but unfortunately I don't have any spare time to look into this (would
> > need to use tools like ICE debugging/tracing).
> 
> Simply because you need to flush the cache in the decompressor of the
> new kernel before jumping into it and I doubt that Russell will be
> happy about adding an utter L2 mess to the decompressor.
> 
> > > I think the correct way to deal with this is disabling L2 and let the
> > > OMAP3 folks deal with it. As Tony said there is some SMI magic to do
> > > that, so we can do the following:
> > >
> > > In l2x0_init()
> > >
> > >    if (!l2_enabled()) {
> > >       if (non_secure()) {
> > >          omap_smi_magic_l2_enable();
> > >          outer_cache.disable = omap_smi_magic_l2_disable;
> > >       } else {
> > >          sane_l2_enable();
> > >          outer_cache.disable = sane_l2_disable;
> > >       }
> > >    }
> >
> > The non_secure() bit is the key. AFAIK there isn't an easy way to check
> > whether you are running in secure or non-secure mode (I think there is
> > some CP14 debug register telling this but those registers aren't
> > mandatory in a CPU implementation).
> 
> And how does the kernel decide whether it needs to use that SMI code
> in sleep34xx.S or not ?
> 
It's OMAP3 specific code and SMI is the only way to enable or disable L2.

Regards,
Santosh 
