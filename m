From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 20 Nov 2015 19:31:21 +0100
Subject: [PATCHv2] arm64: efi: correctly map runtime regions
In-Reply-To: <1448032353-8770-1-git-send-email-mark.rutland@arm.com>
References: <1448032353-8770-1-git-send-email-mark.rutland@arm.com>
Message-ID: <CAKv+Gu8XKpZFdRAGTz2FaptzARN+qDLhxgNQYz+_ypHT9TAOgg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20 November 2015 at 16:12, Mark Rutland <mark.rutland@arm.com> wrote:
> The kernel may use a page granularity of 4K, 16K, or 64K depending on
> configuration.
>
> When mapping EFI runtime regions, we use memrange_efi_to_native to round
> the physical base address of a region down to a kernel page boundary,
> and round the size up to a kernel page boundary, adding the residue left
> over from rounding down the physical base address. We do not round down
> the virtual base address.
>
> In __create_mapping we account for the offset of the virtual base from a
> granule boundary, adding the residue to the size before rounding the
> base down to said granule boundary.
>
> Thus we account for the residue twice, and when the residue is non-zero
> will cause __create_mapping to map an additional page at the end of the
> region. Depending on the memory map, this page may be in a region we are
> not intended/permitted to map, or may clash with a different region that
> we which to map.
>

wish

It is worth to note that, since the memory map is virtually always
sorted in ascending order (especially now that we sort it explicitly
in the stub), this is highly unlikely to cause trouble in practice,
since the additional page mapping is always at the top, and will be
corrected as it is overwritten by the subsequent entry. The page
tables are not active at this stage, so there are no concerns
regarding break-before-make etc. Obviously, we should still fix it.

> As __create_mapping can cope with base addresses which are not page
> aligned, we can instead rely on it to map the region appropriately, and
> simplify efi_virtmap_init by removing the unnecessary code.
>
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Leif Lindholm <leif.lindholm@linaro.org>
> Cc: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm64/kernel/efi.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm64/kernel/efi.c b/arch/arm64/kernel/efi.c
> index de46b50..25b82d8 100644
> --- a/arch/arm64/kernel/efi.c
> +++ b/arch/arm64/kernel/efi.c
> @@ -225,7 +225,7 @@ static bool __init efi_virtmap_init(void)
>         efi_memory_desc_t *md;
>
>         for_each_efi_memory_desc(&memmap, md) {
> -               u64 paddr, npages, size;
> +               u64 size;

I would have dropped 'size' entirely, and use the expression as the
function argument directly, but this is also fine by me.

In either case:
Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

>                 pgprot_t prot;
>
>                 if (!(md->attribute & EFI_MEMORY_RUNTIME))
> @@ -233,10 +233,7 @@ static bool __init efi_virtmap_init(void)
>                 if (md->virt_addr == 0)
>                         return false;
>
> -               paddr = md->phys_addr;
> -               npages = md->num_pages;
> -               memrange_efi_to_native(&paddr, &npages);
> -               size = npages << PAGE_SHIFT;
> +               size = md->num_pages << EFI_PAGE_SHIFT;
>
>                 pr_info("  EFI remap 0x%016llx => %p\n",
>                         md->phys_addr, (void *)md->virt_addr);
> @@ -254,7 +251,8 @@ static bool __init efi_virtmap_init(void)
>                 else
>                         prot = PAGE_KERNEL;
>
> -               create_pgd_mapping(&efi_mm, paddr, md->virt_addr, size, prot);
> +               create_pgd_mapping(&efi_mm, md->phys_addr, md->virt_addr,
> +                                  size, prot);
>         }
>         return true;
>  }
> --
> 1.9.1
>
