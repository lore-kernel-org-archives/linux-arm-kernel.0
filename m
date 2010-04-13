From: saeed.bishara@gmail.com (saeed bishara)
Date: Tue, 13 Apr 2010 10:11:44 +0300
Subject: [PATCH] ARM: fix highmem with VIPT cache and DMA
In-Reply-To: <alpine.LFD.2.00.1004121122050.7232@xanadu.home>
References: <alpine.LFD.2.00.1003251638030.694@xanadu.home>
	<1269610458.807.49.camel@e102109-lin.cambridge.arm.com>
	<alpine.LFD.2.00.1003261144020.694@xanadu.home>
	<alpine.LFD.2.00.1004111033010.7232@xanadu.home>
	<w2hc70ff3ad1004120056za5960033ja97e2046d17a7f24@mail.gmail.com>
	<alpine.LFD.2.00.1004121122050.7232@xanadu.home>
Message-ID: <o2oc70ff3ad1004130011qb51b90a2p3267a8ab04917b05@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

thanks. attached fixed version.

On Mon, Apr 12, 2010 at 6:36 PM, Nicolas Pitre <nico@fluxnic.net> wrote:
> On Mon, 12 Apr 2010, saeed bishara wrote:
>
>> Nico, thanks for the patch.
>> I've ported it for 2.6.32.9 kernel, can you have a look at the
>> attached patch?
>
> That patch is bad.
>
> |diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
> |index b9590a7..5286d71 100644
> |--- a/arch/arm/mm/dma-mapping.c
> |+++ b/arch/arm/mm/dma-mapping.c
> |@@ -602,6 +602,11 @@ static void dma_cache_maint_contiguous(struct page *page, unsigned long offset,
> | ? ? ? ? ? ? ? ? ? ? ? vaddr += offset;
> | ? ? ? ? ? ? ? ? ? ? ? inner_op(vaddr, vaddr + size);
> | ? ? ? ? ? ? ? ? ? ? ? kunmap_high(page);
> |+ ? ? ? ? ? ? ?} else if (cache_is_vipt()) {
> |+ ? ? ? ? ? ? ? ? ? ? ?pte_t saved_pte;
> |+ ? ? ? ? ? ? ? ? ? ? ?vaddr = kmap_high_l1_vipt(page, &saved_pte);
> |+ ? ? ? ? ? ? ? ? ? ? ?inner_op(vaddr, vaddr + size);
> |+ ? ? ? ? ? ? ? ? ? ? ?kunmap_high_l1_vipt(page, saved_pte);
> | ? ? ? ? ? ? ? }
> | ? ? ? }
>
> You should add 'offset' to 'vaddr' before passing it to inner_op(), just
> like it is done 6 lines above it.
>
> Also you left out the addition of the unconditional flush in
> v6_copy_user_highpage_nonaliasing() which is needed now that
> kunmap_atomic() doesn't flush the cache anymore on ARMv6.
>
>
> Nicolas
>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-ARM-fix-highmem-with-VIPT-cache-and-DMA.patch
Type: text/x-patch
Size: 9460 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100413/aeab5cb4/attachment.bin>
