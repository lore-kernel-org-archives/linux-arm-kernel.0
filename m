From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Tue, 25 Jun 2013 11:59:47 +0800
Subject: [PATCH v5 1/4] clk: hi3xxx: add clock support
In-Reply-To: <20130620202246.9136.74727@quantum>
References: <1371459376-25438-1-git-send-email-haojian.zhuang@linaro.org>
 <1371459376-25438-2-git-send-email-haojian.zhuang@linaro.org>
 <20130620202246.9136.74727@quantum>
Message-ID: <CAD6h2NRaMrkFuWbmuGx62pR+r8bWSZFEz_447A4sV+OPpUp6KQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21 June 2013 04:22, Mike Turquette <mturquette@linaro.org> wrote:
> Quoting Haojian Zhuang (2013-06-17 01:56:13)
>> diff --git a/drivers/clk/clk-hi3xxx.c b/drivers/clk/clk-hi3xxx.c
>> new file mode 100644
>> index 0000000..14c2f80
>> --- /dev/null
>> +++ b/drivers/clk/clk-hi3xxx.c
>> @@ -0,0 +1,414 @@
>> +/*
>> + * Hisilicon clock driver
>> + *
>> + * Copyright (c) 2012-2013 Hisilicon Limited.
>> + * Copyright (c) 2012-2013 Linaro Limited.
>> + *
>> + * Author: Haojian Zhuang <haojian.zhuang@linaro.org>
>> + *        Xin Li <li.xin@linaro.org>
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License as published by
>> + * the Free Software Foundation; either version 2 of the License, or
>> + * (at your option) any later version.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU General Public License along
>> + * with this program; if not, write to the Free Software Foundation, Inc.,
>> + * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
>> + *
>> + */
>> +
>> +#include <linux/kernel.h>
>> +#include <linux/clk-provider.h>
>> +#include <linux/clk-private.h>
>
> Please remove clk-private.h.
>
>> +#include <linux/clkdev.h>
>> +#include <linux/delay.h>
>> +#include <linux/io.h>
>> +#include <linux/of.h>
>> +#include <linux/of_address.h>
>> +#include <linux/of_device.h>
>> +#include <linux/slab.h>
>> +#include <linux/clk.h>
>> +
>> +#define HI3620_DISABLE_OFF             0x4
>> +#define HI3620_STATUS_OFF              0x8
>> +
>> +enum {
>> +       HI3620_SCTRL,
>> +       HI3XXX_MAX,
>> +};
>> +
>> +struct hi3620_periclk {
>> +       struct clk_hw   hw;
>> +       void __iomem    *enable;        /* enable register */
>> +       void __iomem    *reset;         /* reset register */
>> +       u32             ebits;          /* bits in enable/disable register */
>> +       u32             rbits;          /* bits in reset/unreset register */
>> +       spinlock_t      *lock;
>> +};
>> +
>> +struct hs_clk {
>> +       void __iomem    *pmctrl;
>> +       void __iomem    *sctrl;
>> +       spinlock_t      lock;
>> +};
>
> I don't see struct hs_clk used anywhere.
>
Oh, I forgot to delete it. This structure is obsolete.

