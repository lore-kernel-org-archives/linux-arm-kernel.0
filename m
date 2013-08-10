From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Sat, 10 Aug 2013 14:32:09 -0300
Subject: [PATCH v2 2/2] ARM: kirkwood: Add basic suspend-to-RAM support
In-Reply-To: <20130810160019.GC12476@lunn.ch>
References: <1376144839-1985-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1376144839-1985-3-git-send-email-ezequiel.garcia@free-electrons.com>
 <20130810150115.GB12476@lunn.ch> <20130810152011.GD3080@localhost>
 <20130810160019.GC12476@lunn.ch>
Message-ID: <20130810173208.GA2362@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 10, 2013 at 06:00:19PM +0200, Andrew Lunn wrote:
> > > > +static int __init kirkwood_pm_init(void)
> > > > +{
> > > > +	ddr_operation_base = ioremap(DDR_OPERATION_BASE, 4);
> > > > +	suspend_set_ops(&kirkwood_suspend_ops);
> > > > +	return 0;
> > > > +}
> > > > +arch_initcall(kirkwood_pm_init);
> > > 
> > > Hi Ezequiel
> > > 
> > > Does this work on a multi arch kernel? Should kirkwood_pm_init() be
> > > checking it is actually running on a kirkwood? Or call
> > > kirkwood_pm_init() from kirkwood_dt_init()?
> > > 
> > 
> > Oh, right... I think you already mentioned this. Sorry, forgot about
> > this completely.
> > 
> > On the other side, kirkwood is not multiplatform-enabled yet, right?
> > So there's no way this can produce any build error.
> 
> Kirkwood is not currently multiplatform, but there is nothing i know
> of which will break when we do become multi-platform. I've been
> keeping an eye out for such issues, and made sure that cpuidle,
> cpufreq, etc are multiplatform safe. I think Thomas removed the last
> blocker for DT based boards going multiplatform when PCI moved to DT.
> So i don't want to add something now, which i know will break with
> multiplatform. Lets do it the right way now.
> 

Of course. And I'd say it's better call kirkwood_pm_init() from some place
kirkwood-specific, rather than leaving the generic arch_initcall checking
for kirkwood machine.

It looks less bloaty, uh?

> > > Another issue is that the ddr_operation_base should probably be
> > > accessed using your atomic_io_set_clear() function, since it is used
> > > by the cpuidle drivers as well.
> > > 
> > 
> > I think this is not needed. Both cpuidle suspend core code disables
> > IRQ before entering any of the suspend or cpuidle states.
> 
> I've no idea how PM works, so i cannot say if its safe or not...

Me neither. But I'm checking the code and it's screaming "local irqs
disabled" before entering any state. Also, the ticker seems to be stopped.

I'd like to know we *really* need such register protection, given
it's not an easy task (see the atomic_io_clear_set discussion).

> > 
> > BTW, do you think the approach of *not* messing with clocks is ok?
> 
> That is correct. The drivers should be disabling clocks, were they can
> be disabled. We know kirkwood ethernet is broken and we cannot
> "easily" disable its clock.
> 

Ok, good.

One more thing I came across while reviewing the PM code.
There's a "standby" state that seems much more appropriate than
the current "mem" state.

I looks like there's not any distinction in the PM code handling
between the two "mem" and "standby" states, but it's a bit misleading
for users to declare "suspend to RAM" when it's not.

So I think we should use that instead. I'll fix all of these and prepare a v3.

Thanks for the feedback!
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
