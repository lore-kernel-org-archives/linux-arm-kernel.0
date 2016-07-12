From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 12 Jul 2016 18:30:34 +0200
Subject: [PATCH v2 6/6] clk: mvebu: Add the peripheral clock driver for
 Armada 3700
In-Reply-To: <146800242289.73491.4169295036354147972@resonance> (Michael
 Turquette's message of "Fri, 08 Jul 2016 11:27:02 -0700")
References: <1467931071-31004-1-git-send-email-gregory.clement@free-electrons.com>
 <1467931071-31004-7-git-send-email-gregory.clement@free-electrons.com>
 <146800242289.73491.4169295036354147972@resonance>
Message-ID: <87r3aystsl.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Michael,
 
 On ven., juil. 08 2016, Michael Turquette <mturquette@baylibre.com> wrote:

> Quoting Gregory CLEMENT (2016-07-07 15:37:51)
>> +#include <linux/clk-provider.h>
>> +#include <linux/clk.h>
>
> Same question as my previous email. Is clk.h necessary? Is this driver
> also a clk consumer?

I think I can remove it indeed.

>
>> +static int armada_3700_add_composite_clk(const struct clk_periph_data *data,
>> +                                        const char * const *parent_name,
>> +                                        void __iomem *reg, spinlock_t *lock,
>> +                                        struct device *dev, struct clk_hw *hw)
>> +{
>> +       const struct clk_ops *mux_ops = NULL, *gate_ops = NULL,
>> +               *div_ops = NULL;
>> +       struct clk_hw *mux_hw = NULL, *gate_hw = NULL, *div_hw = NULL;
>> +       const char * const *names;
>> +       struct clk_mux *mux = NULL;
>> +       struct clk_gate *gate = NULL;
>> +       struct clk_divider *div = NULL;
>> +       struct clk_double_div *double_div = NULL;
>> +       int num_parent;
>> +       int ret = 0;
>> +
>> +       if (data->gate_shift != UNUSED) {
>> +               gate = devm_kzalloc(dev, sizeof(*gate), GFP_KERNEL);
>> +
>> +               if (!gate)
>> +                       return -ENOMEM;
>> +
>> +               gate->reg = reg + CLK_DIS;
>> +               gate->bit_idx = data->gate_shift;
>> +               gate->lock = lock;
>> +               gate_ops = &clk_gate_ops;
>> +               gate_hw = &gate->hw;
>> +       }
>> +
>> +       if (data->mux_shift != UNUSED) {
>> +               mux = devm_kzalloc(dev, sizeof(*mux), GFP_KERNEL);
>> +
>> +               if (!mux) {
>> +                       ret = -ENOMEM;
>> +                       goto free_gate;
>> +               }
>> +
>> +               mux->reg = reg + TBG_SEL;
>> +               mux->shift = data->mux_shift;
>> +               mux->mask = 0x3;
>> +               mux->lock = lock;
>> +               mux_ops = &clk_mux_ro_ops;
>> +               mux_hw = &mux->hw;
>> +       }
>> +
>> +       if (data->div_reg1 != UNUSED) {
>> +               if (data->div_reg2 == UNUSED) {
>> +                       const struct clk_div_table *clkt;
>> +                       int table_size = 0;
>> +
>> +                       div = devm_kzalloc(dev, sizeof(*div), GFP_KERNEL);
>> +                       if (!div) {
>> +                               ret = -ENOMEM;
>> +                               goto free_mux;
>> +                       }
>> +
>> +                       div->reg = reg + data->div_reg1;
>> +                       div->table = data->table;
>> +                       for (clkt = div->table; clkt->div; clkt++)
>> +                               table_size++;
>> +                       div->width = order_base_2(table_size);
>> +                       div->lock = lock;
>> +                       div_ops = &clk_divider_ro_ops;
>> +                       div_hw = &div->hw;
>> +               } else {
>> +                       double_div = devm_kzalloc(dev, sizeof(*double_div),
>> +                                                 GFP_KERNEL);
>> +                       if (!double_div) {
>> +                               ret = -ENOMEM;
>> +                               goto free_mux;
>> +                       }
>> +
>> +                       double_div->reg1 = reg + data->div_reg1;
>> +                       double_div->shift1 = data->div_shift1;
>> +                       double_div->reg2 = reg + data->div_reg1;
>> +                       double_div->shift2 = data->div_shift2;
>> +                       div_ops = &clk_double_div_ops;
>> +                       div_hw = &double_div->hw;
>> +               }
>> +       }
>> +
>> +       switch (data->flags) {
>> +       case XTAL_CHILD:
>> +               /* the xtal clock is the 5th clock */
>> +               names = &parent_name[4];
>> +               num_parent = 1;
>> +               break;
>> +       case TBGA_S_CHILD:
>> +               /* the TBG A S clock is the 3rd clock */
>> +               names = &parent_name[2];
>> +               num_parent = 1;
>> +               break;
>> +       case GBE_CORE_CHILD:
>> +               names = &gbe_name[1];
>> +               num_parent = 1;
>> +               break;
>> +       case  GBE_50_CHILD:
>> +               names = &gbe_name[0];
>> +               num_parent = 1;
>> +               break;
>> +       case  GBE_125_CHILD:
>> +               names = &gbe_name[2];
>> +               num_parent = 1;
>> +               break;
>> +       default:
>> +               names = parent_name;
>> +               num_parent = 4;
>> +       }
>> +       hw = clk_hw_register_composite(dev, data->name,
>> +                                    names, num_parent,
>> +                                    mux_hw, mux_ops,
>> +                                    div_hw, div_ops,
>> +                                    gate_hw, gate_ops,
>> +                                    CLK_IGNORE_UNUSED);
>> +       if (IS_ERR(hw)) {
>> +               ret = PTR_ERR(hw);
>> +               goto free_div;
>> +       }
>> +
>> +       return 0;
>> +free_div:
>> +       devm_kfree(dev, div);
>> +       devm_kfree(dev, double_div);
>> +free_mux:
>> +       devm_kfree(dev, mux);
>> +free_gate:
>> +       devm_kfree(dev, gate);
>> +       return ret;
>> +}
>
> Can this "add" function (aka registration function) be replaced with
> static data instead? I think that all of the static data exists already,
> this function can be removed and your probe can call clk_hw_register
> directly.
>

I see your point and indeed we can remove some allocation. However using
clk_hw_register with composite clock is not straight forward. Indeed the
clk_ops is filled in the clk_hw_register_composite function and none of
these operations are exported outside the clk-composite.c file.

We can't directly point a clk_gate_ops structure or a clk_divider_ops as
you did in the drivers/clk/meson/gxbb.c file for example. For clk
composite it would need modify the framework to either export all the
operation or to create set of operations directly usable and I would
like to avoid doing it when we are close to the merge window.

However I can use static data for the clk_mux, clk_gate and clk_divider
struct.

Is it OK for you?

Thanks,

Gregory

> It might need a macro though, since composite clock structures are
> rather messy. This avoids a lot of unnecessary allocations and time
> populating data that we already have access to. In general I am trying
> to encourage clk drivers to use only clk_hw_register() in their probe
> instead of the helper registration functions.
>
> Similarly I am discouraging drivers from populating hw.init at run-time,
> since we already have that data for that at compile-time.
>
> Regards,
> Mike

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
