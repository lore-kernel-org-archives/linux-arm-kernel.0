From: vishnupatekar0510@gmail.com (Vishnu Patekar)
Date: Wed, 27 Apr 2016 01:55:48 +0800
Subject: [PATCH v2] clk: sunxi: predivider handling for factors clock
In-Reply-To: <CAGb2v66s=2abPvOJnpFYxut3ATLv4ESL-xezhDYcX2DmVaZHYA@mail.gmail.com>
References: <1461084466-20889-1-git-send-email-vishnupatekar0510@gmail.com>
 <1461084466-20889-2-git-send-email-vishnupatekar0510@gmail.com>
 <CAGb2v66s=2abPvOJnpFYxut3ATLv4ESL-xezhDYcX2DmVaZHYA@mail.gmail.com>
Message-ID: <CAEzqOZt6yBK8pcizvz3OxFE_mfk9=OOUqsyv6x-9_Rrx4QzsZg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Wens,

On Mon, Apr 25, 2016 at 10:51 PM, Chen-Yu Tsai <wens@csie.org> wrote:
> Hi,
>
> On Wed, Apr 20, 2016 at 12:47 AM, Vishnu Patekar
> <vishnupatekar0510@gmail.com> wrote:
>> For A31 ahb1 and a83t ahb1 clocks have predivider for certain parent.
>> To handle this, this patch adds predivider table with parent index,
>> prediv shift and width, parents with predivider will have nonzero width.
>>
>> Rate adjustment is moved from clock specific recalc function to generic
>> factors recalc. Also, adds prediv table for a31.
>>
>> Signed-off-by: Vishnu Patekar <vishnupatekar0510@gmail.com>
>> ---
>>  drivers/clk/sunxi/clk-factors.c | 31 +++++++++++++++----------------
>>  drivers/clk/sunxi/clk-factors.h | 10 +++++++++-
>>  drivers/clk/sunxi/clk-sunxi.c   | 31 +++++++++----------------------
>>  3 files changed, 33 insertions(+), 39 deletions(-)
>>
>> diff --git a/drivers/clk/sunxi/clk-factors.c b/drivers/clk/sunxi/clk-factors.c
>> index ddefe96..8f3b637 100644
>> --- a/drivers/clk/sunxi/clk-factors.c
>> +++ b/drivers/clk/sunxi/clk-factors.c
>> @@ -45,10 +45,12 @@ static unsigned long clk_factors_recalc_rate(struct clk_hw *hw,
>>                                              unsigned long parent_rate)
>>  {
>>         u8 n = 1, k = 0, p = 0, m = 0;
>> +       u8 par_index = 0;
>>         u32 reg;
>>         unsigned long rate;
>>         struct clk_factors *factors = to_clk_factors(hw);
>>         const struct clk_factors_config *config = factors->config;
>> +       const struct clk_factors_prediv *prediv = factors->prediv_config;
>>
>>         /* Fetch the register value */
>>         reg = readl(factors->reg);
>> @@ -63,24 +65,16 @@ static unsigned long clk_factors_recalc_rate(struct clk_hw *hw,
>>         if (config->pwidth != SUNXI_FACTORS_NOT_APPLICABLE)
>>                 p = FACTOR_GET(config->pshift, config->pwidth, reg);
>>
>> -       if (factors->recalc) {
>> -               struct factors_request factors_req = {
>> -                       .parent_rate = parent_rate,
>> -                       .n = n,
>> -                       .k = k,
>> -                       .m = m,
>> -                       .p = p,
>> -               };
>> -
>> +       if (prediv) {
>>                 /* get mux details from mux clk structure */
>>                 if (factors->mux)
>> -                       factors_req.parent_index =
>> -                               (reg >> factors->mux->shift) &
>> -                               factors->mux->mask;
>> -
>> -               factors->recalc(&factors_req);
>> +                       par_index = (reg >> factors->mux->shift) &
>> +                                       factors->mux->mask;
>>
>> -               return factors_req.rate;
>> +               if (prediv[par_index].width != SUNXI_FACTORS_NOT_APPLICABLE) {
>> +                       m = FACTOR_GET(prediv[par_index].shift,
>> +                               prediv[par_index].width, reg);
>> +               }
>>         }
>>
>>         /* Calculate the rate */
>> @@ -102,8 +96,12 @@ static int clk_factors_determine_rate(struct clk_hw *hw,
>>         for (i = 0; i < num_parents; i++) {
>>                 struct factors_request factors_req = {
>>                         .rate = req->rate,
>> -                       .parent_index = i,
>>                 };
>> +
>> +               if (factors->prediv_config)
>> +                       factors_req.prediv_width =
>> +                                               factors->prediv_config[i].width;
>> +
>>                 parent = clk_hw_get_parent_by_index(hw, i);
>>                 if (!parent)
>>                         continue;
>> @@ -211,6 +209,7 @@ struct clk *sunxi_factors_register(struct device_node *node,
>>         /* set up factors properties */
>>         factors->reg = reg;
>>         factors->config = data->table;
>> +       factors->prediv_config = data->prediv_table;
>>         factors->get_factors = data->getter;
>>         factors->recalc = data->recalc;
>>         factors->lock = lock;
>> diff --git a/drivers/clk/sunxi/clk-factors.h b/drivers/clk/sunxi/clk-factors.h
>> index 1e63c5b..b1b7745 100644
>> --- a/drivers/clk/sunxi/clk-factors.h
>> +++ b/drivers/clk/sunxi/clk-factors.h
>> @@ -18,10 +18,16 @@ struct clk_factors_config {
>>         u8 n_start;
>>  };
>>
>> +struct clk_factors_prediv {
>> +       u8 parent_index;
>> +       u8 shift;
>> +       u8 width;
>> +};
>> +
>>  struct factors_request {
>>         unsigned long rate;
>>         unsigned long parent_rate;
>> -       u8 parent_index;
>> +       u8 prediv_width;
>>         u8 n;
>>         u8 k;
>>         u8 m;
>> @@ -33,6 +39,7 @@ struct factors_data {
>>         int mux;
>>         int muxmask;
>>         const struct clk_factors_config *table;
>> +       const struct clk_factors_prediv *prediv_table;
>>         void (*getter)(struct factors_request *req);
>>         void (*recalc)(struct factors_request *req);
>
> You removed usage of this callback. Please remove it from the data structures
> as well, so no one assumes it's still applicable.
Okie, I'll remove it.
>
>>         const char *name;
>> @@ -42,6 +49,7 @@ struct clk_factors {
>>         struct clk_hw hw;
>>         void __iomem *reg;
>>         const struct clk_factors_config *config;
>> +       const struct clk_factors_prediv *prediv_config;
>>         void (*get_factors)(struct factors_request *req);
>>         void (*recalc)(struct factors_request *req);
>>         spinlock_t *lock;
>> diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
>> index 91de0a0..5a5f26b 100644
>> --- a/drivers/clk/sunxi/clk-sunxi.c
>> +++ b/drivers/clk/sunxi/clk-sunxi.c
>> @@ -282,8 +282,6 @@ static void sun5i_a13_get_ahb_factors(struct factors_request *req)
>>         req->p = div;
>>  }
>>
>> -#define SUN6I_AHB1_PARENT_PLL6 3
>> -
>>  /**
>>   * sun6i_a31_get_ahb_factors() - calculates m, p factors for AHB
>>   * AHB rate is calculated as follows
>> @@ -307,7 +305,7 @@ static void sun6i_get_ahb1_factors(struct factors_request *req)
>>         div = DIV_ROUND_UP(req->parent_rate, req->rate);
>>
>>         /* calculate pre-divider if parent is pll6 */
>> -       if (req->parent_index == SUN6I_AHB1_PARENT_PLL6) {
>> +       if (req->prediv_width) {
>>                 if (div < 4)
>>                         calcp = 0;
>>                 else if (div / 2 < 4)
>> @@ -329,22 +327,6 @@ static void sun6i_get_ahb1_factors(struct factors_request *req)
>>  }
>>
>>  /**
>> - * sun6i_ahb1_recalc() - calculates AHB clock rate from m, p factors and
>> - *                      parent index
>> - */
>> -static void sun6i_ahb1_recalc(struct factors_request *req)
>> -{
>> -       req->rate = req->parent_rate;
>> -
>> -       /* apply pre-divider first if parent is pll6 */
>> -       if (req->parent_index == SUN6I_AHB1_PARENT_PLL6)
>> -               req->rate /= req->m + 1;
>> -
>> -       /* clk divider */
>> -       req->rate >>= req->p;
>> -}
>> -
>> -/**
>>   * sun4i_get_apb1_factors() - calculates m, p factors for APB1
>>   * APB1 rate is calculated as follows
>>   * rate = (parent_rate >> p) / (m + 1);
>> @@ -474,12 +456,17 @@ static const struct clk_factors_config sun5i_a13_ahb_config = {
>>  };
>>
>>  static const struct clk_factors_config sun6i_ahb1_config = {
>> -       .mshift = 6,
>> -       .mwidth = 2,
>>         .pshift = 4,
>>         .pwidth = 2,
>>  };
>>
>> +static const struct clk_factors_prediv sun6i_ahb1_prediv[] = {
>> +       {.parent_index = 0, .shift = 0, .width = 0 },   /* LOSC  */
>> +       {.parent_index = 1, .shift = 0, .width = 0 },   /* OSC24MHz */
>> +       {.parent_index = 2, .shift = 0, .width = 0 },   /* AXI */
>> +       {.parent_index = 3, .shift = 6, .width = 2 }    /* PLL6/Pre_div */
>
>            ^ a space here would be nice.                         ^
> spaces around here too.
Okie.
>
>> +};
>> +
>>  static const struct clk_factors_config sun4i_apb1_config = {
>>         .mshift = 0,
>>         .mwidth = 5,
>> @@ -551,8 +538,8 @@ static const struct factors_data sun6i_ahb1_data __initconst = {
>>         .mux = 12,
>>         .muxmask = BIT(1) | BIT(0),
>>         .table = &sun6i_ahb1_config,
>> +       .prediv_table = sun6i_ahb1_prediv,
>>         .getter = sun6i_get_ahb1_factors,
>> -       .recalc = sun6i_ahb1_recalc,
>>  };
>>
>>  static const struct factors_data sun4i_apb1_data __initconst = {
>> --
>> 1.9.1
>>
>
> The rest looks good.
Thanks for the review.
>
> Regards
> ChenYu
