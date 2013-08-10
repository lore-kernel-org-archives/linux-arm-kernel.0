From: andrew@lunn.ch (Andrew Lunn)
Date: Sat, 10 Aug 2013 18:00:19 +0200
Subject: [PATCH v2 2/2] ARM: kirkwood: Add basic suspend-to-RAM support
In-Reply-To: <20130810152011.GD3080@localhost>
References: <1376144839-1985-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1376144839-1985-3-git-send-email-ezequiel.garcia@free-electrons.com>
 <20130810150115.GB12476@lunn.ch> <20130810152011.GD3080@localhost>
Message-ID: <20130810160019.GC12476@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > > +static int __init kirkwood_pm_init(void)
> > > +{
> > > +	ddr_operation_base = ioremap(DDR_OPERATION_BASE, 4);
> > > +	suspend_set_ops(&kirkwood_suspend_ops);
> > > +	return 0;
> > > +}
> > > +arch_initcall(kirkwood_pm_init);
> > 
> > Hi Ezequiel
> > 
> > Does this work on a multi arch kernel? Should kirkwood_pm_init() be
> > checking it is actually running on a kirkwood? Or call
> > kirkwood_pm_init() from kirkwood_dt_init()?
> > 
> 
> Oh, right... I think you already mentioned this. Sorry, forgot about
> this completely.
> 
> On the other side, kirkwood is not multiplatform-enabled yet, right?
> So there's no way this can produce any build error.

Kirkwood is not currently multiplatform, but there is nothing i know
of which will break when we do become multi-platform. I've been
keeping an eye out for such issues, and made sure that cpuidle,
cpufreq, etc are multiplatform safe. I think Thomas removed the last
blocker for DT based boards going multiplatform when PCI moved to DT.
So i don't want to add something now, which i know will break with
multiplatform. Lets do it the right way now.

> > Another issue is that the ddr_operation_base should probably be
> > accessed using your atomic_io_set_clear() function, since it is used
> > by the cpuidle drivers as well.
> > 
> 
> I think this is not needed. Both cpuidle suspend core code disables
> IRQ before entering any of the suspend or cpuidle states.

I've no idea how PM works, so i cannot say if its safe or not...
> 
> BTW, do you think the approach of *not* messing with clocks is ok?

That is correct. The drivers should be disabling clocks, were they can
be disabled. We know kirkwood ethernet is broken and we cannot
"easily" disable its clock.

	 Andrew
