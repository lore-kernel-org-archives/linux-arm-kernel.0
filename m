From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Sun, 20 Dec 2015 17:43:13 +0200
Subject: [PATCH v1 1/3] i2c: rk3x: add calc_divs ops for new version
In-Reply-To: <566F5FAC.3080404@rock-chips.com>
References: <1449844384-6236-1-git-send-email-wdc@rock-chips.com>
 <566F5FAC.3080404@rock-chips.com>
Message-ID: <CAHp75VfkteDvC0KUXOXDik9rQeanTXLn9Qq3wux-0rxk5ZotNA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 15, 2015 at 2:32 AM, Jianqun Xu <jay.xu@rock-chips.com> wrote:
> Hi David:
>
> It's better to add a cover-letter, and add changes note for new version,
> such as:
>
> changes since v0:
> - split patch to two patches or more, one patch for one new feature (Heiko)
>
> and NOT to have two same signed-off-by

Besides that?

>>   #define REG_CON_LASTACK   BIT(5) /* 1: send NACK after last received
>> byte */
>>   #define REG_CON_ACTACK    BIT(6) /* 1: stop if NACK is received */
>>
>> +#define VERSION_MASK     0xffff0000

GENMASK()

>> +#define VERSION_SHIFT    16
>> +
>> +#define RK3X_I2C_V0      0x0
>> +#define RK3X_I2C_V1      0x1
>> +
>>   /* REG_MRXADDR bits */
>>   #define REG_MRXADDR_VALID(x) BIT(24 + (x)) /* [x*8+7:x*8] of MRX[R]ADDR
>> valid */
>>
>> @@ -90,10 +96,22 @@ struct rk3x_i2c_soc_data {
>>         int grf_offset;
>>   };
>>
>> +struct rk3x_i2c_ops {
>> +       int (*calc_divs)(unsigned long,
>> +                        unsigned long,
>> +                        unsigned long,
>> +                        unsigned long,
>> +                        unsigned long,
>> +                        unsigned long *,
>> +                        unsigned long *,
>> +                        unsigned int *);

Too many arguments, what about struct for them (perhaps two groups)?

>> +};
>> +
>>   struct rk3x_i2c {
>>         struct i2c_adapter adap;
>>         struct device *dev;
>>         struct rk3x_i2c_soc_data *soc_data;
>> +       struct rk3x_i2c_ops ops;
>>
>>         /* Hardware resources */
>>         void __iomem *regs;
>> @@ -116,6 +134,7 @@ struct rk3x_i2c {
>>         u8 addr;
>>         unsigned int mode;
>>         bool is_last_msg;
>> +       unsigned int time_con;
>>
>>         /* I2C state machine */
>>         enum rk3x_i2c_state state;
>> @@ -151,7 +170,8 @@ static void rk3x_i2c_start(struct rk3x_i2c *i2c)
>>         i2c_writel(i2c, REG_INT_START, REG_IEN);
>>
>>         /* enable adapter with correct mode, send START condition */
>> -       val = REG_CON_EN | REG_CON_MOD(i2c->mode) | REG_CON_START;
>> +       val = i2c->time_con | REG_CON_EN | REG_CON_MOD(i2c->mode)
>> +               | REG_CON_START;
>>
>>         /* if we want to react to NACK, set ACTACK bit */
>>         if (!(i2c->msg->flags & I2C_M_IGNORE_NAK))
>> @@ -443,16 +463,19 @@ out:
>>    * @sda_fall_ns: How many ns it takes for SDA to fall.
>>    * @div_low: Divider output for low
>>    * @div_high: Divider output for high
>> + * @con: version0 is not used
>>    *
>>    * Returns: 0 on success, -EINVAL if the goal SCL rate is too slow. In
>> that case
>>    * a best-effort divider value is returned in divs. If the target rate
>> is
>>    * too high, we silently use the highest possible rate.
>>    */
>> -static int rk3x_i2c_calc_divs(unsigned long clk_rate, unsigned long
>> scl_rate,
>> -                             unsigned long scl_rise_ns,
>> -                             unsigned long scl_fall_ns,
>> -                             unsigned long sda_fall_ns,
>> -                             unsigned long *div_low, unsigned long
>> *div_high)
>> +static int rk3x_i2c_v0_calc_divs(unsigned long clk_rate, unsigned long
>> scl_rate,
>> +                                unsigned long scl_rise_ns,
>> +                                unsigned long scl_fall_ns,
>> +                                unsigned long sda_fall_ns,

Wolfram did some sturct to assign the parameters from device properties.
It might be re-used here.

>> +                                unsigned long *div_low,
>> +                                unsigned long *div_high,
>> +                                unsigned int *con)
>>   {
>>         unsigned long spec_min_low_ns, spec_min_high_ns;
>>         unsigned long spec_setup_start, spec_max_data_hold_ns;
>> @@ -616,17 +639,19 @@ static int rk3x_i2c_calc_divs(unsigned long
>> clk_rate, unsigned long scl_rate,
>>
>>   static void rk3x_i2c_adapt_div(struct rk3x_i2c *i2c, unsigned long
>> clk_rate)
>>   {
>> +       unsigned int con = 0;
>>         unsigned long div_low, div_high;
>>         u64 t_low_ns, t_high_ns;
>>         int ret;
>>
>> -       ret = rk3x_i2c_calc_divs(clk_rate, i2c->scl_frequency,
>> i2c->scl_rise_ns,
>> +       ret = i2c->ops.calc_divs(clk_rate, i2c->scl_frequency,
>> i2c->scl_rise_ns,
>>                                  i2c->scl_fall_ns, i2c->sda_fall_ns,
>> -                                &div_low, &div_high);
>> +                                &div_low, &div_high, &con);
>>         WARN_ONCE(ret != 0, "Could not reach SCL freq %u",
>> i2c->scl_frequency);
>>
>>         clk_enable(i2c->clk);
>>         i2c_writel(i2c, (div_high << 16) | (div_low & 0xffff),
>> REG_CLKDIV);
>> +       i2c->time_con = con;
>>         clk_disable(i2c->clk);
>>
>>         t_low_ns = div_u64(((u64)div_low + 1) * 8 * 1000000000, clk_rate);
>> @@ -661,13 +686,14 @@ static int rk3x_i2c_clk_notifier_cb(struct
>> notifier_block *nb, unsigned long
>>         struct clk_notifier_data *ndata = data;
>>         struct rk3x_i2c *i2c = container_of(nb, struct rk3x_i2c,
>> clk_rate_nb);
>>         unsigned long div_low, div_high;
>> +       unsigned int con = 0;
>>
>>         switch (event) {
>>         case PRE_RATE_CHANGE:
>> -               if (rk3x_i2c_calc_divs(ndata->new_rate,
>> i2c->scl_frequency,
>> +               if (i2c->ops.calc_divs(ndata->new_rate,
>> i2c->scl_frequency,
>>                                        i2c->scl_rise_ns, i2c->scl_fall_ns,
>>                                        i2c->sda_fall_ns,
>> -                                      &div_low, &div_high) != 0)
>> +                                      &div_low, &div_high, &con) != 0)
>>                         return NOTIFY_STOP;
>>
>>                 /* scale up */
>> @@ -816,7 +842,8 @@ static int rk3x_i2c_xfer(struct i2c_adapter *adap,
>>
>>                         /* Force a STOP condition without interrupt */
>>                         i2c_writel(i2c, 0, REG_IEN);
>> -                       i2c_writel(i2c, REG_CON_EN | REG_CON_STOP,
>> REG_CON);
>> +                       i2c_writel(i2c, i2c->time_con | REG_CON_EN |
>> +                                  REG_CON_STOP, REG_CON);
>>
>>                         i2c->state = STATE_IDLE;
>>
>> @@ -871,6 +898,7 @@ static int rk3x_i2c_probe(struct platform_device
>> *pdev)
>>         u32 value;
>>         int irq;
>>         unsigned long clk_rate;
>> +       unsigned int version;
>>
>>         i2c = devm_kzalloc(&pdev->dev, sizeof(struct rk3x_i2c),
>> GFP_KERNEL);
>>         if (!i2c)
>> @@ -983,6 +1011,10 @@ static int rk3x_i2c_probe(struct platform_device
>> *pdev)
>>
>>         platform_set_drvdata(pdev, i2c);
>>
>> +       version = (readl(i2c->regs + REG_CON) & VERSION_MASK) >>
>> VERSION_SHIFT;
>> +       if (version == RK3X_I2C_V0)
>> +               i2c->ops.calc_divs = rk3x_i2c_v0_calc_divs;
>> +
>>         ret = clk_prepare(i2c->clk);
>>         if (ret < 0) {
>>                 dev_err(&pdev->dev, "Could not prepare clock\n");
>>



-- 
With Best Regards,
Andy Shevchenko
