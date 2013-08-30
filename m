From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 30 Aug 2013 23:18:32 +0100
Subject: [PATCH v3 1/3] ARM: Introduce atomic MMIO modify
In-Reply-To: <20130830200830.GB6368@obsidianresearch.com>
References: <1377253445-2842-2-git-send-email-ezequiel.garcia@free-electrons.com>
 <20130823103802.GO4600@tarshish> <20130823110748.GD2389@localhost>
 <20130823113225.GF2389@localhost> <20130823114805.GF10971@arm.com>
 <20130830090807.GB25628@mudshark.cambridge.arm.com>
 <20130830091534.GA62188@MacBook-Pro.local>
 <20130830092032.GD25628@mudshark.cambridge.arm.com>
 <20130830100342.GD62188@MacBook-Pro.local>
 <20130830200830.GB6368@obsidianresearch.com>
Message-ID: <20130830221832.GC6617@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 30, 2013 at 02:08:30PM -0600, Jason Gunthorpe wrote:
> On Fri, Aug 30, 2013 at 11:03:42AM +0100, Catalin Marinas wrote:
> 
> > > Perhaps we should just bit the bullet and define relaxed accessors for all
> > > architectures? It's not difficult to default them to the non-relaxed
> > > variants if the architecture doesn't provide an optimised implementation.
> > 
> > Yes, an asm-generic default relaxed would be good (that's what I
> > suggested earlier in this thread and it was discussed in the past). But
> > no-one volunteered ;).
> 
> Something I've always been confused about..
> 
> Do these _relaxed operators on ARM differ from the PCI-X definition of
> relaxed ordering, and are they expected to generate a PCI TLP with
> the relaxed ordering bit set?

It's more to do with the memory model.  The _relaxed IO accessors just
read/write to the desired IO location without any ordering with respect
to memory - so if you have for instance DMA coherent memory, and you've
written a set of descriptors to that memory, there is no implicit
guarantee that those writes will be visible to the DMA engine if you
enable it using a relaxed operator unless you use an appropriate barrier
between the two.

Conversely, reading a register and then accessing memory, there is no
guarantee that you will have read the register before the memory access
has been performed with the relaxed IO.

The standard IO operations (readl, writel) contain barriers which ensure
correct ordering - the write*() have a barrier before their write, and
the read*() have a barrier after their read.  This ensures correct and
expected ordering with DMA coherent memory.

However, those barriers can be very expensive - they end up having to
themselves issue a write to the L2 cache controller (which obviously
can't use the standard IO operations).

> AFAIK, on x86 read_relaxed is expected to cause the PCI behavior.
> Documentation/DocBook/deviceiobook.tmpl seems to confirm this.

I guess our read* is compatible with that (even though it has nothing
to do with PCI) - the issues in Docbook appear to suggest similar
behaviours from the CPU point of view - IOW, the visibility of DMA vs
the read transaction.  The write is just an extension of that.
