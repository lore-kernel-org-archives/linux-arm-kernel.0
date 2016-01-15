From: wdc@rock-chips.com (David.Wu)
Date: Fri, 15 Jan 2016 16:34:44 +0800
Subject: [PATCH v3 2/4] i2c: rk3x: add ops to caculate i2c clocks
In-Reply-To: <CAHp75VdR01_suo3nTWuuT2OEusy6z6KGSg29LKD8T3kY9eGMPA@mail.gmail.com>
References: <1452774699-57455-1-git-send-email-david.wu@rock-chips.com>
 <1452774699-57455-3-git-send-email-david.wu@rock-chips.com>
 <CAHp75VdR01_suo3nTWuuT2OEusy6z6KGSg29LKD8T3kY9eGMPA@mail.gmail.com>
Message-ID: <5698AF24.2030202@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Andy,

? 2016/1/14 21:19, Andy Shevchenko ??:
> On Thu, Jan 14, 2016 at 2:31 PM, David Wu <david.wu@rock-chips.com> wrote:
>> From: David Wu <wdc@rock-chips.com>
>>
>> I2c Controller of rk3x is updated for the rules to caculate clocks.
>> So it need a new method to caculate i2c clock timing information
>> for new version. The current method is defined as v0, and new is
>> v1, next maybe v2......
> Thanks for an update. My comments below.
>
>> --- a/drivers/i2c/busses/i2c-rk3x.c
>> +++ b/drivers/i2c/busses/i2c-rk3x.c
>> @@ -90,10 +95,27 @@ struct rk3x_i2c_soc_data {
>>          int grf_offset;
>>   };
>>
>> +/**
>> + * struct rk3x_priv_i2c_timings - rk3x I2C timing information
>> + * @div_low: Divider output for low
>> + * @div_high: Divider output for high
>> + */
>> +struct rk3x_priv_i2c_timings {
>> +       unsigned long div_low;
>> +       unsigned long div_high;
>> +};
>> +
>> +struct rk3x_i2c_ops {
>> +       int (*calc_clock)(unsigned long,
>> +                         struct i2c_timings *,
>> +                         struct rk3x_priv_i2c_timings *);
>> +};
>> +
>>   struct rk3x_i2c {
>>          struct i2c_adapter adap;
>>          struct device *dev;
>>          struct rk3x_i2c_soc_data *soc_data;
>> +       struct rk3x_i2c_ops ops;
> Not much sense for now to have a struct for one member.

Yes, it looks ok not to do change here.

>>          /* Hardware resources */
>>          void __iomem *regs;
>> @@ -102,6 +124,7 @@ struct rk3x_i2c {
>>
> What about
>        /* I2C timing settings */
>        struct i2c_timings t;
>
>        /* Divider settings */
>        int (*calc_divs)(unsigned long,
>                          struct i2c_timings *,
>                          unsigned long *div_low,
>                          unsigned long *div_high);
>        unsigned long div_low;
>        unsigned long div_high;
> ?
>
> As far as I understand you still calculate divider values.
>
>>          /* Synchronization & notification */
>>          spinlock_t lock;
>> @@ -431,21 +454,20 @@ out:
>>   }
>>
>>   /**
>> - * Calculate divider values for desired SCL frequency
>> + * Calculate timing clock info values for desired SCL frequency
>>    *
>>    * @clk_rate: I2C input clock rate
>> - * @t_input: Known I2C timing information.
>> - * @div_low: Divider output for low
>> - * @div_high: Divider output for high
> For now seems better to leave this prototype.
>
>> + * @t_input: Known I2C timing information
>> + * @t_output: Caculated rk3x private timing information that would
>> + * be written into regs
>>    *
>>    * Returns: 0 on success, -EINVAL if the goal SCL rate is too slow. In that case
>>    * a best-effort divider value is returned in divs. If the target rate is
>>    * too high, we silently use the highest possible rate.
>>    */
>> -static int rk3x_i2c_calc_divs(unsigned long clk_rate,
>> -                             struct i2c_timings *t_input,
>> -                             unsigned long *div_low,
>> -                             unsigned long *div_high)
>> +static int rk3x_i2c_v0_calc_clock(unsigned long clk_rate,
>> +                                 struct i2c_timings *t_input,
>> +                                 struct rk3x_priv_i2c_timings *t_output)
>>   {
>>          unsigned long spec_min_low_ns, spec_min_high_ns;
>>          unsigned long spec_setup_start, spec_max_data_hold_ns;
>
>> @@ -583,25 +605,25 @@ static int rk3x_i2c_calc_divs(unsigned long clk_rate,
>>
>>                  /* Give low the "ideal" and give high whatever extra is left */
>>                  extra_low_div = ideal_low_div - min_low_div;
>> -               *div_low = ideal_low_div;
>> -               *div_high = min_high_div + (extra_div - extra_low_div);
>> +               t_output->div_low = ideal_low_div;
>> +               t_output->div_high = min_high_div + (extra_div - extra_low_div);
>>          }
>>
>>          /*
>>           * Adjust to the fact that the hardware has an implicit "+1".
>>           * NOTE: Above calculations always produce div_low > 0 and div_high > 0.
>>           */
>> -       *div_low = *div_low - 1;
>> -       *div_high = *div_high - 1;
>> +       t_output->div_low = t_output->div_low - 1;
> -= 1
>
>> +       t_output->div_high = t_output->div_high - 1;
> Ditto.
>
> But without change of prototype those no needed.
>
>>          /* Maximum divider supported by hw is 0xffff */
>> -       if (*div_low > 0xffff) {
>> -               *div_low = 0xffff;
>> +       if (t_output->div_low > 0xffff) {
>> +               t_output->div_low = 0xffff;
>>                  ret = -EINVAL;
>>          }
>>
>> -       if (*div_high > 0xffff) {
>> -               *div_high = 0xffff;
>> +       if (t_output->div_high > 0xffff) {
>> +               t_output->div_high = 0xffff;
>>                  ret = -EINVAL;
>>          }
>>
>> @@ -610,19 +632,21 @@ static int rk3x_i2c_calc_divs(unsigned long clk_rate,
>>
>>   static void rk3x_i2c_adapt_div(struct rk3x_i2c *i2c, unsigned long clk_rate)
>>   {
>> -       unsigned long div_low, div_high;
>>          u64 t_low_ns, t_high_ns;
>>          int ret;
>>
>> -       ret = rk3x_i2c_calc_divs(clk_rate, &i2c->t, &div_low, &div_high);
>> +       ret = i2c->ops.calc_clock(clk_rate, &i2c->t, &i2c->t_priv);
>>          WARN_ONCE(ret != 0, "Could not reach SCL freq %u", i2c->t.bus_freq_hz);
>>
>>          clk_enable(i2c->clk);
>> -       i2c_writel(i2c, (div_high << 16) | (div_low & 0xffff), REG_CLKDIV);
>> +       i2c_writel(i2c, (i2c->t_priv.div_high << 16) |
>> +                 (i2c->t_priv.div_low & 0xffff), REG_CLKDIV);
>>          clk_disable(i2c->clk);
>>
>> -       t_low_ns = div_u64(((u64)div_low + 1) * 8 * 1000000000, clk_rate);
>> -       t_high_ns = div_u64(((u64)div_high + 1) * 8 * 1000000000, clk_rate);
>> +       t_low_ns = div_u64(((u64)i2c->t_priv.div_low + 1) * 8 * 1000000000,
>> +                          clk_rate);
>> +       t_high_ns = div_u64(((u64)i2c->t_priv.div_high + 1) * 8 * 1000000000,
>> +                           clk_rate);
>>          dev_dbg(i2c->dev,
>>                  "CLK %lukhz, Req %uns, Act low %lluns high %lluns\n",
>>                  clk_rate / 1000,
>> @@ -652,12 +676,11 @@ static int rk3x_i2c_clk_notifier_cb(struct notifier_block *nb, unsigned long
>>   {
>>          struct clk_notifier_data *ndata = data;
>>          struct rk3x_i2c *i2c = container_of(nb, struct rk3x_i2c, clk_rate_nb);
>> -       unsigned long div_low, div_high;
>>
>>          switch (event) {
>>          case PRE_RATE_CHANGE:
>> -               if (rk3x_i2c_calc_divs(ndata->new_rate, &i2c->t,
>> -                                      &div_low, &div_high) != 0)
>> +               if (i2c->ops.calc_clock(ndata->new_rate, &i2c->t,
>> +                                       &i2c->t_priv) != 0)
>>                          return NOTIFY_STOP;
>>
>>                  /* scale up */
>> @@ -861,6 +884,7 @@ static int rk3x_i2c_probe(struct platform_device *pdev)
>>          u32 value;
>>          int irq;
>>          unsigned long clk_rate;
>> +       unsigned int version;
> No need to have a separate variable?
>
>> +       version = (readl(i2c->regs + REG_CON) & VERSION_MASK) >> VERSION_SHIFT;
>> +       if (version == RK3X_I2C_V0)
>> +               i2c->ops.calc_clock = rk3x_i2c_v0_calc_clock;
> value = readl(i2c->regs + REG_CON);
> if ((value & VERSION_MASK) >> VERSION_SHIFT) == RK3X_I2C_V0)
>    i2c->ops.calc_clock = rk3x_i2c_v0_calc_clock;
>
