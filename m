From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 15 May 2015 17:52:35 -0700
Subject: [PATCHv3 2/4] clk: socfpga: add a clock driver for the Arria 10
 platform
In-Reply-To: <1431011523-10049-3-git-send-email-dinguyen@opensource.altera.com>
References: <1431011523-10049-1-git-send-email-dinguyen@opensource.altera.com>
 <1431011523-10049-3-git-send-email-dinguyen@opensource.altera.com>
Message-ID: <20150516005235.GP31753@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/07, dinguyen at opensource.altera.com wrote:
> diff --git a/drivers/clk/socfpga/clk-gate-a10.c b/drivers/clk/socfpga/clk-gate-a10.c
> new file mode 100644
> index 0000000..fadf6f7
> --- /dev/null
> +++ b/drivers/clk/socfpga/clk-gate-a10.c
> @@ -0,0 +1,187 @@
[...]
> +
> +static int socfpga_clk_prepare(struct clk_hw *hwclk)
> +{
> +	struct socfpga_gate_clk *socfpgaclk = to_socfpga_gate_clk(hwclk);
> +	struct regmap *sys_mgr_base_addr;
> +	int i;
> +	u32 hs_timing;
> +	u32 clk_phase[2];
> +
> +	if (socfpgaclk->clk_phase[0] || socfpgaclk->clk_phase[1]) {
> +		sys_mgr_base_addr = syscon_regmap_lookup_by_compatible("altr,sys-mgr");
> +		if (IS_ERR(sys_mgr_base_addr)) {

Is there a reason the syscon is grabbed lazily in prepare? Why
not get it before registering this clock?

> +			pr_err("%s: failed to find altr,sys-mgr regmap!\n", __func__);
> +			return -EINVAL;
> +		}
> +
> +		for (i = 0; i < 2; i++) {

i < ARRAY_SIZE(clk_phase) ?

> +			switch (socfpgaclk->clk_phase[i]) {
> +			case 0:
> +				clk_phase[i] = 0;
> +				break;
> +			case 45:
> +				clk_phase[i] = 1;
> +				break;
> +			case 90:
> +				clk_phase[i] = 2;
> +				break;
> +			case 135:
> +				clk_phase[i] = 3;
> +				break;
> +			case 180:
> +				clk_phase[i] = 4;
> +				break;
> +			case 225:
> +				clk_phase[i] = 5;
> +				break;
> +			case 270:
> +				clk_phase[i] = 6;
> +				break;
> +			case 315:
> +				clk_phase[i] = 7;
> +				break;
> +			default:
> +				clk_phase[i] = 0;
> +				break;
> +			}
> +		}
> +
> +		hs_timing = SYSMGR_SDMMC_CTRL_SET(clk_phase[0], clk_phase[1]);
> +		regmap_write(sys_mgr_base_addr, SYSMGR_SDMMCGRP_CTRL_OFFSET,
> +			     hs_timing);
> +	}
> +	return 0;
> +}
> +
> +static struct clk_ops gateclk_ops = {

const?

> +	.prepare = socfpga_clk_prepare,
> +	.recalc_rate = socfpga_gate_clk_recalc_rate,
> +};
> +
> diff --git a/drivers/clk/socfpga/clk-periph-a10.c b/drivers/clk/socfpga/clk-periph-a10.c
> new file mode 100644
> index 0000000..81b9274
> --- /dev/null
> +++ b/drivers/clk/socfpga/clk-periph-a10.c
> @@ -0,0 +1,131 @@
[...]
> + */
> +#include <linux/clk.h>

Are you using this include?

> +#include <linux/clkdev.h>

Are you using this include?

Applies to every file added in this patch.

