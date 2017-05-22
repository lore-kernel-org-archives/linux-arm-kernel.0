From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 22 May 2017 16:49:47 +0100
Subject: [PATCH 0/2] ioremap_wc on arm64
In-Reply-To: <20170522142059.GA83004@localhost>
References: <1495436507-81890-1-git-send-email-jnair@caviumnetworks.com>
 <20170522085615.GC30129@e104818-lin.cambridge.arm.com>
 <20170522115349.GA82957@localhost> <20170522122236.GG1107@arm.com>
 <20170522142059.GA83004@localhost>
Message-ID: <20170522154947.GF30129@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 22, 2017 at 02:21:00PM +0000, Jayachandran C wrote:
> On Mon, May 22, 2017 at 01:22:37PM +0100, Will Deacon wrote:
> > On Mon, May 22, 2017 at 11:53:50AM +0000, Jayachandran C wrote:
> > > On Mon, May 22, 2017 at 09:56:16AM +0100, Catalin Marinas wrote:
> > > > On Mon, May 22, 2017 at 07:01:45AM +0000, Jayachandran C wrote:
> > > > > From its definition, the device "gather" attribute seems to be a better
> > > > > fit for implementing write combining mapping in ioremap_wc().  And on
> > > > > ThunderX2, Device GRE mapping has optimizations that makes it much faster
> > > > > than normal uncached mapping.
> > > > > 
> > > > > I am not sure of the reasoning behind the original decision to make
> > > > > ioremap_wc use "Normal Non-Cached" attribute, since all the other variants
> > > > > of ioremap use device attributes, and ioremap_wc looks like an exception.
> > > > 
> > > > The reason we kept it as Normal NC is that Device_GRE does not allow
> > > > unaligned accesses.
> > > 
> > > There does not to be an expectation to have unaligned access on __iomem
> > > pointers. I also see that memremap can call ioremap_wc (which is a Normal
> > > mapping) or ioremap_wt(which is a Device mapping), so that is inconsistent
> > > as well.
> > > 
> > > Was this added for a specific use case? Also, do you think this patchset
> > > is acceptable?
> > 
> > I think it was used for framebuffers. Note that using normal-NC also aligns
> > with arch/arm/ and, since normal-NC is strictly a more relaxed memory type
> > than Device-GRE, I'm really not keen making on this change.
> 
> If there is a hardware requirement that Normal-NC has to be implemented
> as more relaxed attribute than Device GRE, I can go back to the hardware
> team on this. I did not see any text in the ARM ARM requiring this.

It depends what you mean by "relaxed". Normal NC allows unaligned
accesses and also allows speculative loads (you don't get any ordering
guarantees of the Device memory). If you mean skipping some transparent
cache snooping, it may break other use-cases.

> Even if that is the case, having Normal attribute for ioremap just for
> ioremap_wc is inconsistent. The Device Gathering attribute by its definition
> is exactly what write combining requires. The memremap() API looks like a
> better way to expose Normal-NC mapping (with additional features like
> speculation etc.) if implemented correctly.

I agree, memremap() is a better way but this was merged in 4.3 while
ioremap_wc() had been around for a long time. If you want to change its
semantics, you'd need to go through all its uses in the kernel and make
sure they *only* use I/O accessors with such memory. At a quick grep,
there are several places where the __iomem pointer attribute is dropped
shortly after ioremap() and the pointer is accessed directly. That's
where things will break with Device GRE memory since the compiler
doesn't guarantee aligned accesses.

> Also, patch 1/2 should be useful anyway - can that be picked up?

The patch is harmless but are we going to have a user of Device_GRE?

-- 
Catalin
