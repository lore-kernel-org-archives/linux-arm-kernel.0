From: robherring2@gmail.com (Rob Herring)
Date: Fri, 26 Jul 2013 10:36:53 -0500
Subject: [PATCH RESEND v2] ARM: dt: Use the 'model' field for printing the
 hardware revision
In-Reply-To: <1374844784-2639-1-git-send-email-festevam@gmail.com>
References: <1374844784-2639-1-git-send-email-festevam@gmail.com>
Message-ID: <CAL_JsqKZcWPA6L9duOyBJ7mMyV=Zoda2DhG8eD7g_fgxe8FFkg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 26, 2013 at 8:19 AM, Fabio Estevam <festevam@gmail.com> wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
>
> When booting a device tree kernel, we get the following output from
> 'cat /proc/cpuinfo':
>
> $ cat /proc/cpuinfo
> processor       : 0
> model name      : ARMv7 Processor rev 5 (v7l)
> BogoMIPS        : 531.66
> Features        : swp half thumb fastmult vfp edsp neon vfpv3 tls
> CPU implementer : 0x41
> CPU architecture: 7
> CPU variant     : 0x2
> CPU part        : 0xc08
> CPU revision    : 5
>
> Hardware        : Freescale i.MX51 (Device Tree Support)
> Revision        : 0000
> Serial          : 0000000000000000
>
> The Hardware line does not really describe the hardware type, as it is reading
> the information from the dt 'machine' field.
>
> In the dt case, read the 'model' field instead, so that we can have a better
> description output as follows:
>
> Hardware        : Freescale i.MX51 Babbage Board
>
> The hardware output string is unchanged for the non-dt kernel case.
>
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
> Changes since v1:
> - Fix typo in 'architecture'
>  arch/arm/include/asm/mach/arch.h |  1 +
>  arch/arm/kernel/devtree.c        | 15 ++++++++-------
>  arch/arm/kernel/setup.c          |  7 ++++++-
>  3 files changed, 15 insertions(+), 8 deletions(-)
>
> diff --git a/arch/arm/include/asm/mach/arch.h b/arch/arm/include/asm/mach/arch.h
> index 308ad7d..113d4af 100644
> --- a/arch/arm/include/asm/mach/arch.h
> +++ b/arch/arm/include/asm/mach/arch.h
> @@ -23,6 +23,7 @@ struct smp_operations;
>  struct machine_desc {
>         unsigned int            nr;             /* architecture number  */
>         const char              *name;          /* architecture name    */
> +       const char              *model;         /* architecture model */

As Russell said, we want to get rid of machine_desc at some point. So
I think a better approach is to remove the .name field (i.e. make it
NULL for now) for the DT case.

>         unsigned long           atag_offset;    /* tagged list (relative) */
>         const char *const       *dt_compat;     /* array of device tree
>                                                  * 'compatible' strings */
> diff --git a/arch/arm/kernel/devtree.c b/arch/arm/kernel/devtree.c
> index 5af04f6..90d541a 100644
> --- a/arch/arm/kernel/devtree.c
> +++ b/arch/arm/kernel/devtree.c
> @@ -178,7 +178,6 @@ struct machine_desc * __init setup_machine_fdt(unsigned int dt_phys)
>         struct machine_desc *mdesc, *mdesc_best = NULL;
>         unsigned int score, mdesc_score = ~1;
>         unsigned long dt_root;
> -       const char *model;
>
>  #ifdef CONFIG_ARCH_MULTIPLATFORM
>         DT_MACHINE_START(GENERIC_DT, "Generic DT based system")
> @@ -224,12 +223,14 @@ struct machine_desc * __init setup_machine_fdt(unsigned int dt_phys)
>                 dump_machine_table(); /* does not return */
>         }
>
> -       model = of_get_flat_dt_prop(dt_root, "model", NULL);
> -       if (!model)
> -               model = of_get_flat_dt_prop(dt_root, "compatible", NULL);
> -       if (!model)
> -               model = "<unknown>";
> -       pr_info("Machine: %s, model: %s\n", mdesc_best->name, model);
> +       mdesc_best->model = of_get_flat_dt_prop(dt_root, "model", NULL);

This won't work with Russell's constifying of machine_desc patch.

Rob
