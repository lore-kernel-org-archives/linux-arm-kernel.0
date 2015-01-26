From: robherring2@gmail.com (Rob Herring)
Date: Mon, 26 Jan 2015 14:33:21 -0600
Subject: [PATCH] ARM: /proc/atags: Export also for DT
In-Reply-To: <201501262016.52079@pali>
References: <1403110464-29646-1-git-send-email-pali.rohar@gmail.com>
 <201412041857.49341@pali>
 <CAL_JsqJ9i0jwaL1cyeomQG=bhhcnEgdGWYOqkcwidyk5xOUukg@mail.gmail.com>
 <201501262016.52079@pali>
Message-ID: <CAL_JsqL_EEg7tC-q8wV5v8jAfPSiri4z19iJfz2r7zntRwPyOg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 26, 2015 at 1:16 PM, Pali Roh?r <pali.rohar@gmail.com> wrote:
> This patch will cause that decompressor store full ATAG structure into DT tree ("/atags"):
>
> diff --git a/arch/arm/boot/compressed/atags_to_fdt.c b/arch/arm/boot/compressed/atags_to_fdt.c
> index e7e1cc9..1975d7c 100644
> --- a/arch/arm/boot/compressed/atags_to_fdt.c
> +++ b/arch/arm/boot/compressed/atags_to_fdt.c
> @@ -112,7 +112,7 @@ int atags_to_fdt(void *atag_list, void *fdt, int total_space)
>          * address and size for each bank */
>         uint32_t mem_reg_property[2 * 2 * NR_BANKS];
>         int memcount = 0;
> -       int ret, memsize;
> +       int ret, memsize, atag_size;
>
>         /* make sure we've got an aligned pointer */
>         if ((u32)atag_list & 0x3)
> @@ -184,6 +184,10 @@ int atags_to_fdt(void *atag_list, void *fdt, int total_space)
>                 }
>         }
>
> +       /* include the terminating ATAG_NONE */
> +       atag_size = (char *)atag - (char *)atag_list + sizeof(struct tag_header);
> +       setprop(fdt, "/", "atags", atag_list, atag_size);
> +
>         if (memcount) {
>                 setprop(fdt, "/memory", "reg", mem_reg_property,
>                         4 * memcount * memsize);
>
>
>
> And this patch will export ATAG structure from DT tree ("/atags") into /proc/atags file:

Please properly send your patches.

> diff --git a/arch/arm/kernel/devtree.c b/arch/arm/kernel/devtree.c
> index 9946c1b..0f249a3 100644
> --- a/arch/arm/kernel/devtree.c
> +++ b/arch/arm/kernel/devtree.c
> @@ -29,6 +29,7 @@
>  #include <asm/mach-types.h>
>  #include <asm/system_info.h>
>
> +#include "atags.h"
>
>  #ifdef CONFIG_SMP
>  extern struct of_cpu_method __cpu_method_of_table[];
> @@ -254,5 +255,10 @@ const struct machine_desc * __init setup_machine_fdt(unsigned int dt_phys)
>         if (prop)
>                 system_rev = fdt32_to_cpu(*prop);
>
> +       /* Save atags */
> +       prop = of_get_flat_dt_prop(dt_root, "atags", NULL);
> +       if (prop)
> +               save_atags((void *)prop);
> +
>         return mdesc;
>  }
>
>
> Some userspace applications needs access to ATAG structure where can be stored some information passed
> from bootloader to kernel. Example is Nokia N900 device and NOLO bootloader which provides information
> about bootreason (device was started by power button or by alarm or restarted...) and bootmode (normal
> mode or device update mode).

This goes in the commit message.

These would be non-standard fields which are not upstream. I don't
know that we care in that case...

Rob
