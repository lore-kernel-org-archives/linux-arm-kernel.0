From: sboyd@kernel.org (Stephen Boyd)
Date: Mon, 19 Mar 2018 10:36:44 -0700
Subject: [PATCH v3 03/10] clk: qcom: Add CPU clock driver for msm8996
In-Reply-To: <1518616792-29028-4-git-send-email-ilialin@codeaurora.org>
References: <1518616792-29028-1-git-send-email-ilialin@codeaurora.org>
 <1518616792-29028-4-git-send-email-ilialin@codeaurora.org>
Message-ID: <152148100496.242365.3846617702949655708@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Ilia Lin (2018-02-14 05:59:45)
> From: Rajendra Nayak <rnayak@codeaurora.org>
> 
> Each of the CPU clusters (Power and Perf) on msm8996 are
> clocked via 2 PLLs, a primary and alternate. There are also
> 2 Mux'es, a primary and secondary all connected together
> as shown below
> 
>                              +-------+
>               XO             |       |
>           +------------------>0      |
>                              |       |
>                    PLL/2     | SMUX  +----+
>                      +------->1      |    |
>                      |       |       |    |
>                      |       +-------+    |    +-------+
>                      |                    +---->0      |
>                      |                         |       |
> +---------------+    |             +----------->1      | CPU clk
> |Primary PLL    +----+ PLL_EARLY   |           |       +------>
> |               +------+-----------+    +------>2 PMUX |
> +---------------+      |                |      |       |
>                        |   +------+     |   +-->3      |
>                        +--^+  ACD +-----+   |  +-------+
> +---------------+          +------+         |
> |Alt PLL        |                           |
> |               +---------------------------+
> +---------------+         PLL_EARLY

Thanks for the diagram. Please also put it at the top of the driver
file.

> 
> The primary PLL is what drives the CPU clk, except for times
> when we are reprogramming the PLL itself (for rate changes) when
> we temporarily switch to an alternate PLL. A subsequent patch adds
> support to switch between primary and alternate PLL during rate
> changes.
> 
> The primary PLL operates on a single VCO range, between 600Mhz
> and 3Ghz. However the CPUs do support OPPs with frequencies
> between 300Mhz and 600Mhz. In order to support running the CPUs
> at those frequencies we end up having to lock the PLL at twice
> the rate and drive the CPU clk via the PLL/2 output and SMUX.
> 
> So for frequencies above 600Mhz we follow the following path
>  Primary PLL --> PLL_EARLY --> PMUX(1) --> CPU clk
> and for frequencies between 300Mhz and 600Mhz we follow

Capitalize 'h' in units please.

>  Primary PLL --> PLL/2 --> SMUX(1) --> PMUX(0) --> CPU clk
> Support for this is added in a subsequent patch as well.
> 
> ACD stands for Adaptive Clock Distribution and is used to
> detect voltage droops. We do not add support for ACD as yet.
> This can be added at a later point as needed.
> 
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> Signed-off-by: Ilia Lin <ilialin@codeaurora.org>
> ---
>  drivers/clk/qcom/Kconfig        |   8 +
>  drivers/clk/qcom/Makefile       |   1 +
>  drivers/clk/qcom/clk-cpu-8996.c | 409 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 418 insertions(+)
>  create mode 100644 drivers/clk/qcom/clk-cpu-8996.c
> 
> diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
> index fbf4532..3274877 100644
> --- a/drivers/clk/qcom/Kconfig
> +++ b/drivers/clk/qcom/Kconfig
> @@ -226,3 +226,11 @@ config SPMI_PMIC_CLKDIV
>           Technologies, Inc. SPMI PMIC. It configures the frequency of
>           clkdiv outputs of the PMIC. These clocks are typically wired
>           through alternate functions on GPIO pins.
> +
> +config MSM_APCC_8996
> +       tristate "MSM8996 CPU Clock Controller"
> +       depends on COMMON_CLK_QCOM
> +       help
> +         Support for the CPU clock controller on msm8996 devices.
> +         Say Y if you want to support CPU clock scaling using CPUfreq
> +         drivers for dyanmic power management.

Sort?

> diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
> index 230332c..57b38ba 100644
> --- a/drivers/clk/qcom/Makefile
> +++ b/drivers/clk/qcom/Makefile
> @@ -33,6 +33,7 @@ obj-$(CONFIG_MSM_LCC_8960) += lcc-msm8960.o
>  obj-$(CONFIG_MSM_MMCC_8960) += mmcc-msm8960.o
>  obj-$(CONFIG_MSM_MMCC_8974) += mmcc-msm8974.o
>  obj-$(CONFIG_MSM_MMCC_8996) += mmcc-msm8996.o
> +obj-$(CONFIG_MSM_APCC_8996) += clk-cpu-8996.o

This doesn't look sorted.

>  obj-$(CONFIG_QCOM_A53PLL) += a53-pll.o
>  obj-$(CONFIG_QCOM_CLK_APCS_MSM8916) += apcs-msm8916.o
>  obj-$(CONFIG_QCOM_CLK_RPM) += clk-rpm.o
> diff --git a/drivers/clk/qcom/clk-cpu-8996.c b/drivers/clk/qcom/clk-cpu-8996.c
> new file mode 100644
> index 0000000..42489f1
> --- /dev/null
> +++ b/drivers/clk/qcom/clk-cpu-8996.c
> @@ -0,0 +1,409 @@
> +/*
> + * Copyright (c) 2018, The Linux Foundation. All rights reserved.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 and
> + * only version 2 as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */

Can we get the SPDX tags here please?

> +
> +#include <linux/clk.h>

clk-provider.h?

> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +
> +#include "clk-alpha-pll.h"

#include "clk-regmap.h"

> +
> +#define VCO(a, b, c) { \
> +       .val = a,\
> +       .min_freq = b,\
> +       .max_freq = c,\
> +}

Can this define go into whatever PLL header file defines the struct?

