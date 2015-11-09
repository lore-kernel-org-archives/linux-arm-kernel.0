From: sstabellini@kernel.org (Stefano Stabellini)
Date: Mon, 9 Nov 2015 17:42:50 +0000 (GMT)
Subject: [PATCH 3/3] xen/arm: set the system time in Xen via the
 XENPF_settime hypercall
In-Reply-To: <alpine.DEB.2.02.1511091714460.23825@kaball.uk.xensource.com>
References: <alpine.DEB.2.02.1511051706560.13541@kaball.uk.xensource.com>
 <6188457.uvvdcZaVNM@wuerfel>
 <alpine.DEB.2.02.1511061510190.23825@kaball.uk.xensource.com>
 <22638556.UuzKE0hp21@wuerfel>
 <alpine.DEB.2.02.1511091714460.23825@kaball.uk.xensource.com>
Message-ID: <alpine.DEB.2.02.1511091741480.23825@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 9 Nov 2015, Stefano Stabellini wrote:
> On Mon, 9 Nov 2015, Arnd Bergmann wrote:
> > On Monday 09 November 2015 14:10:22 Stefano Stabellini wrote:
> > > On Thu, 5 Nov 2015, Arnd Bergmann wrote:
> > > > On Thursday 05 November 2015 17:09:45 Stefano Stabellini wrote:
> > > > > +	now = __current_kernel_time();
> > > > 
> > > > We don't have __current_kernel_time64() yet, but it is trivial
> > > > to add, just follow the example of
> > > > current_kernel_time()/current_kernel_time64() and convert the
> > > > existing __current_kernel_time() function into a static
> > > > inline wrapper for the new __current_kernel_time64().
> > > 
> > > All right. I guess something like:
> > > 
> > > struct timespec64 __current_kernel_time64(void)
> > > {
> > > 	struct timekeeper *tk = &tk_core.timekeeper;
> > > 
> > > 	return tk_xtime(tk);
> > > }
> > 
> > Yes, exactly.
> > 
> > Just to make sure that this is actually the correct interface
> > that you want to call:
> > 
> > __current_kernel_time{,64}() is the fastest interface we have
> > to get an approximation of the current time, while ignoring
> > all of the locking.
> > 
> > Is is possible that you instead want ktime_get_real_ts64(),
> > which gives you the time as precise as the kernel knows it,
> > but uses locking?
> 
> I am not 100% sure. Can I call ktime_get_real_ts64 from a
> pvclock_gtod notifier_call function?

It doesn't look like it: we would be getting the tk_core seqcount twice.
