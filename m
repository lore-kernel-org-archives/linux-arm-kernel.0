From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 1 Apr 2016 18:25:41 -0700
Subject: [PATCH v4 5/5] clk: mvebu: new driver for Armada CP110 system
 controller
In-Reply-To: <1459070777-18049-6-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1459070777-18049-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1459070777-18049-6-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20160402012541.GB18567@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/27, Thomas Petazzoni wrote:
> diff --git a/drivers/clk/mvebu/cp110-system-controller.c b/drivers/clk/mvebu/cp110-system-controller.c
> new file mode 100644
> index 0000000..7b22503
> --- /dev/null
> +++ b/drivers/clk/mvebu/cp110-system-controller.c
> @@ -0,0 +1,265 @@
> +/*
> +#include <linux/kernel.h>
> +#include <linux/clk.h>

What's this for?

> +#include <linux/clk-provider.h>
> +#include <linux/io.h>

What's this for?

> +#include <linux/mfd/syscon.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/regmap.h>
> +#include <linux/slab.h>
> +
[..]
> +static int cp110_gate_enable(struct clk_hw *hw)
> +{
> +	struct cp110_gate_clk *gate =
> +		container_of(hw, struct cp110_gate_clk, hw);

Consider a macro to make this fit on one line.

> +
> +	regmap_update_bits(gate->regmap, CP110_PM_CLOCK_GATING_REG,
> +			   BIT(gate->bit_idx), BIT(gate->bit_idx));
> +
[..]
> +static struct clk *cp110_register_gate(const char *name, const char *parent_name,
> +				       struct regmap *regmap, u8 bit_idx)
> +{
> +	struct cp110_gate_clk *gate;
> +	struct clk *clk;
> +	struct clk_init_data init;
> +
> +	gate = kzalloc(sizeof(*gate), GFP_KERNEL);
> +	if (!gate)
> +		return ERR_PTR(-ENOMEM);
> +
> +	init.name = name;
> +	init.ops = &cp110_gate_ops;
> +	init.flags = CLK_IS_BASIC;

No basic please.

> +	init.parent_names = &parent_name;
> +	init.num_parents = 1;
> +
> +	gate->regmap = regmap;
> +	gate->bit_idx = bit_idx;
> +	gate->hw.init = &init;
> +
> +	clk = clk_register(NULL, &gate->hw);
> +	if (IS_ERR(clk))
> +		kfree(gate);
> +
> +	return clk;
> +}
> +
> +static struct clk *cp110_of_clk_get(struct of_phandle_args *clkspec, void *data)
> +{
> +	struct clk_onecell_data *clk_data = data;
> +	unsigned int type = clkspec->args[0];
> +	unsigned int idx = clkspec->args[1];
> +
> +	if (type == CP110_CLK_TYPE_CORE) {
> +		if (idx > CP110_MAX_CORE_CLOCKS)
> +			return ERR_PTR(-EINVAL);
> +		return clk_data->clks[idx];
> +	} else if (type == CP110_CLK_TYPE_GATABLE) {
> +		if (idx > CP110_MAX_GATABLE_CLOCKS)
> +			return ERR_PTR(-EINVAL);
> +		return clk_data->clks[CP110_MAX_CORE_CLOCKS + idx];
> +	}
> +
> +	return ERR_PTR(-EINVAL);
> +}
> +
> +static void __init cp110_syscon_clk_init(struct device_node *np)

Any reason this can't be a platform driver?

> +{
> +	struct regmap *regmap;
> +	const char *name, *apll_name, *core_name, *eip_name, *nand_name;
> +	u32 nand_clk_ctrl;
> +	int clkidx = 0, i;
> +
> +	regmap = syscon_node_to_regmap(np);

Isn't this the only driver for the node? Why not just make the
regmap ourselves in the driver here?

> +	if (IS_ERR(regmap)) {
> +		pr_err("cannot get regmap\n");
> +		return;
> +	}
> +
> +	if (regmap_read(regmap, CP110_NAND_FLASH_CLK_CTRL_REG, &nand_clk_ctrl)) {
> +		pr_err("cannot read from regmap\n");
> +		return;
> +	}
> +
> +	/*
> +	 * Register core clocks
> +	 */

Ok. Not really useful comment.

> +
> +        /* Register the APLL which is the root of the clk tree */
> +	of_property_read_string_index(np, "core-clock-output-names",
> +                                      0, &apll_name);
> +        cp110_clks[0] =
> +		clk_register_fixed_rate(NULL, apll_name, NULL, 0,
> +					1000 * 1000 * 1000);
> +
> +        /* PPv2 is APLL/3 */
> +	of_property_read_string_index(np, "core-clock-output-names",
> +				      1, &name);
> +        cp110_clks[1] =
> +		clk_register_fixed_factor(NULL, name, apll_name,
> +					  0, 1, 3);
> +	clkidx++;
> +
> +        /* EIP clock is APLL/2 */
> +	of_property_read_string_index(np, "core-clock-output-names",
> +				      2, &eip_name);
> +        cp110_clks[2] =
> +		clk_register_fixed_factor(NULL, eip_name, apll_name, 0, 1, 2);
> +	clkidx++;
> +
> +        /* Core clock is EIP/2 */
> +	of_property_read_string_index(np, "core-clock-output-names",
> +				      3, &core_name);
> +        cp110_clks[3] =
> +		clk_register_fixed_factor(NULL, core_name, eip_name, 0, 1, 2);
> +	clkidx++;
> +
> +        /* NAND can be either APLL/2.5 or core clock */
> +	of_property_read_string_index(np, "core-clock-output-names",
> +				      4, &nand_name);
> +        if (nand_clk_ctrl & NF_CLOCK_SEL_400_MASK)
> +                cp110_clks[4] =

Weird indentation here. Please use tabs throughout.

> +			clk_register_fixed_factor(NULL, nand_name,
> +						  apll_name, 0, 2, 5);
> +        else
> +                cp110_clks[4] =
> +			clk_register_fixed_factor(NULL, nand_name,
> +						  core_name, 0, 1, 1);
> +
> +	/*
> +	 * Register gatable clocks
> +	 */
> +	for (i = 0; i < CP110_MAX_GATABLE_CLOCKS; i++) {
> +		const char *parent;
> +		int clkidx, ret;
> +
> +		ret = of_property_read_string_index(np, "gate-clock-output-names",
> +						    i, &name);
> +		/* Reached the end of the list? */
> +		if (ret < 0)
> +			break;
> +
> +		of_property_read_u32_index(np, "gate-clock-indices", i, &clkidx);
> +
> +		switch(clkidx) {
> +		case CP110_GATE_NAND:
> +			parent = nand_name;
> +			break;
> +		case CP110_GATE_PPV2:
> +			parent = "ppv2-core";
> +			break;
> +		case CP110_GATE_EIP150:
> +		case CP110_GATE_EIP197:
> +			parent = "eip";
> +			break;
> +		default:
> +			parent = "core";
> +			break;
> +		}
> +
> +		cp110_clks[CP110_MAX_CORE_CLOCKS + clkidx] =
> +			cp110_register_gate(name, parent,
> +					    regmap, clkidx);
> +	}
> +
> +	of_clk_add_provider(np, cp110_of_clk_get, &cp110_clk_data);

What if this fails?


-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
