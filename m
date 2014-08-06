From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 6 Aug 2014 14:40:25 +0200
Subject: [PATCH 1/2] UEFI arm64: add noefi boot param
In-Reply-To: <20140806083825.GA31711@dhcp-16-198.nay.redhat.com>
References: <20140806083825.GA31711@dhcp-16-198.nay.redhat.com>
Message-ID: <CAKv+Gu83+OtTkM+tEkB4AKpqHg2qGXtfAxC-pQq0u9ez+VjwaA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6 August 2014 10:38, Dave Young <dyoung@redhat.com> wrote:
>
> Adding a noefi boot param like in X86 to disable efi runtime services support.
>
> This will be useful for debugging uefi problems. Also it will be useful
> for later kexec/kdump work. Kexec on uefi support in X86 depends on a fixed vm
> area specific for uefi runtime 1:1 mapping, kernel will switch to a different
> page table for any uefi runtime callback in virtual mode. In arm64 similar
> work probably is necessary. But kexec boot will just works with 'noefi' with
> the limitaion of lacking runtime services. The runtime services is not critical
> for kdump kernel for now. So as for kexec/kdump just leave the 1:1 mapping a
> future work.
>

Can we find a better name? You will still be using the UEFI memory map
rather than the DT memory nodes (which will have been deleted by the
stub), and things like SMBIOS and ACPI that hinge off UEFI remain
enabled as well.

Other than that, the patch looks fine to me

Regards,
Ard.


> Signed-off-by: Dave Young <dyoung@redhat.com>
> ---
>  arch/arm64/kernel/efi.c |   17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
>
> Index: linux-2.6/arch/arm64/kernel/efi.c
> ===================================================================
> --- linux-2.6.orig/arch/arm64/kernel/efi.c
> +++ linux-2.6/arch/arm64/kernel/efi.c
> @@ -31,6 +31,14 @@ static efi_runtime_services_t *runtime;
>
>  static u64 efi_system_table;
>
> +static bool disable_runtime __initdata = false;
> +static int __init setup_noefi(char *arg)
> +{
> +       disable_runtime = true;
> +       return 0;
> +}
> +early_param("noefi", setup_noefi);
> +
>  static int uefi_debug __initdata;
>  static int __init uefi_debug_setup(char *str)
>  {
> @@ -391,11 +399,14 @@ static int __init arm64_enter_virtual_mo
>                 return -1;
>         }
>
> -       pr_info("Remapping and enabling EFI services.\n");
> -
> -       /* replace early memmap mapping with permanent mapping */
>         mapsize = memmap.map_end - memmap.map;
>         early_memunmap(memmap.map, mapsize);
> +
> +       if (disable_runtime)
> +               return -ENODEV;
> +
> +       pr_info("Remapping and enabling EFI services.\n");
> +       /* replace early memmap mapping with permanent mapping */
>         memmap.map = (__force void *)ioremap_cache((phys_addr_t)memmap.phys_map,
>                                                    mapsize);
>         memmap.map_end = memmap.map + mapsize;
