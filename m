From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Thu, 17 Nov 2016 12:35:11 +0100
Subject: [PATCH] ARM64: dma-mapping: preallocate DMA-debug hash tables in
 core_initcall
In-Reply-To: <20161116123918.qzaqczaqri2hab43@localhost>
References: <CGME20161116092025eucas1p2ebaf3ead7de79130ca2656d532284e5b@eucas1p2.samsung.com>
 <1479288013-30945-1-git-send-email-m.szyprowski@samsung.com>
 <20161116123918.qzaqczaqri2hab43@localhost>
Message-ID: <6d01cd35-99b2-432a-4c48-6c130cd69357@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Catalin,


On 2016-11-16 13:39, Catalin Marinas wrote:
> On Wed, Nov 16, 2016 at 10:20:13AM +0100, Marek Szyprowski wrote:
>> fs_initcall is definitely too late to initialize DMA-debug hash tables,
>> because some drivers might get probed and use DMA mapping framework
>> already in core_initcall. Late initialization of DMA-debug results in
>> false warning about accessing memory, that was not allocated. This issue
>> has been observed on ARM 32bit, but the same driver can be used also on
>> ARM64.
>>
>> This patch moves initialization of DMA-debug to core_initcall. This is
>> safe from the initialization perspective. dma_debug_do_init() internally
>> calls debugfs functions and debugfs also gets initialised at
>> core_initcall(), and that is earlier than arch code in the link order,
>> so it will get initialized just before the DMA-debug.
> Do we really want to rely on the link order within an initcall level?
> What guarantees this?

There are many places in the kernel which rely on link order and I'm 
convinced
that calling initcalls in link order is guaranteed.

> I hope someone sorts out the deferred probe or some other dependency
> detection mechanism to address this issue. But in the meantime I
> wouldn't merge a patch which relies on just the link order.

This has nothing to deferred probe. This patch is related to initialization
of dma-debug framework. In my initial submission for ARM arch I proposed
pure_initcall to have this infrastructure available as early as possible,
but Russell pointed that dma-debug depends on debugfs initialization, so
it should be initialized after it. He also pointed that core_initcall will
be fine for this.

Please also note that dt devices are also populated from core_initcall and
drivers can then bind to them and try to use dma-mapping api, what results
in false warnings about using uninitialized memory as dma-debug framework
is unable to track allocations done before its initialization.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
