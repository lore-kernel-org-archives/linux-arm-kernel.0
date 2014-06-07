From: lauraa@codeaurora.org (Laura Abbott)
Date: Fri, 06 Jun 2014 17:55:22 -0700
Subject: [PATCHv2] arm64: Add atomic pool for non-coherent and CMA
 allocaitons.
In-Reply-To: <20140605170500.GC27946@arm.com>
References: <1401739432-5358-1-git-send-email-lauraa@codeaurora.org>
 <20140605170500.GC27946@arm.com>
Message-ID: <539262FA.8010301@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6/5/2014 10:05 AM, Catalin Marinas wrote:
> Hi Laura,
> 
> On Mon, Jun 02, 2014 at 09:03:52PM +0100, Laura Abbott wrote:
>> Neither CMA nor noncoherent allocations support atomic allocations.
>> Add a dedicated atomic pool to support this.
> 
> CMA indeed doesn't support atomic allocations but swiotlb does, the only
> problem being the vmap() to create a non-cacheable mapping. Could we not
> use the atomic pool only for non-coherent allocations?
>

CMA needs the atomic pool for both non-coherent and coherent allocations.
Perhaps I should update the code so we only create the coherent atomic
pool if CMA is used.

.... 

> 
> I think the safest is to use GFP_DMA as well. Without knowing exactly
> what devices will do, what their dma masks are, I think that's a safer
> bet. I plan to limit the CMA buffer to ZONE_DMA as well for lack of a
> better option.
> 
> BTW, most of this code could be turned into a library, especially if we
> don't need to separate coherent/non-coherent pools. Also, a lot of code
> is similar to the dma_alloc_from_coherent() implementation (apart from
> the ioremap() call in dma_declare_coherent_memory() and per-device pool
> rather than global one).
> 

I'm looking into if lib/genalloc.c can be extended for this purpose which
should at least stop some of the duplicate bitmap management code. If that
doesn't seem to work, I'll pull out what we have into a library.

Thanks,
Laura
-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
