From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Wed, 20 Aug 2014 09:03:52 +0200
Subject: CMA region and highmem
In-Reply-To: <20140813191811.GP30401@n2100.arm.linux.org.uk>
References: <20140813191811.GP30401@n2100.arm.linux.org.uk>
Message-ID: <53F44858.2070906@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On 2014-08-13 21:18, Russell King - ARM Linux wrote:
> Marek,
>
> Is there a reason that CMA only steals memory from lowmem, and does
> not allocate from highmem?
>
> The reason I ask is that this morning, I was greeted by this excellent
> OOM on one of my platforms.  It has 2G of memory, and no real DMA
> restrictions, and with much of the memory still available, it OOM'd
> because I need a relatively large CMA block.
>
> If CMA were pushed into highmem, this OOM would not have happened.
>
> Please don't mention anything suggesting that the reason it's in lowmem
> is because of DMA-able memory restrictions - that's a totally bogus and
> insane argument.  The highmem/lowmem split is purely a software thing
> and has nothing to do with the hardware at all.  I'll illustrate:
>
>   Take a platform with 2G of memory.  You configure it with PAGE_OFFSET
>   at 3GB.  You end up with about 760MB of lowmem, the rest as highmem.
>   Let's say (for the sake of argument) that you rely on that split,
>   beacuse you have devices which don't work with the second 1GB of
>   memory.
>
>   Now I build that same kernel, but configure PAGE_OFFSET at 1GB.  Bingo,
>   all 2G of memory is now mapped as lowmem, and there is nothing stopping
>   any of the 2G of memory being handed out for DMA purposes.
>
> Therefore, talking about highmem/lowmem in the same sentence as DMA-able
> memory is totally wrong.
>
> Anyway, back to the OOM:
...
> As you can see, there's plenty of precious lowmem still available, but
> because we only have 760MB of lowmem, from which we steal 256MB for
> CMA, this leaves around 500MB of lowmem free - and that puts quite a
> lot of pressure on lowmem.  Meanwhile, we have oodles of highmem still
> available which would be better suited to CMA - especially as CMA would
> not have to do dance around changing the page tables.
>
> Any thoughts?

There is no direct dependecy on low-mem. It was rather a heritage of initial
CMA implementation, which by design worked only with lowmem (there was no
code to allocate kernel virtual mappings from vmalloc range). The only
requirement about CMA regions is to put them entirely either in lowmem or
in highmem. I will prepare a patch swtiching default CMA region to highmem
if such is available and defined region fits into it.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
