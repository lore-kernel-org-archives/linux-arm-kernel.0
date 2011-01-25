From: will.deacon@arm.com (Will Deacon)
Date: Tue, 25 Jan 2011 18:39:43 -0000
Subject: [PATCH v2 04/28] ARM: mm: cache-l2x0: Add support for
	re-enabling	l2x0
In-Reply-To: <2f97ec8a084e590220e1548fc927b60e@mail.gmail.com>
References: <1295834493-5019-1-git-send-email-ccross@android.com>	<1295834493-5019-5-git-send-email-ccross@android.com>	<1295968464.10109.264.camel@e102109-lin.cambridge.arm.com>	<20110125154133.GB17280@n2100.arm.linux.org.uk>	<1295979242.10109.308.camel@e102109-lin.cambridge.arm.com>
	<2f97ec8a084e590220e1548fc927b60e@mail.gmail.com>
Message-ID: <001001cbbcbf$3c537930$b4fa6b90$@deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Santosh,

> > > Maybe we need a notifier list which can be told when cpuidle
> > events
> > > happen, so that parts of the system such as VFP and L2 cache
> > support
> > > can do the right thing without having platforms add lots of stuff
> > like
> > >
> > >         gic_secondary_init();
> > >         gic_restore_interrupt_types();
> > >         vfp_enable();
> > >         l2x0_enable();
> > >         twd_enable();
> > >         ... etc ...
> > >
> > > in their SoC specific code.
> >
> > But do we need a strict order between such operations? The notifier
> > call
> > chain isn't too flexible.
> >
> I guess it does depends on how the archs have integrated a9. Example
> on OMAP there are different power modes possible.
> 	1. CPU context ,TWD lost
> 	2. CPU context ,TWD + L1 is lost
> 	3. CPU context + L1 is lost + GIC lost
> 	4. CPU context + L1 is lost + GIC lost + L2 lost
> So there is need to have flexibility of calling these function
> based on power modes. I don't know how notifiers can give
> this flexibility

Well if you set the priority fields in the notifier blocks correctly
then you can just return NOTIFY_STOP when you've saved/restored as much
as you want. This assumes of course that you can identify which power
mode you're entering/leaving and that each one is `deeper' than the previous.

Will
