From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 12 Nov 2015 20:27:49 +0100
Subject: [PATCH v3 3/6] xen: introduce XENPF_settime64
In-Reply-To: <5644C97F.7070502@oracle.com>
References: <alpine.DEB.2.02.1511111639500.5676@kaball.uk.xensource.com>
 <alpine.DEB.2.02.1511121634040.526@kaball.uk.xensource.com>
 <5644C97F.7070502@oracle.com>
Message-ID: <9604059.Dn94ENEdgP@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 12 November 2015 12:16:47 Boris Ostrovsky wrote:
> >>> diff --git a/arch/x86/xen/time.c b/arch/x86/xen/time.c
> >>> index 663c2ea..3bbd377 100644
> >>> --- a/arch/x86/xen/time.c
> >>> +++ b/arch/x86/xen/time.c
> >>> @@ -134,10 +134,10 @@ static int xen_pvclock_gtod_notify(struct
> >>> notifier_block *nb,
> >>>     if (!was_set && timespec_compare(&now, &next_sync) < 0)
> >>>             return NOTIFY_OK;
> >>>    -        op.cmd = XENPF_settime;
> >>> -   op.u.settime.secs = now.tv_sec;
> >>> -   op.u.settime.nsecs = now.tv_nsec;
> >>> -   op.u.settime.system_time = xen_clocksource_read();
> >>> +   op.cmd = XENPF_settime32;
> >>> +   op.u.settime32.secs = now.tv_sec;
> >>> +   op.u.settime32.nsecs = now.tv_nsec;
> >>> +   op.u.settime32.system_time = xen_clocksource_read();
> >> Can/should we switch to time64 here? (This would require a couple more changes
> >> but they would all be local to this routine).
> > I can do that, but it should be a separate patch. I'll queue it at the
> > end of the series.
> 
> Didn't Arnd just say that something needs to be done in the hypervisor 
> for that to work? Or did I misunderstood him?

What I meant is that we need to do both sides in order to actually use
64-bit times, but the patches are otherwise independent of one another
because a change to either side is not allowed to break the other.

	Arnd
