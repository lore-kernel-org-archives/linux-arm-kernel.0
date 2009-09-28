From: saaguirre@ti.com (Aguirre Rodriguez, Sergio Alberto)
Date: Mon, 28 Sep 2009 08:55:52 -0500
Subject: arm_syscall cacheflush breakage on VIPT platforms
In-Reply-To: <20090928134232.GG10671@n2100.arm.linux.org.uk>
References: <20090928092919.GA30271@localhost>
	<20090928124922.GA19778@shareable.org>	<20090928131624.GK30271@localhost>
	<20090928131926.GB19778@shareable.org>
	<20090928133109.GM30271@localhost>,
	<20090928134232.GG10671@n2100.arm.linux.org.uk>
Message-ID: <A24693684029E5489D1D202277BE89444B781B63@dlee02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> From: linux-arm-kernel-bounces at lists.infradead.org [linux-arm-kernel-bounces at lists.infradead.org] On Behalf Of Russell King - ARM Linux [linux at arm.linux.org.uk]
> Sent: Monday, September 28, 2009 8:42 AM
> On Mon, Sep 28, 2009 at 04:31:09PM +0300, Imre Deak wrote:
> > On Mon, Sep 28, 2009 at 03:19:26PM +0200, ext Jamie Lokier wrote:
> > > Imre Deak wrote:
> > > > On Mon, Sep 28, 2009 at 02:49:22PM +0200, ext Jamie Lokier wrote:
> > > > > Imre Deak wrote:
> > > > > > Hi,
> > > > > >
> > > > > > the following test app will cause an unhandled kernel paging request
> > > > > > on VIPT platforms. The triggering condition is the mmap_sem held by
> > > > > > thread_func while the main thread performs cache flushing.
> > > > > >
> > > > > > Since the likelihood of this to trigger is relatively low, a patch will
> > > > > > follow that makes similar bugs more visible.
> > > > >
> > > > > I would expect the likelihood of triggering would be higher for at
> > > > > least one of Java, Mono, Parrot or any of the modern Javascript
> > > > > engines.
> > > >
> > > > True, the above statement is only valid for certain use patterns. I was
> > > > mainly interested in applications that do user range cache flushing as
> > > > part of their DMA requests and they didn't have threads with frequent
> > > > syscalls that required mmap_sem, so the problem remained hidden for a
> > > > long time.
> > >
> > > Aieee.  Is sys_cacheflush architecturally the Right Way to do DMA to
> > > userspace, or is it just luck that it happens to work?
> >
> > No, it's not sys_cacheflush but using dma_cache_maint for user range.
> 
> dma_cache_maint can't be used either, because it's only valid for the
> kernel's RAM mapping.
> 
> > And yes I know that at the moment it's not the Right Way to use it on
> > a user range, but the alternative of flushing each page separately is
> > just prohibitively slow.
> 
> That's the way it's going to have to be done I'm afraid, especially
> when you realise you require the physical address for flushing
> non-coherent L2 caches.  Since you need to translate to a struct page
> anyway, getting that is just essential.
> 
> > Hopefully by adding the necessary fixups for the cache ops (and taking
> > mmap_sem) will make this an ok thing to do. An alternative is to
> > mlock the range so no faults are triggered for it, but that's again a
> > not-supported-thing to do from a driver.
> 
> As I do keep pointing out (and people keep ignoring) there is no real
> way to do DMA direct from user mappings.  It's something that the Linux
> kernel Just Doesn't Support.
> 
> You ask any mainline person, and that's basically the reply you get.
> It's been asked about many times.  The answer is always the same.
> 
> I believe that the reason for this is that it is _impossible_ to come
> up with a way to do DMA from userspace in a cross-architecture way.
> There's too many architectural details to make it work.
> 
> Eg, for at least one architecture, you need to get the right colouring
> of all pages to be DMA'd and program that colour index into the DMA
> controller for it to be coherent.
> 
> I really don't know what the answer is, and the pressure that I'm being
> placed under on this is going to lead us into a botched solution that's
> going to have long term problems.  We'll probably end up having to have
> multiple interfaces, and userspace will have to work out which is the
> right one to use.
> 
> I'd much rather just say "no, userspace DMA is *never* going to ever
> be supported" and call it a day, but I suspect no one's going to like
> that either.

Just FYI...

In OMAP3 specifically, we were looking for this to happen, since we have
big buffers that we need to share with other subsystems.

For example, when we take a 8 megapixel RAW 10-bit image (16MB) and
we want to send it to the DSP bridge driver, doing a memcpy to another kernel
allocated and mmaped buffer is a very suboptimal idea.
(which is our only option as per your statement)

Is not that we don't like it, but having a global solution will be more demanded in the
future, so not everybody has to work around this in their subsystem.

Its a real problem, and its not hard to hit nowadays.

Regards,
Sergio
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
> 
