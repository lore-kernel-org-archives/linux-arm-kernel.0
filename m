From: sboyd@kernel.org (Stephen Boyd)
Date: Wed, 17 Oct 2018 08:38:40 -0700
Subject: [PATCH v13 4/8] clk: qcom: Add CPU clock driver for msm8996
In-Reply-To: <20180614215358.11264-5-ilia.lin@gmail.com>
References: <20180614215358.11264-1-ilia.lin@gmail.com>
 <20180614215358.11264-5-ilia.lin@gmail.com>
Message-ID: <153979072095.5275.10118894326299332053@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting ilia.lin at gmail.com (2018-06-14 14:53:51)
>  drivers/clk/qcom/Kconfig         |  10 +
>  drivers/clk/qcom/Makefile        |   1 +
>  drivers/clk/qcom/clk-alpha-pll.h |   6 +
>  drivers/clk/qcom/clk-cpu-8996.c  | 403 +++++++++++++++++++++++++++++++++++++++
>  4 files changed, 420 insertions(+)
>  create mode 100644 drivers/clk/qcom/clk-cpu-8996.c
> 
> diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
> index 9c3480dcc38a..fe01df59f923 100644
> --- a/drivers/clk/qcom/Kconfig
> +++ b/drivers/clk/qcom/Kconfig
> @@ -33,6 +33,16 @@ config QCOM_CLK_APCS_MSM8916
>           Say Y if you want to support CPU frequency scaling on devices
>           such as msm8916.
>  
> +config QCOM_CLK_APCC_MSM8996
> +       tristate "MSM8996 CPU Clock Controller"
> +       depends on ARM64
> +       depends on COMMON_CLK_QCOM
> +       select QCOM_KRYO_L2_ACCESSORS
> +       help
> +         Support for the CPU clock controller on msm8996 devices.
> +         Say Y if you want to support CPU clock scaling using CPUfreq
> +         drivers for dyanmic power management.

APCC comes before APCS alphabetically, so move this up above the other
config please.

