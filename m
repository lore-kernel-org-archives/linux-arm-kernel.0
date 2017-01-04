From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 4 Jan 2017 13:56:39 +0000
Subject: [PATCH v3] arm64: mm: Fix NOMAP page initialization
In-Reply-To: <20161216165437.21612-1-rrichter@cavium.com>
References: <20161216165437.21612-1-rrichter@cavium.com>
Message-ID: <CAKv+Gu_SmTNguC=tSCwYOL2kx-DogLvSYRZc56eGP=JhdrUOsA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16 December 2016 at 16:54, Robert Richter <rrichter@cavium.com> wrote:
> On ThunderX systems with certain memory configurations we see the
> following BUG_ON():
>
>  kernel BUG at mm/page_alloc.c:1848!
>
> This happens for some configs with 64k page size enabled. The BUG_ON()
> checks if start and end page of a memmap range belongs to the same
> zone.
>
> The BUG_ON() check fails if a memory zone contains NOMAP regions. In
> this case the node information of those pages is not initialized. This
> causes an inconsistency of the page links with wrong zone and node
> information for that pages. NOMAP pages from node 1 still point to the
> mem zone from node 0 and have the wrong nid assigned.
>
> The reason for the mis-configuration is a change in pfn_valid() which
> reports pages marked NOMAP as invalid:
>
>  68709f45385a arm64: only consider memblocks with NOMAP cleared for linear mapping
>
> This causes pages marked as nomap being no longer reassigned to the
> new zone in memmap_init_zone() by calling __init_single_pfn().
>
> Fixing this by implementing an arm64 specific early_pfn_valid(). This
> causes all pages of sections with memory including NOMAP ranges to be
> initialized by __init_single_page() and ensures consistency of page
> links to zone, node and section.
>

I like this solution a lot better than the first one, but I am still
somewhat uneasy about having the kernel reason about attributes of
pages it should not touch in the first place. But the fact that
early_pfn_valid() is only used a single time in the whole kernel does
give some confidence that we are not simply moving the problem
elsewhere.

Given that you are touching arch/arm/ as well as arch/arm64, could you
explain why only arm64 needs this treatment? Is it simply because we
don't have NUMA support there?

Considering that Hisilicon D05 suffered from the same issue, I would
like to get some coverage there as well. Hanjun, is this something you
can arrange? Thanks


> The HAVE_ARCH_PFN_VALID config option now requires an explicit
> definiton of early_pfn_valid() in the same way as pfn_valid(). This
> allows a customized implementation of early_pfn_valid() which
> redirects to valid_section() for arm64. This is the same as for the
> generic pfn_valid() implementation.
>
> v3:
>
>  * Use valid_section() which is the same as the default pfn_valid()
>    implementation to initialize
>  * Added Ack for arm/ changes.
>
> v2:
>
>  * Use pfn_present() instead of memblock_is_memory() to support also
>    non-memory NOMAP holes
>
> Acked-by: Russell King <rmk+kernel@armlinux.org.uk>
> Signed-off-by: Robert Richter <rrichter@cavium.com>
> ---
>  arch/arm/include/asm/page.h   |  1 +
>  arch/arm64/include/asm/page.h |  2 ++
>  arch/arm64/mm/init.c          | 15 +++++++++++++++
>  include/linux/mmzone.h        |  5 ++++-
>  4 files changed, 22 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/include/asm/page.h b/arch/arm/include/asm/page.h
> index 4355f0ec44d6..79761bd55f94 100644
> --- a/arch/arm/include/asm/page.h
> +++ b/arch/arm/include/asm/page.h
> @@ -158,6 +158,7 @@ typedef struct page *pgtable_t;
>
>  #ifdef CONFIG_HAVE_ARCH_PFN_VALID
>  extern int pfn_valid(unsigned long);
> +#define early_pfn_valid(pfn)   pfn_valid(pfn)
>  #endif
>
>  #include <asm/memory.h>
> diff --git a/arch/arm64/include/asm/page.h b/arch/arm64/include/asm/page.h
> index 8472c6def5ef..17ceb7435ded 100644
> --- a/arch/arm64/include/asm/page.h
> +++ b/arch/arm64/include/asm/page.h
> @@ -49,6 +49,8 @@ typedef struct page *pgtable_t;
>
>  #ifdef CONFIG_HAVE_ARCH_PFN_VALID
>  extern int pfn_valid(unsigned long);
> +extern int early_pfn_valid(unsigned long);
> +#define early_pfn_valid early_pfn_valid
>  #endif
>
>  #include <asm/memory.h>
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index 212c4d1e2f26..8ff62a7ff634 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -145,11 +145,26 @@ static void __init zone_sizes_init(unsigned long min, unsigned long max)
>  #endif /* CONFIG_NUMA */
>
>  #ifdef CONFIG_HAVE_ARCH_PFN_VALID
> +
>  int pfn_valid(unsigned long pfn)
>  {
>         return memblock_is_map_memory(pfn << PAGE_SHIFT);
>  }
>  EXPORT_SYMBOL(pfn_valid);
> +
> +/*
> + * This is the same as the generic pfn_valid() implementation. We use
> + * valid_section() here to make sure all pages of a section including
> + * NOMAP pages are initialized with __init_single_page().
> + */
> +int early_pfn_valid(unsigned long pfn)
> +{
> +       if (pfn_to_section_nr(pfn) >= NR_MEM_SECTIONS)
> +               return 0;
> +       return valid_section(__nr_to_section(pfn_to_section_nr(pfn)));
> +}
> +EXPORT_SYMBOL(early_pfn_valid);
> +
>  #endif
>
>  #ifndef CONFIG_SPARSEMEM
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index 0f088f3a2fed..bedcf8a95881 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -1170,12 +1170,16 @@ static inline struct mem_section *__pfn_to_section(unsigned long pfn)
>  }
>
>  #ifndef CONFIG_HAVE_ARCH_PFN_VALID
> +
>  static inline int pfn_valid(unsigned long pfn)
>  {
>         if (pfn_to_section_nr(pfn) >= NR_MEM_SECTIONS)
>                 return 0;
>         return valid_section(__nr_to_section(pfn_to_section_nr(pfn)));
>  }
> +
> +#define early_pfn_valid(pfn)   pfn_valid(pfn)
> +
>  #endif
>
>  static inline int pfn_present(unsigned long pfn)
> @@ -1200,7 +1204,6 @@ static inline int pfn_present(unsigned long pfn)
>  #define pfn_to_nid(pfn)                (0)
>  #endif
>
> -#define early_pfn_valid(pfn)   pfn_valid(pfn)
>  void sparse_init(void);
>  #else
>  #define sparse_init()  do {} while (0)
> --
> 2.11.0
>
