From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Sat, 31 Oct 2015 07:30:30 +0100
Subject: [for 4.3-final PATCH v2] memremap: fix highmem support
In-Reply-To: <20151030201758.13415.13264.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <20151030201758.13415.13264.stgit@dwillia2-desk3.amr.corp.intel.com>
Message-ID: <CAKv+Gu91tkcEAC72oLmjLa4+0pTc9dzWveHSeGDoYZi0XRfU0g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30 October 2015 at 21:19, Dan Williams <dan.j.williams@intel.com> wrote:
> Currently memremap checks if the range is "System RAM" and returns the
> kernel linear address.  This is broken for highmem platforms where a
> range may be "System RAM", but is not part of the kernel linear mapping.
> Fallback to ioremap_cache() in these cases, to let the arch code attempt
> to handle it.
>
> Note that ARM ioremap will WARN when attempting to remap ram, and in
> that case the caller needs to be fixed.  For this reason, existing
> ioremap_cache() usages for ARM are already trained to avoid attempts to
> remap ram.
>
> The impact of this bug is low for now since the pmem driver is the only
> user of memremap(), but this is important to fix before more conversions
> to memremap arrive in 4.4.
>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Reported-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

This does still leave the issue that we assume that lowmem memory
ranges listed as 'System RAM' in /proc/iomem are always covered by the
linear mapping. Since the semantics of 'System RAM' are not documented
anywhere (as far as I know), this may not be universally true on all
architectures.


> ---
>  kernel/memremap.c |   14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/memremap.c b/kernel/memremap.c
> index 72b0c66628b6..9d6b55587eaa 100644
> --- a/kernel/memremap.c
> +++ b/kernel/memremap.c
> @@ -24,6 +24,16 @@ __weak void __iomem *ioremap_cache(resource_size_t offset, unsigned long size)
>  }
>  #endif
>
> +static void *try_ram_remap(resource_size_t offset, size_t size)
> +{
> +       struct page *page = pfn_to_page(offset >> PAGE_SHIFT);
> +
> +       /* In the simple case just return the existing linear address */
> +       if (!PageHighMem(page))
> +               return __va(offset);
> +       return NULL; /* fallback to ioremap_cache */
> +}
> +
>  /**
>   * memremap() - remap an iomem_resource as cacheable memory
>   * @offset: iomem resource start address
> @@ -66,8 +76,8 @@ void *memremap(resource_size_t offset, size_t size, unsigned long flags)
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
>