> +
>  config QCOM_CLK_RPM
>         tristate "RPM based Clock Controller"
>         depends on COMMON_CLK_QCOM && MFD_QCOM_RPM
> diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
> index 762c01137c2f..d142778f6e92 100644
> --- a/drivers/clk/qcom/Makefile
> +++ b/drivers/clk/qcom/Makefile
> @@ -36,6 +36,7 @@ obj-$(CONFIG_MSM_MMCC_8974) += mmcc-msm8974.o
>  obj-$(CONFIG_MSM_MMCC_8996) += mmcc-msm8996.o
>  obj-$(CONFIG_QCOM_A53PLL) += a53-pll.o
>  obj-$(CONFIG_QCOM_CLK_APCS_MSM8916) += apcs-msm8916.o
> +obj-$(CONFIG_QCOM_CLK_APCC_MSM8996) += clk-cpu-8996.o
>  obj-$(CONFIG_QCOM_CLK_RPM) += clk-rpm.o
>  obj-$(CONFIG_QCOM_CLK_SMD_RPM) += clk-smd-rpm.o
>  obj-$(CONFIG_SDM_GCC_845) += gcc-sdm845.o
> diff --git a/drivers/clk/qcom/clk-alpha-pll.h b/drivers/clk/qcom/clk-alpha-pll.h
> index f981b486c468..9ce2a32f30ab 100644
> --- a/drivers/clk/qcom/clk-alpha-pll.h
> +++ b/drivers/clk/qcom/clk-alpha-pll.h
> @@ -50,6 +50,12 @@ struct pll_vco {
>         u32 val;
>  };
>  
> +#define VCO(a, b, c) { \
> +       .val = a,\
> +       .min_freq = b,\
> +       .max_freq = c,\
> +}
> +
>  /**
>   * struct clk_alpha_pll - phase locked loop (PLL)
>   * @offset: base address of registers
> diff --git a/drivers/clk/qcom/clk-cpu-8996.c b/drivers/clk/qcom/clk-cpu-8996.c
> new file mode 100644
> index 000000000000..d92cad93af20
> --- /dev/null
> +++ b/drivers/clk/qcom/clk-cpu-8996.c
> @@ -0,0 +1,403 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2018, The Linux Foundation. All rights reserved.
> + */
> +
> +/*
> + * Each of the CPU clusters (Power and Perf) on msm8996 are
> + * clocked via 2 PLLs, a primary and alternate. There are also
> + * 2 Mux'es, a primary and secondary all connected together
> + * as shown below
> + *
> + *                              +-------+
> + *               XO             |       |
> + *           +------------------>0      |
> + *                              |       |
> + *                    PLL/2     | SMUX  +----+
> + *                      +------->1      |    |
> + *                      |       |       |    |
> + *                      |       +-------+    |    +-------+
> + *                      |                    +---->0      |
> + *                      |                         |       |
> + * +---------------+    |             +----------->1      | CPU clk
> + * |Primary PLL    +----+ PLL_EARLY   |           |       +------>
> + * |               +------+-----------+    +------>2 PMUX |
> + * +---------------+      |                |      |       |
> + *                        |   +------+     |   +-->3      |
> + *                        +--^+  ACD +-----+   |  +-------+
> + * +---------------+          +------+         |
> + * |Alt PLL        |                           |
> + * |               +---------------------------+
> + * +---------------+         PLL_EARLY
> + *
> + * The primary PLL is what drives the CPU clk, except for times
> + * when we are reprogramming the PLL itself (for rate changes) when
> + * we temporarily switch to an alternate PLL. A subsequent patch adds
> + * support to switch between primary and alternate PLL during rate
> + * changes.
> + *
> + * The primary PLL operates on a single VCO range, between 600MHz
> + * and 3GHz. However the CPUs do support OPPs with frequencies
> + * between 300MHz and 600MHz. In order to support running the CPUs
> + * at those frequencies we end up having to lock the PLL at twice
> + * the rate and drive the CPU clk via the PLL/2 output and SMUX.
> + *
> + * So for frequencies above 600MHz we follow the following path
> + *  Primary PLL --> PLL_EARLY --> PMUX(1) --> CPU clk
> + * and for frequencies between 300MHz and 600MHz we follow
> + *  Primary PLL --> PLL/2 --> SMUX(1) --> PMUX(0) --> CPU clk
> + * Support for this is added in a subsequent patch as well.
> + *
> + * ACD stands for Adaptive Clock Distribution and is used to
> + * detect voltage droops.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>

include clk-provider.h?

> +
> +#include "clk-alpha-pll.h"
> +#include "clk-regmap.h"
> +
> +enum _pmux_input {

Is this enum used?

> +       DIV_2_INDEX = 0,
> +       PLL_INDEX,
> +       ACD_INDEX,
> +       ALT_INDEX,
> +       NUM_OF_PMUX_INPUTS
> +};
> +
> +static const u8 prim_pll_regs[PLL_OFF_MAX_REGS] = {
> +       [PLL_OFF_L_VAL] = 0x04,
> +       [PLL_OFF_ALPHA_VAL] = 0x08,
> +       [PLL_OFF_USER_CTL] = 0x10,
> +       [PLL_OFF_CONFIG_CTL] = 0x18,
> +       [PLL_OFF_CONFIG_CTL_U] = 0x1c,
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

Nitpick: I have no idea why muxes is written as mux'es. Please drop the
apostrophe.

> +
> +struct clk_cpu_8996_mux {
> +       u32     reg;
> +       u8      shift;
> +       u8      width;
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
> +       u32 val;
> +       struct clk_regmap *clkr = to_clk_regmap(hw);
> +       struct clk_cpu_8996_mux *cpuclk = to_clk_cpu_8996_mux_hw(hw);
> +       u32 mask = (u32)GENMASK(cpuclk->width - 1, 0);
> +
> +       regmap_read(clkr->regmap, cpuclk->reg, &val);
> +       val >>= (u32)(cpuclk->shift);
> +
> +       return (u8)(val & mask);

Nitpick: What's with all the casts in here? Can they be removed?

> +}
> +
> +static int clk_cpu_8996_mux_set_parent(struct clk_hw *hw, u8 index)
> +{
> +       u32 val;
> +       struct clk_regmap *clkr = to_clk_regmap(hw);
> +       struct clk_cpu_8996_mux *cpuclk = to_clk_cpu_8996_mux_hw(hw);
> +       unsigned int mask = GENMASK(cpuclk->width + cpuclk->shift - 1,
> +                                   cpuclk->shift);

Maybe this can be a u32 so it fits on one line?

> +
> +       val = (u32)index;
> +       val <<= (u32)(cpuclk->shift);
> +
> +       return regmap_update_bits(clkr->regmap, cpuclk->reg, mask, val);

Same comment about casting.

> +}
> +
> +static int
> +clk_cpu_8996_mux_determine_rate(struct clk_hw *hw, struct clk_rate_request *req)
> +{
> +       struct clk_cpu_8996_mux *cpuclk = to_clk_cpu_8996_mux_hw(hw);
> +       struct clk_hw *parent = cpuclk->pll;
> +
> +       req->best_parent_rate = clk_hw_round_rate(parent, req->rate);
> +       req->best_parent_hw = parent;
> +
> +       return 0;

What's the necessity of this function? Is the parent not always
cpuclk->pll?

> +}
> +
> +const struct clk_ops clk_cpu_8996_mux_ops = {

static?

> +       .set_parent = clk_cpu_8996_mux_set_parent,
> +       .get_parent = clk_cpu_8996_mux_get_parent,
> +       .determine_rate = clk_cpu_8996_mux_determine_rate,
> +};
> +
> +static struct clk_cpu_8996_mux pwrcl_smux = {
> +       .reg = 0x40,
> +       .shift = 2,
> +       .width = 2,
> +       .clkr.hw.init = &(struct clk_init_data) {
> +               .name = "pwrcl_smux",
> +               .parent_names = (const char *[]){
> +                       "xo",
> +                       "pwrcl_pll_main",
> +               },
> +               .num_parents = 2,
> +               .ops = &clk_cpu_8996_mux_ops,
> +               .flags = CLK_SET_RATE_PARENT,
> +       },
> +};
> +
> +static struct clk_cpu_8996_mux perfcl_smux = {
> +       .reg = 0x80040,
> +       .shift = 2,
> +       .width = 2,
> +       .clkr.hw.init = &(struct clk_init_data) {
> +               .name = "perfcl_smux",
> +               .parent_names = (const char *[]){
> +                       "xo",
> +                       "perfcl_pll_main",
> +               },
> +               .num_parents = 2,
> +               .ops = &clk_cpu_8996_mux_ops,
> +               .flags = CLK_SET_RATE_PARENT,
> +       },
> +};
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
> +               .flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,

Please comment why CLK_IGNORE_UNUSED is used here.

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
> +               .flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,

Same. I guess it's because these clks should never be turned off?

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

IS the endian thing needed? I don't think that has mattered before.

> +};
> +
> +struct clk_regmap *clks[] = {

Please name this something a little more cpu_clk_msm8996 specific.

> +       &perfcl_pll.clkr,
> +       &pwrcl_pll.clkr,
> +       &perfcl_alt_pll.clkr,
> +       &pwrcl_alt_pll.clkr,
> +       &perfcl_smux.clkr,
> +       &pwrcl_smux.clkr,
> +       &perfcl_pmux.clkr,
> +       &pwrcl_pmux.clkr,
> +};
> +
> +static int
> +qcom_cpu_clk_msm8996_register_clks(struct device *dev, struct regmap *regmap)
> +{
> +       int i, ret;
> +
> +       perfcl_smux.pll = clk_hw_register_fixed_factor(dev, "perfcl_pll_main",
> +                                                      "perfcl_pll",
> +                                                  CLK_SET_RATE_PARENT, 1, 2);
> +
> +       pwrcl_smux.pll = clk_hw_register_fixed_factor(dev, "pwrcl_pll_main",
> +                                                     "pwrcl_pll",
> +                                                  CLK_SET_RATE_PARENT, 1, 2);
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

Slam this function into probe? I don't see the need to split it out.

> +}
> +
> +static int qcom_cpu_clk_msm8996_driver_probe(struct platform_device *pdev)
> +{
> +       int ret;
> +       void __iomem *base;
> +       struct resource *res;
> +       struct regmap *regmap;
> +       struct clk_hw_onecell_data *data;
> +       struct device *dev = &pdev->dev;
> +
> +       data = devm_kzalloc(dev, sizeof(*data) + 2 * sizeof(struct clk_hw *),
> +                           GFP_KERNEL);
> +       if (!data)
> +               return -ENOMEM;
> +
> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       base = devm_ioremap_resource(dev, res);
> +       if (IS_ERR(base))
> +               return PTR_ERR(base);
> +
> +       regmap = devm_regmap_init_mmio(dev, base, &cpu_msm8996_regmap_config);
> +       if (IS_ERR(regmap))
> +               return PTR_ERR(regmap);
> +
> +       ret = qcom_cpu_clk_msm8996_register_clks(dev, regmap);
> +       if (ret)
> +               return ret;
> +
> +       data->hws[0] = &pwrcl_pmux.clkr.hw;
> +       data->hws[1] = &perfcl_pmux.clkr.hw;
> +       data->num = 2;
> +
> +       return devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get, data);
> +}
> +
> +static const struct of_device_id qcom_cpu_clk_msm8996_match_table[] = {
> +       { .compatible = "qcom,msm8996-apcc" },
> +       {}
> +};

Add a module device table macro?

> +
> +static struct platform_driver qcom_cpu_clk_msm8996_driver = {
> +       .probe = qcom_cpu_clk_msm8996_driver_probe,
> +       .driver = {
> +               .name = "qcom-msm8996-apcc",
> +               .of_match_table = qcom_cpu_clk_msm8996_match_table,
> +       },
> +};
> +module_platform_driver(qcom_cpu_clk_msm8996_driver);
> +
> +MODULE_ALIAS("platform:msm8996-apcc");
> +MODULE_DESCRIPTION("QCOM MSM8996 CPU Clock Driver");
> +MODULE_LICENSE("GPL v2");
