From: nico@fluxnic.net (Nicolas Pitre)
Date: Fri, 28 May 2010 15:26:21 -0400 (EDT)
Subject: [PATCH] ARM: fix highmem with VIPT cache and DMA
In-Reply-To: <20100528185604.GB5189@n2100.arm.linux.org.uk>
References: <alpine.LFD.2.00.1003251638030.694@xanadu.home>
	<1269610458.807.49.camel@e102109-lin.cambridge.arm.com>
	<alpine.LFD.2.00.1003261144020.694@xanadu.home>
	<alpine.LFD.2.00.1004111033010.7232@xanadu.home>
	<20100528185604.GB5189@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.00.1005281503260.24526@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 28 May 2010, Russell King - ARM Linux wrote:

> FYI, I'm considering reverting this patch; this patch is one of two
> responsible for causing a stability regression of Versatile Express
> platform - a highmem+Cortex A9 MPCore system with VIPT non-aliasing
> caches.

Two questions:

1) Do you actually have CONFIG_HIGHMEM enabled?

2) If no, does the reversal of this patch really make a difference?
   If yes, are you sure highmem actually works reliably without it?

In theory, this patch should have no effect if CONFIG_HIGHMEM is 
configured out, and should result in the same kernel binary with or 
without this patch.

But if you do have CONFIG_HIGHMEM turned on without this patch then you 
should get memory corruption pretty fast simply by booting on a block 
device with a driver that uses DMA.  That was confirmed on both a TI 
OMAP board and on a Marvell Dove board.

> The two commits responsible for making Versatile Express userspace
> completely unstable are:
> 
> b8349b569aae661dea9d59d7d2ee587ccea3336c
> ARM: 6112/1: Use the Inner Shareable I-cache and BTB ops on ARMv7 SMP
> 
> 7e5a69e83ba7a0d5917ad830f417cba8b8d6aa72
> ARM: 6007/1: fix highmem with VIPT cache and DMA
> 
> Most of the instability is from the second (this) patch, but reverting
> just one patch doesn't fully restore userspace stability.

And that includes reverting only b8349b56, right?

> The instability seen consists of completely random SIGSEGVs and SIGILLs,
> sometimes early enough to kill init, sometimes init is the only thing
> able to run - so it's very severe.

That is exactly the observed behavior on OMAP and Dove when this patch 
is _not_ applied.

> Rootfs is on ext2fs on a read only MMC filesystem, using the MMCI driver.
> No swap.

The OMAP board was also using an MMC card, while the Dove board was 
booting on a SATA hard disk.

Also beware the CONFIG_MMC_BLOCK_BOUNCE option.  If that is enabled and 
the core code decides to actually use it, then the cache coherency issue 
caused by DMA usage will be hidden and things might appear to just work 
fine as the DMA won't happen directly into highmem user pages (same 
thing if you boot with NFS root).


Nicolas
