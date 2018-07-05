From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 6 Jul 2018 00:26:16 +0200
Subject: [PATCH v2 2/4] efi/arm: map UEFI memory map even w/o runtime
 services enabled
In-Reply-To: <20180619064424.6642-3-takahiro.akashi@linaro.org>
References: <20180619064424.6642-1-takahiro.akashi@linaro.org>
 <20180619064424.6642-3-takahiro.akashi@linaro.org>
Message-ID: <CAKv+Gu8m6DafSohjodBe324=UdubrPRLxGVGfTqOxhJ7FYK5Bg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19 June 2018 at 08:44, AKASHI Takahiro <takahiro.akashi@linaro.org> wrote:
> Under the current implementation, UEFI memory map will be mapped and made
> available in virtual mappings only if runtime services are enabled.
> But in a later patch, we want to use UEFI memory map in acpi_os_ioremap()
> to create mappings of ACPI tables using memory attributes described in
> UEFI memory map.
>
> So, as a first step, arm_enter_runtime_services() will be modified
> so that UEFI memory map will be always accessible.
>
> See a relevant commit:
>     arm64: acpi: fix alignment fault in accessing ACPI tables
>
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

This may be taken via the arm64 tree.

> ---
>  drivers/firmware/efi/arm-runtime.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/firmware/efi/arm-runtime.c b/drivers/firmware/efi/arm-runtime.c
> index 5889cbea60b8..30ac5c82051e 100644
> --- a/drivers/firmware/efi/arm-runtime.c
> +++ b/drivers/firmware/efi/arm-runtime.c
> @@ -115,6 +115,13 @@ static int __init arm_enable_runtime_services(void)
>                 return 0;
>         }
>
> +       mapsize = efi.memmap.desc_size * efi.memmap.nr_map;
> +
> +       if (efi_memmap_init_late(efi.memmap.phys_map, mapsize)) {
> +               pr_err("Failed to remap EFI memory map\n");
> +               return 0;
> +       }
> +
>         if (efi_runtime_disabled()) {
>                 pr_info("EFI runtime services will be disabled.\n");
>                 return 0;
> @@ -127,13 +134,6 @@ static int __init arm_enable_runtime_services(void)
>
>         pr_info("Remapping and enabling EFI services.\n");
>
> -       mapsize = efi.memmap.desc_size * efi.memmap.nr_map;
> -
> -       if (efi_memmap_init_late(efi.memmap.phys_map, mapsize)) {
> -               pr_err("Failed to remap EFI memory map\n");
> -               return -ENOMEM;
> -       }
> -
>         if (!efi_virtmap_init()) {
>                 pr_err("UEFI virtual mapping missing or invalid -- runtime services will not be available\n");
>                 return -ENOMEM;
> --
> 2.17.0
>
