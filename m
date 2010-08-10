From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 10 Aug 2010 17:36:16 +0100
Subject: [regression] in linux-next: sh_mobile_ceu_camera broken by
	"ARM: Prohibit ioremap() on kernel managed RAM"
In-Reply-To: <4C615D0D.2080600@st.com>
References: <4C5ED116.5000002@arndnet.de>
	<20100808220035.GD23623@n2100.arm.linux.org.uk>
	<4C615D0D.2080600@st.com>
Message-ID: <20100810163616.GA7702@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 10, 2010 at 03:07:09PM +0100, Stuart Menefy wrote:
> Doesn't dma_alloc_coherent() suffer from the same problems? Pages are
> allocated using alloc_pages, and in the non-coherent case will be
> mapped uncached into consistent mapping region, creating a second
> mapping with different attributes.

Yes, and it's just waiting to corrupt your data.  It's the next item on
the list of things to fix for ARMv6/ARMv7 for the next merge window.

This merge window contains a small step in that direction by changing
the way the DMA region allocator works - aligning allocations to their
natural size.

Potentially, that means people may need a larger DMA region - there
will be allocation patterns which fail (eg, 1.5MB, 256MB, 16MB, 240MB)
which used to succeed - though problems due to fragmentation should
be reduced due to the natural alignment of blocks below 1MB.

There are two solutions I'm contemplating:

1. We pre-allocate the memory for the DMA region at boot and never free
   it for other uses.  This means that the DMA coherent region will
   always be fully populated regardless of how much memory is actually
   in use.

2. We allocate memory for the DMA region in sections, and unmap that
   memory from the lowmem pool.

(1) has the problem that people won't like it due to the obvious waste,
but it is the easy solution.

(2) is rather disgusting to achieve because of the problems of updating
all page tables in the system, especially on SMP systems.

The option of doing nothing is not realistic - as ARM processors progress,
the speculative prefetch benaviour is only going to become more aggressive,
and therefore memory which is mapped multiple times with different
attributes _will_ fail to behave as expected in random and hard to debug
ways.
