From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 2 Jul 2014 12:13:24 +0200
Subject: [PATCH 1/2] efi/arm64: fix potential NULL dereference of
 efi.systab
In-Reply-To: <1404295802-28030-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1404295802-28030-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <CAKv+Gu-SLQC82q7Rj5ZusbFxwysy7KpRhZ=vw1ipXu9kvq46aQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> On 2 July 2014 12:10, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> We assign efi.systab using efi_lookup_mapped_addr(), and test for !NULL, but
> then go on an dereference it anyway.
>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  arch/arm64/kernel/efi.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/kernel/efi.c b/arch/arm64/kernel/efi.c
> index 56c3327bbf79..e785f93f17cb 100644
> --- a/arch/arm64/kernel/efi.c
> +++ b/arch/arm64/kernel/efi.c
> @@ -419,8 +419,11 @@ static int __init arm64_enter_virtual_mode(void)
>         }
>
>         efi.systab = (__force void *)efi_lookup_mapped_addr(efi_system_table);
> -       if (efi.systab)
> -               set_bit(EFI_SYSTEM_TABLES, &efi.flags);
> +       if (!efi.systab) {
> +               pr_err("Failed to remap EFI System Table!\n");

... this needs a kfree(virtmap) as well.

> +               return -1;
> +       }
> +       set_bit(EFI_SYSTEM_TABLES, &efi.flags);
>
>         local_irq_save(flags);
>         cpu_switch_mm(idmap_pg_dir, &init_mm);
> --
> 1.8.3.2
>
