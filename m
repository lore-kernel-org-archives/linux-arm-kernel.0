From: robh@kernel.org (Rob Herring)
Date: Tue, 10 Mar 2015 16:47:27 -0500
Subject: [PATCH 1/5] of/fdt: allow FDT virtual address outside of linear
 direct mapping
In-Reply-To: <1425380630-3684-2-git-send-email-ard.biesheuvel@linaro.org>
References: <1425380630-3684-1-git-send-email-ard.biesheuvel@linaro.org>
 <1425380630-3684-2-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <CAL_JsqL=hgQWM93tgp3cCWU290-fbj37LtvqLWFo+vPFVYws3A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 3, 2015 at 5:03 AM, Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
> The early FDT code reserves the physical region that contains the
> FDT, and uses __pa() to calculate the FDT's physical address.
> However, if the FDT is mapped outside of the linear direct mapping,
> __pa() cannot be used.
>
> So create a __weak default wrapper called fdt_virt_to_phys() around
> __pa(), and use that instead. This allows architectures to drop in
> their own virt/phys mapping for the FDT blob.
>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>
> I am aware that __weak functions are generally frowned upon, but in this
> case, I wonder if it is worth the trouble to add arch specific header files
> so we can include them here.
>
>  drivers/of/fdt.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> index 3a896c9aeb74..b10ce880000b 100644
> --- a/drivers/of/fdt.c
> +++ b/drivers/of/fdt.c
> @@ -547,6 +547,18 @@ static int __init __fdt_scan_reserved_mem(unsigned long node, const char *uname,
>  }
>
>  /**
> + * fdt_virt_to_phys - translate a virtual address inside the FDT image
> + *                    to its corresponding physical address
> + *
> + * This needs to be overridden by the architecture if the virtual mapping
> + * of the FDT is separate from the linear direct mapping of system RAM
> + */
> +phys_addr_t __weak __init fdt_virt_to_phys(void *virt)
> +{
> +       return __pa(virt);
> +}
> +
> +/**
>   * early_init_fdt_scan_reserved_mem() - create reserved memory regions
>   *
>   * This function grabs memory from early allocator for device exclusive use
> @@ -562,7 +574,7 @@ void __init early_init_fdt_scan_reserved_mem(void)
>                 return;
>
>         /* Reserve the dtb region */
> -       early_init_dt_reserve_memory_arch(__pa(initial_boot_params),
> +       early_init_dt_reserve_memory_arch(fdt_virt_to_phys(initial_boot_params),

This is already a weak function call, so I'd rather change
early_init_dt_reserve_memory_arch to take the virt address and do the
conversion inside it. Or we could just pass both addresses from the
arch code to the core code.

Rob
