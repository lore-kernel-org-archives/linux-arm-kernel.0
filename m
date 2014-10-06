From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 6 Oct 2014 14:28:57 +0200
Subject: [PATCH v7 03/11] pwm: add support for atmel-hlcdc-pwm device
In-Reply-To: <20141006135009.6cd980a1@bbrezillon>
References: <1412175188-28278-1-git-send-email-boris.brezillon@free-electrons.com>
 <1412175188-28278-4-git-send-email-boris.brezillon@free-electrons.com>
 <20141006104634.GE25202@ulmo> <20141006135009.6cd980a1@bbrezillon>
Message-ID: <20141006122856.GB26833@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 06, 2014 at 01:50:09PM +0200, Boris Brezillon wrote:
> On Mon, 6 Oct 2014 12:46:35 +0200 Thierry Reding <thierry.reding@gmail.com> wrote:
> > On Wed, Oct 01, 2014 at 04:53:00PM +0200, Boris Brezillon wrote:
[...]
> > > +	if (pres > ATMEL_HLCDC_PWMPS_MAX)
> > > +		return -EINVAL;
> > 
> > I think the condition above needs to be "pres == ATMEL_HLCDC_PWMPS_MAX",
> > otherwise this will never be true.
> 
> Actually the previous loop is:
> 
> 	for (pres = 0; pres *<=* ATMEL_HLCDC_PWMPS_MAX; pres++)
> 
> thus pres will be equal to ATMEL_HLCDC_PWMPS_MAX + 1 when no
> appropriate prescaler is found.

Indeed so.

> > > +		regmap_update_bits(hlcdc->regmap, ATMEL_HLCDC_CFG(0),
> > > +				   ATMEL_HLCDC_CLKPWMSEL, gencfg);
> > > +	}
> > > +
> > > +	do_div(pwmcval, period_ns);
> > > +	if (pwmcval > 255)
> > 
> > The PWM core already makes sure that duty_ns <= period_ns, so pwmcval
> > could be anywhere between 0 and 256 here. Where does the disconnect come
> > from? Why not make pwmcval = duty_ns * 255 if that's the maximum?
> 
> Here is what the datasheet says:
> 
> "Due to the comparison mechanism, the output pulse has a width between
> zero and 255 PWM counter cycles. Thus by adding a simple passive filter
> outside the chip, an analog voltage between 0 and (255/256) ? VDD can
> be obtained (for the positive polarity case, or between (1/256) ? VDD
> and VDD for the negative polarity case). Other voltage values can be
> obtained by adding active external circuitry."
> 
> Given this explanation we should divide by 256, but 256/256 is a
> forbidden value, hence I just use the maximum available one (255) when
> I'm asked to configure a duty cycle occupying the whole period.

Okay, perhaps you can summarize the above explanation from the datasheet
in a comment to clarify.

> > > +		pwmcval = 255;
> > > +
> > > +	pwmcfg |= ATMEL_HLCDC_PWMCVAL(pwmcval);
> > > +
> > > +	regmap_update_bits(hlcdc->regmap, ATMEL_HLCDC_CFG(6),
> > > +			   ATMEL_HLCDC_PWMCVAL_MASK | ATMEL_HLCDC_PWMPS_MASK,
> > > +			   pwmcfg);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int atmel_hlcdc_pwm_set_polarity(struct pwm_chip *c,
> > > +					struct pwm_device *pwm,
> > > +					enum pwm_polarity polarity)
> > > +{
> > > +	struct atmel_hlcdc_pwm_chip *chip =
> > > +				pwm_chip_to_atmel_hlcdc_pwm_chip(c);
> > > +	struct atmel_hlcdc *hlcdc = chip->hlcdc;
> > > +	u32 cfg = 0;
> > > +
> > > +	if (polarity == PWM_POLARITY_NORMAL)
> > > +		cfg = ATMEL_HLCDC_PWMPOL;
> > 
> > That's strange. Inverse polarity is the default on this hardware?
> 
> Quote from the datasheet:
> 
> "
> ? PWMPOL: LCD Controller PWM Signal Polarity
> This bit defines the polarity of the PWM output signal. If set to one,
> the output pulses are high level (the output will be high when- ever
> the value in the counter is less than the value CVAL) If set to zero,
> the output pulses are low level.
> "
> 
> My understanding is that ATMEL_HLCDC_PWMPOL should be set when using
> normal polarity (and my tests confirm that it works as expected ;-)).

Yes, sounds good then.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141006/59385bb9/attachment.sig>
