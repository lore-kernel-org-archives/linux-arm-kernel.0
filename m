From: narmstrong@baylibre.com (Neil Armstrong)
Date: Tue, 16 Aug 2016 15:50:18 +0200
Subject: [PATCH v2 1/4] pwm: Add support for Meson PWM Controller
In-Reply-To: <CAFBinCAXJ_POd9=UhL8vM6_sXXgVMgSZCwDKosLSzW2++ZmTQQ@mail.gmail.com>
References: <1468142645-4360-1-git-send-email-narmstrong@baylibre.com>
 <1468142645-4360-2-git-send-email-narmstrong@baylibre.com>
 <CAFBinCAXJ_POd9=UhL8vM6_sXXgVMgSZCwDKosLSzW2++ZmTQQ@mail.gmail.com>
Message-ID: <ad674bac-885b-e975-dd4c-d7ae11789d5a@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Martin,

On 08/15/2016 06:55 PM, Martin Blumenstingl wrote:
> On Sun, Jul 10, 2016 at 11:24 AM, Neil Armstrong

[...]

>> +static int meson_pwm_calc(struct meson_pwm_chip *chip,
>> +                              struct meson_pwm_channel *pwm_chan,
>> +                              unsigned int id,
>> +                              int duty_ns, unsigned int period_ns)
>> +{
>> +       unsigned int pwm_pre_div;
>> +       unsigned int pwm_cnt;
>> +       unsigned int pwm_duty_cnt;
>> +       unsigned long fin_freq = -1;
>> +       unsigned long fin_ns;
>> +       unsigned int i = 0;
>> +
>> +       if (duty_ns > period_ns)
>> +               return -EINVAL;
>> +
>> +       switch (id) {
>> +       case PWM_A:
>> +               fin_freq = clk_get_rate(chip->clk[0]);
>> +               break;
>> +       case PWM_B:
>> +               fin_freq = clk_get_rate(chip->clk[1]);
>> +               break;
>> +       }
>> +       if (fin_freq <= 0) {
>> +               dev_err(chip->chip.dev, "invalid source clock frequency\n");
>> +               return -EINVAL;
>> +       }
>> +       dev_dbg(chip->chip.dev, "fin_freq: %luHz\n", fin_freq);
>> +       fin_ns = NSEC_PER_SEC / fin_freq;
>> +
>> +       /* Calc pre_div with the period */
>> +       for (i = 0; i < MISC_CLK_DIV_MASK; i++) {
>> +               pwm_pre_div = i;
> according to the public (S905) datasheet the hardware wants "value
> +1": "Selects the divider (N+1) for the PWM A clock"
> so shouldn't this be pwm_pre_div = i + 1?
> all your calculations below are already adding 1 to pwm_pre_div, but
> pwm_pre_div is directly written to the hardware register in
> meson_pwm_config()

You misread the datasheet, usually the phrase :
"PWM_A_CLK_DIV: Selects the divider (N+1) for the PWM A clock"

Means, the divider that will be applied will be "N + 1", N is the value written in the register.

This is why we start from 0 and for the following calculation, I add +1 :
>> +               pwm_cnt = DIV_ROUND_CLOSEST(period_ns,
>> +                               fin_ns * (pwm_pre_div + 1));

This behavior was also present in the original vendor's driver.

>> +               dev_dbg(chip->chip.dev, "fin_ns=%lu pre_div=%d cnt=%d\n",
>> +                               fin_ns, pwm_pre_div, pwm_cnt);
>> +               if (pwm_cnt <= 0xffff)
>> +                       break;
>> +       }
>> +       if (i == MISC_CLK_DIV_MASK) {
>> +               dev_err(chip->chip.dev, "Unable to get period pre_div");
>> +               return -EINVAL;
>> +       }
>> +       dev_dbg(chip->chip.dev, "period_ns=%d pre_div=%d pwm_cnt=%d\n",
>> +               period_ns, pwm_pre_div, pwm_cnt);
>> +
>> +       if (duty_ns == period_ns) {
>> +               pwm_chan->pwm_pre_div = pwm_pre_div;
>> +               pwm_chan->pwm_hi = pwm_cnt;
>> +               pwm_chan->pwm_lo = 0;
>> +       } else if (duty_ns == 0) {
>> +               pwm_chan->pwm_pre_div = pwm_pre_div;
>> +               pwm_chan->pwm_hi = 0;
>> +               pwm_chan->pwm_lo = pwm_cnt;
>> +       } else {
>> +               /* Then check is we can have the duty with the same pre_div */
>> +               pwm_duty_cnt = DIV_ROUND_CLOSEST(duty_ns,
>> +                                       fin_ns * (pwm_pre_div + 1));
>> +               if (pwm_cnt > 0xffff) {
>> +                       dev_err(chip->chip.dev, "Unable to get duty period, differences are too high");
>> +                       return -EINVAL;
>> +               }
>> +               dev_dbg(chip->chip.dev, "duty_ns=%d pre_div=%d pwm_cnt=%d\n",
>> +                       duty_ns, pwm_pre_div, pwm_duty_cnt);
>> +
>> +               pwm_chan->pwm_pre_div = pwm_pre_div;
>> +               pwm_chan->pwm_hi = pwm_duty_cnt;
>> +               pwm_chan->pwm_lo = pwm_cnt - pwm_chan->pwm_hi;
>> +       }
>> +
>> +       return 0;
>> +}

Neil
