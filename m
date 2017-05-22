From: will.deacon@arm.com (Will Deacon)
Date: Mon, 22 May 2017 13:22:37 +0100
Subject: [PATCH 0/2] ioremap_wc on arm64
In-Reply-To: <20170522115349.GA82957@localhost>
References: <1495436507-81890-1-git-send-email-jnair@caviumnetworks.com>
 <20170522085615.GC30129@e104818-lin.cambridge.arm.com>
 <20170522115349.GA82957@localhost>
Message-ID: <20170522122236.GG1107@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 22, 2017 at 11:53:50AM +0000, Jayachandran C wrote:
> On Mon, May 22, 2017 at 09:56:16AM +0100, Catalin Marinas wrote:
> > On Mon, May 22, 2017 at 07:01:45AM +0000, Jayachandran C wrote:
> > > From its definition, the device "gather" attribute seems to be a better
> > > fit for implementing write combining mapping in ioremap_wc().  And on
> > > ThunderX2, Device GRE mapping has optimizations that makes it much faster
> > > than normal uncached mapping.
> > > 
> > > I am not sure of the reasoning behind the original decision to make
> > > ioremap_wc use "Normal Non-Cached" attribute, since all the other variants
> > > of ioremap use device attributes, and ioremap_wc looks like an exception.
> > 
> > The reason we kept it as Normal NC is that Device_GRE does not allow
> > unaligned accesses.
> 
> There does not to be an expectation to have unaligned access on __iomem
> pointers. I also see that memremap can call ioremap_wc (which is a Normal
> mapping) or ioremap_wt(which is a Device mapping), so that is inconsistent
> as well.
> 
> Was this added for a specific use case? Also, do you think this patchset
> is acceptable?

I think it was used for framebuffers. Note that using normal-NC also aligns
with arch/arm/ and, since normal-NC is strictly a more relaxed memory type
than Device-GRE, I'm really not keen making on this change.

Will
