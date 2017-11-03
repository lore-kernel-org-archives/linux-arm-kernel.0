From: zhang.lyra@gmail.com (Chunyan Zhang)
Date: Fri, 3 Nov 2017 20:12:35 +0800
Subject: [PATCH V3 05/11] clk: sprd: add mux clock support
In-Reply-To: <532aed43-03bf-ea26-bdc2-d7deb1093f53@arm.com>
References: <20171102065626.21835-1-chunyan.zhang@spreadtrum.com>
 <20171102065626.21835-6-chunyan.zhang@spreadtrum.com>
 <532aed43-03bf-ea26-bdc2-d7deb1093f53@arm.com>
Message-ID: <CAAfSe-tUF1YiDf_y4-GXBKTjiVCkL-y627mUjss6CZ6jr0CPTg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Julien,

On 3 November 2017 at 02:11, Julien Thierry <julien.thierry@arm.com> wrote:
> Hi,
>
>
> On 02/11/17 06:56, Chunyan Zhang wrote:
>>
>> This patch adds clock multiplexor support for Spreadtrum platforms,
>> the mux clocks also can be found in sprd composite clocks, so
>> provides two helpers that can be reused later on.
>>
>> Signed-off-by: Chunyan Zhang <chunyan.zhang@spreadtrum.com>
>> ---
>>   drivers/clk/sprd/Makefile |  1 +
>>   drivers/clk/sprd/mux.c    | 89
>> +++++++++++++++++++++++++++++++++++++++++++++++
>>   drivers/clk/sprd/mux.h    | 65 ++++++++++++++++++++++++++++++++++
>>   3 files changed, 155 insertions(+)
>>   create mode 100644 drivers/clk/sprd/mux.c
>>   create mode 100644 drivers/clk/sprd/mux.h
>>
>> diff --git a/drivers/clk/sprd/Makefile b/drivers/clk/sprd/Makefile
>> index 8cd5592..cee36b5 100644
>> --- a/drivers/clk/sprd/Makefile
>> +++ b/drivers/clk/sprd/Makefile
>> @@ -2,3 +2,4 @@ obj-$(CONFIG_SPRD_COMMON_CLK)   += clk-sprd.o
>>     clk-sprd-y  += common.o
>>   clk-sprd-y    += gate.o
>> +clk-sprd-y     += mux.o
>> diff --git a/drivers/clk/sprd/mux.c b/drivers/clk/sprd/mux.c
>> new file mode 100644
>> index 0000000..5a344e0
>> --- /dev/null
>> +++ b/drivers/clk/sprd/mux.c
>> @@ -0,0 +1,89 @@
>> +/*
>> + * Spreadtrum multiplexer clock driver
>> + *
>> + * Copyright (C) 2017 Spreadtrum, Inc.
>> + * Author: Chunyan Zhang <chunyan.zhang@spreadtrum.com>
>> + *
>> + * SPDX-License-Identifier: GPL-2.0
>> + */
>> +
>> +#include <linux/clk.h>
>> +#include <linux/clk-provider.h>
>> +#include <linux/regmap.h>
>> +
>> +#include "mux.h"
>> +
>> +DEFINE_SPINLOCK(sprd_mux_lock);
>> +EXPORT_SYMBOL_GPL(sprd_mux_lock);
>> +
>> +u8 sprd_mux_helper_get_parent(const struct sprd_clk_common *common,
>> +                             const struct sprd_mux_internal *mux)
>> +{
>> +       unsigned int reg;
>> +       u8 parent;
>> +       int num_parents;
>> +       int i;
>> +
>> +       sprd_regmap_read(common->regmap, common->reg, &reg);
>> +       parent = reg >> mux->shift;
>> +       parent &= (1 << mux->width) - 1;
>> +
>> +       if (mux->table) {
>> +               num_parents = clk_hw_get_num_parents(&common->hw);
>> +
>> +               for (i = 0; i < num_parents; i++)
>> +                       if (parent == mux->table[i] ||
>> +                           (i < (num_parents - 1) && parent >
>> mux->table[i] &&
>> +                            parent < mux->table[i + 1]))
>> +                               return i;
>> +               if (i == num_parents)
>> +                       return i - 1;
>
>
> The if branch is not necessary since you only get there when the loop has
> finished, so the condition is always true. And the loop can be simplified
> to:
>
> for (i = 0; i < num_parents - 1; i++)
>         if (parent >= mux->table[i] &&  parent < mux->table[i + 1])
>                 return i;
>
> return num_parents;
>
>
>
>> +       }
>> +
>> +       return parent;
>> +}
>> +EXPORT_SYMBOL_GPL(sprd_mux_helper_get_parent);
>> +
>> +static u8 sprd_mux_get_parent(struct clk_hw *hw)
>> +{
>> +       struct sprd_mux *cm = hw_to_sprd_mux(hw);
>> +
>> +       return sprd_mux_helper_get_parent(&cm->common, &cm->mux);
>> +}
>> +
>> +int sprd_mux_helper_set_parent(const struct sprd_clk_common *common,
>> +                              const struct sprd_mux_internal *mux,
>> +                              u8 index)
>> +{
>> +       unsigned long flags = 0;
>> +       unsigned int reg;
>> +
>> +       if (mux->table)
>> +               index = mux->table[index];
>> +
>> +       spin_lock_irqsave(common->lock, flags);
>> +
>> +       sprd_regmap_read(common->regmap, common->reg, &reg);
>> +       reg &= ~GENMASK(mux->width + mux->shift - 1, mux->shift);
>> +       sprd_regmap_write(common->regmap, common->reg,
>> +                         reg | (index << mux->shift));
>> +
>> +       spin_unlock_irqrestore(common->lock, flags);
>> +
>> +       return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(sprd_mux_helper_set_parent);
>> +
>> +static int sprd_mux_set_parent(struct clk_hw *hw, u8 index)
>> +{
>> +       struct sprd_mux *cm = hw_to_sprd_mux(hw);
>> +
>> +       return sprd_mux_helper_set_parent(&cm->common, &cm->mux, index);
>> +}
>> +
>> +const struct clk_ops sprd_mux_ops = {
>> +       .get_parent = sprd_mux_get_parent,
>> +       .set_parent = sprd_mux_set_parent,
>> +       .determine_rate = __clk_mux_determine_rate,
>> +};
>> +EXPORT_SYMBOL_GPL(sprd_mux_ops);
>
>
> Same as with the other patch, I'd recommend have one set of ops for direct
> mux and another one for a mux using a table to map the parents. Keeping
> functions for both modes separate.
>

I might prefer to keep them together, since separating them will
increase many lines of code for maintaining :)
And will export double of these functions, not only for mux driver but
also for composite driver.
And I think the name like "sprd_mux_helper_set_parent_table" is a little long.

