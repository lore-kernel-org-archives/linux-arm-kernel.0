From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 9 Jul 2010 15:34:52 +0100
Subject: [PATCH v2 3/3] ARM: Add barriers to the I/O
	accessorsifARM_DMA_MEM_BUFFERABLE
In-Reply-To: <1278685283.11895.52.camel@e102109-lin.cambridge.arm.com>
References: <20100709110350.11333.34303.stgit@e102109-lin.cambridge.arm.com>
	<20100709110814.11333.83771.stgit@e102109-lin.cambridge.arm.com>
	<1278675696.11895.37.camel@e102109-lin.cambridge.arm.com>
	<20100709121629.GE22845@n2100.arm.linux.org.uk>
	<1278680538.11895.49.camel@e102109-lin.cambridge.arm.com>
	<1278685283.11895.52.camel@e102109-lin.cambridge.arm.com>
Message-ID: <20100709143452.GJ22845@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 09, 2010 at 03:21:23PM +0100, Catalin Marinas wrote:
> The patch below changes the __raw_* accessors to inline functions. Do
> you see any problem with this? This would be needed even without the I/O
> ordering patches.

I'd suggest you try building a kernel before and after this patch and
compare the sizes - and then look at the disassembly associated with
these accessors.

Certainly previous gcc versions generated useless instruction overhead
when these were inline functions - partly down to it wanting to make
sure things passed to/from __raw_writeb() and __raw_readb() were
absolutely definitely only 8-bit in size, and partly because this
seems to destroy GCC's ability to spot commonalities between multiple
accesses.

That's the reason why I've never pushed a patch which causes read[bwl]
and write[bwl] to check their arguments a little more strictly - I
found that it caused gcc to generate worse code for these accessors.
