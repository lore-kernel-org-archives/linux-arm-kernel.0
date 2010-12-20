From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 20 Dec 2010 18:08:31 +0000
Subject: [PATCH] ARM: Fix subtle race in CPU pen_release hotplug code
In-Reply-To: <20101220165053.GF28157@n2100.arm.linux.org.uk>
References: <E1PTuaP-0000Fl-EF@rmk-PC.arm.linux.org.uk>
	<AANLkTi=vp_jWMn98+cDs=+r9D7Don9iz+NvuOB6iCv42@mail.gmail.com>
	<20101220165053.GF28157@n2100.arm.linux.org.uk>
Message-ID: <1292868512.10292.49.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2010-12-20 at 16:50 +0000, Russell King - ARM Linux wrote:
> On Mon, Dec 20, 2010 at 04:39:07PM +0000, Catalin Marinas wrote:
> > On 18 December 2010 11:04, Russell King - ARM Linux
> > <linux@arm.linux.org.uk> wrote:
> > > There is a subtle race in the CPU hotplug code, where a CPU which has
> > > been offlined can online itself before being requested, which results
> > > in things going astray on the next online/offline cycle.
> > [...]
> > > --- a/arch/arm/mach-realview/platsmp.c
> > > +++ b/arch/arm/mach-realview/platsmp.c
> > > @@ -36,6 +36,19 @@ extern void realview_secondary_startup(void);
> > >  */
> > >  volatile int __cpuinitdata pen_release = -1;
> > >
> > > +/*
> > > + * Write pen_release in a way that is guaranteed to be visible to all
> > > + * observers, irrespective of whether they're taking part in coherency
> > > + * or not.  This is necessary for the hotplug code to work reliably.
> > > + */
> > > +static void write_pen_release(int val)
> > > +{
> > > +       pen_release = val;
> > > +       smp_wmb();
> > > +       __cpuc_flush_dcache_area((void *)&pen_release, sizeof(pen_release));
> > > +       outer_clean_range(__pa(&pen_release), __pa(&pen_release + 1));
> > > +}
> >
> > Just a minor thing - I don't think we need any barrier here. According
> > to the ARM ARM B2.2.7:
> >
> > "Any data cache or unified cache maintenance operation by MVA must be
> > executed in program order
> > relative to any explicit load or store on the same processor to an
> > address covered by the MVA of the
> > cache operation."
> 
> Right, I had been thinking about that.  I think the barrier came from the
> original ARM implementation, and I added the cache flushes.

I think the original smp_wmb() was there to prevent the pen_release
update not being visible to the primary CPU before the spin_lock() loop
on the secondary, leading to a deadlock.

The smp_wmb() is no longer needed with your patch as we do explicit
cache flushing which contains a DSB. But for clarity, you may still want
to keep it as a separate call in platform_secondary_init() rather than
write_pen_release():

 	 * let the primary processor know we're out of the
 	 * pen, then head off into the C entry point
 	 */
-	pen_release = -1;
+	write_pen_release(-1);
 	smp_wmb();
 
 	/*
 	 * Synchronise with the boot thread.

> > We also have a corresponding smp_rmb() in boot_secondary(), I don't
> > think it has any use either.
> 
> I think you're right, but it looks a little unsafe without:
> 
>         timeout = jiffies + (1 * HZ);
>         while (time_before(jiffies, timeout)) {
>                 if (pen_release == -1)
>                         break;
> 
>                 udelay(10);
>         }
> 
> I don't think it makes much odds if the pen_release check gets
> re-ordered, especially as we do a final pen_release check after we
> unlock.  However, could the loop end up waiting additional 10us
> without the smp_rmb() ?

Looking through A3.8.2, there is only a "control dependency" between
reading the jiffies and reading the pen_release. My understanding is
that these reads could happen in any order, so to avoid an additional
10us wait the barrier is still useful.

This smp_rmb() was supposed to work in pair with the smp_wmb() above but
that's only by following the memory-barriers.txt document. From an ARM
perspective, we could simply have an smp_mb() in boot_secondary().

If we keep the smp_wmb() in platform_secondary_init() for clarity, we
could keep the smp_rmb() here as well. I think I prefer this option.

-- 
Catalin
