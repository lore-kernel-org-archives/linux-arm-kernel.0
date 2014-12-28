From: robherring2@gmail.com (Rob Herring)
Date: Sat, 27 Dec 2014 20:53:29 -0600
Subject: [RFC/PATCHv2 2/5] ARM: mvebu: use dt_fixup to provide fallback
 for enable-method
In-Reply-To: <1419369212-17047-3-git-send-email-chris.packham@alliedtelesis.co.nz>
References: <1419369212-17047-1-git-send-email-chris.packham@alliedtelesis.co.nz>
 <1419369212-17047-3-git-send-email-chris.packham@alliedtelesis.co.nz>
Message-ID: <CAL_JsqJggc9+xaY5gkEa9_LeJUfcD-HOcD+=ZVjQbSTG6x2RhA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 23, 2014 at 3:13 PM, Chris Packham
<chris.packham@alliedtelesis.co.nz> wrote:
> When the device tree doesn't define an enable-method insert a property
> into the flattened device tree. arm_dt_init_cpu_maps() will then parse
> this an set smp_ops appropriately. Now that we have this fallback it is
> no longer necessary to set .smp in the DT_MACHINE definition.
> Additionally Armada 370, which is a single core device, no longer has any
> smp operations defined.
>
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---
> As Arnd and Maxime suggested this replaces the unconditional setting of
> smp_ops[1] with a fixup that inserts an appropriate property in the
> device-tree if needed. It turned out not to be terribly tricky to
> implement that checked each possible CPU node. One assumption I've made
> is that the cpu nodes are numbered contiguously but that seems to be
> reasonable.

In general, that's not a good assumption, but may be okay for Armada.

> [1] - http://lists.infradead.org/pipermail/linux-arm-kernel/2014-December/309766.html

I'm not really convinced this is better than a 1-line function...

>
>  arch/arm/mach-mvebu/board-v7.c | 42 +++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 41 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/mach-mvebu/board-v7.c b/arch/arm/mach-mvebu/board-v7.c
> index d0d39f1..08eb6a9 100644
> --- a/arch/arm/mach-mvebu/board-v7.c
> +++ b/arch/arm/mach-mvebu/board-v7.c
> @@ -17,6 +17,8 @@
>  #include <linux/clk-provider.h>
>  #include <linux/of_address.h>
>  #include <linux/of_platform.h>
> +#include <linux/of_fdt.h>
> +#include <linux/libfdt.h>
>  #include <linux/io.h>
>  #include <linux/clocksource.h>
>  #include <linux/dma-mapping.h>
> @@ -198,6 +200,44 @@ static void __init mvebu_dt_init(void)
>         of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
>  }
>
> +static void __init armada_370_xp_dt_fixup(void)
> +{
> +       int offset, node;
> +       int i, len;
> +       void *prop;
> +       char buffer[20];
> +       unsigned long root = of_get_flat_dt_root();
> +
> +       if (!IS_ENABLED(CONFIG_SMP) ||

This doesn't need to be conditional on SMP. You should fixup the DT
independent of kernel options.

> +           !of_flat_dt_is_compatible(root, "marvell,armadaxp"))
> +               return;
> +
> +       offset = fdt_path_offset(initial_boot_params, "/cpus");
> +       if (offset < 0)
> +               return;
> +
> +       prop = fdt_getprop(initial_boot_params, offset, "enable-method", &len);
> +       if (prop)
> +               return;
> +
> +       for (i = 0; i < NR_CPUS; i++) {
> +               snprintf(buffer, sizeof(buffer), "cpu@%d", i);
> +               node = fdt_subnode_offset(initial_boot_params, offset, buffer);

You can use fdt_node_offset_by_compatible with the cpu compatible
string here instead.

> +               if (node < 0)
> +                       break;
> +               prop = fdt_getprop(initial_boot_params, node,
> +                                  "enable-method", &len);

Do you really need to search thru all of the nodes? enable-method
should either be present on all or none.

> +               if (prop)
> +                       return;
> +       }
> +
> +       pr_info("No enable-method defined. "
> +               "Falling back to \"marvell,armada-xp-smp\"\n");
> +
> +       fdt_setprop(initial_boot_params, offset, "enable-method",
> +                   "marvell,armada-xp-smp", sizeof("marvell,armada-xp-smp"));

Use fdt_setprop_string here.

enable-method is supposed to be a per cpu property. The Marvell berlin
binding is wrong here and should not be copied.

Rob

> +}
> +
>  static const char * const armada_370_xp_dt_compat[] = {
>         "marvell,armada-370-xp",
>         NULL,
> @@ -206,11 +246,11 @@ static const char * const armada_370_xp_dt_compat[] = {
>  DT_MACHINE_START(ARMADA_370_XP_DT, "Marvell Armada 370/XP (Device Tree)")
>         .l2c_aux_val    = 0,
>         .l2c_aux_mask   = ~0,
> -       .smp            = smp_ops(armada_xp_smp_ops),
>         .init_machine   = mvebu_dt_init,
>         .init_irq       = mvebu_init_irq,
>         .restart        = mvebu_restart,
>         .dt_compat      = armada_370_xp_dt_compat,
> +       .dt_fixup       = armada_370_xp_dt_fixup,
>  MACHINE_END
>
>  static const char * const armada_375_dt_compat[] = {
> --
> 2.2.0.rc0
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
