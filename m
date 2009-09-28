From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Mon, 28 Sep 2009 16:10:32 +0200
Subject: arm_syscall cacheflush breakage on VIPT platforms
In-Reply-To: <20090928134232.GG10671@n2100.arm.linux.org.uk>
References: <20090928092919.GA30271@localhost>
	<20090928133109.GM30271@localhost>
	<20090928134232.GG10671@n2100.arm.linux.org.uk>
Message-ID: <200909281610.32674.laurent.pinchart@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russel,

On Monday 28 September 2009 15:42:32 Russell King - ARM Linux wrote:
> On Mon, Sep 28, 2009 at 04:31:09PM +0300, Imre Deak wrote:
> > On Mon, Sep 28, 2009 at 03:19:26PM +0200, ext Jamie Lokier wrote:
> > > Imre Deak wrote:
> > > > I was mainly interested in applications that do user range cache
> > > > flushing as part of their DMA requests and they didn't have threads
> > > > with frequent syscalls that required mmap_sem, so the problem
> > > > remained hidden for a long time.
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

I don't think people are ignoring you, but they are mostly trying to find a 
way to make it (somehow) work.

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

Do we really need a cross-architecture solution ? The pressure to implement a 
working userspace DMA solution seem to come mostly from embedded system 
developers, and embedded systems usually don't mind arch-specific APIs.
 
> I'd much rather just say "no, userspace DMA is *never* going to ever
> be supported" and call it a day, but I suspect no one's going to like
> that either.

In that case developers will all create their own incompatible solutions and 
the situation will likely get worse. Do you think it would be possible to 
create a clean DMA-to-userspace API specific to the ARM architecture ?

-- 
Laurent Pinchart
