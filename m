From: pullip.cho@samsung.com (KyongHo Cho)
Date: Fri, 15 Apr 2011 11:24:16 +0900
Subject: [PATCH] OMAP: iommu flush page table entries from L1 and L2 cache
In-Reply-To: <20110414223036.GA7335@n2100.arm.linux.org.uk>
References: <1302817968-28516-1-git-send-email-fernando.lugo@ti.com>
	<20110414223036.GA7335@n2100.arm.linux.org.uk>
Message-ID: <BANLkTikfXbtsqaw5ZuP_BbDCtsxXOHZs_w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Russell.

I think we need cache maintenance operations that effect on inner and
outer caches at the same time.

Even though the DMA APIs are not for cache maintenance but for IO mapping,
they are useful for cache maint'
because they operate on inner and outer caches.

As you know, inner cache of Cortex-A is logical cache and outer cache
is physical cache in the programmer's point of view.
We need logical address and physical address at the same time to clean
or invalidate inner and outer cache.
That means we need to translate logical to physical address and it is
sometimes not trivial.

Finally, the kernel will contain many similar routines that do same thing.

On Fri, Apr 15, 2011 at 7:30 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Thu, Apr 14, 2011 at 04:52:48PM -0500, Fernando Guzman Lugo wrote:
>> From: Ramesh Gupta <grgupta@ti.com>
>>
>> This patch is to flush the iommu page table entries from L1 and L2
>> caches using dma_map_single. This also simplifies the implementation
>> by removing the functions ?flush_iopgd_range/flush_iopte_range.
>
> No. ?This usage is just wrong. ?If you're going to use the DMA API then
> unmap it, otherwise the DMA API debugging will go awol.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at ?http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at ?http://www.tux.org/lkml/
>
