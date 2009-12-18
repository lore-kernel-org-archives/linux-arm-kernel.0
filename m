From: jamie@shareable.org (Jamie Lokier)
Date: Fri, 18 Dec 2009 19:54:32 +0000
Subject: [PATCH] ARM: Add SWP/SWPB emulation for ARMv7 processors (v2)
In-Reply-To: <20091218182007.GF5527@n2100.arm.linux.org.uk>
References: <20091218180406.32211.72790.stgit@e101986-lin>
	<20091218182007.GF5527@n2100.arm.linux.org.uk>
Message-ID: <20091218195432.GC1205@shareable.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux wrote:
> > +	  NOTE: when accessing uncached shared regions, LDREX/STREX rely
> > +	  on an external transaction monitoring block called a global
> > +	  monitor to maintain update atomicity. If your system does not
> > +	  implement a global monitor, this option is not safe for programs
> > +	  that are permitted to map uncached memory (CAP_SYS_RAWIO).
> 
> We can trap this case by looking at the L_PTE_MT_* bits in the pte
> for the page we're going to be accessing - that's probably a good
> idea to ensure that such accesses are trapped, rather than going
> head and possibly risking silent corruption.

After that test, the kernel could even use the SWP/SWPB instructions
if necessary for correct behaviour :-)

Trapping and sending the process a signal would be
a good way to ensure code doing that is fixed.

There might be thread synchronisation code using SWP/SWPB on shared
memory which gets mapped uncached to prevent aliasing.

So would it be more appropriate to trap when the access is to a
non-RAM mapping?  Or are there devices which depend on the SWP bus
cycle on RAM too, for example a PCI device updating RAM by DMA and
using locked cycles?

-- Jamie
