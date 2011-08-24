From: will.deacon@arm.com (Will Deacon)
Date: Wed, 24 Aug 2011 17:59:38 +0100
Subject: [PATCH v4 0/8] MMU disabling code and kexec fixes
In-Reply-To: <alpine.LFD.2.00.1108241035400.20358@xanadu.home>
References: <1314136012-20533-1-git-send-email-will.deacon@arm.com>
	<alpine.LFD.2.00.1108232120590.20358@xanadu.home>
	<20110824105848.GE32688@e102144-lin.cambridge.arm.com>
	<alpine.LFD.2.00.1108241035400.20358@xanadu.home>
Message-ID: <20110824165938.GT32688@e102144-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 24, 2011 at 03:53:44PM +0100, Nicolas Pitre wrote:
> On Wed, 24 Aug 2011, Will Deacon wrote:
> > On Wed, Aug 24, 2011 at 02:25:36AM +0100, Nicolas Pitre wrote:
> > > Is this really necessary?  Relying on "known physical address" is often 
> > > going to lead us in situations where that physical address get encoded 
> > > outside the kernel proper and then we're stuck with it forever.  This 
> > > would be more "reliable" if the interface would be passed that address 
> > > and if the page was dynamically allocated/freed.
> > 
> > We don't want to allocate this dynamically because we need to avoid the
> > situation where the virtual address of this page aliases with the physical
> > address of the reset code. By keeping the page close to the start of
> > physical memory, we avoid this scenario.
> 
> Well... how probable might this be the case in practice?
> 
> And wouldn't this issue easily being worked around simply by allocating 
> a second page if the first one is found to alias?  Surely the reset code 
> is much smaller than a page.

Ok, so we can probably get around this corner case by checking for the alias
and reallocating in the next section (the ID mapping is done at the section
granularity).

> > On top of that, I'd like to use the bottom of this page as a holding pen
> > for secondary CPUs when doing an SMP kexec. In this case, the new kernel
> > needs to take care not to allocate the page for general use. I suppose we
> > could fix this with a new ATAG / FDT property but that seems a bit overkill.
> 
> Is it?

Well it means re-encoding a DT blob from within the kernel so that we can
tell the next kernel not to allocate from a given page of physical memory.
If we already have this infrastructure, then great, but it looks to me like
it only lives within dtc (as libfdt) at the moment.

> > I was also thinking that it might be useful if bootloaders want to throw all
> > of the CPUs at the kernel during boot, rather than implementing their own
> > SMP pen. In this case, they could make use of this reserved page (I was
> > planning to version the pen implementation).
> 
> I get really uncomfortable at the prospect of having more _implicit_ 
> dependencies between the kernel and bootloaders.  If ever we want to 
> move things around for whatever reasons in the future then such fixed 
> legacy addresses might really get in the way.  So I don't see the 
> passing of that info using an ATAG or a DT node as something not bad at 
> all.  This becomes just another resource provided to the kernel, like 
> the ramdisk image, that can be located almost anywhere. And then you 
> have no backward compatibility issues either as the page validity 
> becomes explicit.

Ok, point taken on the bootloader interface, I'd just rather have a way to
make this unreliable to bootloaders without having to re-encode the .dtb in
the kexec code.

Can you think of any clever tricks so that we only look at this pen when
we're being kexec'd?

Cheers,

Will
