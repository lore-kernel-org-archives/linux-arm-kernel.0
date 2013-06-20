From: mturquette@linaro.org (Mike Turquette)
Date: Thu, 20 Jun 2013 16:29:03 -0700
Subject: [PATCH v4 1/4] clk: add support for Rockchip gate clocks
In-Reply-To: <201306131659.40802.heiko@sntech.de>
References: <201306131658.36584.heiko@sntech.de>
 <201306131659.40802.heiko@sntech.de>
Message-ID: <20130620232903.9136.70323@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Heiko St?bner (2013-06-13 07:59:40)
> This adds basic support for gate-clocks on Rockchip SoCs.
> There are 16 gates in each register and use the HIWORD_MASK
> mechanism for changing gate settings.
> 
> The gate registers form a continuos block which makes the dt node
> structure a matter of taste, as either all 160 gates can be put into
> one gate clock spanning all registers or they can be divided into
> the 10 individual gates containing 16 clocks each.
> The code supports both approaches.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>

I've taken this patch into clk-next for 3.11. Perhaps in the future the
gate-clock binding can be enhanced to allow for this kind of clock
globbing and this driver can disappear entirely.

Regards,
Mike

> ---
>  .../devicetree/bindings/clock/rockchip.txt         |   74 +++++++++++++++
>  drivers/clk/Makefile                               |    1 +
>  drivers/clk/rockchip/Makefile                      |    5 ++
>  drivers/clk/rockchip/clk-rockchip.c                |   94 ++++++++++++++++++++
>  4 files changed, 174 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/rockchip.txt
>  create mode 100644 drivers/clk/rockchip/Makefile
>  create mode 100644 drivers/clk/rockchip/clk-rockchip.c
> 
> diff --git a/Documentation/devicetree/bindings/clock/rockchip.txt b/Documentation/devicetree/bindings/clock/rockchip.txt
> new file mode 100644
> index 0000000..a891c82
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/rockchip.txt
> @@ -0,0 +1,74 @@
> +Device Tree Clock bindings for arch-rockchip
> +
> +This binding uses the common clock binding[1].
> +
> +[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
> +
> +== Gate clocks ==
> +
> +The gate registers form a continuos block which makes the dt node
> +structure a matter of taste, as either all gates can be put into
> +one gate clock spanning all registers or they can be divided into
> +the 10 individual gates containing 16 clocks each.
> +The code supports both approaches.
> +
> +Required properties:
> +- compatible : "rockchip,rk2928-gate-clk"
> +- reg : shall be the control register address(es) for the clock.
> +- #clock-cells : from common clock binding; shall be set to 1
> +- clock-output-names : the corresponding gate names that the clock controls
> +- clocks : should contain the parent clock for each individual gate,
> +  therefore the number of clocks elements should match the number of
> +  clock-output-names
> +
> +Example using multiple gate clocks:
> +
> +               clk_gates0: gate-clk at 200000d0 {
> +                       compatible = "rockchip,rk2928-gate-clk";
> +                       reg = <0x200000d0 0x4>;
> +                       clocks = <&dummy>, <&dummy>,
> +                                <&dummy>, <&dummy>,
> +                                <&dummy>, <&dummy>,
> +                                <&dummy>, <&dummy>,
> +                                <&dummy>, <&dummy>,
> +                                <&dummy>, <&dummy>,
> +                                <&dummy>, <&dummy>,
> +                                <&dummy>, <&dummy>;
> +
> +                       clock-output-names =
> +                               "gate_core_periph", "gate_cpu_gpll",
> +                               "gate_ddrphy", "gate_aclk_cpu",
> +                               "gate_hclk_cpu", "gate_pclk_cpu",
> +                               "gate_atclk_cpu", "gate_i2s0",
> +                               "gate_i2s0_frac", "gate_i2s1",
> +                               "gate_i2s1_frac", "gate_i2s2",
> +                               "gate_i2s2_frac", "gate_spdif",
> +                               "gate_spdif_frac", "gate_testclk";
> +
> +                       #clock-cells = <1>;
> +               };
> +
> +               clk_gates1: gate-clk at 200000d4 {
> +                       compatible = "rockchip,rk2928-gate-clk";
> +                       reg = <0x200000d4 0x4>;
> +                       clocks = <&xin24m>, <&xin24m>,
> +                                <&xin24m>, <&dummy>,
> +                                <&dummy>, <&xin24m>,
> +                                <&xin24m>, <&dummy>,
> +                                <&xin24m>, <&dummy>,
> +                                <&xin24m>, <&dummy>,
> +                                <&xin24m>, <&dummy>,
> +                                <&xin24m>, <&dummy>;
> +
> +                       clock-output-names =
> +                               "gate_timer0", "gate_timer1",
> +                               "gate_timer2", "gate_jtag",
> +                               "gate_aclk_lcdc1_src", "gate_otgphy0",
> +                               "gate_otgphy1", "gate_ddr_gpll",
> +                               "gate_uart0", "gate_frac_uart0",
> +                               "gate_uart1", "gate_frac_uart1",
> +                               "gate_uart2", "gate_frac_uart2",
> +                               "gate_uart3", "gate_frac_uart3";
> +
> +                       #clock-cells = <1>;
> +               };
> diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
> index f51b52b..2e2e957 100644
> --- a/drivers/clk/Makefile
> +++ b/drivers/clk/Makefile
> @@ -25,6 +25,7 @@ ifeq ($(CONFIG_COMMON_CLK), y)
>  obj-$(CONFIG_ARCH_MMP)         += mmp/
>  endif
>  obj-$(CONFIG_MACH_LOONGSON1)   += clk-ls1x.o
> +obj-$(CONFIG_ARCH_ROCKCHIP)    += rockchip/
>  obj-$(CONFIG_ARCH_SUNXI)       += sunxi/
>  obj-$(CONFIG_ARCH_U8500)       += ux500/
>  obj-$(CONFIG_ARCH_VT8500)      += clk-vt8500.o
> diff --git a/drivers/clk/rockchip/Makefile b/drivers/clk/rockchip/Makefile
> new file mode 100644
> index 0000000..8d3aefa
> --- /dev/null
> +++ b/drivers/clk/rockchip/Makefile
> @@ -0,0 +1,5 @@
> +#
> +# Rockchip Clock specific Makefile
> +#
> +
> +obj-y  += clk-rockchip.o
> diff --git a/drivers/clk/rockchip/clk-rockchip.c b/drivers/clk/rockchip/clk-rockchip.c
> new file mode 100644
> index 0000000..ff990c4
> --- /dev/null
> +++ b/drivers/clk/rockchip/clk-rockchip.c
> @@ -0,0 +1,94 @@
> +/*
> + * Copyright (c) 2013 MundoReader S.L.
> + * Author: Heiko Stuebner <heiko@sntech.de>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/clkdev.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +
> +static DEFINE_SPINLOCK(clk_lock);
> +
> +/*
> + * Gate clocks
> + */
> +
> +static void __init rk2928_gate_clk_init(struct device_node *node,
> +                                        void *data)
> +{
> +       struct clk_onecell_data *clk_data;
> +       const char *clk_parent;
> +       const char *clk_name;
> +       void __iomem *reg;
> +       void __iomem *reg_idx;
> +       int flags;
> +       int qty;
> +       int reg_bit;
> +       int clkflags = CLK_SET_RATE_PARENT;
> +       int i;
> +
> +       qty = of_property_count_strings(node, "clock-output-names");
> +       if (qty < 0) {
> +               pr_err("%s: error in clock-output-names %d\n", __func__, qty);
> +               return;
> +       }
> +
> +       if (qty == 0) {
> +               pr_info("%s: nothing to do\n", __func__);
> +               return;
> +       }
> +
> +       reg = of_iomap(node, 0);
> +
> +       clk_data = kzalloc(sizeof(struct clk_onecell_data), GFP_KERNEL);
> +       if (!clk_data)
> +               return;
> +
> +       clk_data->clks = kzalloc(qty * sizeof(struct clk *), GFP_KERNEL);
> +       if (!clk_data->clks) {
> +               kfree(clk_data);
> +               return;
> +       }
> +
> +       flags = CLK_GATE_HIWORD_MASK | CLK_GATE_SET_TO_DISABLE;
> +
> +       for (i = 0; i < qty; i++) {
> +               of_property_read_string_index(node, "clock-output-names",
> +                                             i, &clk_name);
> +
> +               /* ignore empty slots */
> +               if (!strcmp("reserved", clk_name))
> +                       continue;
> +
> +               clk_parent = of_clk_get_parent_name(node, i);
> +
> +               /* keep all gates untouched for now */
> +               clkflags |= CLK_IGNORE_UNUSED;
> +
> +               reg_idx = reg + (4 * (i / 16));
> +               reg_bit = (i % 16);
> +
> +               clk_data->clks[i] = clk_register_gate(NULL, clk_name,
> +                                                     clk_parent, clkflags,
> +                                                     reg_idx, reg_bit,
> +                                                     flags,
> +                                                     &clk_lock);
> +               WARN_ON(IS_ERR(clk_data->clks[i]));
> +       }
> +
> +       clk_data->clk_num = qty;
> +
> +       of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
> +}
> +CLK_OF_DECLARE(rk2928_gate, "rockchip,rk2928-gate-clk", rk2928_gate_clk_init);
> -- 
> 1.7.10.4
