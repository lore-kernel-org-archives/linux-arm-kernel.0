From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 28 Apr 2011 14:40:55 +0100
Subject: [PATCH] OMAP: iommu flush page table entries from L1 and L2 cache
In-Reply-To: <BANLkTin8gugnVoai6VHC7qMgK4eKRXRtHg@mail.gmail.com>
References: <1302817968-28516-1-git-send-email-fernando.lugo@ti.com>
	<20110414223036.GA7335@n2100.arm.linux.org.uk>
	<BANLkTin8gugnVoai6VHC7qMgK4eKRXRtHg@mail.gmail.com>
Message-ID: <20110428134055.GA19709@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 15, 2011 at 06:26:40AM -0500, Gupta, Ramesh wrote:
> Russell,
> 
> On Thu, Apr 14, 2011 at 5:30 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Thu, Apr 14, 2011 at 04:52:48PM -0500, Fernando Guzman Lugo wrote:
> >> From: Ramesh Gupta <grgupta@ti.com>
> >>
> >> This patch is to flush the iommu page table entries from L1 and L2
> >> caches using dma_map_single. This also simplifies the implementation
> >> by removing the functions ?flush_iopgd_range/flush_iopte_range.
> >
> > No. ?This usage is just wrong. ?If you're going to use the DMA API then
> > unmap it, otherwise the DMA API debugging will go awol.
> >
> 
> Thank you for the comments, this particular memory is always a write
> from the A9 for MMU programming and
> only read from the slave processor, that is the reason for not calling
> the unmap. I can re-look into the changes to call
> unmap in a proper way as this impacts the DMA API.
> Are there any other ways to perform only flush the memory from L1/L2 caches?

We _could_ invent a new API to deal with this, which is probably going
to be far better in the longer term for page table based iommus.  That's
going to need some thought - eg, do we need to pass a struct device
argument for the iommu cache flushing so we know whether we need to flush
or not (eg, if we have cache coherent iommus)...
