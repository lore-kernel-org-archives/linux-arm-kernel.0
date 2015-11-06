From: sstabellini@kernel.org (Stefano Stabellini)
Date: Fri, 6 Nov 2015 15:09:53 +0000 (GMT)
Subject: [PATCH 1/3] xen/arm: introduce xen_read_wallclock
In-Reply-To: <23850350.L7uJax1OoN@wuerfel>
References: <alpine.DEB.2.02.1511051706560.13541@kaball.uk.xensource.com>
 <1446743385-12848-1-git-send-email-stefano.stabellini@eu.citrix.com>
 <23850350.L7uJax1OoN@wuerfel>
Message-ID: <alpine.DEB.2.02.1511061502280.23825@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 5 Nov 2015, Arnd Bergmann wrote:
> On Thursday 05 November 2015 17:09:43 Stefano Stabellini wrote:
> > Read the wallclock from the shared info page at boot time.
> > 
> > Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
> 
> Please use the appropriate timespec64 based functions here,
> we are in the process of converting all callers of struct timespec.

OK, I can do that


> > ---
> > +static void xen_read_wallclock(struct timespec *ts)
> > +{
> > +	u32 version;
> > +	u64 delta;
> > +	struct timespec now;
> > +	struct shared_info *s = HYPERVISOR_shared_info;
> > +	struct pvclock_wall_clock *wall_clock = &(s->wc);
> 
> pvclock_wall_clock has a 'u32 sec', so that suffers from
> a potential overflow. We should try to avoid introducing that
> on ARM, and instead have a 64-bit seconds based version,
> or alternatively a 64-bit nanoseconds version (with no
> extra seconds) that is also sufficient.

Unfortunately this a preexisting ABI which is common with other existing
architectures (see arch/x86/kernel/pvclock.c:pvclock_read_wallclock). I
cannot just change it.


> >  	struct vcpu_register_vcpu_info info;
> > @@ -218,6 +246,7 @@ static int __init xen_guest_init(void)
> >  	struct shared_info *shared_info_page = NULL;
> >  	struct resource res;
> >  	phys_addr_t grant_frames;
> > +	struct timespec ts;
> >  
> >  	if (!xen_domain())
> >  		return 0;
> > @@ -291,6 +320,8 @@ static int __init xen_guest_init(void)
> >  
> >  	pv_time_ops.steal_clock = xen_stolen_accounting;
> >  	static_key_slow_inc(&paravirt_steal_enabled);
> > +	xen_read_wallclock(&ts);
> > +	do_settimeofday(&ts);
> >  
> 
> Once you can get a 64-bit time, call do_settimeofday64()
> here.

OK
