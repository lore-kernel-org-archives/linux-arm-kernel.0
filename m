From: will.deacon@arm.com (Will Deacon)
Date: Wed, 30 Jul 2014 10:45:57 +0100
Subject: [PATCH v3 1/1] iommu-api: Add map_sg/unmap_sg functions
In-Reply-To: <53D7D82C.2080201@codeaurora.org>
References: <1406572731-6216-1-git-send-email-ohaugan@codeaurora.org>
 <1406572731-6216-2-git-send-email-ohaugan@codeaurora.org>
 <20140728191111.GW15536@arm.com> <53D6EFC0.1060308@codeaurora.org>
 <20140729092547.GB9245@arm.com> <53D7D82C.2080201@codeaurora.org>
Message-ID: <20140730094557.GD12239@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 29, 2014 at 06:21:48PM +0100, Olav Haugan wrote:
> On 7/29/2014 2:25 AM, Will Deacon wrote:
> > I agree that we can't handle IOMMUs that have a minimum page size larger
> > than the CPU page size, but we should be able to handle the case where the
> > maximum supported page size on the IOMMU is smaller than the CPU page size
> > (e.g. 4k IOMMU with 64k pages on the CPU). I think that could trip a BUG_ON
> > with your patch, although the alignment would be ok in iommu_map because
> > page sizes are always a power-of-2. You also end up rounding the size to
> > 64k, which could lead to mapping more than you really need to.
> 
> Which BUG_ON would I trip? If the supported IOMMU page size is less than
> the CPU supported page size then iommu_map will nicely take care of
> splitting up the mapping calls into sizes supported by the IOMMU (taken
> care of by iommu_pgsize()). However, I see you point regarding the
> PAGE_ALIGN of the offset+length that can cause overmapping which you
> don't really want. What is the alternative here? Just leave it and do
> not align at all? That is how iommu_map() currently works. It will
> return error if the iova|phys|size is not aligned to the minimum pgsize
> supported by the IOMMU. So I would not change the behavior if I just
> left it without trying to align.

Yeah, I think losing the align is probably the best bet for now.

> I will remove the BUG_ON for (iova & (~PAGE_MASK)).

Great, that's the BUG_ON I was referring to above.

> >> (The code in __map_sg_chunk in arch/arm/mm/dma-mapping.c does the same
> >> thing btw.)
> > 
> > I have the same objection to that code :)
> 
> I am hoping we can remove/simplify some of that code when we have the
> iommmu_map_sg API available....

Looking forward to it!

Will
