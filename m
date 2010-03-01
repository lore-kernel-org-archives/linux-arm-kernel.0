From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 01 Mar 2010 10:42:34 +0000
Subject: USB mass storage and ARM cache coherency
In-Reply-To: <1267316072.23523.1842.camel@pasglop>
References: <1266979632.23523.1668.camel@pasglop>
	<1267201521.14703.50.camel@e102109-lin.cambridge.arm.com>
	<20100226210030.GC23933@n2100.arm.linux.org.uk>
	<1267316072.23523.1842.camel@pasglop>
Message-ID: <1267440154.23333.44.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 2010-02-28 at 00:14 +0000, Benjamin Herrenschmidt wrote:
> On Fri, 2010-02-26 at 21:00 +0000, Russell King - ARM Linux wrote:
> > On Fri, Feb 26, 2010 at 04:25:21PM +0000, Catalin Marinas wrote:
> > > For mmap'ed pages (and present in the page cache), is it guaranteed that
> > > the HCD driver won't write to it once it has been mapped into user
> > > space? If that's the case, it may solve the problem by just reversing
> > > the meaning of PG_arch_1 on ARM and assume that a newly allocated page
> > > has dirty D-cache by default.
> >
> > I guess we could also set PG_arch_1 in the DMA API as well, to avoid the
> > unnecessary D cache flushing when clean pages get mapped into userspace.

That sounds good to me.

> That's an interesting thought for us too. When doing I$/D$ coherency, we
> have to fist flush the D$ and then invalidate the I$. If we could keep
> track of D$ and I$ separately, we could avoid the first step in many
> cases, including the DMA API trick you mentioned.
> 
> I wonder if it's time to get a PG_arch_2 :-)

As an optimisation, I think this would help (rather than always
invalidating the I-cache in update_mmu_cache or set_pte_at).

-- 
Catalin