> +#include <linux/clk-provider.h>
> +#include <linux/io.h>
> +#include <linux/of.h>
> +
> +#include "clk.h"
> +
> +#define CLK_MGR_FREE_SHIFT		16
> +#define CLK_MGR_FREE_MASK		0x7
> +
> +#define SOCFPGA_MPU_FREE_CLK		"mpu_free_clk"
> +#define SOCFPGA_NOC_FREE_CLK		"noc_free_clk"
> +#define SOCFPGA_SDMMC_FREE_CLK		"sdmmc_free_clk"
[..]
> +
> +static __init void __socfpga_periph_init(struct device_node *node,
> +	const struct clk_ops *ops)
> +{
[..]
> +	init.name = clk_name;
> +	init.ops = ops;
> +	init.flags = 0;
> +
> +	parent_name = of_clk_get_parent_name(node, 0);
> +	init.num_parents = 1;
> +	init.parent_names = &parent_name;
> +
> +	periph_clk->hw.hw.init = &init;
> +
> +	clk = clk_register(NULL, &periph_clk->hw.hw);
> +	if (WARN_ON(IS_ERR(clk))) {
> +		kfree(periph_clk);
> +		return;
> +	}
> +	rc = of_clk_add_provider(node, of_clk_src_simple_get, clk);

Why not check the return value?

> +
> diff --git a/drivers/clk/socfpga/clk-pll-a10.c b/drivers/clk/socfpga/clk-pll-a10.c
> new file mode 100644
> index 0000000..2adc2f5
> --- /dev/null
> +++ b/drivers/clk/socfpga/clk-pll-a10.c
[..]
> +
> +static u8 clk_pll_get_parent(struct clk_hw *hwclk)
> +{
> +	struct socfpga_pll *socfpgaclk = to_socfpga_clk(hwclk);
> +	u32 pll_src;
> +
> +	pll_src = readl(socfpgaclk->hw.reg);
> +
> +	return (pll_src >> CLK_MGR_PLL_CLK_SRC_SHIFT) &
> +		CLK_MGR_PLL_CLK_SRC_MASK;
> +}
> +
> +

Nitpick: Single newline please.

> +static struct clk_ops clk_pll_ops = {

const?

> +	.recalc_rate = clk_pll_recalc_rate,
> +	.get_parent = clk_pll_get_parent,
> +};
> +
> +static __init struct clk *__socfpga_pll_init(struct device_node *node,

__init goes after the return type, doesn't it?

> +	const struct clk_ops *ops)
> +{
> +	u32 reg;
> +	struct clk *clk;
> +	struct socfpga_pll *pll_clk;
> +	const char *clk_name = node->name;
> +	const char *parent_name[SOCFGPA_MAX_PARENTS];
> +	struct clk_init_data init;
> +	struct device_node *clkmgr_np;
> +	int rc;
> +	int i = 0;
> +
> +	of_property_read_u32(node, "reg", &reg);
> +
> +	pll_clk = kzalloc(sizeof(*pll_clk), GFP_KERNEL);
> +	if (WARN_ON(!pll_clk))
> +		return NULL;
> +
> +	clkmgr_np = of_find_compatible_node(NULL, NULL, "altr,clk-mgr");

I haven't looked at the binding, but I would expect there to be
some phandle to this node somewhere so that we don't have to
search the whole tree?

> +	clk_mgr_a10_base_addr = of_iomap(clkmgr_np, 0);
> +	BUG_ON(!clk_mgr_a10_base_addr);
> +	pll_clk->hw.reg = clk_mgr_a10_base_addr + reg;
> +
> +	of_property_read_string(node, "clock-output-names", &clk_name);
> +
> +	init.name = clk_name;
> +	init.ops = ops;
[..]
> diff --git a/drivers/clk/socfpga/clk.h b/drivers/clk/socfpga/clk.h
> index b09a5d5..6989847 100644
> --- a/drivers/clk/socfpga/clk.h
> +++ b/drivers/clk/socfpga/clk.h
> @@ -34,10 +34,14 @@
>  	((((smplsel) & 0x7) << 3) | (((drvsel) & 0x7) << 0))
>  
>  extern void __iomem *clk_mgr_base_addr;
> +extern void __iomem *clk_mgr_a10_base_addr;
>  
>  void __init socfpga_pll_init(struct device_node *node);
>  void __init socfpga_periph_init(struct device_node *node);
>  void __init socfpga_gate_init(struct device_node *node);
> +void __init socfpga_a10_pll_init(struct device_node *node);
> +void __init socfpga_a10_periph_init(struct device_node *node);
> +void __init socfpga_a10_gate_init(struct device_node *node);

__init is useless on prototypes. It's not your fault for copying
previous code, but it would be good to avoid adding more and to
clean this up in some other patch.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
