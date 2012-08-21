From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Tue, 21 Aug 2012 16:46:54 +0200
Subject: [PATCH] ARM: relax conditions required for enabling Contiguous
 Memory Allocator
In-Reply-To: <201208202001.23443.arnd@arndb.de>
References: <1345443372-3824-1-git-send-email-m.szyprowski@samsung.com>
 <201208202001.23443.arnd@arndb.de>
Message-ID: <00c001cd7fab$d145f350$73d1d9f0$%szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Monday, August 20, 2012 10:01 PM Arnd Bergmann wrote:

> On Monday 20 August 2012, Marek Szyprowski wrote:
> > Contiguous Memory Allocator requires only paging and MMU enabled not
> > particular CPU architectures, so there is no need for strict dependency
> > on CPU type. This enables to use CMA on some older ARM v5 systems which
> > also might need large contiguous blocks for the multimedia processing hw
> > modules.
> >
> > Reported-by: Prabhakar Lad <prabhakar.csengg@gmail.com>
> > Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> 
> The patch looks simple, but I want a better explanation for it.
> When we went through all possible cases, we decided that:
> 
> * ARMv6+ need CMA to avoid the double mapping problem.

Right. CMA can be used to avoid double mapping issues, but we also should keep in
mind that right now no one observed any issues with the real hw, so this discussion
is still a bit hypothetical.

> * ARMv4/v5 cannot generally use CMA because it doesn't work
>   together with DMABOUNCE. I don't remember if it was the
>   only problem, but I definitely remember this was intentional.

DMABOUNCE is used only by a few machines. I also tested and see no reason why it 
might cause problems with such machines. I've used DMABOUNCE code to test atomic 
allocations many times and found no problems. The only issue I might suspect is 
a very limited DMA zone. CMA needs 4Mib alignment of the contiguous area base and
size to meet requirements of the memory management core (mainly for migration and
page isolation purposes), so it might not fit into some small DMA zones.

> * We want a common kernel for all ARMv6+ eventually, and a
>   separate kernel for all ARMv4/v5 ones.

I see no problem here, if required why may have even a separate dma_map_ops for
CMA and use it only for selected devices.

> 
> If the reasoning has changed, please try to explain the full
> situation. On a related topic, what happened to the idea that
> ARMv6+ is broken without CMA? I noticed that it's optional
> now.

Right. I removed unconditional dependency on CMA on Russell's request. CMA is
still experimental and there are still some known issues with it, which we are 
investigating. It doesn't make sense to make the whole architecture depending
on the experimental stuff. The old method of allocating and managing coherent
buffers was stable and worked well enough for the drivers and platforms already
present in the mainline kernel, so if one want to use stable stuff I see no 
reason to disable it.

Best regards
-- 
Marek Szyprowski
Samsung Poland R&D Center
