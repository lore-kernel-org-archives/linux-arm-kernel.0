From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 29 Oct 2015 13:55:12 +0100
Subject: [GIT PULL] memremap fix for 4.3
In-Reply-To: <1446105610.23766.17.camel@intel.com>
References: <1446105610.23766.17.camel@intel.com>
Message-ID: <CAKv+Gu_u_kWWO7vg0_zbkARqOxan7x5COAdgO=ns8pXWVvPzFw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29 October 2015 at 17:00, Williams, Dan J <dan.j.williams@intel.com> wrote:
> Hi Linus, please pull from:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm libnvdimm-fixes
>
> ...to receive a small fixlet for 4.3.
>
> The new memremap() api introduced in the 4.3 cycle to unify/replace
> ioremap_cache() and ioremap_wt() is mishandling the highmem case.  This
> patch has received a build success notification from a 0day-kbuild-robot
> run and has been out for a review for a day.  Russell has not had a
> chance to weigh in on it yet.
>
> I do not think the usage of kmap is strictly necessary as we should be
> able to fall back to ioremap_cache(), but I include it for two reasons:
>
> 1/ ARM ioremap() will WARN if passed a pfn_valid() address.
>

It will also return NULL

> 2/ acpi_map() carries a similar kmap fallback, and that quirk can now be
> centrally carried in this common routine.
>

I *really* think we should remove the kmap() fallback. memremap() is
intended as a drop-in replacement for ioremap_cache(), and if the
latter does not allow pfn_valid() pages to be ioremap'ed() on ARM,
they shouldn't silently end up being kmap()'ed at some random time in
the future when a certain user of ioremap_cache() gets upgraded to
memremap().

Could we not merge this for 4.3 please, and give Russell and the other
ARM folks some time to chime in? In the mean time, we could fix just
the bug by adding the !PageHighmem() test in the code path that ends
up returning the __va() result of the input physical address.

Regards,
Ard.


>
> ---
>
> The following changes since commit 25cb62b76430a91cc6195f902e61c2cb84ade622:
>
>   Linux 4.3-rc5 (2015-10-11 11:09:45 -0700)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm libnvdimm-fixes
>
> for you to fetch changes up to bcaa4236b558092dd5ff14ea943e89fd944fcd28:
>
>   memremap: fix highmem support (2015-10-26 16:55:56 -0400)
>
> ----------------------------------------------------------------
> Dan Williams (1):
>       memremap: fix highmem support
>
>  include/linux/highmem.h | 12 ++++++++++++
>  kernel/memremap.c       | 28 +++++++++++++++++++++++++---
>  2 files changed, 37 insertions(+), 3 deletions(-)
>
> commit bcaa4236b558092dd5ff14ea943e89fd944fcd28
> Author: Dan Williams <dan.j.williams@intel.com>
> Date:   Mon Oct 26 16:55:56 2015 -0400
>
>     memremap: fix highmem support
>
>     Currently memremap checks if the range is "System RAM" and returns the
>     kernel linear address.  This is broken for highmem platforms where a
>     range may be "System RAM", but is not part of the kernel linear mapping.
>     Similar to acpi_map(), use kmap() for PAGE_SIZE memremap() requests for
>     highmem, and fall back to ioremap_cache() otherwise.
>
>     The impact of this bug is low for now since the pmem driver is the only
>     user of memremap(), but this is important to fix before more conversions
>     to memremap arrive in 4.4.
>
>     Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>     Reported-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>     Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>
> diff --git a/include/linux/highmem.h b/include/linux/highmem.h
> index 6aefcd0031a6..c20cf24c76dd 100644
> --- a/include/linux/highmem.h
> +++ b/include/linux/highmem.h
> @@ -41,6 +41,13 @@ void kmap_flush_unused(void);
>
>  struct page *kmap_to_page(void *addr);
>
> +static inline bool is_kmap_addr(const void *x)
> +{
> +       unsigned long addr = (unsigned long) x;
> +
> +       return addr >= PKMAP_ADDR(0) && addr < PKMAP_ADDR(LAST_PKMAP);
> +}
> +
>  #else /* CONFIG_HIGHMEM */
>
>  static inline unsigned int nr_free_highpages(void) { return 0; }
> @@ -50,6 +57,11 @@ static inline struct page *kmap_to_page(void *addr)
>         return virt_to_page(addr);
>  }
>
> +static inline bool is_kmap_addr(const void *x)
> +{
> +       return false;
> +}
> +
>  #define totalhigh_pages 0UL
>
>  #ifndef ARCH_HAS_KMAP
> diff --git a/kernel/memremap.c b/kernel/memremap.c
> index 72b0c66628b6..901d7ec3583a 100644
> --- a/kernel/memremap.c
> +++ b/kernel/memremap.c
> @@ -10,6 +10,7 @@
>   * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
>   * General Public License for more details.
>   */
> +#include <linux/highmem.h>
>  #include <linux/device.h>
>  #include <linux/types.h>
>  #include <linux/io.h>
> @@ -24,6 +25,25 @@ __weak void __iomem *ioremap_cache(resource_size_t offset, unsigned long size)
>  }
>  #endif
>
> +static void *try_ram_remap(resource_size_t offset, size_t size)
> +{
> +       struct page *page = pfn_to_page(offset >> PAGE_SHIFT);
> +       unsigned int pg_off = offset & ~PAGE_MASK;
> +
> +       /* In the simple case just return the existing linear address */
> +       if (!PageHighMem(page))
> +               return __va(offset);
> +
> +       /*
> +        * Try kmap first since some arch ioremap implementations fail when
> +        * being passed a ram address.
> +        */
> +       if (pg_off + size <= PAGE_SIZE)
> +               return kmap(page) + pg_off;
> +
> +       return NULL;
> +}
> +
>  /**
>   * memremap() - remap an iomem_resource as cacheable memory
>   * @offset: iomem resource start address
> @@ -66,8 +86,8 @@ void *memremap(resource_size_t offset, size_t size, unsigned long flags)
>                  * the requested range is potentially in "System RAM"
>                  */
>                 if (is_ram == REGION_INTERSECTS)
> -                       addr = __va(offset);
> -               else
> +                       addr = try_ram_remap(offset, size);
> +               if (!addr)
>                         addr = ioremap_cache(offset, size);
>         }
>
> @@ -94,7 +114,9 @@ EXPORT_SYMBOL(memremap);
>
>  void memunmap(void *addr)
>  {
> -       if (is_vmalloc_addr(addr))
> +       if (is_kmap_addr(addr))
> +               kunmap(addr);
> +       else if (is_vmalloc_addr(addr))
>                 iounmap((void __iomem *) addr);
>  }
>  EXPORT_SYMBOL(memunmap);
>