Thanks,
Chunyan

> Cheers,
>
>
>> diff --git a/drivers/clk/sprd/mux.h b/drivers/clk/sprd/mux.h
>> new file mode 100644
>> index 0000000..148ca8c
>> --- /dev/null
>> +++ b/drivers/clk/sprd/mux.h
>> @@ -0,0 +1,65 @@
>> +/*
>> + * Spreadtrum multiplexer clock driver
>> + *
>> + * Copyright (C) 2017 Spreadtrum, Inc.
>> + * Author: Chunyan Zhang <chunyan.zhang@spreadtrum.com>
>> + *
>> + * SPDX-License-Identifier: GPL-2.0
>> + */
>> +
>> +#ifndef _SPRD_MUX_H_
>> +#define _SPRD_MUX_H_
>> +
>> +#include "common.h"
>> +
>> +struct sprd_mux_internal {
>> +       u8              shift;
>> +       u8              width;
>> +       const u8        *table;
>> +};
>> +
>> +struct sprd_mux {
>> +       struct sprd_mux_internal mux;
>> +       struct sprd_clk_common  common;
>> +};
>> +
>> +#define _SPRD_MUX_CLK(_shift, _width, _table)          \
>> +       {                                               \
>> +               .shift  = _shift,                       \
>> +               .width  = _width,                       \
>> +               .table  = _table,                       \
>> +       }
>> +
>> +#define SPRD_MUX_CLK(_struct, _name, _parents, _table,                 \
>> +                                    _reg, _shift, _width,              \
>> +                                    _flags)                            \
>> +       struct sprd_mux _struct = {                                     \
>> +               .mux    = _SPRD_MUX_CLK(_shift, _width, _table),        \
>> +               .common = {                                             \
>> +                       .regmap         = NULL,                         \
>> +                       .reg            = _reg,                         \
>> +                       .lock           = &sprd_mux_lock,               \
>> +                       .hw.init = CLK_HW_INIT_PARENTS(_name,           \
>> +                                                      _parents,        \
>> +                                                      &sprd_mux_ops,   \
>> +                                                      _flags),         \
>> +               }                                                       \
>> +       }
>> +
>> +static inline struct sprd_mux *hw_to_sprd_mux(const struct clk_hw *hw)
>> +{
>> +       struct sprd_clk_common *common = hw_to_sprd_clk_common(hw);
>> +
>> +       return container_of(common, struct sprd_mux, common);
>> +}
>> +
>> +extern const struct clk_ops sprd_mux_ops;
>> +extern spinlock_t sprd_mux_lock;
>> +
>> +u8 sprd_mux_helper_get_parent(const struct sprd_clk_common *common,
>> +                             const struct sprd_mux_internal *mux);
>> +int sprd_mux_helper_set_parent(const struct sprd_clk_common *common,
>> +                              const struct sprd_mux_internal *mux,
>> +                              u8 index);
>> +
>> +#endif /* _SPRD_MUX_H_ */
>>
>
> --
> Julien Thierry
