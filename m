From: robin.murphy@arm.com (Robin Murphy)
Date: Thu, 10 Nov 2016 16:17:30 +0000
Subject: [PATCH] iommu/dma-iommu: properly respect configured address
 space size
In-Reply-To: <20161110155938.GI2078@8bytes.org>
References: <CGME20161107130625eucas1p2dd23c07010b4f3eddb6c6540ed802246@eucas1p2.samsung.com>
 <1478523973-8828-1-git-send-email-m.szyprowski@samsung.com>
 <68e7a18b-739e-b73e-eacf-3cb6c1bd279a@arm.com>
 <20161110155938.GI2078@8bytes.org>
Message-ID: <9d239c5c-a4ed-f177-319f-7c467a6059ba@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/11/16 15:59, Joerg Roedel wrote:
> On Tue, Nov 08, 2016 at 11:37:23AM +0000, Robin Murphy wrote:
>> TBH I've been pondering ripping the size stuff out of dma-iommu, as it
>> all stems from me originally failing to understand what dma_32bit_pfn is
>> actually for.
> 
> The point of dma_32bit_pfn is to allocate dma-address below 4G by
> default. This is a performance optimization so that even devices capable
> of 64bit DMA are using SAC by default instead of DAC.
> 
> Since it is the goal to share a dma-iommu implemenation between
> architectures, I would rather prefer not to rip this stuff out.

Oh, I didn't mean rip it out entirely, just get rid of the bogus
assumption that it's the "size" of the domain, especially when given a
>32-bit DMA mask, since that defeats the very optimisation I do now
understand (although it might still be OK for platform devices where
SAC/DAC doesn't apply, to avoid the rb_last() overhead every time).

>From the patch I've started, "rip it out" turns out to actually be
mostly "rewrite the comments" anyway - I'll post something soon.

Robin.
