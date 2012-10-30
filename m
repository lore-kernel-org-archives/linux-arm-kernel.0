From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 30 Oct 2012 12:46:22 +0100
Subject: [PATCH V2 1/3] clk: mvebu: add armada-370-xp specific clocks
In-Reply-To: <20121030112025.18780.88390@nucleus>
References: <1349125926-16144-1-git-send-email-gregory.clement@free-electrons.com>
 <1349125926-16144-2-git-send-email-gregory.clement@free-electrons.com>
 <20121030112025.18780.88390@nucleus>
Message-ID: <508FBE0E.5030505@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/30/2012 12:20 PM, Mike Turquette wrote:
> Quoting Gregory CLEMENT (2012-10-01 14:12:04)
>> Add Armada 370/XP specific clocks: core clocks and CPU clocks.
>>
>> The CPU clocks are only for Armada XP for the SMP mode.
>>
>> The core clocks are clocks which have their rate set during reset. The
>> code was written with the other SoCs of the mvebu family in
>> mind. Adding them should be pretty straight forward. For a new
>> SoC, only 3 binding have to be added:
>> - one to provide the tclk frequency
>> - one to provde the pclk frequency
>> - and one to provide the ratio between the pclk and the children
>>   clocks
>>
>> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> 
> Thanks for sending v2 Gregory.  Functionally this series looks good but
> unfortunately there are a few style and white space nitpicks below.

Hi Mike,

You don't review the last version: I have sent a third version tow weeks
ago (October th 15th). But all your comment should applied for this last
version.

The changelog was
V2 -> V3:
- Rebased on top of v3.7-rc1
- Fixed a typo in device trees
- Fixed warning from checkpatch

Thanks for your review, I will send a new version in few hours.

