From: jamie@shareable.org (Jamie Lokier)
Date: Fri, 8 Jan 2010 14:19:18 +0000
Subject: [PATCH] ARM: Add SWP/SWPB emulation for ARMv7 processors (v3)
In-Reply-To: <1262858349.2695.7.camel@pc1117.cambridge.arm.com>
References: <20100106181705.GD11773@shareable.org>
	<1262858349.2695.7.camel@pc1117.cambridge.arm.com>
Message-ID: <20100108141918.GC19328@shareable.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Catalin Marinas wrote:
> On Wed, 2010-01-06 at 18:17 +0000, Jamie Lokier wrote:
> > Catalin Marinas wrote:
> > > > Is there any reason why this wasn't always like that?
> > >
> > > On ARMv6 onwards (where this user RO, kernel RO is supported) we cannot
> > > easily differentiate between the vectors page and a normal kernel page
> > > unless we use another L_PTE_ bit. We need the vectors page to be
> > > writable if there is no TLS register in hardware (I guess we could use
> > > domain switching to override this though). But on ARMv7 we always have a
> > > TLS register, so no need to write to the vectors page.
> > 
> > Could you map the TLS page writable (kernel access only) at another
> > address at the same time, carefully choosing an aliasing address so
> > that no cache flush is needed after writing?
> 
> It could be but I'm not sure it's worth. Leif's patch is intended for
> ARMv7 where we always have a hardware TLS register. The FIQ handler
> installation could probably be done by first calling set_fs(KERNEL_DS).

You're right.

I was confused about the meaning of (user RO == kernel RW) pages,
thinking that like on a 386, it makes copy_to_user expensive.

But I've just remembered that ARM uses ldrt and strt instructions for
user memory access... doh!

So user RO == kernel RW hardly matters.

-- Jamie
