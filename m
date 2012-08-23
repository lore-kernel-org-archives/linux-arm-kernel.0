From: minchan@kernel.org (Minchan Kim)
Date: Thu, 23 Aug 2012 15:43:57 +0900
Subject: [v2 0/4] ARM: dma-mapping: IOMMU atomic allocation
In-Reply-To: <1345702229-9539-1-git-send-email-hdoyu@nvidia.com>
References: <1345702229-9539-1-git-send-email-hdoyu@nvidia.com>
Message-ID: <20120823064357.GD5369@bbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 23, 2012 at 09:10:25AM +0300, Hiroshi Doyu wrote:
> Hi,
> 
> The commit e9da6e9 "ARM: dma-mapping: remove custom consistent dma
> region" breaks the compatibility with existing drivers. This causes
> the following kernel oops(*1). That driver has called dma_pool_alloc()
> to allocate memory from the interrupt context, and it hits
> BUG_ON(in_interrpt()) in "get_vm_area_caller()". This patch seris
> fixes this problem with making use of the pre-allocate atomic memory
> pool which DMA is using in the same way as DMA does now.
> 
> Any comment would be really appreciated.
> 
> v2:
> Don't modify attrs(DMA_ATTR_NO_KERNEL_MAPPING) for atomic allocation. (Marek)
> Skip vzalloc (KyongHo, Minchan)

Huh? I would like to correct exactly. I didn't say that kzalloc unify is okay.
As KyongHo said, there are other usecases for allocating big buffer but
I can't agree his opinion that it's system memory shortage if the allocation
fails. Because there are lots of freeable pages(cached page + anon pages
with swap , shrinkable slab and so on). But as I said early, VM can't do
anything except relying on kswapd in atomic context while there are a ton
of freeable pages in system and we can't gaurantee kswapd will do something
for us before seeing the page allocation failure in process context.
Especially, UP is more problem. So, it never indicate system needs more memory.

Atomic high order allocation is very fragile in VM POV
so caller should have fallback mechanism. Otherwise, don't do that.

-- 
Kind regards,
Minchan Kim