> 
>> diff --git a/Documentation/devicetree/bindings/clock/mvebu-cpu-clock.txt b/Documentation/devicetree/bindings/clock/mvebu-cpu-clock.txt
>> new file mode 100644
>> index 0000000..c524618
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/clock/mvebu-cpu-clock.txt
>> @@ -0,0 +1,21 @@
>> +Device Tree Clock bindings for cpu clock of Marvell EBU platforms
>> +
>> +Required properties:
>> +- compatible : shall be one of the following:
>> +       "marvell,armada-xp-cpu-clockctrl" - cpu clocks for Armada XP
>> +- reg : Address and length of the clock complex register set
>> +- #clock-cells : should be set to 1.
>> +- clocks : shall be the input parent clock phandle for the clock.
>> +
>> +cpuclk: clock-complex at d0018700 {
>> +       #clock-cells = <1>;
>> +       compatible = "marvell,armada-xp-cpu-clockctrl";
>> +       reg = <0xd0018700 0xA0>;
>> +       clocks = <&coreclk 1>;
>> +}
>> +
>> +cpu at 0 {
>> +       compatible = "marvell,sheeva-v7";
> 
> Unnecessary white space before the tab in the line above.
> 
>> diff --git a/drivers/clk/mvebu/clk-core.c b/drivers/clk/mvebu/clk-core.c
>> new file mode 100644
>> index 0000000..5792cb5
>> --- /dev/null
>> +++ b/drivers/clk/mvebu/clk-core.c
>> @@ -0,0 +1,312 @@
>> +/*
>> + * Marvell EBU clock core handling defined at reset
>> + *
>> + * Copyright (C) 2012 Marvell
>> + *
>> + * Gregory CLEMENT <gregory.clement@free-electrons.com>
>> + *
>> + * This file is licensed under the terms of the GNU General Public
>> + * License version 2.  This program is licensed "as is" without any
>> + * warranty of any kind, whether express or implied.
>> + */
>> +#include <linux/kernel.h>
>> +#include <linux/clk.h>
>> +#include <linux/clkdev.h>
>> +#include <linux/clk-provider.h>
>> +#include <linux/of_address.h>
>> +#include <linux/io.h>
>> +#include <linux/of.h>
>> +
>> +/* Sample At Reset is a 64 bit bitfiled split in two register of 32
>> + * bits*/
> 
> Can you make this proper comment block style per CodingStyle convention?
> 
>> +
>> +#define SARL                               0   /* Low part [0:31] */
>> +#define            SARL_AXP_PCLK_FREQ_OPT          21
>> +#define            SARL_AXP_PCLK_FREQ_OPT_MASK     0x7
>> +#define            SARL_A370_PCLK_FREQ_OPT         11
>> +#define            SARL_A370_PCLK_FREQ_OPT_MASK    0xF
>> +#define            SARL_AXP_FAB_FREQ_OPT           24
>> +#define            SARL_AXP_FAB_FREQ_OPT_MASK      0xF
>> +#define            SARL_A370_FAB_FREQ_OPT          15
>> +#define            SARL_A370_FAB_FREQ_OPT_MASK     0x1F
>> +#define            SARL_A370_TCLK_FREQ_OPT         20
>> +#define            SARL_A370_TCLK_FREQ_OPT_MASK    0x1
>> +#define SARH                               4   /* High part [32:63] */
>> +#define            SARH_AXP_PCLK_FREQ_OPT          (52-32)
>> +#define            SARH_AXP_PCLK_FREQ_OPT_MASK     0x1
>> +#define            SARH_AXP_PCLK_FREQ_OPT_SHIFT    3
>> +#define            SARH_AXP_FAB_FREQ_OPT           (51-32)
>> +#define            SARH_AXP_FAB_FREQ_OPT_MASK      0x1
>> +#define            SARH_AXP_FAB_FREQ_OPT_SHIFT     4
>> +
>> +u32 *sar_reg;
>> +int sar_reg_size;
>> +
>> +enum core_clk {
>> +       tclk, pclk, nbclk, hclk, dramclk, clk_max
>> +};
>> +
>> +struct core_clk_fn {
>> +       u32(*get_tclk_freq) (void);
>> +       u32(*get_pck_freq) (void);
>> +       const int *(*get_fab_freq_opt) (void);
>> +};
>> +
>> +/* Ratio between VCO and each of the member in the following order:
>> +   CPU clock, L2 clock, DRAM controler clock, DDR clcok */
> 
> ditto
> 
>> +static const int reset_core_ratio[32][4] = {
>> +       [0x01] = {1, 2, 2, 2},
>> +       [0x02] = {2, 2, 6, 3},
>> +       [0x03] = {2, 2, 3, 3},
>> +       [0x04] = {1, 2, 3, 3},
>> +       [0x05] = {1, 2, 4, 2},
>> +       [0x06] = {1, 1, 2, 2},
>> +       [0x07] = {2, 3, 6, 6},
>> +       [0x09] = {1, 2, 6, 3},
>> +       [0x0A] = {2, 4, 10, 5},
>> +       [0x0C] = {1, 2, 4, 4},
>> +       [0x0F] = {2, 2, 5, 5},
>> +       [0x13] = {1, 1, 2, 1},
>> +       [0x14] = {2, 3, 6, 3},
>> +       [0x1B] = {1, 1, 1, 1},
>> +};
>> +
>> +static struct clk *clks[clk_max];
>> +
>> +static struct clk_onecell_data clk_data;
>> +
>> +/* Frequency in MHz*/
>> +static u32 armada_370_pclk[] = { 400, 533, 667, 800, 1000, 1067, 1200 };
>> +
>> +static u32 armada_xp_pclk[] = { 1000, 1066, 1200, 1333, 1500, 1666,
>> +       1800, 2000, 667, 0, 800, 1600
>> +};
>> +
>> +static u32 armada_370_tclk[] = { 166, 200 };
>> +
>> +static const int *__init armada_370_get_fab_freq_opt(void)
>> +{
>> +       u8 fab_freq_opt = 0;
>> +
>> +       fab_freq_opt = ((sar_reg[0] >> SARL_A370_FAB_FREQ_OPT) &
>> +                       SARL_A370_FAB_FREQ_OPT_MASK);
>> +
>> +       if (reset_core_ratio[fab_freq_opt][0] == 0)
>> +               return NULL;
>> +       else
>> +               return reset_core_ratio[fab_freq_opt];
>> +}
>> +
>> +static u32 __init armada_370_get_pck_freq(void)
>> +{
>> +       u32 cpu_freq;
>> +       u8 cpu_freq_select = 0;
>> +
>> +       cpu_freq_select = ((sar_reg[0] >> SARL_A370_PCLK_FREQ_OPT) &
>> +                          SARL_A370_PCLK_FREQ_OPT_MASK);
>> +       if (cpu_freq_select > ARRAY_SIZE(armada_370_pclk)) {
>> +               pr_err("CPU freq select unsuported %d\n", cpu_freq_select);
>> +               cpu_freq = 0;
>> +       } else
>> +               cpu_freq = armada_370_pclk[cpu_freq_select];
>> +
>> +       return cpu_freq * 1000 * 1000;
>> +}
>> +
>> +static u32 __init armada_370_get_tclk_freq(void)
>> +{
>> +       u32 tclk_freq;
>> +       u8 tclk_freq_select = 0;
>> +
>> +       tclk_freq_select = ((sar_reg[0] >> SARL_A370_TCLK_FREQ_OPT) &
>> +                           SARL_A370_TCLK_FREQ_OPT_MASK);
>> +       if (tclk_freq_select > ARRAY_SIZE(armada_370_tclk)) {
>> +               pr_err("TCLK freq select unsuported %d\n", tclk_freq_select);
>> +               tclk_freq = 0;
>> +       } else
>> +               tclk_freq = armada_370_tclk[tclk_freq_select];
>> +
>> +       return tclk_freq * 1000 * 1000;
>> +}
>> +
>> +static const int *__init armada_xp_get_fab_freq_opt(void)
>> +{
>> +       u8 fab_freq_opt = 0;
>> +
>> +       fab_freq_opt = ((sar_reg[0] >> SARL_AXP_FAB_FREQ_OPT) &
>> +                       SARL_AXP_FAB_FREQ_OPT_MASK);
>> +       /* The upper bit is not contiguous to the other ones
>> +        * and located in the high part of the SAR
>> +        * registers */
> 
> ditto
> 
>> +       fab_freq_opt |= (((sar_reg[1] >> SARH_AXP_FAB_FREQ_OPT) &
>> +                         SARH_AXP_FAB_FREQ_OPT_MASK)
>> +                        << SARH_AXP_FAB_FREQ_OPT_SHIFT);
>> +
>> +       if (reset_core_ratio[fab_freq_opt][0] == 0)
>> +               return NULL;
>> +       else
>> +               return reset_core_ratio[fab_freq_opt];
>> +}
>> +
>> +static u32 __init armada_xp_get_pck_freq(void)
>> +{
>> +       u32 cpu_freq;
>> +       u8 cpu_freq_select = 0;
>> +
>> +       cpu_freq_select = ((sar_reg[0] >> SARL_AXP_PCLK_FREQ_OPT) &
>> +                          SARL_AXP_PCLK_FREQ_OPT_MASK);
>> +       /* The upper bit is not contiguous to the other ones
>> +        * and located in the high part of the SAR
>> +        * registers */
> 
> ditto
> 
>> +       cpu_freq_select |= (((sar_reg[1] >> SARH_AXP_PCLK_FREQ_OPT) &
>> +                            SARH_AXP_PCLK_FREQ_OPT_MASK)
>> +                           << SARH_AXP_PCLK_FREQ_OPT_SHIFT);
>> +       if (cpu_freq_select > ARRAY_SIZE(armada_xp_pclk)) {
>> +               pr_err("CPU freq select unsuported: %d\n", cpu_freq_select);
>> +               cpu_freq = 0;
>> +       } else
>> +               cpu_freq = armada_xp_pclk[cpu_freq_select];
>> +
>> +       return cpu_freq * 1000 * 1000;
>> +}
>> +
>> +/* For Armada XP TCLK frequency is fix: 250MHz */
>> +static u32 __init armada_xp_get_tclk_freq(void)
>> +{
>> +       return 250 * 1000 * 1000;
>> +}
>> +
>> +void __init of_core_clk_setup(struct device_node *node,
>> +                             struct core_clk_fn clk_fn)
>> +{
>> +       struct clk *clk;
>> +       unsigned long rate;
>> +       const char *clk_name;
>> +       int i;
>> +
>> +       /* clock 0 is tclk */
>> +       of_property_read_string_index(node, "clock-output-names", tclk,
>> +                               &clk_name);
>> +       rate = clk_fn.get_tclk_freq();
>> +       if (rate != 0)
>> +               clk = clk_register_fixed_rate(NULL, clk_name, NULL,
>> +                                             CLK_IS_ROOT, rate);
>> +       else {
>> +               pr_err("Invalid freq for %s\n", clk_name);
>> +               return;
>> +       }
>> +
>> +       if (WARN_ON(IS_ERR(clk)))
>> +               return;
>> +       clks[tclk] = clk;
>> +
>> +       /* clock 1 is pclk */
>> +       of_property_read_string_index(node, "clock-output-names", pclk,
>> +                               &clk_name);
>> +       rate = clk_fn.get_pck_freq();
>> +       if (rate != 0)
>> +               clk = clk_register_fixed_rate(NULL, clk_name, NULL,
>> +                                             CLK_IS_ROOT, rate);
>> +       else {
>> +               pr_err("Invalid freq for %s\n", clk_name);
>> +               return;
>> +       }
>> +       if (WARN_ON(IS_ERR(clk)))
>> +               return;
>> +       clks[pclk] = clk;
>> +
>> +       /* the clocks 2 to 4 are nbclk, hclk and dramclk and are all
>> +        * derivated from the clock 1: pclk */
> 
> ditto
> 
>> +
>> +       for (i = nbclk; i <= dramclk; i++) {
>> +               const int *ratio = clk_fn.get_fab_freq_opt();
>> +               const char *parent_clk_name;
>> +
>> +               of_property_read_string_index(node, "clock-output-names",
>> +                                        i, &clk_name);
>> +               of_property_read_string_index(node, "clock-output-names",
>> +                                        pclk, &parent_clk_name);
>> +
>> +               if (ratio != NULL)
>> +                       clk = clk_register_fixed_factor(NULL, clk_name,
>> +                                                       parent_clk_name, 0,
>> +                                                       ratio[0],
>> +                                                       ratio[i - nbclk + 1]);
>> +               else {
>> +                       pr_err("Invalid clk ratio for %s\n", clk_name);
>> +                       return;
>> +               }
>> +
>> +               if (WARN_ON(IS_ERR(clk)))
>> +                       return;
>> +               clks[i] = clk;
>> +       }
>> +       clk_data.clk_num = ARRAY_SIZE(clks);
>> +       clk_data.clks = clks;
>> +       of_clk_add_provider(node, of_clk_src_onecell_get, &clk_data);
>> +}
>> +
>> +static struct core_clk_fn armada_370_clk_fn = {
>> +       .get_tclk_freq = armada_370_get_tclk_freq,
>> +       .get_pck_freq = armada_370_get_pck_freq,
>> +       .get_fab_freq_opt = armada_370_get_fab_freq_opt,
>> +};
>> +
>> +static struct core_clk_fn armada_xp_clk_fn = {
>> +       .get_tclk_freq = armada_xp_get_tclk_freq,
>> +       .get_pck_freq = armada_xp_get_pck_freq,
>> +       .get_fab_freq_opt = armada_xp_get_fab_freq_opt,
>> +};
>> +
>> +static const __initconst struct of_device_id clk_match[] = {
>> +       {
>> +        .compatible = "marvell,armada-370-core-clockctrl",
>> +        .data = &armada_370_clk_fn,
>> +        },
> 
> Indention is a bit weird here.  The members are just indented with one
> space and there is an extra white space in front of the closing bracket.
> Can you re-align?
> 
>> +
>> +       {
>> +        .compatible = "marvell,armada-xp-core-clockctrl",
>> +        .data = &armada_xp_clk_fn,
>> +        },
> 
> ditto
> 
>> +       {
>> +        /* sentinel */
>> +        }
> 
> ditto
> 
>> +};
>> +
>> +void __init mvebu_core_clocks_init(void)
>> +{
>> +       struct device_node *np;
>> +       struct resource res;
>> +       void __iomem *sar_base;
>> +       int i;
>> +
>> +       np = of_find_node_by_name(NULL, "mvebu-sar");
>> +
>> +       if (!np)
>> +               goto err;
>> +
>> +       if (of_address_to_resource(np, 0, &res))
>> +               goto err;
>> +
>> +       sar_reg_size = resource_size(&res);
>> +       sar_reg = kmalloc(sar_reg_size, GFP_KERNEL);
>> +
>> +       sar_base = ioremap(res.start, sar_reg_size);
>> +       if (sar_base == NULL)
>> +               goto err;
>> +       for (i = 0; i < sar_reg_size; i += sizeof(*sar_reg))
>> +               sar_reg[i] = readl(sar_base + i);
>> +
>> +       iounmap(sar_base);
>> +
>> +       for_each_matching_node(np, clk_match) {
>> +               const struct of_device_id *match = of_match_node(clk_match, np);
>> +               struct core_clk_fn *clk_fn = match->data;
>> +               of_core_clk_setup(np, *clk_fn);
>> +       }
>> +
>> +       return;
>> +err:
>> +       pr_err("%s:SAR base adresse not set in DT\n", __func__);
>> +       return;
>> +}
>> diff --git a/drivers/clk/mvebu/clk-core.h b/drivers/clk/mvebu/clk-core.h
>> new file mode 100644
>> index 0000000..a04f80b
>> --- /dev/null
>> +++ b/drivers/clk/mvebu/clk-core.h
>> @@ -0,0 +1,19 @@
>> +/*
>> + *  * Marvell EBU clock core handling defined at reset
>> + *
>> + * Copyright (C) 2012 Marvell
>> + *
>> + * Gregory CLEMENT <gregory.clement@free-electrons.com>
>> + *
>> + * This file is licensed under the terms of the GNU General Public
>> + * License version 2.  This program is licensed "as is" without any
>> + * warranty of any kind, whether express or implied.
>> + */
>> +
>> +#ifndef __MVEBU_CLK_CORE_H
>> +#define __MVEBU_CLK_CORE_H
>> +
>> +void __init of_core_clk_setup(struct device_node *node);
>> +void __init mvebu_core_clocks_init(void);
>> +
>> +#endif
>> diff --git a/drivers/clk/mvebu/clk-cpu.c b/drivers/clk/mvebu/clk-cpu.c
>> new file mode 100644
>> index 0000000..6b5c841
>> --- /dev/null
>> +++ b/drivers/clk/mvebu/clk-cpu.c
>> @@ -0,0 +1,155 @@
>> +/*
>> + * Marvell MVEBU CPU clock handling.
>> + *
>> + * Copyright (C) 2012 Marvell
>> + *
>> + * Gregory CLEMENT <gregory.clement@free-electrons.com>
>> + *
>> + * This file is licensed under the terms of the GNU General Public
>> + * License version 2.  This program is licensed "as is" without any
>> + * warranty of any kind, whether express or implied.
>> + */
>> +#include <linux/kernel.h>
>> +#include <linux/clk.h>
> 
> clk-provider.h includes clk.h, so this is redundant.
> 
> Regards,
> Mike
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
