From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Thu, 12 Nov 2015 11:28:47 +0000
Subject: [PATCH v3 5/6] xen/arm: introduce xen_read_wallclock
In-Reply-To: <6299736.g7Jp9b7byl@wuerfel>
References: <alpine.DEB.2.02.1511111639500.5676@kaball.uk.xensource.com>
 <1447260696-450-5-git-send-email-stefano.stabellini@eu.citrix.com>
 <6299736.g7Jp9b7byl@wuerfel>
Message-ID: <alpine.DEB.2.02.1511121128240.526@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 11 Nov 2015, Arnd Bergmann wrote:
> On Wednesday 11 November 2015 16:51:35 Stefano Stabellini wrote:
> > +static void xen_read_wallclock(struct timespec64 *ts)
> > +{
> > +       u32 version;
> > +       u64 delta;
> > +       struct timespec64 now;
> > +       struct shared_info *s = HYPERVISOR_shared_info;
> > +       struct pvclock_wall_clock *wall_clock = &(s->wc);
> > +
> > +       /* get wallclock at system boot */
> > +       do {
> > +               version = wall_clock->version;
> > +               rmb();          /* fetch version before time */
> > +               now.tv_sec  = ((uint64_t)wall_clock->sec_hi << 32) | wall_clock->sec;
> > +               now.tv_nsec = wall_clock->nsec;
> > +               rmb();          /* fetch time before checking version */
> > +       } while ((wall_clock->version & 1) || (version != wall_clock->version));
> > +
> > +       /* time since system boot */
> > +       delta = ktime_get_ns();
> > +       delta += now.tv_sec * (u64)NSEC_PER_SEC + now.tv_nsec;
> > +
> > +       *ts = ns_to_timespec64(delta);
> > +}
> 
> Looks correct to me and better than the previous versions, but you are still
> converting from timespec64 to nanoseconds and back. While I previously
> recommended going all the way to nanoseconds here, I guess this you
> can even avoid the ns_to_timespec64() if you stay within timespec64
> domain and replace the last lines with
> 
> 	ktime_get_ts64(&ts_monotonic);
> 	*ts = timespec64_add(now, ts_monotonic);
> 
> which avoids both the multiplication and division.

Much better, I'll do that.  Thanks for the suggestion!
