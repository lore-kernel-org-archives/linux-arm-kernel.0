From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 18 Sep 2009 22:05:47 +0100
Subject: free_memmap() and sparsemem
In-Reply-To: <1252493855.24414.30.camel@pc1117.cambridge.arm.com>
References: <1252493855.24414.30.camel@pc1117.cambridge.arm.com>
Message-ID: <20090918210547.GM6601@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 09, 2009 at 11:57:35AM +0100, Catalin Marinas wrote:
> I haven't followed the full thread on omap and memory holes but I got an
> issue on RealView PBX with sparsemem enabled (patches not pushed yet for
> mainline). Basically I'm using this configuration:
> 
> 256MB @ 0x00000000 -> PAGE_OFFSET
> 512MB @ 0x20000000 -> PAGE_OFFSET + 0x10000000
> 256MB @ 0x80000000 -> PAGE_OFFSET + 0x20000000
> 
> I could only use two banks (the second at 0x70000000) but I need the
> first 256MB for DMA (since Linux only accepts DMA zone to be at the
> bottom). The phys_to_virt/virt_to_phys macros were modified to provide a
> contiguous translation to virtual addresses.

I normally say to keep these translation macros simple, so that conversions
are as fast as possible.

There's also no point using sparsemem if you're going to make the virtual
memory space contiguous - it just buys you complexity with no advantage.
Sparsemem is about a sparse virtual space, not a sparse physical space.

So at the end of it, your patch has nothing to do with sparsemem, but is
a problem with non-linear v:p translations.

New patch description to reflect those comments please.
