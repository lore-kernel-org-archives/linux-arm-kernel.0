From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Sun, 15 Jan 2017 23:12:49 +0200
Subject: [PATCH] iommu/dma: Add support for DMA_ATTR_FORCE_CONTIGUOUS
In-Reply-To: <0e5c066f-ddf6-30ce-392e-79bd0f401a18@arm.com>
References: <1484305674-15018-1-git-send-email-geert+renesas@glider.be>
 <CAMuHMdWBfTm_QRuB7x-ZDh0bgGmHokqm7=F2b0rjQTYzizC9hA@mail.gmail.com>
 <0e5c066f-ddf6-30ce-392e-79bd0f401a18@arm.com>
Message-ID: <1782501.BR5drHV8iS@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Robin,

On Friday 13 Jan 2017 12:17:24 Robin Murphy wrote:
> On 13/01/17 11:59, Geert Uytterhoeven wrote:
> > On Fri, Jan 13, 2017 at 12:32 PM, Robin Murphy wrote:
> >> On 13/01/17 11:07, Geert Uytterhoeven wrote:
> >>> Add support for DMA_ATTR_FORCE_CONTIGUOUS to the generic IOMMU DMA code.
> >>> This allows to allocate physically contiguous DMA buffers on arm64
> >>> systems with an IOMMU.
> >> 
> >> Can anyone explain what this attribute is actually used for? I've never
> >> quite figured it out.
> > 
> > My understanding is that DMA_ATTR_FORCE_CONTIGUOUS is needed when using
> > an IOMMU but wanting the buffers to be both contiguous in IOVA space and
> > physically contiguous to allow passing to devices without IOMMU.
> > 
> > Main users are graphic and remote processors.
> 
> Sure, I assumed it must be to do with buffer sharing, but the systems
> I'm aware of which have IOMMUs in their media subsystems tend to have
> them in front of every IP block involved, so I was curious as to what
> bit of non-IOMMU hardware wanted to play too. The lone in-tree use in
> the Exynos DRM driver was never very revealing, and the new one I see in
> the Qualcomm PIL driver frankly looks redundant to me.

If two (or more) devices with different memory requirements are involved in 
buffer sharing, we need to either allocate and export buffers from the device 
with the strictest requirements, or to implement a central buffer allocator. 
In any case, I don't think DMA_ATTR_FORCE_CONTIGUOUS is the right solution to 
that problem.

Forcing contiguous allocation can however help with performance optimization, 
as mapping physically contiguous memory through IOMMUs can make use of larger 
page sizes.

-- 
Regards,

Laurent Pinchart
