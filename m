From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 14 Oct 2015 15:51:58 +0100
Subject: [PATCHv3 02/11] arm64: Handle section maps for swapper/idmap
In-Reply-To: <561E56D4.40506@arm.com>
References: <1444821634-1689-1-git-send-email-suzuki.poulose@arm.com>
 <1444821634-1689-3-git-send-email-suzuki.poulose@arm.com>
 <20151014120618.GB2150@leverpostej> <561E56D4.40506@arm.com>
Message-ID: <20151014145158.GA4422@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> >>+/* With 4K pages, we use section maps. */
> >>+#ifdef CONFIG_ARM64_4K_PAGES
> >>+#define ARM64_SWAPPER_USES_SECTION_MAPS 1
> >>+#else
> >>+#define ARM64_SWAPPER_USES_SECTION_MAPS 0
> >>+#endif
> >
> >The comment is somewhat redunant. It would be better to state why we do
> >this for 4K and not 64K (or 16K).
> 
> Something like :
> 
> /*
>  * ARM64 kernel is guaranteed to be loaded at 2M aligned
>  * address (as per booting requirements). Hence we can use
>  * section mapping with 4K (section size = 2M) and not with
>  * 16K(section size = 32M) or 64K (section size = 512M).
>  */

That sounds much better. I hadn't figured out why myself, so thanks for
the explanation :)

However, there's one minor nit: the start of memory below the kernel is
2M aligned, but the offset means that the kernel itself is not loaded at
a 2M aligned address.

So how about:

/*
 * The linear mapping and the start of memory are both 2M aligned (per
 * the arm64 booting.txt requirements). Hence we can use section mapping
 * with 4K (section size = 2M) but not with 16K (section size = 32M) or
 * 64K (section size = 512M).
 */

> >>+	 * us PUD_SIZE (with SECTION maps, i.e, 4K) or PMD_SIZE (without
> >>+	 * SECTION maps, i.e, 64K pages) memory starting from PHYS_OFFSET
> >>+	 * (which must be aligned to 2MB as per Documentation/arm64/booting.txt).
> >
> >This didn't seem to get updated for 16K later in the series, unless I
> >missed something.
> >
> >Perhaps drop the mention of 4K / 64K entirely here?
> 
> You are right, I missed it. We can drop the pagesize info entirely.

Ok. Sounds good.

> >>@@ -551,7 +552,7 @@ int kern_addr_valid(unsigned long addr)
> >>  	return pfn_valid(pte_pfn(*pte));
> >>  }
> >>  #ifdef CONFIG_SPARSEMEM_VMEMMAP
> >>-#ifdef CONFIG_ARM64_64K_PAGES
> >>+#if !ARM64_SWAPPER_USES_SECTION_MAPS
> >
> >This leaves the comments on the #else and #endif stale. Please update
> >those too.
> 
> Done.

Great.

Thanks,
Mark.
