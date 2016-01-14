From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Thu, 14 Jan 2016 15:29:30 +0200
Subject: [PATCH v3 3/4] i2c: rk3x: new method to caculate i2c clocks
In-Reply-To: <1452774699-57455-4-git-send-email-david.wu@rock-chips.com>
References: <1452774699-57455-1-git-send-email-david.wu@rock-chips.com>
 <1452774699-57455-4-git-send-email-david.wu@rock-chips.com>
Message-ID: <CAHp75VcweSAdUbe8V1UxsNXeQ-7gpeMS8DAdVe1MiCXVPHNjLA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 14, 2016 at 2:31 PM, David Wu <david.wu@rock-chips.com> wrote:
> There was an timing issue about "repeated start" time at the I2C
> controller of version0, controller appears to drop SDA at .875x (7/8)
> programmed clk high. The rule(.875x) isn't enough to meet tSU;STA
> requirements on 100k's Standard-mode. To resolve this issue,
> data_upd_st, start_setup_cnt and stop_setup_cnt configs for I2C
> timing information are added, new rules are designed to calculate
> the timing information at new v1.

> --- a/drivers/i2c/busses/i2c-rk3x.c
> +++ b/drivers/i2c/busses/i2c-rk3x.c
> @@ -58,10 +58,15 @@ enum {
>  #define REG_CON_LASTACK   BIT(5) /* 1: send NACK after last received byte */
>  #define REG_CON_ACTACK    BIT(6) /* 1: stop if NACK is received */
>
> +#define REG_CON_SDA_CNT(cnt)  ((cnt) << 8)
> +#define REG_CON_STA_CNT(cnt)  ((cnt) << 12)
> +#define REG_CON_STO_CNT(cnt)  ((cnt) << 14)
> +
>  #define VERSION_MASK     GENMASK(31, 16)
>  #define VERSION_SHIFT    16
>
>  #define RK3X_I2C_V0      0x0
> +#define RK3X_I2C_V1      0x1
>
>  /* REG_MRXADDR bits */
>  #define REG_MRXADDR_VALID(x) BIT(24 + (x)) /* [x*8+7:x*8] of MRX[R]ADDR valid */
> @@ -99,10 +104,16 @@ struct rk3x_i2c_soc_data {
>   * struct rk3x_priv_i2c_timings - rk3x I2C timing information
>   * @div_low: Divider output for low
>   * @div_high: Divider output for high
> + * @thd_sda_count: SDA update point config used to adjust sda setup/hold time
> + * @tsu_sta_count: Start setup config for setup start time and hold start time
> + * @tsu_sto_count: Stop setup config for setup stop time
>   */
>  struct rk3x_priv_i2c_timings {
>         unsigned long div_low;
>         unsigned long div_high;
> +       unsigned int thd_sda_count;
> +       unsigned int tsu_sta_count;
> +       unsigned int tsu_sto_count;
>  };

And in this (or even separate) patch makes sense to introduce
extension structure, which is struct rk3x_priv_i2c_timings.

>  struct rk3x_i2c_ops {
> @@ -154,6 +165,13 @@ static inline u32 i2c_readl(struct rk3x_i2c *i2c, unsigned int offset)
>         return readl(i2c->regs + offset);
>  }
>
> +static inline u32 rk3x_i2c_get_con_count(struct rk3x_i2c *i2c)
> +{
> +       return REG_CON_SDA_CNT(i2c->t_priv.thd_sda_count) |
> +              REG_CON_STA_CNT(i2c->t_priv.tsu_sta_count) |
> +              REG_CON_STO_CNT(i2c->t_priv.tsu_sto_count);
> +}
> +
>  /* Reset all interrupt pending bits */
>  static inline void rk3x_i2c_clean_ipd(struct rk3x_i2c *i2c)
>  {
> @@ -165,13 +183,13 @@ static inline void rk3x_i2c_clean_ipd(struct rk3x_i2c *i2c)
>   */
>  static void rk3x_i2c_start(struct rk3x_i2c *i2c)
>  {
> -       u32 val;
> +       u32 val = rk3x_i2c_get_con_count(i2c);
>
>         rk3x_i2c_clean_ipd(i2c);
>         i2c_writel(i2c, REG_INT_START, REG_IEN);
>
>         /* enable adapter with correct mode, send START condition */
> -       val = REG_CON_EN | REG_CON_MOD(i2c->mode) | REG_CON_START;
> +       val = val | REG_CON_EN | REG_CON_MOD(i2c->mode) | REG_CON_START;
>
>         /* if we want to react to NACK, set ACTACK bit */
>         if (!(i2c->msg->flags & I2C_M_IGNORE_NAK))
> @@ -212,7 +230,7 @@ static void rk3x_i2c_stop(struct rk3x_i2c *i2c, int error)
>                  * get the intended effect by resetting its internal state
>                  * and issuing an ordinary START.
>                  */
> -               i2c_writel(i2c, 0, REG_CON);
> +               i2c_writel(i2c, rk3x_i2c_get_con_count(i2c), REG_CON);
>
>                 /* signal that we are finished with the current msg */
>                 wake_up(&i2c->wait);
> @@ -630,6 +648,211 @@ static int rk3x_i2c_v0_calc_clock(unsigned long clk_rate,
>         return ret;
>  }
>
> +/**
> + * Calculate timing clock info values for desired SCL frequency
> + *
> + * @clk_rate: I2C input clock rate
> + * @t_input: Known I2C timing information
> + * @t_output: Caculated rk3x private timing information that would
> + * be written into regs
> + * Returns: 0 on success, -EINVAL if the goal SCL rate is too slow. In that case
> + * a best-effort divider value is returned in divs. If the target rate is
> + * too high, we silently use the highest possible rate.
> + * The following formulas are v1's method to calculate clock.
> + *
> + * l = divl + 1;
> + * h = divh + 1;
> + * s = data_upd_st + 1;
> + * u = start_setup_cnt + 1;
> + * p = stop_setup_cnt + 1;
> + * T = Tclk_i2c;
> +
> + * tHigh = 8 * h * T;
> + * tLow = 8 * l * T;
> +
> + * tHD;sda = (l * s + 1) * T;
> + * tSU;sda = [(8 - s) * l + 1] * T;
> + * tI2C = 8 * (l + h) * T;
> +
> + * tSU;sta = (8h * u + 1) * T;
> + * tHD;sta = [8h * (u + 1) - 1] * T;
> + * tSU;sto = (8h * p + 1) * T;
> + */
> +static int rk3x_i2c_v1_calc_clock(unsigned long clk_rate,
> +                                 struct i2c_timings *t_input,
> +                                 struct rk3x_priv_i2c_timings *t_output)
> +{

I see some similarities with existing code for v0. Can be refactored?

> +       unsigned long spec_min_low_ns, spec_min_high_ns;
> +       unsigned long spec_min_setup_start_ns, spec_min_stop_setup_ns;
> +       unsigned long spec_min_data_setup_ns, spec_max_data_hold_ns;
> +
> +       unsigned long min_low_ns, min_high_ns, min_total_ns;
> +       unsigned long min_setup_start_ns, min_setup_data_ns;
> +       unsigned long min_stop_setup_ns, max_hold_data_ns;
> +
> +       unsigned long clk_rate_khz, scl_rate_khz;
> +
> +       unsigned long min_low_div, min_high_div;
> +
> +       unsigned long min_div_for_hold, min_total_div;
> +       unsigned long extra_div, extra_low_div;
> +       unsigned long data_hd_cnt;
> +
> +       int ret = 0;
> +
> +       /* Support standard-mode and fast-mode */
> +       if (WARN_ON(t_input->bus_freq_hz > 400000))
> +               t_input->bus_freq_hz = 400000;
> +
> +       /* prevent scl_rate_khz from becoming 0 */
> +       if (WARN_ON(t_input->bus_freq_hz < 1000))
> +               t_input->bus_freq_hz = 1000;
> +
> +       /*
> +        * min_low_ns: The minimum number of ns we need to hold low to
> +        *             meet I2C specification, should include fall time.
> +        * min_high_ns: The minimum number of ns we need to hold high to
> +        *              meet I2C specification, should include rise time.
> +        */
> +       if (t_input->bus_freq_hz <= 100000) {
> +               spec_min_low_ns = 4700;
> +               spec_min_high_ns = 4000;
> +
> +               spec_min_setup_start_ns = 4700;
> +               spec_min_stop_setup_ns = 4000;
> +
> +               spec_min_data_setup_ns = 250;
> +                spec_max_data_hold_ns = 3450;
> +       } else if (t_input->bus_freq_hz <= 400000) {
> +               spec_min_low_ns = 1300;
> +               spec_min_high_ns = 600;
> +
> +               spec_min_setup_start_ns = 600;
> +               spec_min_stop_setup_ns = 600;
> +
> +               spec_min_data_setup_ns = 100;
> +               spec_max_data_hold_ns = 900;
> +       }
> +
> +       /* caculate min-divh and min-divl */
> +       clk_rate_khz = DIV_ROUND_UP(clk_rate, 1000);
> +       scl_rate_khz = t_input->bus_freq_hz / 1000;
> +       min_total_div = DIV_ROUND_UP(clk_rate_khz, scl_rate_khz * 8);
> +
> +       min_high_ns = t_input->scl_rise_ns + spec_min_high_ns;
> +       min_high_div = DIV_ROUND_UP(clk_rate_khz * min_high_ns, 8 * 1000000);
> +
> +       min_low_ns = t_input->scl_fall_ns + spec_min_low_ns;
> +       min_low_div = DIV_ROUND_UP(clk_rate_khz * min_low_ns, 8 * 1000000);
> +
> +       /* Final divh and divl must be greater than 0, otherwise the
> +        * hardware would not output the i2c clk.
> +        */
> +       if (min_high_div <= 1)
> +               min_high_div = 2;
> +       if (min_low_div <= 1)
> +               min_low_div = 2;
> +
> +       /* These are the min dividers needed for min hold times. */
> +       min_div_for_hold = (min_low_div + min_high_div);
> +       min_total_ns = min_low_ns + min_high_ns;
> +
> +       /*
> +        * This is the maximum divider so we don't go over the maximum.
> +        * We don't round up here (we round down) since this is a maximum.
> +        */
> +        if (min_div_for_hold >= min_total_div) {
> +               /*
> +                * Time needed to meet hold requirements is important.
> +                * Just use that.
> +                */
> +               t_output->div_low = min_low_div;
> +               t_output->div_high = min_high_div;
> +       } else {
> +               /*
> +                * We've got to distribute some time among the low and high
> +                * so we don't run too fast.
> +                * We'll try to split things up by the scale of min_low_div and
> +                * min_high_div, biasing slightly towards having a higher div
> +                * for low (spend more time low).
> +                */
> +               extra_div = min_total_div - min_div_for_hold;
> +               extra_low_div = DIV_ROUND_UP(min_low_div * extra_div,
> +                                            min_div_for_hold);
> +
> +               t_output->div_low = min_low_div + extra_low_div;
> +               t_output->div_high = min_high_div + (extra_div - extra_low_div);
> +       }
> +
> +       /*
> +        * calculate sda data hold count by the rules, thd_sda_count:3
> +        * is a appropriate value to reduce calculated times.
> +        * tHD;sda  = (l * s + 1) * T
> +        * tSU;sda = ((8 - s) * l + 1) * T
> +        */
> +       for (data_hd_cnt = 3; data_hd_cnt >= 0; data_hd_cnt--) {
> +               max_hold_data_ns =  DIV_ROUND_UP((data_hd_cnt
> +                                                * (t_output->div_low) + 1)
> +                                                * 1000000, clk_rate_khz);
> +               min_setup_data_ns =  DIV_ROUND_UP(((8 - data_hd_cnt)
> +                                                * (t_output->div_low) + 1)
> +                                                * 1000000, clk_rate_khz);
> +               if ((max_hold_data_ns < spec_max_data_hold_ns) &&
> +                   (min_setup_data_ns > spec_min_data_setup_ns)) {
> +                       t_output->thd_sda_count = data_hd_cnt;
> +                       break;
> +               }
> +       }
> +
> +       /*
> +        * calculate start setup count, and we aren't care tHD;STA.
> +        * If the start setup count meets the rule of tSU;sta, it also
> +        * meets the rule of tHD;STA.
> +        * tSU;sta = (8h * u + 1) * T
> +        * tHD;sta = [8h * (u + 1) - 1] * T
> +        */
> +       min_setup_start_ns = t_input->scl_rise_ns + spec_min_setup_start_ns;
> +       t_output->tsu_sta_count = DIV_ROUND_UP(clk_rate_khz * min_setup_start_ns
> +                          - 1000000, 8 * 1000000 * (t_output->div_high));
> +
> +       /*
> +        * calculate start setup count by the rule:
> +        * tSU;sto =(8h * p + 1) * T
> +        */
> +       min_stop_setup_ns = t_input->scl_rise_ns + spec_min_stop_setup_ns;
> +       t_output->tsu_sto_count = DIV_ROUND_UP(clk_rate_khz * min_stop_setup_ns
> +                          - 1000000, 8 * 1000000 * (t_output->div_high));
> +
> +       /*
> +        * Adjust to the fact that the hardware has an implicit "+1".
> +        * NOTE: Above calculations always produce div_low > 0 and div_high > 0.
> +        */
> +       t_output->div_low -= 1;
> +       t_output->div_high -= 1;
> +
> +       /* Maximum divider supported by hw is 0xffff */
> +       if (t_output->div_low > 0xffff) {
> +               t_output->div_low = 0xffff;
> +               ret = -EINVAL;
> +       }
> +
> +       if (t_output->div_high > 0xffff) {
> +               t_output->div_high = 0xffff;
> +               ret = -EINVAL;
> +       }
> +
> +       /*
> +        * Adjust to the fact that the hardware has an implicit "+1".
> +        * NOTE: Above calculations always produce thd_sda_count > 0,
> +        * tsu_sta_count > 0 and tsu_sta_count > 0.
> +        */
> +       t_output->thd_sda_count -= 1;
> +       t_output->tsu_sta_count -= 1;
> +       t_output->tsu_sto_count -= 1;
> +
> +       return ret;
> +}
> +
>  static void rk3x_i2c_adapt_div(struct rk3x_i2c *i2c, unsigned long clk_rate)
>  {
>         u64 t_low_ns, t_high_ns;
> @@ -829,7 +1052,8 @@ static int rk3x_i2c_xfer(struct i2c_adapter *adap,
>
>                         /* Force a STOP condition without interrupt */
>                         i2c_writel(i2c, 0, REG_IEN);
> -                       i2c_writel(i2c, REG_CON_EN | REG_CON_STOP, REG_CON);
> +                       i2c_writel(i2c, rk3x_i2c_get_con_count(i2c) |
> +                                       REG_CON_EN | REG_CON_STOP, REG_CON);
>
>                         i2c->state = STATE_IDLE;
>
> @@ -969,7 +1193,9 @@ static int rk3x_i2c_probe(struct platform_device *pdev)
>         platform_set_drvdata(pdev, i2c);
>
>         version = (readl(i2c->regs + REG_CON) & VERSION_MASK) >> VERSION_SHIFT;
> -       if (version == RK3X_I2C_V0)
> +       if (version == RK3X_I2C_V1)
> +               i2c->ops.calc_clock = rk3x_i2c_v1_calc_clock;
> +       else
>                 i2c->ops.calc_clock = rk3x_i2c_v0_calc_clock;

Perhaps time to use switch-case:

switch ((value & MASK) >> SHIFT) {
case V1:
v1();
break;
case V0:
default:
v0();
break;
}

-- 
With Best Regards,
Andy Shevchenko