> +
> +#define DIV_2_INDEX            0
> +#define PLL_INDEX              1
> +#define ACD_INDEX              2
> +#define ALT_INDEX              3
> +
> +static const u8 prim_pll_regs[PLL_OFF_MAX_REGS] = {
> +       [PLL_OFF_L_VAL] = 0x04,
> +       [PLL_OFF_ALPHA_VAL] = 0x08,
> +       [PLL_OFF_USER_CTL] = 0x10,
> +       [PLL_OFF_CONFIG_CTL] = 0x18,
> +       [PLL_OFF_CONFIG_CTL_U] = 0x1C,

Please use lowercase hex throughout. Consistency is key!

> +       [PLL_OFF_TEST_CTL] = 0x20,
> +       [PLL_OFF_TEST_CTL_U] = 0x24,
> +       [PLL_OFF_STATUS] = 0x28,
> +};
> +
> +static const u8 alt_pll_regs[PLL_OFF_MAX_REGS] = {
> +       [PLL_OFF_L_VAL] = 0x04,
> +       [PLL_OFF_ALPHA_VAL] = 0x08,
> +       [PLL_OFF_ALPHA_VAL_U] = 0x0c,
> +       [PLL_OFF_USER_CTL] = 0x10,
> +       [PLL_OFF_USER_CTL_U] = 0x14,
> +       [PLL_OFF_CONFIG_CTL] = 0x18,
> +       [PLL_OFF_TEST_CTL] = 0x20,
> +       [PLL_OFF_TEST_CTL_U] = 0x24,
> +       [PLL_OFF_STATUS] = 0x28,
> +};
> +
> +/* PLLs */
> +
> +static const struct alpha_pll_config hfpll_config = {
> +       .l = 60,
> +       .config_ctl_val = 0x200d4828,
> +       .config_ctl_hi_val = 0x006,
> +       .pre_div_mask = BIT(12),
> +       .post_div_mask = 0x3 << 8,
> +       .main_output_mask = BIT(0),
> +       .early_output_mask = BIT(3),
> +};
> +
> +static struct clk_alpha_pll perfcl_pll = {
> +       .offset = 0x80000,
> +       .regs = prim_pll_regs,
> +       .flags = SUPPORTS_DYNAMIC_UPDATE | SUPPORTS_FSM_MODE,
> +       .clkr.hw.init = &(struct clk_init_data){
> +               .name = "perfcl_pll",
> +               .parent_names = (const char *[]){ "xo" },
> +               .num_parents = 1,
> +               .ops = &clk_alpha_pll_huayra_ops,
> +       },
> +};
> +
> +static struct clk_alpha_pll pwrcl_pll = {
> +       .offset = 0x0,
> +       .regs = prim_pll_regs,
> +       .flags = SUPPORTS_DYNAMIC_UPDATE | SUPPORTS_FSM_MODE,
> +       .clkr.hw.init = &(struct clk_init_data){
> +               .name = "pwrcl_pll",
> +               .parent_names = (const char *[]){ "xo" },
> +               .num_parents = 1,
> +               .ops = &clk_alpha_pll_huayra_ops,
> +       },
> +};
> +
> +static const struct pll_vco alt_pll_vco_modes[] = {
> +       VCO(3,  250000000,  500000000),
> +       VCO(2,  500000000,  750000000),
> +       VCO(1,  750000000, 1000000000),
> +       VCO(0, 1000000000, 2150400000),
> +};
> +
> +static const struct alpha_pll_config altpll_config = {
> +       .l = 16,
> +       .vco_val = 0x3 << 20,
> +       .vco_mask = 0x3 << 20,
> +       .config_ctl_val = 0x4001051b,
> +       .post_div_mask = 0x3 << 8,
> +       .post_div_val = 0x1,
> +       .main_output_mask = BIT(0),
> +       .early_output_mask = BIT(3),
> +};
> +
> +static struct clk_alpha_pll perfcl_alt_pll = {
> +       .offset = 0x80100,
> +       .regs = alt_pll_regs,
> +       .vco_table = alt_pll_vco_modes,
> +       .num_vco = ARRAY_SIZE(alt_pll_vco_modes),
> +       .flags = SUPPORTS_OFFLINE_REQ | SUPPORTS_FSM_MODE,
> +       .clkr.hw.init = &(struct clk_init_data) {
> +               .name = "perfcl_alt_pll",
> +               .parent_names = (const char *[]){ "xo" },
> +               .num_parents = 1,
> +               .ops = &clk_alpha_pll_hwfsm_ops,
> +       },
> +};
> +
> +static struct clk_alpha_pll pwrcl_alt_pll = {
> +       .offset = 0x100,
> +       .regs = alt_pll_regs,
> +       .vco_table = alt_pll_vco_modes,
> +       .num_vco = ARRAY_SIZE(alt_pll_vco_modes),
> +       .flags = SUPPORTS_OFFLINE_REQ | SUPPORTS_FSM_MODE,
> +       .clkr.hw.init = &(struct clk_init_data) {
> +               .name = "pwrcl_alt_pll",
> +               .parent_names = (const char *[]){ "xo" },
> +               .num_parents = 1,
> +               .ops = &clk_alpha_pll_hwfsm_ops,
> +       },
> +};
> +
> +/* Mux'es */
> +
> +struct clk_cpu_8996_mux {
> +       u32     reg;
> +       u32     shift;

u8 shift?

> +       u32     width;

u8 width?

> +       struct clk_hw   *pll;
> +       struct clk_regmap clkr;
> +};
> +
> +static inline
> +struct clk_cpu_8996_mux *to_clk_cpu_8996_mux_hw(struct clk_hw *hw)
> +{
> +       return container_of(to_clk_regmap(hw), struct clk_cpu_8996_mux, clkr);
> +}
> +
> +static u8 clk_cpu_8996_mux_get_parent(struct clk_hw *hw)
> +{
> +       unsigned int val;
> +       struct clk_regmap *clkr = to_clk_regmap(hw);
> +       struct clk_cpu_8996_mux *cpuclk = to_clk_cpu_8996_mux_hw(hw);
> +       unsigned int mask = GENMASK(cpuclk->width - 1, 0);
> +
> +       regmap_read(clkr->regmap, cpuclk->reg, &val);
> +
> +       val >>= cpuclk->shift;
> +       val &= mask;
> +
> +       return val;

return val & mask;

> +}
> +
> +static int clk_cpu_8996_mux_set_parent(struct clk_hw *hw, u8 index)
> +{
> +       unsigned int val;

u32 val?

> +       struct clk_regmap *clkr = to_clk_regmap(hw);
> +       struct clk_cpu_8996_mux *cpuclk = to_clk_cpu_8996_mux_hw(hw);
> +       unsigned int mask = GENMASK(cpuclk->width + cpuclk->shift - 1,
> +                                   cpuclk->shift);
> +
> +       val = index;
> +       val <<= cpuclk->shift;
> +
> +       return regmap_update_bits(clkr->regmap, cpuclk->reg, mask, val);
> +}
> +
> +static int
> +clk_cpu_8996_mux_determine_rate(struct clk_hw *hw, struct clk_rate_request *req)
> +{
> +       struct clk_cpu_8996_mux *cpuclk = to_clk_cpu_8996_mux_hw(hw);
> +       struct clk_hw *parent = cpuclk->pll;
> +
> +       if (!cpuclk->pll)
> +               return -EINVAL;

Does this happen?

> +
> +       req->best_parent_rate = clk_hw_round_rate(parent, req->rate);
> +       req->best_parent_hw = parent;

Is the parent index always the same? Perhaps just call
clk_hw_get_parent_by_index() then instead of adding a pointer to the
clk_cpu_8996_mux.

> +
> +       return 0;
> +}
> +
> +const struct clk_ops clk_cpu_8996_mux_ops = {
> +       .set_parent = clk_cpu_8996_mux_set_parent,
> +       .get_parent = clk_cpu_8996_mux_get_parent,
> +       .determine_rate = clk_cpu_8996_mux_determine_rate,
> +};
[...]
> +
> +static struct clk_cpu_8996_mux pwrcl_pmux = {
> +       .reg = 0x40,
> +       .shift = 0,
> +       .width = 2,
> +       .pll = &pwrcl_pll.clkr.hw,
> +       .clkr.hw.init = &(struct clk_init_data) {
> +               .name = "pwrcl_pmux",
> +               .parent_names = (const char *[]){
> +                       "pwrcl_smux",
> +                       "pwrcl_pll",
> +                       "pwrcl_pll_acd",
> +                       "pwrcl_alt_pll",
> +               },
> +               .num_parents = 4,
> +               .ops = &clk_cpu_8996_mux_ops,
> +               .flags = CLK_SET_RATE_PARENT | CLK_IS_CRITICAL,
> +       },
> +};
> +
> +static struct clk_cpu_8996_mux perfcl_pmux = {
> +       .reg = 0x80040,
> +       .shift = 0,
> +       .width = 2,
> +       .pll = &perfcl_pll.clkr.hw,
> +       .clkr.hw.init = &(struct clk_init_data) {
> +               .name = "perfcl_pmux",
> +               .parent_names = (const char *[]){
> +                       "perfcl_smux",
> +                       "perfcl_pll",
> +                       "perfcl_pll_acd",
> +                       "perfcl_alt_pll",
> +               },
> +               .num_parents = 4,
> +               .ops = &clk_cpu_8996_mux_ops,
> +               .flags = CLK_SET_RATE_PARENT | CLK_IS_CRITICAL,

Not sure CLK_IS_CRITICAL is the right mode. Perhaps CLK_IGNORE_UNUSED
for now? We don't want to force XO to stay on forever here.

> +       },
> +};
> +
> +static const struct regmap_config cpu_msm8996_regmap_config = {
> +       .reg_bits               = 32,
> +       .reg_stride             = 4,
> +       .val_bits               = 32,
> +       .max_register           = 0x80210,
> +       .fast_io                = true,
> +       .val_format_endian      = REGMAP_ENDIAN_LITTLE,
> +};
> +
> +static const struct of_device_id match_table[] = {

Move this next to driver structure and give it a more specific name.

> +       { .compatible = "qcom-msm8996-apcc" },

Bad compatible? Should be qcom,msm8996-apcc?

> +       {}
> +};
> +
> +struct clk_regmap *clks[] = {
> +       /* PLLs */
> +       &perfcl_pll.clkr,
> +       &pwrcl_pll.clkr,
> +       &perfcl_alt_pll.clkr,
> +       &pwrcl_alt_pll.clkr,
> +       /* MUXs */
> +       &perfcl_smux.clkr,
> +       &pwrcl_smux.clkr,
> +       &perfcl_pmux.clkr,
> +       &pwrcl_pmux.clkr,

Please drop useless comments inside this array.

> +};
> +
> +struct clk_hw_clks {
> +       unsigned int num;
> +       struct clk_hw *hws[];
> +};

