From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 18 Mar 2016 12:22:59 +0000
Subject: [PATCH v2 1/1] arm64/dma-mapping: reduce an unnecessary
 conversion for coherent DMA
In-Reply-To: <1458267967-6332-2-git-send-email-thunder.leizhen@huawei.com>
References: <1458267967-6332-1-git-send-email-thunder.leizhen@huawei.com>
 <1458267967-6332-2-git-send-email-thunder.leizhen@huawei.com>
Message-ID: <20160318122259.GC4645@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 18, 2016 at 10:26:07AM +0800, Zhen Lei wrote:
> 1.For coherent DMA
>   In swiotlb_alloc_coherent, it directly return vaddr on success, and
> pass vaddr to free_pages on failure. So, we can directly transparent pass
> vaddr from __dma_free to swiotlb_free_coherent.
> 
> 2.Keep no change for non-coherent DMA.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  arch/arm64/mm/dma-mapping.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)

You sent a patch without any real reason like "improved performance",
just making the code slightly harder to read. Currently it is pretty
clear to me that phys_to_virt is meant for computing the swiotlb
address and we ignore the actual vaddr in this context.

So, I'm not taking this patch (if you want, you can send one just adding
a comment why vaddr cannot always be passed to the swiotlb API).

-- 
Catalin
