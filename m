From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 9 Aug 2013 16:14:10 +0100
Subject: [PATCH v6 1/4] clk: hi3xxx: add clock support
In-Reply-To: <1374813135-16238-2-git-send-email-haojian.zhuang@linaro.org>
References: <1374813135-16238-1-git-send-email-haojian.zhuang@linaro.org>
 <1374813135-16238-2-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <20130809151410.GQ27325@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 26, 2013 at 05:32:12AM +0100, Haojian Zhuang wrote:
> Add clock support with device tree on Hisilicon SoC.
>
> Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
> Cc: Mike Turquette <mturquette@linaro.org>
> ---
>  .../devicetree/bindings/clock/hisilicon.txt        |  66 ++++
>  drivers/clk/Makefile                               |   1 +
>  drivers/clk/clk-hi3xxx.c                           | 398 +++++++++++++++++++++
>  3 files changed, 465 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/hisilicon.txt
>  create mode 100644 drivers/clk/clk-hi3xxx.c
>
> diff --git a/Documentation/devicetree/bindings/clock/hisilicon.txt b/Documentation/devicetree/bindings/clock/hisilicon.txt
> new file mode 100644
> index 0000000..5d7a220
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/hisilicon.txt
> @@ -0,0 +1,66 @@
> +Device Tree Clock bindings for arch-hi3xxx
> +
> +This binding uses the common clock binding[1].
> +
> +[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
> +
> +Required properties for mux clocks:
> + - compatible : Shall be "hisilicon,hi3620-clk-mux".
> + - clocks : shall be the input parent clock phandle for the clock. This should
> +       be the reference clock.
> + - clock-output-names : shall be reference name.
> + - #clock-cells : from common clock binding; shall be set to 0.
> + - clkmux-reg : array of mux register offset & mask bits

Offset from what base address? There's no reg property listed, the
binding document doesn't refer to a container, and the example doesn't
show one.

Do these offsets within the parent's address space vary, or is a known
set of clocks a known offsets always going to exist?

If all the clocks are a component of a parent block of IP, is that
parent block not better described as a provider of multiple clocks?

> + - clkmux-table : array of mux select bits
> +
> +Required properties for Hi3620 gate clocks:
> + - compatible : Shall be "hisilicon,hi3620-clk-gate".
> + - clocks : shall be the input parent clock phandle for the clock. This should
> +       be the reference clock.
> + - clock-output-names : shall be reference name.
> + - #clock-cells : from common clock binding; shall be set to 0.
> + - hi3620-clkgate : array of enable register offset & enable bits
> + - hi3620-clkreset : array of reset register offset & enable bits

Similarly, offset from where?

> +
> +Required properties for clock divider:
> + - compatible : Shall be "hisilicon,hi3620-clk-div".
> + - clocks : shall be the input parent clock phandle for the clock. This should
> +       be the reference clock.
> + - clock-output-names : shall be reference name.
> + - #clock-cells : from common clock binding; shall be set to 0.
> + - #clkdiv-table-cells : the number of parameters after phandle in
> +   clkdiv-table property.
> + - clkdiv-table : list of value that are used to configure clock
> +   divider. They're value of phandle, index & divider value.

I'm having some difficulty understanding what the properties above
actually represent.

> + - clkdiv : array of divider register offset & mask bits.

Offset from...?

> +
> +Required properties for gate clocks:
> + - compatible : Shall be "hisilicon,clk-gate".
> + - clocks : shall be the input parent clock phandle for the clock. This should
> +       be the reference clock.
> + - clock-output-names : shall be reference name.
> + - #clock-cells : from common clock binding; shall be set to 0.
> + - clkgate-inverted : bool value. True means that set-to-disable.

Is that a generic property, or only valid for hisilicon,clk-gate?

> +
> +For example:
> +       timclk1: clkgate at 38 {
> +               compatible = "hisilicon,clk-gate";
> +               #clock-cells = <0>;
> +               clocks = <&refclk_timer1>;
> +               clock-output-names = "timclk1";
> +               clkgate-inverted;
> +               clkgate = <0 18>;
> +       };
> +
> +       dtable: clkdiv at 0 {
> +               #clkdiv-table-cells = <2>;
> +       };
> +
> +       div_cfgaxi: clkdiv at 2 {
> +               compatible = "hisilicon,hi3620-clk-div";
> +               #clock-cells = <0>;
> +               clocks = <&div_shareaxi>;
> +               clock-output-names = "cfgAXI_div";
> +               clkdiv-table = <&dtable 0x01 2>;
> +               clkdiv = <0x100 0x60>;
> +       };

[...]

> +static const struct of_device_id hi3xxx_of_match[] = {
> +       { .compatible = "hisilicon,sctrl" },
> +};

This parent wasn't mentioned in the binding. Is it documented elsewhere?

> +
> +static void __iomem __init *hi3xxx_init_clocks(struct device_node *np)
> +{
> +       struct device_node *parent;
> +       const struct of_device_id *match;
> +       void __iomem *ret = NULL;
> +
> +       parent = of_get_parent(np);
> +       if (!parent) {
> +               pr_warn("Can't find parent node of these clocks\n");
> +               goto out;

>From out you only seem to return. Why not just return?

Does this leave the of_node refcounts balanced? (as a more general
question, does most code?).

> +       }
> +       match = of_match_node(hi3xxx_of_match, parent);
> +       if (!match) {
> +               pr_warn("Can't find the right parent\n");
> +               goto out;

Why not just return?

> +       }
> +
> +       if (!hi3xxx_clk_base) {
> +               ret = of_iomap(parent, 0);
> +               WARN_ON(!ret);
> +               hi3xxx_clk_base = ret;
> +       } else {
> +               ret = hi3xxx_clk_base;

Necessarily, ret = NULL in this case.

Why not rearrange the whole block:

	if (!hi3xx_clk_base)
		return NULL;
	
	/*
	 * do stuff assuming hi3xx_clk_base here
	 */

Even better, the mapping of the registers should be centralised and done
at the start - no need to fail repeatedly for each child. You already
seemed to have a compatible string for the parent node...

[...]

> +static void __init hi3620_clkgate_setup(struct device_node *np)
> +{
> +       struct hi3620_periclk *pclk;
> +       struct clk_init_data *init;
> +       struct clk *clk;
> +       const char *clk_name, *name, **parent_names;
> +       u32 rdata[2], gdata[2];
> +       void __iomem *base;
> +
> +       base = hi3xxx_init_clocks(np);
> +       if (!base)
> +               return;
> +
> +       if (of_property_read_string(np, "clock-output-names", &clk_name))
> +               return;
> +       if (of_property_read_u32_array(np, "hi3620-clkgate",
> +                                      &gdata[0], 2))
> +               return;
> +
> +       /* gate only has the fixed parent */
> +       parent_names = kzalloc(sizeof(char *), GFP_KERNEL);
> +       if (!parent_names)
> +               return;
> +       parent_names[0] = of_clk_get_parent_name(np, 0);

It seems odd to allocate a single pointer, surely there has to be a
better way? Could this single pointer not be stored in a wrapper of
clk_init_data?

Is it possible for of_clk_get_parent_name to fail?

> +
> +       pclk = kzalloc(sizeof(*pclk), GFP_KERNEL);
> +       if (!pclk)
> +               goto err_pclk;
> +
> +       init = kzalloc(sizeof(*init), GFP_KERNEL);
> +       if (!init)
> +               goto err_init;
> +       init->name = kstrdup(clk_name, GFP_KERNEL);

You're happy to refer to the parent name embedded in the dt, but kstrdup
the child name?

> +       init->ops = &hi3620_clkgate_ops;
> +       init->flags = CLK_SET_RATE_PARENT;
> +       init->parent_names = parent_names;
> +       init->num_parents = 1;
> +
> +       if (!of_property_read_u32_array(np, "hi3620-clkreset",
> +                                       &rdata[0], 2)) {
> +               pclk->reset = base + rdata[0];
> +               pclk->rbits = rdata[1];
> +       }
> +       pclk->enable = base + gdata[0];
> +       pclk->ebits = gdata[1];
> +       pclk->lock = &hi3xxx_clk_lock;
> +       pclk->hw.init = init;
> +
> +       clk = clk_register(NULL, &pclk->hw);
> +       if (IS_ERR(clk))
> +               goto err_clk;
> +       if (!of_property_read_string(np, "clock-names", &name))
> +               clk_register_clkdev(clk, name, NULL);
> +       of_clk_add_provider(np, of_clk_src_simple_get, clk);
> +       return;
> +err_clk:
> +       kfree(init);
> +err_init:
> +       kfree(pclk);
> +err_pclk:
> +       kfree(parent_names);
> +}
> +CLK_OF_DECLARE(hi3620_gate, "hisilicon,hi3620-clk-gate", hi3620_clkgate_setup)
> +
> +static int __init hi3xxx_parse_mux(struct device_node *np,
> +                                  u8 *num_parents,
> +                                  u32 *table)
> +{
> +       int i, cnt, ret;
> +
> +       /* get the count of items in mux */
> +       for (i = 0, cnt = 0; ; i++, cnt++) {
> +               /* parent's #clock-cells property is always 0 */
> +               if (!of_parse_phandle(np, "clocks", i))
> +                       break;
> +       }

Remove the references to cnt in this loop. Afterwards add:

	cnt = i;

> +
> +       for (i = 0; i < cnt; i++) {
> +               if (!of_clk_get_parent_name(np, i))
> +                       return -ENOENT;
> +       }
> +       *num_parents = cnt;
> +       table = kzalloc(sizeof(u32 *) * cnt, GFP_KERNEL);
> +       if (!table)
> +               return -ENOMEM;
> +       ret = of_property_read_u32_array(np, "clkmux-table",
> +                                        table, cnt);
> +       if (ret)
> +               goto err;
> +       return 0;
> +err:
> +       kfree(table);
> +       return ret;

The err case is only used at the end of the function. Why not:

        if (!ret)
                return 0;

        kfree(table);
        return ret;

[...]

> +static void __init hs_clkgate_setup(struct device_node *np)
> +{
> +       struct clk *clk;
> +       const char *clk_name, **parent_names, *name;
> +       unsigned long flags = 0;
> +       u32 data[2];
> +       void __iomem *base;
> +
> +       base = hi3xxx_init_clocks(np);
> +       if (!base)
> +               return;
> +       if (of_property_read_string(np, "clock-output-names", &clk_name))
> +               return;
> +       if (of_property_read_u32_array(np, "clkgate",
> +                                      &data[0], 2))
> +               return;
> +       if (of_property_read_bool(np, "clkgate-inverted"))
> +               flags = CLK_GATE_SET_TO_DISABLE;
> +       /* gate only has the fixed parent */
> +       parent_names = kzalloc(sizeof(char *), GFP_KERNEL);
> +       if (!parent_names)
> +               return;
> +       parent_names[0] = of_clk_get_parent_name(np, 0);
> +
> +       clk = clk_register_gate(NULL, clk_name, parent_names[0], 0,
> +                               base + data[0], (u8)data[1], flags,
> +                               &hi3xxx_clk_lock);
> +       if (IS_ERR(clk))
> +               goto err;
> +       if (!of_property_read_string(np, "clock-names", &name))
> +               clk_register_clkdev(clk, name, NULL);
> +       of_clk_add_provider(np, of_clk_src_simple_get, clk);
> +       return;
> +err:
> +       kfree(parent_names);

Why shift the err case out of line if it's only referred to once?

> +}
> +CLK_OF_DECLARE(hs_gate, "hisilicon,clk-gate", hs_clkgate_setup)
> +
> +void __init hi3620_clkdiv_setup(struct device_node *np)
> +{
> +       struct clk *clk;
> +       const char *clk_name, **parent_names;
> +       struct clk_div_table *table;
> +       unsigned int table_num;
> +       int i;
> +       u32 data[2];
> +       u8 shift, width;
> +       const char *propname = "clkdiv-table";
> +       const char *cellname = "#clkdiv-table-cells";
> +       struct of_phandle_args div_table;
> +       void __iomem *reg, *base;
> +
> +       base = hi3xxx_init_clocks(np);
> +       if (!base)
> +               return;
> +
> +       if (of_property_read_string(np, "clock-output-names", &clk_name))
> +               return;
> +       if (of_property_read_u32_array(np, "clkdiv", &data[0], 2))
> +               return;
> +
> +       /*process the div_table*/
> +       for (i = 0; ; i++) {
> +               if (of_parse_phandle_with_args(np, propname, cellname,
> +                                              i, &div_table))
> +                       break;
> +       }
> +
> +       /*table ends with <0, 0>, so plus one to table_num*/
> +       table_num = i + 1;

That certainly wasn't described in the binding (and the example doesn't
match).

> +
> +       table = kzalloc(sizeof(struct clk_div_table) * table_num, GFP_KERNEL);
> +       if (!table)
> +               return ;

Unnecessary space.

> +
> +       for (i = 0; ; i++) {
> +               if (of_parse_phandle_with_args(np, propname, cellname,
> +                                              i, &div_table))
> +                       break;
> +
> +               table[i].val = div_table.args[0];
> +               table[i].div = div_table.args[1];
> +       }
> +
> +       /* gate only has the fixed parent */
> +       parent_names = kzalloc(sizeof(char *), GFP_KERNEL);
> +       if (!parent_names)
> +               goto err_par;
> +       parent_names[0] = of_clk_get_parent_name(np, 0);

Similarly to my earlier comment, I suspect there's a better way of
handling this.

Thanks,
Mark.