Please just NULL terminate the list of clk_hw pointers, or keep the
size around instead.

> +
> +static int
> +qcom_cpu_clk_msm8996_register_clks(struct device *dev, struct clk_hw_clks *hws,
> +                                  struct regmap *regmap)
> +{
> +       int i, ret;
> +
> +       hws->hws[0] = clk_hw_register_fixed_factor(dev, "perfcl_pll_main",
> +                                                  "perfcl_pll",
> +                                                  CLK_SET_RATE_PARENT, 1, 2);
> +       perfcl_smux.pll = hws->hws[0];
> +
> +       hws->hws[1] = clk_hw_register_fixed_factor(dev, "pwrcl_pll_main",
> +                                                  "pwrcl_pll",
> +                                                  CLK_SET_RATE_PARENT, 1, 2);
> +       pwrcl_smux.pll = hws->hws[1];
> +
> +       hws->num = 2;

Maybe just open code the fixed factor clk registration? Then the
devm_clk_hw_register() function can be used on those static structs to
make removal simpler.

> +
> +       for (i = 0; i < ARRAY_SIZE(clks); i++) {
> +               ret = devm_clk_register_regmap(dev, clks[i]);
> +               if (ret)
> +                       return ret;
> +       }
> +
> +       clk_alpha_pll_configure(&perfcl_pll, regmap, &hfpll_config);
> +       clk_alpha_pll_configure(&pwrcl_pll, regmap, &hfpll_config);
> +       clk_alpha_pll_configure(&perfcl_alt_pll, regmap, &altpll_config);
> +       clk_alpha_pll_configure(&pwrcl_alt_pll, regmap, &altpll_config);
> +
> +       return ret;
> +}
> +
> +static int qcom_cpu_clk_msm8996_driver_probe(struct platform_device *pdev)
> +{
> +       int ret;
> +       void __iomem *base;
> +       struct resource *res;
> +       struct regmap *regmap_cpu;

Just call it regmap please.

> +       struct clk_hw_clks *hws;
> +       struct clk_hw_onecell_data *data;
> +       struct device *dev = &pdev->dev;
> +       struct device_node *node = dev->of_node;
> +
> +       data = devm_kzalloc(dev, sizeof(*data) + 2 * sizeof(struct clk_hw *),
> +                           GFP_KERNEL);
> +       if (!data)
> +               return -ENOMEM;
> +
> +       hws = devm_kzalloc(dev, sizeof(*hws) + 2 * sizeof(struct clk_hw *),
> +                          GFP_KERNEL);
> +       if (!hws)
> +               return -ENOMEM;
> +
> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       base = devm_ioremap_resource(dev, res);
> +       if (IS_ERR(base))
> +               return PTR_ERR(base);
> +
> +       regmap_cpu = devm_regmap_init_mmio(dev, base,
> +                                          &cpu_msm8996_regmap_config);
> +       if (IS_ERR(regmap_cpu))
> +               return PTR_ERR(regmap_cpu);
> +
> +       ret = qcom_cpu_clk_msm8996_register_clks(dev, hws, regmap_cpu);
> +       if (ret)
> +               return ret;
> +
> +       data->hws[0] = &pwrcl_pmux.clkr.hw;
> +       data->hws[1] = &perfcl_pmux.clkr.hw;
> +
> +       data->num = 2;
> +
> +       platform_set_drvdata(pdev, hws);
> +
> +       return of_clk_add_hw_provider(node, of_clk_hw_onecell_get, data);
> +}
> +
> +static int qcom_cpu_clk_msm8996_driver_remove(struct platform_device *pdev)
> +{
> +       int i;
> +       struct device *dev = &pdev->dev;
> +       struct clk_hw_clks *hws = platform_get_drvdata(pdev);
> +
> +       for (i = 0; i < hws->num; i++)
> +               clk_hw_unregister_fixed_rate(hws->hws[i]);
> +
> +       of_clk_del_provider(dev->of_node);

Use devm_of_clk_add_hw_provider() instead.

> +
> +       return 0;
> +}
> +
> +static struct platform_driver qcom_cpu_clk_msm8996_driver = {
> +       .probe = qcom_cpu_clk_msm8996_driver_probe,
> +       .remove = qcom_cpu_clk_msm8996_driver_remove,
> +       .driver = {
> +               .name = "qcom-msm8996-apcc",
> +               .of_match_table = match_table,
> +       },
> +};
> +
> +module_platform_driver(qcom_cpu_clk_msm8996_driver);
> +
> +MODULE_ALIAS("platform:msm8996-apcc");
> +MODULE_DESCRIPTION("QCOM MSM8996 CPU clock Driver");

Not sure why Driver is capitalized and clock is not.
