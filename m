From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 23 Aug 2016 17:57:41 +0800
Subject: [PATCH v2 1/5] clk: sunxi-ng: mux: Add support for mux tables
In-Reply-To: <20160823085305.GB2598@lukather>
References: <1471248795-17951-1-git-send-email-wens@csie.org>
 <1471248795-17951-2-git-send-email-wens@csie.org>
 <20160823085305.GB2598@lukather>
Message-ID: <CAGb2v66SDxjubqyyVGHFVQUYnQdB_F-RwY6MgALDJquMWgKJZw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 23, 2016 at 4:53 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> On Mon, Aug 15, 2016 at 04:13:11PM +0800, Chen-Yu Tsai wrote:
>> Some clock muxes have holes, i.e. invalid or unconnected inputs,
>> between parent mux values.
>>
>> Add support for specifying a mux table to map clock parents to
>> mux values.
>>
>> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>> ---
>> Changes since v1: none
>> ---
>>  drivers/clk/sunxi-ng/ccu_mux.c | 12 ++++++++++++
>>  drivers/clk/sunxi-ng/ccu_mux.h | 12 ++++++++++--
>>  2 files changed, 22 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/clk/sunxi-ng/ccu_mux.c b/drivers/clk/sunxi-ng/ccu_mux.c
>> index 1329b9ab481e..68b32f168a74 100644
>> --- a/drivers/clk/sunxi-ng/ccu_mux.c
>> +++ b/drivers/clk/sunxi-ng/ccu_mux.c
>> @@ -107,6 +107,15 @@ u8 ccu_mux_helper_get_parent(struct ccu_common *common,
>>       parent = reg >> cm->shift;
>>       parent &= (1 << cm->width) - 1;
>>
>> +     if (cm->table) {
>> +             int num_parents = clk_hw_get_num_parents(&common->hw);
>> +             int i;
>> +
>> +             for (i = 0; i < num_parents; i++)
>> +                     if (cm->table[i] == parent)
>> +                             return i;
>> +     }
>> +
>>       return parent;
>>  }
>>
>> @@ -117,6 +126,9 @@ int ccu_mux_helper_set_parent(struct ccu_common *common,
>>       unsigned long flags;
>>       u32 reg;
>>
>> +     if (cm->table)
>> +             index = cm->table[index];
>> +
>>       spin_lock_irqsave(common->lock, flags);
>>
>>       reg = readl(common->base + common->reg);
>> diff --git a/drivers/clk/sunxi-ng/ccu_mux.h b/drivers/clk/sunxi-ng/ccu_mux.h
>> index d35ce5e93840..f0078de78712 100644
>> --- a/drivers/clk/sunxi-ng/ccu_mux.h
>> +++ b/drivers/clk/sunxi-ng/ccu_mux.h
>> @@ -6,8 +6,9 @@
>>  #include "ccu_common.h"
>>
>>  struct ccu_mux_internal {
>> -     u8      shift;
>> -     u8      width;
>> +     u8              shift;
>> +     u8              width;
>> +     const u8        *table;
>>
>>       struct {
>>               u8      index;
>> @@ -21,6 +22,13 @@ struct ccu_mux_internal {
>>       } variable_prediv;
>>  };
>>
>> +#define SUNXI_CLK_MUX_TABLE(_shift, _width, _table)  \
>> +     {                                               \
>> +             .shift  = _shift,                       \
>> +             .width  = _width,                       \
>> +             .table  = _table,                       \
>> +     }
>> +
>>  #define SUNXI_CLK_MUX(_shift, _width)        \
>>       {                                       \
>>               .shift  = _shift,               \
>
> I'd prefer if you also converted the SUNXI_CLK_MUX to use the MUX
> table version.

You mean expanding SUNXI_CLK_MUX to SUNXI_CLK_MUX_TABLE right?
Sure.

> I've just merged the renaming patch for those macros to be consistent
> with the other internal structures macro, so that name will have to be
> adjusted..

Please push and I'll do a follow up.

ChenYu
