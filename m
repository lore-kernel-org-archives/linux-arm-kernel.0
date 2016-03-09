From: rric@kernel.org (Robert Richter)
Date: Wed, 9 Mar 2016 12:32:14 +0100
Subject: [PATCH v2 1/2] arm64: vmemmap: use virtual projection of linear
 region
In-Reply-To: <CAKv+Gu9mwj0qscQJSH8wEi0zYC0anrr1hBYbdFE83iN+oQLnRQ@mail.gmail.com>
References: <1456505834-8638-1-git-send-email-ard.biesheuvel@linaro.org>
 <1456505834-8638-2-git-send-email-ard.biesheuvel@linaro.org>
 <56DE25DD.4010401@gmail.com>
 <E540D948-6371-4F71-A8B6-025BC39A0515@linaro.org>
 <CAKv+Gu9mwj0qscQJSH8wEi0zYC0anrr1hBYbdFE83iN+oQLnRQ@mail.gmail.com>
Message-ID: <20160309113214.GB1535@rric.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08.03.16 17:31:05, Ard Biesheuvel wrote:
> On 8 March 2016 at 09:15, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> >
> >
> >> On 8 mrt. 2016, at 08:07, David Daney <ddaney.cavm@gmail.com> wrote:
> >>
> >>> On 02/26/2016 08:57 AM, Ard Biesheuvel wrote:
> >>> Commit dd006da21646 ("arm64: mm: increase VA range of identity map") made
> >>> some changes to the memory mapping code to allow physical memory to reside
> >>> at an offset that exceeds the size of the virtual mapping.
> >>>
> >>> However, since the size of the vmemmap area is proportional to the size of
> >>> the VA area, but it is populated relative to the physical space, we may
> >>> end up with the struct page array being mapped outside of the vmemmap
> >>> region. For instance, on my Seattle A0 box, I can see the following output
> >>> in the dmesg log.
> >>>
> >>>    vmemmap : 0xffffffbdc0000000 - 0xffffffbfc0000000   (     8 GB maximum)
> >>>              0xffffffbfc0000000 - 0xffffffbfd0000000   (   256 MB actual)
> >>>
> >>> We can fix this by deciding that the vmemmap region is not a projection of
> >>> the physical space, but of the virtual space above PAGE_OFFSET, i.e., the
> >>> linear region. This way, we are guaranteed that the vmemmap region is of
> >>> sufficient size, and we can even reduce the size by half.
> >>>
> >>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> >>
> >> I see this commit now in Linus' kernel.org tree in v4.5-rc7.
> >>
> >> FYI:  I am seeing a crash that goes away when I revert this.  My kernel has some other modifications (our NUMA patches) so I haven't yet fully tracked this down on an unmodified kernel, but this is what I am getting:
> >>
> >
> 
> I managed to reproduce and diagnose this. The problem is that vmemmap
> is no longer zone aligned, which causes trouble in the zone based
> rounding that occurs in memory_present. The below patch fixes this by
> rounding down the subtracted offset. Since this implies that the
> region could stick off the other end, it also reverts the halving of
> the region size.

I have seen the same panic. The fix solves the problem. See enclosed
diff for reference as there was some patch corruption of the original.

Thanks,

-Robert


>From 562760cc30905748cb851cc9aee2bb9d88c67d47 Mon Sep 17 00:00:00 2001
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Tue, 8 Mar 2016 17:31:05 +0700
Subject: [PATCH] arm64: vmemmap: Fix use virtual projection of linear region

Signed-off-by: Robert Richter <rrichter@cavium.com>
---
 arch/arm64/include/asm/pgtable.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index d9de87354869..98697488650f 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -40,7 +40,7 @@
  * VMALLOC_END: extends to the available space below vmmemmap, PCI I/O space,
  *	fixed mappings and modules
  */
-#define VMEMMAP_SIZE		ALIGN((1UL << (VA_BITS - PAGE_SHIFT - 1)) * sizeof(struct page), PUD_SIZE)
+#define VMEMMAP_SIZE		ALIGN((1UL << (VA_BITS - PAGE_SHIFT)) * sizeof(struct page), PUD_SIZE)
 
 #ifndef CONFIG_KASAN
 #define VMALLOC_START		(VA_START)
@@ -52,7 +52,7 @@
 #define VMALLOC_END		(PAGE_OFFSET - PUD_SIZE - VMEMMAP_SIZE - SZ_64K)
 
 #define VMEMMAP_START		(VMALLOC_END + SZ_64K)
-#define vmemmap			((struct page *)VMEMMAP_START - (memstart_addr >> PAGE_SHIFT))
+#define vmemmap			((struct page *)VMEMMAP_START - ((memstart_addr >> PAGE_SHIFT) & PAGE_SECTION_MASK))
 
 #define FIRST_USER_ADDRESS	0UL
 
-- 
2.7.0.rc3



> 
> 
> --------8<----------
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index f50608674580..ed57c0865290 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -40,7 +40,7 @@
>   * VMALLOC_END: extends to the available space below vmmemmap, PCI I/O space,
>   *     fixed mappings and modules
>   */
> -#define VMEMMAP_SIZE           ALIGN((1UL << (VA_BITS - PAGE_SHIFT -
> 1)) * sizeof(struct page), PUD_SIZE)
> +#define VMEMMAP_SIZE           ALIGN((1UL << (VA_BITS - PAGE_SHIFT))
> * sizeof(struct page), PUD_SIZE)
> 
>  #ifndef CONFIG_KASAN
>  #define VMALLOC_START          (VA_START)
> @@ -52,7 +52,8 @@
>  #define VMALLOC_END            (PAGE_OFFSET - PUD_SIZE - VMEMMAP_SIZE - SZ_64K)
> 
>  #define VMEMMAP_START          (VMALLOC_END + SZ_64K)
> -#define vmemmap                        ((struct page *)VMEMMAP_START
> - (memstart_addr >> PAGE_SHIFT))
> +#define vmemmap                        ((struct page *)VMEMMAP_START - \
> +                               ((memstart_addr >> PAGE_SHIFT) &
> PAGE_SECTION_MASK))
> 
>  #define FIRST_USER_ADDRESS     0UL
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
