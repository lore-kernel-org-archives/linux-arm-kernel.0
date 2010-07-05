From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 05 Jul 2010 12:16:17 +0100
Subject: [patch 1/2] arm: Disable outer (L2) cache in kexec
In-Reply-To: <alpine.LFD.2.00.1007051311040.2525@localhost.localdomain>
References: <20100705092105.157256920@linutronix.de>
	<1278327174.11315.21.camel@e102109-lin.cambridge.arm.com>
	<alpine.LFD.2.00.1007051311040.2525@localhost.localdomain>
Message-ID: <1278328577.11315.25.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2010-07-05 at 12:13 +0100, Thomas Gleixner wrote:
> On Mon, 5 Jul 2010, Catalin Marinas wrote:
> 
> > On Mon, 2010-07-05 at 10:25 +0100, Thomas Gleixner wrote:
> > > kexec does not disable the outer cache before disabling the inner
> > > caches in cpu_proc_fin(). So L2 is enabled across the kexec jump. When
> > > the new kernel enables chaches again, it randomly crashes.
> > >
> > > Disabling L2 before calling cpu_proc_fin() cures the problem.
> > >
> > > Disabling L2 requires the following new functions: flush_all(),
> > > inv_all() and disable(). Add them to outer_cache_fns and call them
> > > from the kexec code.
> > >
> > > Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> > > Index: linux-2.6/arch/arm/include/asm/outercache.h
> > > ===================================================================
> > > --- linux-2.6.orig/arch/arm/include/asm/outercache.h
> > > +++ linux-2.6/arch/arm/include/asm/outercache.h
> > > @@ -25,6 +25,9 @@ struct outer_cache_fns {
> > >         void (*inv_range)(unsigned long, unsigned long);
> > >         void (*clean_range)(unsigned long, unsigned long);
> > >         void (*flush_range)(unsigned long, unsigned long);
> > > +       void (*flush_all)(void);
> > > +       void (*inv_all)(void);
> > > +       void (*disable)(void);
> >
> > Why don't we handle the flush_all/inv_all in the disable function and
> > avoid exporting them? Once exported, people may start using them in
> 
> Because OMAP needs them to avoid reimplementing everything in the OMAP
> part. So OMAP only needs to override the disable function. And if
> Russell wants to add his cleanup patch which he posted last week, then
> the split and the export needs to be done anyway.

OK, good point.

Thanks.

-- 
Catalin
