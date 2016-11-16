From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 16 Nov 2016 05:39:18 -0700
Subject: [PATCH] ARM64: dma-mapping: preallocate DMA-debug hash tables in
 core_initcall
In-Reply-To: <1479288013-30945-1-git-send-email-m.szyprowski@samsung.com>
References: <CGME20161116092025eucas1p2ebaf3ead7de79130ca2656d532284e5b@eucas1p2.samsung.com>
 <1479288013-30945-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <20161116123918.qzaqczaqri2hab43@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 16, 2016 at 10:20:13AM +0100, Marek Szyprowski wrote:
> fs_initcall is definitely too late to initialize DMA-debug hash tables,
> because some drivers might get probed and use DMA mapping framework
> already in core_initcall. Late initialization of DMA-debug results in
> false warning about accessing memory, that was not allocated. This issue
> has been observed on ARM 32bit, but the same driver can be used also on
> ARM64.
> 
> This patch moves initialization of DMA-debug to core_initcall. This is
> safe from the initialization perspective. dma_debug_do_init() internally
> calls debugfs functions and debugfs also gets initialised at
> core_initcall(), and that is earlier than arch code in the link order,
> so it will get initialized just before the DMA-debug.

Do we really want to rely on the link order within an initcall level?
What guarantees this?

I hope someone sorts out the deferred probe or some other dependency
detection mechanism to address this issue. But in the meantime I
wouldn't merge a patch which relies on just the link order.

-- 
Catalin
