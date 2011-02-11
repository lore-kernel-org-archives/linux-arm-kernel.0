From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Fri, 11 Feb 2011 17:53:25 +0530
Subject: reboot not working on linux-2.6.37 for ARMv7
In-Reply-To: <20110211122007.GE23404@n2100.arm.linux.org.uk>
References: <AANLkTi=FCJr-0aF0LG92PC4Q7J4R5PDU7xobnvCgDHy8@mail.gmail.com>
	<20110211120305.GD23404@n2100.arm.linux.org.uk>
	<b78da14247ac79e0f2c8ecae9bbf6745@mail.gmail.com>
	<20110211122007.GE23404@n2100.arm.linux.org.uk>
Message-ID: <c39663a9155a8396e344ee1eb68e53db@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Russell King - ARM Linux [mailto:linux at arm.linux.org.uk]
> Sent: Friday, February 11, 2011 5:50 PM
> To: Santosh Shilimkar
> Cc: shiraz hashim; Armando VISCONTI; amit.goel at st.com;
> vipin.kumar at st.com; linux-arm-kernel at lists.infradead.org
> Subject: Re: reboot not working on linux-2.6.37 for ARMv7
>
> On Fri, Feb 11, 2011 at 05:40:46PM +0530, Santosh Shilimkar wrote:
> > > -----Original Message-----
> > > From: linux-arm-kernel-bounces at lists.infradead.org
> [mailto:linux-
> > > arm-kernel-bounces at lists.infradead.org] On Behalf Of Russell
> King -
> > > ARM Linux
> > > Sent: Friday, February 11, 2011 5:33 PM
> > > To: shiraz hashim
> > > Cc: Armando VISCONTI; amit.goel at st.com; vipin.kumar at st.com;
> linux-
> > > arm-kernel at lists.infradead.org
> > > Subject: Re: reboot not working on linux-2.6.37 for ARMv7
> > >
> > > On Fri, Feb 11, 2011 at 05:01:06PM +0530, shiraz hashim wrote:
> > > > Hi,
> > > >
> > > > I am using linux-2.6.37 on our ARM Cortex A9 (dual core) SMP
> > > platform
> > > > with PL310 as Level 2 cache. We observe that on reboot the
> control
> > > > is not able to reach to the arch_reset.
> > > >
> > > > The problem happens when L1 cache is disabled in
> > > > arm_machine_restart, through cpu_proc_fin() and L2 cache is
> > > flushed.
> > >
> > > Where's the L2 cache flush?  The sequence is:
> > >
> > >         /* Clean and invalidate caches */
> > >         flush_cache_all();
> > >         /* Turn off caching */
> > >         cpu_proc_fin();
> > >         /* Push out any further dirty data, and ensure cache is
> > > empty */
> > >         flush_cache_all();
> > >
> > > and flush_cache_all() calls v7_flush_kern_cache_all() in
> > > arch/arm/mm/cache-v7.S.
> > >
> > > I do hope you're not modifying flush_cache_all() to also call
> the L2
> > > cache functions because that's wrong.
> > >
> > I don't want to hijack this thread. But don't we need L2 flush too
> in
> > reboot path ? If the arch_reset function fails because of the data
> has
> > not made it main memory and stuck in L2 which is used as part of
> this
> > function. With C bit disabled, there won't be any look up done in
> L2.
>
> We only actually need the flushes if we're going to do a soft-
> reboot.
> Soft-reboot isn't supported on ARMv6 and ARMv7 (as the proc-*.S
> reset
> doesn't contain the necessary code).  ARMv5 and lower don't have L2
> caches, so its not a concern for them.
>
> Hard-reboot doesn't actually need the cache flushes.  Unfortunately,
> we've no way of knowing whether a platform implements soft-reboot or
> hard-reboot.

Thanks for clarification.

Regards,
Santosh
