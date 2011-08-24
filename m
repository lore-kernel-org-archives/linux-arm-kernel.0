From: will.deacon@arm.com (Will Deacon)
Date: Wed, 24 Aug 2011 11:58:48 +0100
Subject: [PATCH v4 0/8] MMU disabling code and kexec fixes
In-Reply-To: <alpine.LFD.2.00.1108232120590.20358@xanadu.home>
References: <1314136012-20533-1-git-send-email-will.deacon@arm.com>
	<alpine.LFD.2.00.1108232120590.20358@xanadu.home>
Message-ID: <20110824105848.GE32688@e102144-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nicolas,

Thanks for looking at this lot.

On Wed, Aug 24, 2011 at 02:25:36AM +0100, Nicolas Pitre wrote:
> On Tue, 23 Aug 2011, Will Deacon wrote:
> 
> > Hello,
> > 
> > This is version 4 of the patches originally posted here:
> > 
> > v1: http://lists.infradead.org/pipermail/linux-arm-kernel/2011-June/052157.html
> > v2: http://lists.infradead.org/pipermail/linux-arm-kernel/2011-June/052559.html
> > v3: http://lists.infradead.org/pipermail/linux-arm-kernel/2011-June/053252.html
> > 
> > There are many changes since v3. Notably:
> > 	- Support for Thumb-2
> > 	- Based on 3.1-rc3 (now that some of the previous patches have
> > 	  been merged)
> > 	- The reserved stack page now sits below swapper and is reserved
> > 	  by memblock during memory init. This has the advantage of being
> > 	  at a known physical address for a platform, which will be helpful
> > 	  for non-hotplug SMP booting.
> 
> Is this really necessary?  Relying on "known physical address" is often 
> going to lead us in situations where that physical address get encoded 
> outside the kernel proper and then we're stuck with it forever.  This 
> would be more "reliable" if the interface would be passed that address 
> and if the page was dynamically allocated/freed.

We don't want to allocate this dynamically because we need to avoid the
situation where the virtual address of this page aliases with the physical
address of the reset code. By keeping the page close to the start of
physical memory, we avoid this scenario.

On top of that, I'd like to use the bottom of this page as a holding pen
for secondary CPUs when doing an SMP kexec. In this case, the new kernel
needs to take care not to allocate the page for general use. I suppose we
could fix this with a new ATAG / FDT property but that seems a bit overkill.

I was also thinking that it might be useful if bootloaders want to throw all
of the CPUs at the kernel during boot, rather than implementing their own
SMP pen. In this case, they could make use of this reserved page (I was
planning to version the pen implementation).

The latter idea might simply be crazy, but I think the other points are
valid :)

Will
