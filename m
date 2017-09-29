From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Fri, 29 Sep 2017 14:13:50 +0200
Subject: [PATCH 3/4] iommu/arm-smmu-v3: Use NUMA memory allocations for
 stream tables and comamnd queues
In-Reply-To: <db28d6ff-77e5-ed59-c1b8-57c917564a68@arm.com>
References: <20170921085922.11659-1-ganapatrao.kulkarni@cavium.com>
 <20170921085922.11659-4-ganapatrao.kulkarni@cavium.com>
 <CGME20170921115811epcas5p49012d8793fc765bb86830bfc377b6d36@epcas5p4.samsung.com>
 <db28d6ff-77e5-ed59-c1b8-57c917564a68@arm.com>
Message-ID: <7e270ffc-963c-c1c7-410c-ff3c2e767984@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Robin,

On 2017-09-21 13:58, Robin Murphy wrote:
> [+Christoph and Marek]
>
> On 21/09/17 09:59, Ganapatrao Kulkarni wrote:
>> Introduce smmu_alloc_coherent and smmu_free_coherent functions to
>> allocate/free dma coherent memory from NUMA node associated with SMMU.
>> Replace all calls of dmam_alloc_coherent with smmu_alloc_coherent
>> for SMMU stream tables and command queues.
> This doesn't work - not only do you lose the 'managed' aspect and risk
> leaking various tables on probe failure or device removal, but more
> importantly, unless you add DMA syncs around all the CPU accesses to the
> tables, you lose the critical 'coherent' aspect, and that's a horribly
> invasive change that I really don't want to make.
>
> Christoph, Marek; how reasonable do you think it is to expect
> dma_alloc_coherent() to be inherently NUMA-aware on NUMA-capable
> systems? SWIOTLB looks fairly straightforward to fix up (for the simple
> allocation case; I'm not sure it's even worth it for bounce-buffering),
> but the likes of CMA might be a little trickier...

I'm not sure if there is any dma-coherent implementation that is NUMA aware.

Maybe author should provide some benchmarks, which show that those 
structures
should be allocated in NUMA-aware way?

On the other hand it is not that hard to add required dma_sync_* calls 
around
all the code which updated those tables.

 > ...

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
