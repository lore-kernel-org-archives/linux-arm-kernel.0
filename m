From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 06 Nov 2015 16:56:18 +0100
Subject: [PATCH 1/3] xen/arm: introduce xen_read_wallclock
In-Reply-To: <alpine.DEB.2.02.1511061502280.23825@kaball.uk.xensource.com>
References: <alpine.DEB.2.02.1511051706560.13541@kaball.uk.xensource.com>
 <23850350.L7uJax1OoN@wuerfel>
 <alpine.DEB.2.02.1511061502280.23825@kaball.uk.xensource.com>
Message-ID: <7480268.6Ff8Mvx46N@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 06 November 2015 15:09:53 Stefano Stabellini wrote:
> > > ---
> > > +static void xen_read_wallclock(struct timespec *ts)
> > > +{
> > > +   u32 version;
> > > +   u64 delta;
> > > +   struct timespec now;
> > > +   struct shared_info *s = HYPERVISOR_shared_info;
> > > +   struct pvclock_wall_clock *wall_clock = &(s->wc);
> > 
> > pvclock_wall_clock has a 'u32 sec', so that suffers from
> > a potential overflow. We should try to avoid introducing that
> > on ARM, and instead have a 64-bit seconds based version,
> > or alternatively a 64-bit nanoseconds version (with no
> > extra seconds) that is also sufficient.
> 
> Unfortunately this a preexisting ABI which is common with other existing
> architectures (see arch/x86/kernel/pvclock.c:pvclock_read_wallclock). I
> cannot just change it.

Maybe we need a "struct pvclock_wall_clock_v2"?

In theory, 'u32 sec' takes us all the way until 2106, which is significantly
longer away than the signed overflow in 2038, but it would still be nice
to not introduce this limitation on ARM in the first place.

I'm not quite sure about how the split between pvclock_wall_clock and
the delta works. Normally I'd expect that pvclock_wall_clock is the wallclock
time as it was at boot, while delta is the number of expired nanoseconds
since boot. However it is unclear why the latter has a longer range
(539 years starting at boot, rather than 126 years starting in 1970).

	Arnd
