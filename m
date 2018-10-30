From: robh+dt@kernel.org (Rob Herring)
Date: Tue, 30 Oct 2018 10:16:44 -0500
Subject: [PATCH 4/6] of/fdt: Populate phys_initrd_start/phys_initrd_size
 from FDT
In-Reply-To: <20181029235206.30060-5-f.fainelli@gmail.com>
References: <20181029235206.30060-1-f.fainelli@gmail.com>
 <20181029235206.30060-5-f.fainelli@gmail.com>
Message-ID: <CAL_Jsq+2u_J+F-+b=cL4ACtp70_zgvk_Q-HKOY=iqAD9gzxR-g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 29, 2018 at 6:52 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
>
> If the architecture implements ARCH_HAS_PHYS_INITRD, make the FDT
> scanning code populate the physical address of the start of the FDT and
> its size.
>
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  arch/arm/mm/init.c | 2 +-
>  drivers/of/fdt.c   | 4 ++++
>  2 files changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
> index 8f364aa24172..517e95cfb5d2 100644
> --- a/arch/arm/mm/init.c
> +++ b/arch/arm/mm/init.c
> @@ -237,7 +237,7 @@ static void __init arm_initrd_init(void)
>         phys_addr_t start;
>         unsigned long size;
>
> -       /* FDT scan will populate initrd_start */
> +       /* FDT scan will populate initrd_start and phys_initrd_start */
>         if (initrd_start && !phys_initrd_size) {
>                 phys_initrd_start = __virt_to_phys(initrd_start);
>                 phys_initrd_size = initrd_end - initrd_start;
> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> index 76c83c1ffeda..313cd4f24258 100644
> --- a/drivers/of/fdt.c
> +++ b/drivers/of/fdt.c
> @@ -899,6 +899,10 @@ static void __early_init_dt_declare_initrd(unsigned long start,
>         initrd_start = (unsigned long)__va(start);
>         initrd_end = (unsigned long)__va(end);

As Ard pointed out, these __va() calls will BUG on arm64 if VM
debugging is enabled. Unless the arm64 folks want to remove that check
(probably not), I'm fine with a 'if (!IS_ENABLED(CONFIG_ARM64)) {'
conditional here.

>         initrd_below_start_ok = 1;
> +#ifdef CONFIG_ARCH_HAS_PHYS_INITRD
> +       phys_initrd_start = start;
> +       phys_initrd_size = end - start;
> +#endif
>  }
>  #endif
>
> --
> 2.17.1
>
