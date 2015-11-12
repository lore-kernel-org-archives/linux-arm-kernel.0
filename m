From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 12 Nov 2015 17:10:07 +0100
Subject: [PATCH v3 3/6] xen: introduce XENPF_settime64
In-Reply-To: <5644B08F.9000205@oracle.com>
References: <alpine.DEB.2.02.1511111639500.5676@kaball.uk.xensource.com>
 <1447260696-450-3-git-send-email-stefano.stabellini@eu.citrix.com>
 <5644B08F.9000205@oracle.com>
Message-ID: <6642964.WydNcvXaCu@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 12 November 2015 10:30:23 Boris Ostrovsky wrote:
> > diff --git a/arch/x86/xen/time.c b/arch/x86/xen/time.c
> > index 663c2ea..3bbd377 100644
> > --- a/arch/x86/xen/time.c
> > +++ b/arch/x86/xen/time.c
> > @@ -134,10 +134,10 @@ static int xen_pvclock_gtod_notify(struct notifier_block *nb,
> >       if (!was_set && timespec_compare(&now, &next_sync) < 0)
> >               return NOTIFY_OK;
> >   
> > -     op.cmd = XENPF_settime;
> > -     op.u.settime.secs = now.tv_sec;
> > -     op.u.settime.nsecs = now.tv_nsec;
> > -     op.u.settime.system_time = xen_clocksource_read();
> > +     op.cmd = XENPF_settime32;
> > +     op.u.settime32.secs = now.tv_sec;
> > +     op.u.settime32.nsecs = now.tv_nsec;
> > +     op.u.settime32.system_time = xen_clocksource_read();
> 
> Can/should we switch to time64 here? (This would require a couple more 
> changes but they would all be local to this routine).

We definitely should. We are in the process of removing all uses of
timespec from the kernel in favor of timespec64, and this requires
changing the Xen code as well if we want to do it right. I suppose that
both Dom0 and DomU will have to support the old and the new interface
for x86, so we have a fallback if the 64-bit interface fails.

	Arnd
