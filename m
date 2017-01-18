From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 18 Jan 2017 12:37:59 +0100
Subject: [PATCH v7 4/8] PWM: add PWM driver for STM32 plaftorm
In-Reply-To: <CA+M3ks64VEE8a0oeiA8J-T5FDzwWTo=pdaMACy+pz7EyOQY-Jg@mail.gmail.com>
References: <1483608344-9012-1-git-send-email-benjamin.gaignard@st.com>
 <1483608344-9012-5-git-send-email-benjamin.gaignard@st.com>
 <20170118100817.GF18989@ulmo.ba.sec>
 <CA+M3ks64VEE8a0oeiA8J-T5FDzwWTo=pdaMACy+pz7EyOQY-Jg@mail.gmail.com>
Message-ID: <20170118113759.GA16826@ulmo.ba.sec>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 18, 2017 at 12:15:58PM +0100, Benjamin Gaignard wrote:
> 2017-01-18 11:08 GMT+01:00 Thierry Reding <thierry.reding@gmail.com>:
> > On Thu, Jan 05, 2017 at 10:25:40AM +0100, Benjamin Gaignard wrote:
[...]
> >> +static u32 active_channels(struct stm32_pwm *dev)
> >> +{
> >> +     u32 ccer;
> >> +
> >> +     regmap_read(dev->regmap, TIM_CCER, &ccer);
> >> +
> >> +     return ccer & TIM_CCER_CCXE;
> >> +}
> >
> > This looks like something that you could track in software, but this is
> > probably fine, too. Again, technically regmap_read() could fail, so you
> > might want to consider adding some code to handle it. In practice it
> > probably won't, so maybe you don't.
> 
> TIM_CCER_CCXE is a value that IIO timer can also read (not write) so
> I have keep the same logic for pwm driver.

Would that not be racy? What happens if after active_channels() here,
the IIO timer modifies the TIM_CCER register?

> >> +     ret = stm32_pwm_config(chip, pwm, state->duty_cycle, state->period);
> >> +     if (ret)
> >> +             return ret;
> >> +
> >> +     if (!enabled && state->enabled)
> >> +             ret = stm32_pwm_enable(chip, pwm);
> >> +
> >> +     return ret;
> >> +}
> >
> > Would it be possible to merge stm32_pwm_disable(), stm32_pwm_enable(),
> > stm32_pwm_set_polarity() and stm32_pwm_config() into stm32_pwm_apply()?
> > Part of the reason for the atomic API was to make it easier to write
> > these drivers, but your implementation effectively copies what the
> > transitional helpers do.
> >
> > It might not make a difference technically in your case, but I think
> > it'd make the implementation more compact and set a better example for
> > future reference.
> 
> hmm... it will create a fat function with lot of where
> enabling/disabling/configuration
> will be mixed I'm really not convince that will more compact and readable.

I don't object to splitting this up into separate functions, I just
don't think the functions should correspond to the legacy ones. One
variant that I think could work out nicely would be to have one
function that precomputes the various values, call in from ->apply()
and then do only the register writes along with a couple of
conditionals depending on enable state, for example.

> >> +static const struct pwm_ops stm32pwm_ops = {
> >> +     .owner = THIS_MODULE,
> >> +     .apply = stm32_pwm_apply,
> >> +};
> >> +
> >> +static int stm32_pwm_set_breakinput(struct stm32_pwm *priv,
> >> +                                 int level, int filter)
> >> +{
> >> +     u32 bdtr = TIM_BDTR_BKE;
> >> +
> >> +     if (level)
> >> +             bdtr |= TIM_BDTR_BKP;
> >> +
> >> +     bdtr |= (filter & TIM_BDTR_BKF_MASK) << TIM_BDTR_BKF_SHIFT;
> >> +
> >> +     regmap_update_bits(priv->regmap,
> >> +                        TIM_BDTR, TIM_BDTR_BKE | TIM_BDTR_BKP | TIM_BDTR_BKF,
> >> +                        bdtr);
> >> +
> >> +     regmap_read(priv->regmap, TIM_BDTR, &bdtr);
> >> +
> >> +     return (bdtr & TIM_BDTR_BKE) ? 0 : -EINVAL;
> >> +}
> >> +
> >> +static int stm32_pwm_set_breakinput2(struct stm32_pwm *priv,
> >> +                                  int level, int filter)
> >> +{
> >> +     u32 bdtr = TIM_BDTR_BK2E;
> >> +
> >> +     if (level)
> >> +             bdtr |= TIM_BDTR_BK2P;
> >> +
> >> +     bdtr |= (filter & TIM_BDTR_BKF_MASK) << TIM_BDTR_BK2F_SHIFT;
> >> +
> >> +     regmap_update_bits(priv->regmap,
> >> +                        TIM_BDTR, TIM_BDTR_BK2E |
> >> +                        TIM_BDTR_BK2P |
> >> +                        TIM_BDTR_BK2F,
> >> +                        bdtr);
> >> +
> >> +     regmap_read(priv->regmap, TIM_BDTR, &bdtr);
> >> +
> >> +     return (bdtr & TIM_BDTR_BK2E) ? 0 : -EINVAL;
> >> +}
> >
> > As far as I can tell the only difference here is the various bit
> > positions. Can you collapse the above two functions and add a new
> > parameter to unify some code?
> 
> Yes it is all about bit shifting, I had try unify those two functions
> with index has additional parameter
> but it just add if() before each lines so no real benefit for code size.

How about if you precompute the values and masks? Something like:

	u32 bke = (index == 0) ? ... : ...;
	u32 bkp = (index == 0) ? ... : ...;
	u32 bkf = (index == 0) ? ... : ...;
	u32 mask = (index == 0) ? ... : ...;

	bdtr = bke | bkf;

	if (level)
		bdtr |= bkp;

	regmap_update_bits(priv->regmap, TIM_BDTR, mask, bdtr);

	regmap_read(priv->regmap, TIM_BDTR, &bdtr);

	return (bdtr & bke) ? 0 : -EINVAL;

?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170118/7b32fa5f/attachment.sig>
