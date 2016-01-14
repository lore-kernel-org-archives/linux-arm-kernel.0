From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Thu, 14 Jan 2016 15:05:15 +0200
Subject: [PATCH v3 1/4] i2c: rk3x: switch to i2c generic dt parsing
In-Reply-To: <1452774699-57455-2-git-send-email-david.wu@rock-chips.com>
References: <1452774699-57455-1-git-send-email-david.wu@rock-chips.com>
 <1452774699-57455-2-git-send-email-david.wu@rock-chips.com>
Message-ID: <CAHp75VdtDjNMLH2szW=u-+iogoTc3t5wnOpoGndoadMCetLtDw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 14, 2016 at 2:31 PM, David Wu <david.wu@rock-chips.com> wrote:
> Switch to the new generic functions: i2c_parse_fw_timings().

Nice one!
Reviwed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Minor comments below.

> --- a/drivers/i2c/busses/i2c-rk3x.c
> +++ b/drivers/i2c/busses/i2c-rk3x.c

> @@ -437,10 +434,7 @@ out:
>   * Calculate divider values for desired SCL frequency
>   *
>   * @clk_rate: I2C input clock rate
> - * @scl_rate: Desired SCL rate
> - * @scl_rise_ns: How many ns it takes for SCL to rise.
> - * @scl_fall_ns: How many ns it takes for SCL to fall.
> - * @sda_fall_ns: How many ns it takes for SDA to fall.
> + * @t_input: Known I2C timing information.

Perhaps t_input -> t.

>   * @div_low: Divider output for low
>   * @div_high: Divider output for high
>   *
> @@ -448,11 +442,10 @@ out:
>   * a best-effort divider value is returned in divs. If the target rate is
>   * too high, we silently use the highest possible rate.
>   */
> -static int rk3x_i2c_calc_divs(unsigned long clk_rate, unsigned long scl_rate,
> -                             unsigned long scl_rise_ns,
> -                             unsigned long scl_fall_ns,
> -                             unsigned long sda_fall_ns,
> -                             unsigned long *div_low, unsigned long *div_high)
> +static int rk3x_i2c_calc_divs(unsigned long clk_rate,
> +                             struct i2c_timings *t_input,

Ditto.

> +                             unsigned long *div_low,
> +                             unsigned long *div_high)
>  {
>         unsigned long spec_min_low_ns, spec_min_high_ns;
>         unsigned long spec_setup_start, spec_max_data_hold_ns;

> @@ -517,18 +510,19 @@ static int rk3x_i2c_calc_divs(unsigned long clk_rate, unsigned long scl_rate,
>          * we meet tSU;STA and tHD;STA times.
>          */
>         min_high_ns = max(min_high_ns,
> -               DIV_ROUND_UP((scl_rise_ns + spec_setup_start) * 1000, 875));
> +               DIV_ROUND_UP((t_input->scl_rise_ns + spec_setup_start) * 1000,
> +                            875));

To one line (after above change).

>         min_high_ns = max(min_high_ns,
> -               DIV_ROUND_UP((scl_rise_ns + spec_setup_start +
> -                             sda_fall_ns + spec_min_high_ns), 2));
> +               DIV_ROUND_UP((t_input->scl_rise_ns + spec_setup_start +
> +                             t_input->sda_fall_ns + spec_min_high_ns), 2));

Ditto.

> @@ -620,10 +614,8 @@ static void rk3x_i2c_adapt_div(struct rk3x_i2c *i2c, unsigned long clk_rate)
>         u64 t_low_ns, t_high_ns;
>         int ret;
>
> -       ret = rk3x_i2c_calc_divs(clk_rate, i2c->scl_frequency, i2c->scl_rise_ns,
> -                                i2c->scl_fall_ns, i2c->sda_fall_ns,
> -                                &div_low, &div_high);
> -       WARN_ONCE(ret != 0, "Could not reach SCL freq %u", i2c->scl_frequency);
> +       ret = rk3x_i2c_calc_divs(clk_rate, &i2c->t, &div_low, &div_high);
> +       WARN_ONCE(ret != 0, "Could not reach SCL freq %u", i2c->t.bus_freq_hz);

I would recommend to

struct i2c_timings *t = &i2c->t;

+       ret = rk3x_i2c_calc_divs(clk_rate, t, &div_low, &div_high);
+       WARN_ONCE(ret != 0, "Could not reach SCL freq %u", t->bus_freq_hz);

> @@ -634,7 +626,7 @@ static void rk3x_i2c_adapt_div(struct rk3x_i2c *i2c, unsigned long clk_rate)
>         dev_dbg(i2c->dev,
>                 "CLK %lukhz, Req %uns, Act low %lluns high %lluns\n",
>                 clk_rate / 1000,
> -               1000000000 / i2c->scl_frequency,
> +               1000000000 / i2c->t.bus_freq_hz,

Ditto.

-- 
With Best Regards,
Andy Shevchenko
