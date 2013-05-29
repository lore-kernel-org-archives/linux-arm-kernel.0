From: mturquette@linaro.org (Mike Turquette)
Date: Wed, 29 May 2013 10:39:38 -0700
Subject: [PATCH] clk: add specified-rate clock
In-Reply-To: <1368189862-17119-1-git-send-email-james.hogan@imgtec.com>
References: <1368189862-17119-1-git-send-email-james.hogan@imgtec.com>
Message-ID: <20130529173938.6058.96646@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting James Hogan (2013-05-10 05:44:22)
> The frequency of some SoC's external oscillators (for example TZ1090's
> XTAL1) are configured by the board using pull-ups/pull-downs of
> configuration pins, the logic values of which are automatically latched
> on reset and available in an SoC register. Add a generic clock component
> and DT bindings to handle this.
> 
> It behaves similar to a fixed rate clock (read-only), except it needs
> information about a register field (reg, shift, width), and the
> clock-frequency is a mapping from register field values to clock
> frequencies.
> 

James,

Thanks for sending this!  It looks mostly good and is a useful clock
type to support.  Comments below.

<snip>
> diff --git a/Documentation/devicetree/bindings/clock/specified-clock.txt b/Documentation/devicetree/bindings/clock/specified-clock.txt
> new file mode 100644
> index 0000000..b36ccf9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/specified-clock.txt
> @@ -0,0 +1,39 @@
> +Binding for fixed-rate clock sources with readable configuration.
> +
> +This binding uses the common clock binding[1].
> +
> +[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
> +
> +Required properties:
> +- compatible         : Shall be "specified-clock".
> +- #clock-cells       : From common clock binding; shall be set to 0.
> +- reg                : Address of configuration register.
> +- shift              : Shift of config value field in configuration register.
> +- width              : Width of config value field in configuration register.

It might be better to make this a mask instead of the width.  We have
already hit this issue with the mux table on Nvidia where arbitrary
masks are necessary.  Mask + shift probably helps future-proof us a bit.

The rest of the binding looks good.

<snip>
> diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
> index e7f7fe9..1343179 100644
> --- a/drivers/clk/Makefile
> +++ b/drivers/clk/Makefile
> @@ -8,6 +8,7 @@ obj-$(CONFIG_COMMON_CLK)        += clk-fixed-rate.o
>  obj-$(CONFIG_COMMON_CLK)       += clk-gate.o
>  obj-$(CONFIG_COMMON_CLK)       += clk-mux.o
>  obj-$(CONFIG_COMMON_CLK)       += clk-composite.o
> +obj-$(CONFIG_COMMON_CLK)       += clk-specified-rate.o

One thing that does occur to me is that this could potentially be
combined with the fixed-rate clock.  If the properties for a specified
rate existing in the DT data then this code applies, otherwise the
existing fixed-rate code is used.  I don't have a strong opinion about
combining the code, but something to consider.

<snip>
> +#ifdef CONFIG_OF
> +/**
> + * of_specified_clk_setup() - Setup function for specified fixed rate clock
> + */
> +void __init of_specified_clk_setup(struct device_node *node)
> +{
> +       struct clk *clk;
> +       const char *clk_name = node->name;
> +       u32 shift, width, rate;
> +       void __iomem *reg;
> +       int len, num_rates, i;
> +       struct property *prop;
> +       struct clk_specified_rate_entry *rates;
> +       const __be32 *p;
> +
> +       of_property_read_string(node, "clock-output-names", &clk_name);
> +
> +       if (of_property_read_u32(node, "shift", &shift)) {
> +               pr_err("%s(%s): could not read shift property\n",
> +                      __func__, clk_name);
> +               return;
> +       }
> +
> +       if (of_property_read_u32(node, "width", &width)) {
> +               pr_err("%s(%s): could not read width property\n",
> +                      __func__, clk_name);
> +               return;
> +       }
> +
> +       reg = of_iomap(node, 0);
> +       if (!reg) {
> +               pr_err("%s(%s): of_iomap failed\n",
> +                      __func__, clk_name);
> +               return;
> +       }
> +
> +       /* check clock-frequency exists */
> +       prop = of_find_property(node, "clock-frequency", &len);
> +       if (!prop) {
> +               pr_err("%s(%s): could not find clock-frequency property\n",
> +                      __func__, clk_name);
> +               goto err_iounmap;
> +       }
> +
> +       if (len & (sizeof(u32)*2 - 1)) {
> +               pr_err("%s(%s): clock-frequency has invalid size of %d bytes\n",
> +                      __func__, clk_name, len);
> +               goto err_iounmap;
> +       }
> +       num_rates = len / (sizeof(*rates)*2);

This tripped me up for a few minutes.  I think it is a bit weird to
count bytes as a way to validate length and determine the number of
pairs.

I have written a binding for mux clocks which can have a table of
parents and the code below shows how I parsed the table:

+       u32 pair[2];
+
+       table_size = of_count_phandle_with_args(node, "table", "#clock-cells");
+
+       if (table_size < 1)
+               return NULL;
+
+       table = kzalloc(sizeof(struct clk_div_table) * table_size, GFP_KERNEL);
+       if (!table) {
+               pr_err("%s: unable to allocate memory for %s table\n", __func__, node->name);
+               return NULL;
+       }
+
+       for (i = 0; i < table_size; i++) {
+               if (!of_property_read_u32_array(node, "table", pair, ARRAY_SIZE(pair))) {
+                       table[i].val = pair[0];
+                       table[i].div = pair[1];
+               }
+       }

I'll be posting the mux-clock binding soon :-)

Regards,
Mike
