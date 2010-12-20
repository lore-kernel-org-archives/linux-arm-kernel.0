From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 20 Dec 2010 16:50:53 +0000
Subject: [PATCH] ARM: Fix subtle race in CPU pen_release hotplug code
In-Reply-To: <AANLkTi=vp_jWMn98+cDs=+r9D7Don9iz+NvuOB6iCv42@mail.gmail.com>
References: <E1PTuaP-0000Fl-EF@rmk-PC.arm.linux.org.uk>
	<AANLkTi=vp_jWMn98+cDs=+r9D7Don9iz+NvuOB6iCv42@mail.gmail.com>
Message-ID: <20101220165053.GF28157@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 20, 2010 at 04:39:07PM +0000, Catalin Marinas wrote:
> On 18 December 2010 11:04, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > There is a subtle race in the CPU hotplug code, where a CPU which has
> > been offlined can online itself before being requested, which results
> > in things going astray on the next online/offline cycle.
> [...]
> > --- a/arch/arm/mach-realview/platsmp.c
> > +++ b/arch/arm/mach-realview/platsmp.c
> > @@ -36,6 +36,19 @@ extern void realview_secondary_startup(void);
> > ?*/
> > ?volatile int __cpuinitdata pen_release = -1;
> >
> > +/*
> > + * Write pen_release in a way that is guaranteed to be visible to all
> > + * observers, irrespective of whether they're taking part in coherency
> > + * or not. ?This is necessary for the hotplug code to work reliably.
> > + */
> > +static void write_pen_release(int val)
> > +{
> > + ? ? ? pen_release = val;
> > + ? ? ? smp_wmb();
> > + ? ? ? __cpuc_flush_dcache_area((void *)&pen_release, sizeof(pen_release));
> > + ? ? ? outer_clean_range(__pa(&pen_release), __pa(&pen_release + 1));
> > +}
> 
> Just a minor thing - I don't think we need any barrier here. According
> to the ARM ARM B2.2.7:
> 
> "Any data cache or unified cache maintenance operation by MVA must be
> executed in program order
> relative to any explicit load or store on the same processor to an
> address covered by the MVA of the
> cache operation."

Right, I had been thinking about that.  I think the barrier came from the
original ARM implementation, and I added the cache flushes.

> We also have a corresponding smp_rmb() in boot_secondary(), I don't
> think it has any use either.

I think you're right, but it looks a little unsafe without:

        timeout = jiffies + (1 * HZ);
        while (time_before(jiffies, timeout)) {
                if (pen_release == -1)
                        break;

                udelay(10);
        }

I don't think it makes much odds if the pen_release check gets
re-ordered, especially as we do a final pen_release check after we
unlock.  However, could the loop end up waiting additional 10us
without the smp_rmb() ?
