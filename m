From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 10 Nov 2015 13:35:41 +0100
Subject: [PATCH v2 6/7] xen/arm: introduce xen_read_wallclock
In-Reply-To: <1447156675-7418-6-git-send-email-stefano.stabellini@eu.citrix.com>
References: <alpine.DEB.2.02.1511101131350.5676@kaball.uk.xensource.com>
 <1447156675-7418-6-git-send-email-stefano.stabellini@eu.citrix.com>
Message-ID: <3711503.LuojCRibK3@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 10 November 2015 11:57:54 Stefano Stabellini wrote:
> +static void xen_read_wallclock(struct timespec64 *ts)
> +{
> +       u32 version;
> +       u64 delta;
> +       struct timespec64 now;
> +       struct shared_info *s = HYPERVISOR_shared_info;
> +       struct pvclock_wall_clock *wall_clock = &(s->wc);
> +
> +       /* get wallclock at system boot */
> +       do {
> +               version = wall_clock->version;
> +               rmb();          /* fetch version before time */
> +               now.tv_sec  = ((uint64_t)wall_clock->sec_hi << 32) | wall_clock->sec;
> +               now.tv_nsec = wall_clock->nsec;
> +               rmb();          /* fetch time before checking version */
> +       } while ((wall_clock->version & 1) || (version != wall_clock->version));
> +
> +       delta = arch_timer_read_counter() * (u64)NSEC_PER_SEC;
> +       do_div(delta, arch_timer_get_rate());     /* time since system boot */
> +       delta += now.tv_sec * (u64)NSEC_PER_SEC + now.tv_nsec;
> +
> +       now.tv_nsec = do_div(delta, NSEC_PER_SEC);
> +       now.tv_sec = delta;
> +
> +       set_normalized_timespec64(ts, now.tv_sec, now.tv_nsec);
> +
> +}

Instead of the two do_div(), I would do the entire calculation in
terms of nanoseconds and then call ns_to_timespec64() in the end
instead of set_normalized_timespec64(). That is just an optimization
though, your version looks correct as well.

	Arnd
