From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Tue, 10 Nov 2015 15:58:53 +0000
Subject: [PATCH v2 7/7] xen/arm: set the system time in Xen via the
 XENPF_settime64 hypercall
In-Reply-To: <4039287.QS1nrAMb0E@wuerfel>
References: <alpine.DEB.2.02.1511101131350.5676@kaball.uk.xensource.com>
 <1447156675-7418-7-git-send-email-stefano.stabellini@eu.citrix.com>
 <4039287.QS1nrAMb0E@wuerfel>
Message-ID: <alpine.DEB.2.02.1511101557230.5676@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 10 Nov 2015, Arnd Bergmann wrote:
> On Tuesday 10 November 2015 11:57:55 Stefano Stabellini wrote:
> > +       op.u.settime64.nsecs = now.tv_nsec;
> > +       op.u.settime64.system_time = arch_timer_read_counter() * (u64)NSEC_PER_SEC;
> > +       do_div(op.u.settime64.system_time, arch_timer_get_rate());
> 
> NSEC_PER_SEC is a large number, doesn't that multiplication overflow the
> 64-bit system_time variable?

It could be a concern, you are right. I think I can solve this issue and
remove multiple do_divs by calculating nsec_per_tick at initialization
time and use it here and in xen_read_wallclock.


> > +       printk("GTOD: Setting to %llu.%u at %llu\n",
> 
> 				   %llu.%09u
> 
> so you get the leading zeroes.
> 
> > +              op.u.settime64.secs,
> > +              op.u.settime64.nsecs,
> > +              op.u.settime64.system_time);
> > +       (void)HYPERVISOR_platform_op(&op);
> 
> 	Arnd
> 