>> +
>> +static void __iomem *hi3xxx_clk_base[HI3XXX_MAX];
>> +
>> +static DEFINE_SPINLOCK(hi3xxx_clk_lock);
>> +
>> +static const struct of_device_id hi3xxx_of_match[] = {
>> +       { .compatible = "hisilicon,sctrl", .data = (void *)HI3620_SCTRL, },
>> +};
>> +
>> +static void __iomem __init *hi3xxx_init_clocks(struct device_node *np)
>> +{
>> +       struct device_node *parent;
>> +       const struct of_device_id *match;
>> +       void __iomem *ret = NULL;
>> +       int i;
>> +
>> +       parent = of_get_parent(np);
>> +       if (!parent)
>> +               goto out;
>> +       match = of_match_node(hi3xxx_of_match, parent);
>> +       if (!match)
>> +               goto out;
>> +
>> +       i = (unsigned int)match->data;
>> +       switch (i) {
>> +       case HI3620_SCTRL:
>> +               if (!hi3xxx_clk_base[i]) {
>> +                       ret = of_iomap(parent, 0);
>> +                       WARN_ON(!ret);
>> +                       hi3xxx_clk_base[i] = ret;
>> +               } else {
>> +                       ret = hi3xxx_clk_base[i];
>> +               }
>> +               break;
>> +       default:
>> +               goto out;
>> +       }
>> +out:
>> +       return ret;
>> +}
>> +
>> +static int hi3620_clkgate_prepare(struct clk_hw *hw)
>> +{
>> +       struct hi3620_periclk *pclk;
>> +       unsigned long flags = 0;
>> +
>> +       pclk = container_of(hw, struct hi3620_periclk, hw);
>> +
>> +       if (pclk->lock)
>> +               spin_lock_irqsave(pclk->lock, flags);
>> +       if (pclk->reset) {
>> +               writel_relaxed(pclk->rbits, pclk->reset + HI3620_DISABLE_OFF);
>> +               readl_relaxed(pclk->reset + HI3620_STATUS_OFF);
>> +       }
>> +       if (pclk->lock)
>> +               spin_unlock_irqrestore(pclk->lock, flags);
>> +       return 0;
>> +}
>> +
>> +static int hi3620_clkgate_enable(struct clk_hw *hw)
>> +{
>> +       struct hi3620_periclk *pclk;
>> +       unsigned long flags = 0;
>> +
>> +       pclk = container_of(hw, struct hi3620_periclk, hw);
>> +       if (pclk->lock)
>> +               spin_lock_irqsave(pclk->lock, flags);
>> +       writel_relaxed(pclk->ebits, pclk->enable);
>> +       readl_relaxed(pclk->enable + HI3620_STATUS_OFF);
>> +       if (pclk->lock)
>> +               spin_unlock_irqrestore(pclk->lock, flags);
>> +       return 0;
>> +}
>> +
>> +static void hi3620_clkgate_disable(struct clk_hw *hw)
>> +{
>> +       struct hi3620_periclk *pclk;
>> +       unsigned long flags = 0;
>> +
>> +       pclk = container_of(hw, struct hi3620_periclk, hw);
>> +       if (pclk->lock)
>> +               spin_lock_irqsave(pclk->lock, flags);
>> +       writel_relaxed(pclk->ebits, pclk->enable + HI3620_DISABLE_OFF);
>> +       readl_relaxed(pclk->enable + HI3620_STATUS_OFF);
>> +       if (pclk->lock)
>> +               spin_unlock_irqrestore(pclk->lock, flags);
>> +}
>> +
>> +static struct clk_ops hi3620_clkgate_ops = {
>> +       .prepare        = hi3620_clkgate_prepare,
>> +       .enable         = hi3620_clkgate_enable,
>> +       .disable        = hi3620_clkgate_disable,
>
> Missing .unprepare always worries me. What does your .prepare do?

Resetting clock is implemented in .prepare().

>
>> +};
>> +
>> +static void __init hi3620_clkgate_setup(struct device_node *np)
>> +{
>> +       struct hi3620_periclk *pclk;
>> +       struct clk_init_data *init;
>> +       struct clk *clk;
>> +       const char *clk_name, *name, **parent_names;
>> +       u32 rdata[2], gdata[2];
>> +       void __iomem *base;
>> +
>> +       base = hi3xxx_init_clocks(np);
>> +       if (!base)
>> +               return;
>> +
>> +       if (of_property_read_string(np, "clock-output-names", &clk_name))
>> +               return;
>> +       if (of_property_read_u32_array(np, "hisilicon,hi3620-clkgate",
>> +                                      &gdata[0], 2))
>> +               return;
>> +
>> +       /* gate only has the fixed parent */
>> +       parent_names = kzalloc(sizeof(char *), GFP_KERNEL);
>> +       if (!parent_names)
>> +               return;
>> +       parent_names[0] = of_clk_get_parent_name(np, 0);
>> +
>> +       pclk = kzalloc(sizeof(*pclk), GFP_KERNEL);
>> +       if (!pclk)
>> +               goto err_pclk;
>> +
>> +       init = kzalloc(sizeof(*init), GFP_KERNEL);
>> +       if (!init)
>> +               goto err_init;
>> +       init->name = kstrdup(clk_name, GFP_KERNEL);
>> +       init->ops = &hi3620_clkgate_ops;
>> +       init->flags = CLK_SET_RATE_PARENT;
>> +       init->parent_names = parent_names;
>> +       init->num_parents = 1;
>> +
>> +       if (!of_property_read_u32_array(np, "hisilicon,hi3620-clkreset",
>> +                                       &rdata[0], 2)) {
>> +               pclk->reset = base + rdata[0];
>> +               pclk->rbits = rdata[1];
>> +       }
>> +       pclk->enable = base + gdata[0];
>> +       pclk->ebits = gdata[1];
>> +       pclk->lock = &hi3xxx_clk_lock;
>> +       pclk->hw.init = init;
>> +
>> +       clk = clk_register(NULL, &pclk->hw);
>> +       if (IS_ERR(clk))
>> +               goto err_clk;
>> +       if (!of_property_read_string(np, "clock-names", &name))
>> +               clk_register_clkdev(clk, name, NULL);
>> +       of_clk_add_provider(np, of_clk_src_simple_get, clk);
>> +       return;
>> +err_clk:
>> +       kfree(init);
>> +err_init:
>> +       kfree(pclk);
>> +err_pclk:
>> +       kfree(parent_names);
>> +}
>> +CLK_OF_DECLARE(hi3620_gate, "hisilicon,hi3620-clk-gate", hi3620_clkgate_setup)
>> +
>> +static int __init hi3xxx_parse_mux(struct device_node *np,
>> +                                  u8 *num_parents,
>> +                                  u32 *table)
>> +{
>> +       int i, cnt, ret;
>> +
>> +       /* get the count of items in mux */
>> +       for (i = 0, cnt = 0; ; i++, cnt++) {
>> +               /* parent's #clock-cells property is always 0 */
>> +               if (!of_parse_phandle(np, "clocks", i))
>> +                       break;
>> +       }
>> +
>> +       for (i = 0; i < cnt; i++) {
>> +               if (!of_clk_get_parent_name(np, i))
>> +                       return -ENOENT;
>> +       }
>> +       *num_parents = cnt;
>> +       table = kzalloc(sizeof(u32 *) * cnt, GFP_KERNEL);
>> +       if (!table)
>> +               return -ENOMEM;
>> +       ret = of_property_read_u32_array(np, "hisilicon,clkmux-table",
>> +                                        table, cnt);
>> +       if (ret)
>> +               goto err;
>> +       return 0;
>> +err:
>> +       kfree(table);
>> +       return ret;
>> +}
>> +
>> +static void __init clkmux_setup(struct device_node *np, int mode)
>> +{
>> +       struct clk *clk;
>> +       const char *clk_name, **parent_names = NULL;
>> +       u32 rdata[2], mask, *table = NULL;
>> +       u8 num_parents, shift, clk_mux_flags = 0;
>> +       void __iomem *reg, *base;
>> +       int i, ret;
>> +
>> +       base = hi3xxx_init_clocks(np);
>> +       if (!base)
>> +               return;
>> +
>> +       if (of_property_read_string(np, "clock-output-names", &clk_name))
>> +               return;
>> +       if (of_property_read_u32_array(np, "hisilicon,clkmux-reg",
>> +                                      &rdata[0], 2))
>> +               return;
>> +       ret = hi3xxx_parse_mux(np, &num_parents, table);
>> +       if (ret)
>> +               return;
>> +
>> +       parent_names = kzalloc(sizeof(char *) * num_parents, GFP_KERNEL);
>> +       if (!parent_names)
>> +               goto err;
>> +       for (i = 0; i < num_parents; i++)
>> +               parent_names[i] = of_clk_get_parent_name(np, i);
>> +
>> +       reg = base + rdata[0];
>> +       shift = ffs(rdata[1]) - 1;
>> +       mask = rdata[1] >> shift;
>> +       if (mode)
>> +               clk_mux_flags = CLK_MUX_HIWORD_MASK;
>> +       clk = clk_register_mux_table(NULL, clk_name, parent_names, num_parents,
>> +                                    CLK_SET_RATE_PARENT, reg, shift, mask,
>> +                                    clk_mux_flags, table, &hi3xxx_clk_lock);
>
> It seems that you could use the basic mux-clock DT binding I posted.
> This looks to do the same thing. CLK_MUX_HIWORD_MASK will need to be
> added as a new property, but otherwise it should work.

OK
>
>> +       if (IS_ERR(clk))
>> +               goto err_clk;
>> +       of_clk_add_provider(np, of_clk_src_simple_get, clk);
>> +
>> +       return;
>> +err_clk:
>> +       kfree(parent_names);
>> +err:
>> +       kfree(table);
>> +}
>> +
>> +static void __init hi3620_clkmux_setup(struct device_node *np)
>> +{
>> +       clkmux_setup(np, 1);
>> +}
>> +CLK_OF_DECLARE(hi3620_mux, "hisilicon,hi3620-clk-mux", hi3620_clkmux_setup)
>> +
>> +static void __init hi3xxx_clkmux_setup(struct device_node *np)
>> +{
>> +       clkmux_setup(np, 0);
>> +}
>> +CLK_OF_DECLARE(hi3xxx_mux, "hisilicon,clk-mux", hi3xxx_clkmux_setup)
>> +
>> +static void __init hs_clkgate_setup(struct device_node *np)
>> +{
>> +       struct clk *clk;
>> +       const char *clk_name, **parent_names, *name;
>> +       unsigned long flags = 0;
>> +       u32 data[2];
>> +       void __iomem *base;
>> +
>> +       base = hi3xxx_init_clocks(np);
>> +       if (!base)
>> +               return;
>> +       if (of_property_read_string(np, "clock-output-names", &clk_name))
>> +               return;
>> +       if (of_property_read_u32_array(np, "hisilicon,clkgate",
>> +                                      &data[0], 2))
>> +               return;
>> +       if (of_property_read_bool(np, "hisilicon,clkgate-inverted"))
>> +               flags = CLK_GATE_SET_TO_DISABLE;
>> +       /* gate only has the fixed parent */
>> +       parent_names = kzalloc(sizeof(char *), GFP_KERNEL);
>> +       if (!parent_names)
>> +               return;
>> +       parent_names[0] = of_clk_get_parent_name(np, 0);
>> +
>> +       clk = clk_register_gate(NULL, clk_name, parent_names[0], 0,
>> +                               base + data[0], (u8)data[1], flags,
>> +                               &hi3xxx_clk_lock);
>
> Same here. Looks like it could use the basic gate-clock binding.
>
OK

>> +       if (IS_ERR(clk))
>> +               goto err;
>> +       if (!of_property_read_string(np, "clock-names", &name))
>> +               clk_register_clkdev(clk, name, NULL);
>> +       of_clk_add_provider(np, of_clk_src_simple_get, clk);
>> +       return;
>> +err:
>> +       kfree(parent_names);
>> +}
>> +CLK_OF_DECLARE(hs_gate, "hisilicon,clk-gate", hs_clkgate_setup)
>> +
>> +void __init hi3620_clkdiv_setup(struct device_node *np)
>> +{
>> +       struct clk *clk;
>> +       const char *clk_name, **parent_names;
>> +       struct clk_div_table *table;
>> +       unsigned int table_num;
>> +       int i;
>> +       u32 data[2];
>> +       u8 shift, width;
>> +       const char *propname = "hisilicon,clkdiv-table";
>> +       const char *cellname = "#hisilicon,clkdiv-table-cells";
>> +       struct of_phandle_args div_table;
>> +       void __iomem *reg, *base;
>> +
>> +       base = hi3xxx_init_clocks(np);
>> +       if (!base)
>> +               return;
>> +
>> +       if (of_property_read_string(np, "clock-output-names", &clk_name))
>> +               return;
>> +       if (of_property_read_u32_array(np, "hisilicon,clkdiv",
>> +                                      &data[0], 2))
>> +               return;
>> +
>> +       /*process the div_table*/
>> +       for (i = 0; ; i++) {
>> +               if (of_parse_phandle_with_args(np, propname, cellname,
>> +                                              i, &div_table))
>> +                       break;
>> +       }
>> +
>> +       /*table ends with <0, 0>, so plus one to table_num*/
>> +       table_num = i + 1;
>> +
>> +       table = kzalloc(sizeof(struct clk_div_table) * table_num, GFP_KERNEL);
>> +       if (!table)
>> +               return ;
>> +
>> +       for (i = 0; ; i++) {
>> +               if (of_parse_phandle_with_args(np, propname, cellname,
>> +                                              i, &div_table))
>> +                       break;
>> +
>> +               table[i].val = div_table.args[0];
>> +               table[i].div = div_table.args[1];
>> +       }
>> +
>> +       /* gate only has the fixed parent */
>> +       parent_names = kzalloc(sizeof(char *), GFP_KERNEL);
>> +       if (!parent_names)
>> +               goto err_par;
>> +       parent_names[0] = of_clk_get_parent_name(np, 0);
>> +       reg = base + data[0];
>> +       shift = ffs(data[1]) - 1;
>> +       width = fls(data[1]) - ffs(data[1]) + 1;
>> +       clk = clk_register_divider_table(NULL, clk_name, parent_names[0], 0,
>> +                                        reg, shift, width,
>> +                                        CLK_DIVIDER_HIWORD_MASK,
>> +                                        table, &hi3xxx_clk_lock);
>
> This also could use the basic divider-clock binding. I'll need to see if
> the table parsing is the same. Again the HIWORD_MASK flag must be added
> as a property.

OK
