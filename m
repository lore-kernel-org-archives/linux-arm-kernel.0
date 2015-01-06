From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 6 Jan 2015 09:38:24 +0000
Subject: [PATCH 1/2] arm64: don't make early_*map() calls post
 paging_init()
In-Reply-To: <1420482835-6444-2-git-send-email-leif.lindholm@linaro.org>
References: <1420482835-6444-1-git-send-email-leif.lindholm@linaro.org>
 <1420482835-6444-2-git-send-email-leif.lindholm@linaro.org>
Message-ID: <CAKv+Gu_EWCYYcmsLuojGGQ+6x+Lp5fWJQ+4fvR-4fqXqU2f53Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5 January 2015 at 18:33, Leif Lindholm <leif.lindholm@linaro.org> wrote:
> arm64 early_ioremap/iounmap/memremap/memunmap are not supported beyond
> the call to paging_init(), but arm64_enter_virtual_mode() (an early
> initcall) makes one call to unmap the UEFI memory map.
>
> Rearrange the code to unmap this region before paging_init().
>
> Signed-off-by: Leif Lindholm <leif.lindholm@linaro.org>
> ---
>  arch/arm64/kernel/efi.c   | 12 +++---------
>  arch/arm64/kernel/setup.c |  2 --
>  2 files changed, 3 insertions(+), 11 deletions(-)
>
> diff --git a/arch/arm64/kernel/efi.c b/arch/arm64/kernel/efi.c
> index 6fac253..790adb5 100644
> --- a/arch/arm64/kernel/efi.c
> +++ b/arch/arm64/kernel/efi.c
> @@ -317,15 +317,8 @@ void __init efi_init(void)
>                 return;
>
>         reserve_regions();
> -}
> -
> -void __init efi_idmap_init(void)
> -{
> -       if (!efi_enabled(EFI_BOOT))
> -               return;
>
> -       /* boot time idmap_pg_dir is incomplete, so fill in missing parts */
> -       efi_setup_idmap();
> +       early_memunmap(memmap.map, params.mmap_size);
>  }
>
>  static int __init remap_region(efi_memory_desc_t *md, void **new)
> @@ -380,7 +373,6 @@ static int __init arm64_enter_virtual_mode(void)
>         }
>
>         mapsize = memmap.map_end - memmap.map;
> -       early_memunmap(memmap.map, mapsize);
>
>         if (efi_runtime_disabled()) {
>                 pr_info("EFI runtime services will be disabled.\n");
> @@ -393,6 +385,8 @@ static int __init arm64_enter_virtual_mode(void)
>                                                    mapsize);
>         memmap.map_end = memmap.map + mapsize;
>
> +       efi_setup_idmap();
> +

I think this is incorrect: we may call early_alloc() here which is
only allowed before paging_init()

>         efi.memmap = &memmap;
>
>         /* Map the runtime regions */
> diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
> index b809911..c7eb3c5 100644
> --- a/arch/arm64/kernel/setup.c
> +++ b/arch/arm64/kernel/setup.c
> @@ -401,8 +401,6 @@ void __init setup_arch(char **cmdline_p)
>         paging_init();
>         request_standard_resources();
>
> -       efi_idmap_init();
> -
>         unflatten_device_tree();
>
>         psci_init();
> --
> 2.1.3
>
