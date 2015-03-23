From: joro@8bytes.org (Joerg Roedel)
Date: Mon, 23 Mar 2015 13:29:10 +0100
Subject: [PATCH] CHROMIUM: iommu: rockchip: Make sure that page table
 state is coherent
In-Reply-To: <CAAFQd5Abk6X7AVTFaNuUSiShn31pzwwTE3VjfLnE4kyziAjy2A@mail.gmail.com>
References: <1423480761-33453-1-git-send-email-tfiga@chromium.org>
 <20150303133659.GD10502@8bytes.org>
 <CAAFQd5Abk6X7AVTFaNuUSiShn31pzwwTE3VjfLnE4kyziAjy2A@mail.gmail.com>
Message-ID: <20150323122910.GO4441@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tomasz,

On Mon, Mar 23, 2015 at 05:38:45PM +0900, Tomasz Figa wrote:
> While unmapping, the driver zaps all iovas belonging to the mapping,
> so the page tables not used by any mapping won't be cached. Now when
> the driver creates a mapping it might end up occupying several page
> tables. However, since the mapping area is virtually contiguous, only
> the first and last page table can be shared with different mappings.
> This means that only first and last iovas can be already cached. In
> fact, we could detect if first and last page tables are shared and do
> not zap at all, but this wouldn't really optimize too much. Why
> invalidating one iova is enough to invalidate the whole page table is
> unclear to me as well, but it seems to be the correct way on this
> hardware.
> 
> As for the race, it's also kind of explained by the above. The already
> running hardware can trigger page table look-ups in the IOMMU and so
> caching of the page table between our zapping and updating its
> contents. With this patch zapping is performed after updating the page
> table so the race is gone.

Okay, this makes sense. Can you add this information to the patch
changelog and resend please?

Thanks,

	Joerg
