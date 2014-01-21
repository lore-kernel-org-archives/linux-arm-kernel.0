From: ta.omasab@gmail.com (Thomas Abraham)
Date: Tue, 21 Jan 2014 14:05:27 +0530
Subject: [PATCH v2 2/7] clk: samsung: add infrastructure to register cpu
 clocks
In-Reply-To: <20140120092412.0c2d57e4@amdc2363>
References: <1390047057-2239-1-git-send-email-thomas.ab@samsung.com>
 <1390047057-2239-3-git-send-email-thomas.ab@samsung.com>
 <20140120092412.0c2d57e4@amdc2363>
Message-ID: <CAJuA9ajpcB41b0d09emqPPVLxeXviQAjeEObNjPxnZ3PcZk0GA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lukasz,

On Mon, Jan 20, 2014 at 1:54 PM, Lukasz Majewski <l.majewski@samsung.com> wrote:
> Hi Thomas,
>
>> From: Thomas Abraham <thomas.ab@samsung.com>
>>
>> The CPU clock provider supplies the clock to the CPU clock domain. The
>> composition and organization of the CPU clock provider could vary
>> among Exynos SoCs. A CPU clock provider can be composed of clock mux,
>> dividers and gates. This patch defines a new clock type for CPU clock
>> provider and adds infrastructure to register the CPU clock providers
>> for Samsung platforms.
>>
>> In addition to this, the arm cpu clock provider for Exynos4210 and
>> compatible SoCs is instantiated using the new cpu clock type. The
>> clock frequency table and the clock configuration data for this clock
>> is obtained from device tree. This implementation is reusable for
>> Exynos4x12 and Exynos5250 SoCs as well.
>>
>> Cc: Tomasz Figa <t.figa@samsung.com>
>> Cc: Lukasz Majewski <l.majewski@majess.pl>
>> Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
>> ---
>>  drivers/clk/samsung/Makefile  |    2 +-
>>  drivers/clk/samsung/clk-cpu.c |  345
>> +++++++++++++++++++++++++++++++++++++++++
>> drivers/clk/samsung/clk.h     |    3 + 3 files changed, 349
>> insertions(+), 1 deletions(-) create mode 100644
>> drivers/clk/samsung/clk-cpu.c
>>
>> diff --git a/drivers/clk/samsung/Makefile
>> b/drivers/clk/samsung/Makefile index 8eb4799..e2b453f 100644
>> --- a/drivers/clk/samsung/Makefile
>> +++ b/drivers/clk/samsung/Makefile
>> @@ -2,7 +2,7 @@
>>  # Samsung Clock specific Makefile
>>  #
>>
>> -obj-$(CONFIG_COMMON_CLK)     += clk.o clk-pll.o
>> +obj-$(CONFIG_COMMON_CLK)     += clk.o clk-pll.o clk-cpu.o
>>  obj-$(CONFIG_ARCH_EXYNOS4)   += clk-exynos4.o
>>  obj-$(CONFIG_SOC_EXYNOS5250) += clk-exynos5250.o
>>  obj-$(CONFIG_SOC_EXYNOS5420) += clk-exynos5420.o
>> diff --git a/drivers/clk/samsung/clk-cpu.c
>> b/drivers/clk/samsung/clk-cpu.c new file mode 100644
>> index 0000000..92fba45
>> --- /dev/null
>> +++ b/drivers/clk/samsung/clk-cpu.c
>> @@ -0,0 +1,345 @@
>> +/*
>> + * Copyright (c) 2014 Samsung Electronics Co., Ltd.
>> + * Author: Thomas Abraham <thomas.ab@samsung.com>
>> + *
>> + * This program is free software; you can redistribute it and/or
>> modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + *
>> + * This file contains the utility functions to register the cpu
>> clocks
>> + * for samsung platforms.
>> +*/
>> +
>> +#include <linux/errno.h>
>> +#include "clk.h"
>> +
>> +#define SRC_CPU                      0x0
>> +#define STAT_CPU             0x200
>> +#define DIV_CPU0             0x300
>> +#define DIV_CPU1             0x304
>> +#define DIV_STAT_CPU0                0x400
>> +#define DIV_STAT_CPU1                0x404
>> +
>> +/**
>> + * struct samsung_cpuclk_freq_table: table of frequency supported by
>> + * a cpu clock and associated data if any.
>> + * @freq: points to a table of supported frequencies (in KHz)
>> + * @freq_count: number of entries in the frequency table
>> + * @data: cpu clock specific data, if any
>> + *
>> + * This structure holds the frequency options supported by the cpu
>> clock in
>> + * which this structure is contained. The data pointer is an
>> optional data
>> + * that can provide any additional configuration options for the
>> supported
>> + * frequencies. This structure is intended to be reusable for all
>> cpu clocks
>> + * in Samsung SoC based platforms
>> + */
>> +struct samsung_cpuclk_freq_table {
>> +     const unsigned long     *freq;       /* in KHz */
>> +     unsigned long           freq_count;
>> +     const void              *data;
>> +};
>> +
>> +/**
>> + * struct exynos4210_freq_data: format of auxillary data associated
>> with
>> + * each frequency supported by the cpu clock for exynos4210.
>> + * @parent_freq: The frequency of the parent clock required to
>> generate the
>> + * supported cpu clock speed.
>> + * @div0: value to be programmed in the div_cpu0 register.
>> + * @div1: value to be programmed in the div_cpu1 register.
>> + *
>> + * This structure holds the auxillary configuration data for each
>> supported
>> + * cpu clock frequency on Exynos4210 and compatible SoCs.
>> + */
>> +struct exynos4210_freq_data {
>> +     unsigned long   parent_freq;
>> +     unsigned int    div0;
>> +     unsigned int    div1;
>> +};
>> +
>> +/**
>> + * struct samsung_cpuclk: information about clock supplied to a CPU
>> core.
>> + * @hw: handle between ccf and cpu clock.
>> + * @ctrl_base: base address of the clock controller.
>> + * @offset: offset from the ctrl_base address where the cpu clock
>> div/mux
>> + *          registers can be accessed.
>> + * @parent: clock handle representing the clock output of the parent
>> clock.
>> + * @freq_table: the frequency table supported by this cpu clock.
>> + */
>> +struct samsung_cpuclk {
>> +     struct clk_hw           hw;
>> +     void __iomem            *ctrl_base;
>> +     unsigned long           offset;
>> +     struct clk              *parent;
>> +     const struct samsung_cpuclk_freq_table *freq_table;
>> +};
>> +
>> +#define to_samsung_cpuclk(hw)        container_of(hw, struct
>> samsung_cpuclk, hw) +
>> +/**
>> + * struct samsung_cpuclk_match_data: soc specific data for cpu
>> clocks.
>> + * @parser: pointer to a function that can parse SoC specific cpu
>> clock
>> + *   frequency and associated configuration data.
>> + * @offset: optional offset from base of clock controller register
>> base,
>> + *   to be used when accessing clock controller registers
>> related to the
>> + * cpu clock.
>> + * @offset: offset from the ctrl_base address where the cpu clock
>> div/mux
>> + *   registers can be accessed.
>> + */
>> +struct samsung_cpuclk_match_data {
>> +     int (*parser)(struct device_node *,
>> +                     struct samsung_cpuclk_freq_table **);
>> +     unsigned int offset;
>> +};
>> +
>> +/* This is a helper function to perform clock rounding for cpu
>> clocks. */ +static long samsung_cpuclk_round_rate(struct clk_hw *hw,
>> +                     unsigned long drate, unsigned long *prate)
>> +{
>> +     struct samsung_cpuclk *cpuclk = to_samsung_cpuclk(hw);
>> +     const struct samsung_cpuclk_freq_table *freq_tbl;
>> +     int i;
>> +
>> +     freq_tbl = cpuclk->freq_table;
>> +     drate /= 1000;
>> +
>> +     for (i = 0; i < freq_tbl->freq_count; i++) {
>> +             if (drate >= freq_tbl->freq[i])
>> +                     return freq_tbl->freq[i] * 1000;
>> +     }
>> +     return freq_tbl->freq[i - 1] * 1000;
>> +}
>> +
>> +#define EXYNOS4210_ARM_DIV1(base) ((readl(base + DIV_CPU0) & 0xf) +
>> 1) +#define EXYNOS4210_ARM_DIV2(base) (((readl(base + DIV_CPU0) >>
>> 28) & 0xf) + 1) +
>> +/*
>> + * CPU clock speed for Exynos4210 and compatible SoCs is
>> + * parent clock speed / core1_ratio / core2_ratio
>> + */
>> +static unsigned long exynos4210_armclk_recalc_rate(struct clk_hw *hw,
>> +                             unsigned long parent_rate)
>> +{
>> +     struct samsung_cpuclk *armclk = to_samsung_cpuclk(hw);
>> +     void __iomem *base = armclk->ctrl_base + armclk->offset;
>> +
>> +     return parent_rate / EXYNOS4210_ARM_DIV1(base) /
>> +                             EXYNOS4210_ARM_DIV2(base);
>> +}
>> +
>> +/* set rate callback for cpuclk type on Exynos4210 and similar SoCs
>> */ +static int exynos4210_armclk_set_rate(struct clk_hw *hw, unsigned
>> long drate,
>> +                                     unsigned long prate)
>> +{
>> +     struct samsung_cpuclk *armclk = to_samsung_cpuclk(hw);
>> +     const struct samsung_cpuclk_freq_table *freq_tbl;
>> +     const struct exynos4210_freq_data *freq_data;
>> +     unsigned long mux_reg, idx;
>> +     void __iomem *base;
>> +
>> +     if (drate == prate)
>> +             return 0;
>> +
>> +     freq_tbl = armclk->freq_table;
>> +     freq_data = freq_tbl->data;
>> +     base = armclk->ctrl_base + armclk->offset;
>> +
>> +     for (idx = 0; idx < freq_tbl->freq_count; idx++, freq_data++)
>> +             if ((freq_tbl->freq[idx] * 1000) == drate)
>> +                     break;
>> +
>> +     if (drate < prate) {
>> +             mux_reg = readl(base + SRC_CPU);
>> +             writel(mux_reg | (1 << 16), base + SRC_CPU);
>> +             while (((readl(base + STAT_CPU) >> 16) & 0x7) != 2)
>> +                     ;
>> +
>> +             clk_set_rate(armclk->parent, drate);
>> +     }
>> +
>> +     writel(freq_data->div0, base + DIV_CPU0);
>> +     while (readl(base + DIV_STAT_CPU0) != 0)
>> +             ;
>> +     writel(freq_data->div1, base + DIV_CPU1);
>> +     while (readl(base + DIV_STAT_CPU1) != 0)
>> +             ;
>> +
>> +     if (drate > prate) {
>> +             mux_reg = readl(base + SRC_CPU);
>> +             writel(mux_reg | (1 << 16), base + SRC_CPU);
>> +             while (((readl(base + STAT_CPU) >> 16) & 0x7) != 2)
>> +                     ;
>> +
>> +             clk_set_rate(armclk->parent, freq_data->parent_freq
>> * 1000);
>> +     }
>> +
>> +     mux_reg = readl(base + SRC_CPU);
>> +     writel(mux_reg & ~(1 << 16), base + SRC_CPU);
>> +     while (((readl(base + STAT_CPU) >> 16) & 0x7) != 1)
>> +                     ;
>> +     return 0;
>> +}
>> +
>> +/* clock ops for armclk on Exynos4210 and compatible platforms. */
>> +static const struct clk_ops exynos4210_armclk_clk_ops = {
>> +     .recalc_rate = exynos4210_armclk_recalc_rate,
>> +     .round_rate = samsung_cpuclk_round_rate,
>> +     .set_rate = exynos4210_armclk_set_rate,
>> +};
>> +
>> +/* helper function to register a cpu clock */
>> +static void __init samsung_cpuclk_register(unsigned int lookup_id,
>> +             const char *name, const char *parent, const struct
>> clk_ops *ops,
>> +             const struct samsung_cpuclk_freq_table *freq_tbl,
>> +             void __iomem *reg_base,
>> +             const struct samsung_cpuclk_match_data *data)
>> +{
>> +     struct samsung_cpuclk *cpuclk;
>> +     struct clk_init_data init;
>> +     struct clk *clk;
>> +
>> +     cpuclk = kzalloc(sizeof(*cpuclk), GFP_KERNEL);
>> +     if (!cpuclk) {
>> +             pr_err("%s: could not allocate memory for cpuclk
>> %s\n",
>> +                                     __func__, name);
>> +             return;
>> +     }
>> +
>> +     init.name = name;
>> +     init.flags = CLK_GET_RATE_NOCACHE;
>> +     init.parent_names = &parent;
>> +     init.num_parents = 1;
>> +     init.ops = ops;
>> +
>> +     cpuclk->hw.init = &init;
>> +     cpuclk->ctrl_base = reg_base;
>> +     cpuclk->offset = data->offset;
>> +     cpuclk->freq_table = freq_tbl;
>> +     cpuclk->parent = __clk_lookup(parent);
>> +
>> +     clk = clk_register(NULL, &cpuclk->hw);
>> +     if (IS_ERR(clk)) {
>> +             pr_err("%s: could not register cpuclk %s\n",
>> __func__,     name);
>> +             kfree(cpuclk);
>> +             return;
>> +     }
>> +     samsung_clk_add_lookup(clk, lookup_id);
>> +}
>> +
>> +#define EXYNOS4210_DIV_CPU01(d0, d1, d2, d3, d4, d5, d6,
>> d7)           \
>> +             ((d0 << 28) | (d1 << 24) | (d2 << 20) | (d3
>> << 16) |      \
>> +              (d4 << 12) | (d5 << 8) | (d6 << 4) | (d7 << 0))
>> +#define EXYNOS4210_DIV_CPU11(d0, d1,
>> d2)                           \
>> +             ((d0 << 8) | (d1 << 4) | (d2 << 0))
>> +#define EXYNOS4210_CFG_LEN 13
>> +
>> +/*
>> + * parse cpu clock frequency table and auxillary configuration data
>> from dt
>> + * for exynos4210 and compatible SoC's.
>> + */
>> +static int exynos4210_armclk_cfg_parser(struct device_node *np,
>> +             struct samsung_cpuclk_freq_table **tbl)
>> +{
>> +     struct samsung_cpuclk_freq_table *freq_tbl;
>> +     struct exynos4210_freq_data *fdata, *t_fdata;
>> +     unsigned long *freqs, cfg[EXYNOS4210_CFG_LEN];
>> +     const struct property *prop;
>> +     unsigned int tbl_sz, i, j;
>> +     const __be32 *val;
>> +     int ret;
>> +
>> +     prop = of_find_property(np, "arm-frequency-table", NULL);
>> +     if (!prop)
>> +             return -EINVAL;
>> +     if (!prop->value)
>> +             return -EINVAL;
>> +     if ((prop->length / sizeof(u32)) % EXYNOS4210_CFG_LEN)
>
> Cannot we have the EXYNOS4210_CFG_LEN parsed from DT as well?

As per Rob's suggestion, the clock divider ration table will be
removed. So this portion of the code will be reworked.

>
>> +             return -EINVAL;
>> +     tbl_sz = (prop->length / sizeof(u32)) / EXYNOS4210_CFG_LEN;
>> +
>> +     freq_tbl = kzalloc(sizeof(*freq_tbl), GFP_KERNEL);
>> +     if (!freq_tbl)
>> +             return -ENOMEM;
>> +
>> +     freqs = kzalloc(sizeof(u32) * tbl_sz, GFP_KERNEL);
>> +     if (!freqs) {
>> +             ret = -ENOMEM;
>> +             goto free_freq_tbl;
>> +     }
>> +
>> +     fdata = kzalloc(sizeof(*fdata) * tbl_sz, GFP_KERNEL);
>> +     if (!fdata) {
>> +             ret = -ENOMEM;
>> +             goto free_freqs;
>> +     }
>> +     t_fdata = fdata;
>> +
>> +     val = prop->value;
>> +     for (i = 0; i < tbl_sz; i++, fdata++) {
>> +             for (j = 0; j < EXYNOS4210_CFG_LEN; j++)
>> +                     cfg[j] = be32_to_cpup(val++);
>> +             freqs[i] = cfg[0];
>> +             fdata->parent_freq = cfg[1];
>
> Why do we need the separate parent_freq entry here?
>
> In the patch 4/7 the freqs (cfg[0]) and parent_freq (cfg[1]) values are
> the same for all supported devices (at "arm-frequency-table").
>
> What is the rationale for having those values duplicated in the DT?

The intention was to support frequencies which may not be direct
output of the parent PLL clock. For instance, if the PLL supports
200MHz, 400MHz and 600MHz and the CPU clock needs to be set to 300MHz,
then 600MHz / 2 is a valid clock output for the cpu clock. So this is
an example where the cpu clock speed is different from its parent
clock speed.

If possible, I will try and remove the need for this table in the next version.

Thanks,
Thomas.

>
>
>> +             fdata->div0 = EXYNOS4210_DIV_CPU01(cfg[9], cfg[8],
>> cfg[7],
>> +                             cfg[6], cfg[5], cfg[4], cfg[3],
>> cfg[2]);
>> +             fdata->div1 = EXYNOS4210_DIV_CPU11(cfg[12], cfg[11],
>> cfg[10]);
>> +     }
>> +
>> +     freq_tbl->freq = freqs;
>> +     freq_tbl->freq_count = tbl_sz;
>> +     freq_tbl->data = t_fdata;
>> +     *tbl = freq_tbl;
>> +     return 0;
>> +
>> +free_freqs:
>> +     kfree(freqs);
>> +free_freq_tbl:
>> +     kfree(freq_tbl);
>> +     return ret;
>> +}
>> +
>> +static struct samsung_cpuclk_match_data exynos4210_cpuclk_match_data
>> = {
>> +     .parser = exynos4210_armclk_cfg_parser,
>> +     .offset = 0x14200,
>> +};
>> +
>> +static struct samsung_cpuclk_match_data exynos5250_cpuclk_match_data
>> = {
>> +     .parser = exynos4210_armclk_cfg_parser,
>> +     .offset = 0x200,
>> +};
>> +
>> +static const struct of_device_id samsung_clock_ids[] = {
>> +     { .compatible = "samsung,exynos4210-clock",
>> +                     .data = &exynos4210_cpuclk_match_data, },
>> +     { .compatible = "samsung,exynos4412-clock",
>> +                     .data = &exynos4210_cpuclk_match_data, },
>> +     { .compatible = "samsung,exynos5250-clock",
>> +                     .data = &exynos5250_cpuclk_match_data, },
>> +};
>> +
>> +int __init samsung_register_arm_clock(struct device_node *np,
>> +             unsigned int lookup_id, const char *parent,
>> void __iomem *base) +{
>> +     const struct of_device_id *match;
>> +     struct samsung_cpuclk_freq_table *freq_table;
>> +     const struct samsung_cpuclk_match_data *data;
>> +     int ret;
>> +
>> +     match = of_match_node(samsung_clock_ids, np);
>> +     if (!match) {
>> +             pr_err("%s: could not determine soc type\n",
>> __func__);
>> +             return -EINVAL;
>> +     }
>> +
>> +     data = match->data;
>> +     ret = data->parser(np, &freq_table);
>> +     if (ret) {
>> +             pr_err("%s: error %d in parsing arm clock freq
>> table",
>> +                                             __func__, ret);
>> +             return -EINVAL;
>> +     }
>> +
>> +     samsung_cpuclk_register(lookup_id, "armclk", parent,
>> +             &exynos4210_armclk_clk_ops, freq_table, base, data);
>> +
>> +     return 0;
>> +}
>> diff --git a/drivers/clk/samsung/clk.h b/drivers/clk/samsung/clk.h
>> index 31b4174..a759330 100644
>> --- a/drivers/clk/samsung/clk.h
>> +++ b/drivers/clk/samsung/clk.h
>> @@ -340,4 +340,7 @@ extern void __init
>> samsung_clk_register_pll(struct samsung_pll_clock *pll_list,
>>  extern unsigned long _get_rate(const char *clk_name);
>>
>> +extern int __init samsung_register_arm_clock(struct device_node *np,
>> +             unsigned int lookup_id, const char *parent, void
>> __iomem *base); +
>>  #endif /* __SAMSUNG_CLK_H */
>
>
>
> --
> Best regards,
>
> Lukasz Majewski
>
> Samsung R&D Institute Poland (SRPOL) | Linux Platform Group
