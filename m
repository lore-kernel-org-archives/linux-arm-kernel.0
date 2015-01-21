From: s.dyasly@samsung.com (Sergey Dyasly)
Date: Wed, 21 Jan 2015 09:52:57 +0300
Subject: [RFC][PATCH RESEND] mm: vmalloc: remove ioremap align constraint
In-Reply-To: <5891256.RkdjYUxedq@wuerfel>
References: <1419328813-2211-1-git-send-email-d.safonov@partner.samsung.com>
 <11656044.WGcPr1b8t8@wuerfel>
 <20150103185946.1d4fad32bb3de9ac9bdcfb88@gmail.com>
 <5891256.RkdjYUxedq@wuerfel>
Message-ID: <20150121095257.ce97fb984ed7b9572cb1cc6a@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 04 Jan 2015 17:38:06 +0100
Arnd Bergmann <arnd@arndb.de> wrote:

> On Saturday 03 January 2015 18:59:46 Sergey Dyasly wrote:
> > Hi Arnd,
> > 
> > First, some background information. We originally encountered high fragmentation
> > issue in vmalloc area:
> > 
> > 	1. Total size of vmalloc area was 400 MB.
> > 	2. 200 MB of vmalloc area was consumed by ioremaps of various sizes.
> > 	3. Largest contiguous chunk of vmalloc area was 12 MB.
> > 	4. ioremap of 10 MB failed due to 8 MB alignment requirement.
> 
> Interesting, can you describe how you end up with that many ioremap mappings?
> 200MB seems like a lot. Do you perhaps get a lot of duplicate entries for the
> same hardware registers, or maybe a leak?
> 
> Can you send the output of /proc/vmallocinfo?
>  
> > It was decided to further increase the size of vmalloc area to resolve the above
> > issue. And I don't like that solution because it decreases the amount of lowmem.
> 
> If all the mappings are in fact required, have you considered using
> CONFIG_VMSPLIT_2G split to avoid the use of highmem?
> 
> > Now let's see how ioremap uses supersections. Judging from current implementation
> > of __arm_ioremap_pfn_caller:
> > 
> > 	#if !defined(CONFIG_SMP) && !defined(CONFIG_ARM_LPAE)
> > 		if (pfn >= 0x100000 && !((paddr | size | addr) & ~SUPERSECTION_MASK)) {
> > 			remap_area_supersections();
> > 		} else if (!((paddr | size | addr) & ~PMD_MASK)) {
> > 			remap_area_sections();
> > 		} else
> > 	#endif
> > 			err = ioremap_page_range();
> > 
> > supersections and sections mappings are used only in !SMP && !LPAE case.
> > Otherwise, mapping is created using the usual 4K pages (and we are using SMP).
> > The suggested patch removes alignment requirements for ioremap but it means that
> > sections will not be used in !SMP case. So another solution is required.
> > 
> > __get_vm_area_node has align parameter, maybe it can be used to specify the
> > required alignment of ioremap operation? Because I find current generic fls
> > algorithm to be very restrictive in cases when it's not necessary to use such
> > a big alignment.
> 
> I think using next-power-of-two alignment generally helps limit the effects of
> fragmentation the same way that the buddy allocator works.
> 
> Since the section and supersection maps are only used with non-SMP non-LPAE
> (why is that the case btw?),

vmap/vunmap mechanism works that way. ARM is using 2 levels of page tables:
PGD and PTE; and that provides the needed level of indirection. Every mm
contains a copy of init_mm's pgd mappings for kernel and they point to the same
set of PTEs. vmap/vunmap manipulates only with *pgd->pte and the change becomes
visible to every mm. This is impossible to do for sections because they use
PGD entries directly.

> it would however make sense to use the default
> (7 + PAGE_SHIFT) instead of the ARM-specific 24 here if one of them is set,
> I don't see any downsides to that.

This makes sense. I'll prepare a patch for that.

> 
> 	Arnd


-- 
Sergey Dyasly <s.dyasly@samsung.com>
