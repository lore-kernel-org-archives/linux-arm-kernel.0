From: mturquette@baylibre.com (Michael Turquette)
Date: Tue, 12 Jul 2016 15:26:07 -0700
Subject: [PATCH v4] xen/arm: Add a clock property
In-Reply-To: <1468309605-19522-1-git-send-email-dirk.behme@de.bosch.com>
References: <1468309605-19522-1-git-send-email-dirk.behme@de.bosch.com>
Message-ID: <146836236759.73491.11707389619985827497@resonance>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Dirk Behme (2016-07-12 00:46:45)
> Clocks described by this property are reserved for use by Xen, and the OS
> must not alter their state any way, such as disabling or gating a clock,
> or modifying its rate. Ensuring this may impose constraints on parent
> clocks or other resources used by the clock tree.

Note that clk_prepare_enable will not prevent the rate from changing
(clk_set_rate) or a parent from changing (clk_set_parent). The only way
to do this currently would be to set the following flags on the effected
clocks:

	CLK_SET_RATE_GATE
	CLK_SET_PARENT_GATE

And then enable the clocks. All calls to clk_set_parent and clk_set_rate
with those clocks in the path will fail, so long as they are prepared
and enabled. This implementation detail is specific to Linux and
definitely should not go into the binding.

> 
> This property is used to proxy clocks for devices Xen has taken ownership
> of, such as UARTs, for which the associated clock controller(s) remain
> under the control of Dom0.

I'm still not completely sure about this type of layering and whether or
not it is sane. If you want Xen to manage the clock controller, AND you
want Linux guests or dom0 to consume those clocks and manipulate them in
other drivers, then this solution won't work.

Regards,
Mike

> 
> Up to now, the workaround for this has been to use the Linux kernel
> command line parameter 'clk_ignore_unused'. See Xen bug
> 
> http://bugs.xenproject.org/xen/bug/45
> 
> too.
> 
> Signed-off-by: Dirk Behme <dirk.behme@de.bosch.com>
> ---
> Changes in v4: Switch to the xen.txt description proposed by Mark:
>                https://www.spinics.net/lists/arm-kernel/msg516158.html
> 
> Changes in v3: Use the xen.txt description proposed by Michael. Thanks!
> 
> Changes in v2: Drop the Linux implementation details like clk_disable_unused
>                in xen.txt.
> 
>  Documentation/devicetree/bindings/arm/xen.txt | 12 +++++++
>  arch/arm/xen/enlighten.c                      | 47 +++++++++++++++++++++++++++
>  2 files changed, 59 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/xen.txt b/Documentation/devicetree/bindings/arm/xen.txt
> index c9b9321..437e50b 100644
> --- a/Documentation/devicetree/bindings/arm/xen.txt
> +++ b/Documentation/devicetree/bindings/arm/xen.txt
> @@ -17,6 +17,18 @@ the following properties:
>    A GIC node is also required.
>    This property is unnecessary when booting Dom0 using ACPI.
>  
> +Optional properties:
> +
> +- clocks: a list of phandle + clock-specifier pairs
> +  Clocks described by this property are reserved for use by Xen, and the
> +  OS must not alter their state any way, such as disabling or gating a
> +  clock, or modifying its rate. Ensuring this may impose constraints on
> +  parent clocks or other resources used by the clock tree.
> +
> +  Note: this property is used to proxy clocks for devices Xen has taken
> +  ownership of, such as UARTs, for which the associated clock
> +  controller(s) remain under the control of Dom0.
> +
>  To support UEFI on Xen ARM virtual platforms, Xen populates the FDT "uefi" node
>  under /hypervisor with following parameters:
>  
> diff --git a/arch/arm/xen/enlighten.c b/arch/arm/xen/enlighten.c
> index 47acb36..5c546d0 100644
> --- a/arch/arm/xen/enlighten.c
> +++ b/arch/arm/xen/enlighten.c
> @@ -24,6 +24,7 @@
>  #include <linux/of_fdt.h>
>  #include <linux/of_irq.h>
>  #include <linux/of_address.h>
> +#include <linux/clk-provider.h>
>  #include <linux/cpuidle.h>
>  #include <linux/cpufreq.h>
>  #include <linux/cpu.h>
> @@ -444,6 +445,52 @@ static int __init xen_pm_init(void)
>  }
>  late_initcall(xen_pm_init);
>  
> +/*
> + * Check if we want to register some clocks, that they
> + * are not freed because unused by clk_disable_unused().
> + * E.g. the serial console clock.
> + */
> +static int __init xen_arm_register_clks(void)
> +{
> +       struct clk *clk;
> +       struct device_node *xen_node;
> +       unsigned int i, count;
> +       int ret = 0;
> +
> +       xen_node = of_find_compatible_node(NULL, NULL, "xen,xen");
> +       if (!xen_node) {
> +               pr_err("Xen support was detected before, but it has disappeared\n");
> +               return -EINVAL;
> +       }
> +
> +       count = of_clk_get_parent_count(xen_node);
> +       if (!count)
> +               goto out;
> +
> +       for (i = 0; i < count; i++) {
> +               clk = of_clk_get(xen_node, i);
> +               if (IS_ERR(clk)) {
> +                       pr_err("Xen failed to register clock %i. Error: %li\n",
> +                              i, PTR_ERR(clk));
> +                       ret = PTR_ERR(clk);
> +                       goto out;
> +               }
> +
> +               ret = clk_prepare_enable(clk);
> +               if (ret < 0) {
> +                       pr_err("Xen failed to enable clock %i. Error: %i\n",
> +                              i, ret);
> +                       goto out;
> +               }
> +       }
> +
> +       ret = 0;
> +
> +out:
> +       of_node_put(xen_node);
> +       return ret;
> +}
> +late_initcall(xen_arm_register_clks);
>  
>  /* empty stubs */
>  void xen_arch_pre_suspend(void) { }
> -- 
> 2.8.0
> 
