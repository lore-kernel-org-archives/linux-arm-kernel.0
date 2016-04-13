From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 13 Apr 2016 11:25:54 +0100
Subject: [RESEND 09/11] pwm: sti: Add PWM Capture call-back
In-Reply-To: <20160412105314.GE18882@ulmo.ba.sec>
References: <1456932729-9667-1-git-send-email-lee.jones@linaro.org>
 <1456932729-9667-10-git-send-email-lee.jones@linaro.org>
 <20160412105314.GE18882@ulmo.ba.sec>
Message-ID: <20160413102554.GQ8094@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 12 Apr 2016, Thierry Reding wrote:

> On Wed, Mar 02, 2016 at 03:32:07PM +0000, Lee Jones wrote:
> > Once a PWM Capture has been initiated, the capture call
> > enables a rising edge detection IRQ, then waits.  Once each
> > of the 3 phase changes have been recorded the thread then
> > wakes.  The remaining part of the call carries out the
> > relevant calculations and passes back a formatted string to
> > the caller.
> > 
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >  drivers/pwm/pwm-sti.c | 72 +++++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 72 insertions(+)
> > 
> > diff --git a/drivers/pwm/pwm-sti.c b/drivers/pwm/pwm-sti.c
> > index 82a69e4..8de9b4a 100644
> > --- a/drivers/pwm/pwm-sti.c
> > +++ b/drivers/pwm/pwm-sti.c
> > @@ -309,7 +309,79 @@ static void sti_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
> >  	clear_bit(pwm->hwpwm, &pc->configured);
> >  }
> >  
> > +static int sti_pwm_capture(struct pwm_chip *chip, struct pwm_device *pwm,
> > +			   int channel, char *buf)
> > +{
> > +	struct sti_pwm_chip *pc = to_sti_pwmchip(chip);
> > +	struct sti_pwm_compat_data *cdata = pc->cdata;
> > +	struct sti_cpt_data *d = pc->cpt_data[channel];
> > +	struct device *dev = pc->dev;
> > +	unsigned int f, dc;
> > +	unsigned int high, low;
> > +	bool level;
> > +	int ret;
> > +
> > +	if (channel > cdata->cpt_num_chan - 1) {
> > +		dev_err(dev, "Channel %d is not valid\n", channel);
> > +		return -EINVAL;
> > +	}
> > +
> > +	mutex_lock(&d->lock);
> 
> Should this perhaps reuse the struct pwm_device's ->lock?
> 
> > +
> > +	/* Prepare capture measurement */
> > +	d->index = 0;
> > +	regmap_write(pc->regmap, PWM_CPT_EDGE(channel), CPT_EDGE_RISING);
> > +	regmap_field_write(pc->pwm_cpt_int_en, BIT(channel));
> > +	ret = wait_event_interruptible_timeout(d->wait, d->index > 1, HZ);
> 
> The timeout here should make sure callers don't hang forever. But maybe
> you can still make sure that when the PWM gets disabled the wait queue
> is woken and perhaps return an appropriate error code to let users know
> that the operation was interrupted.

Sure.  I'll look into that.

> Also, how about letting callers choose the value of the timeout? In some
> cases they may be interested in long-running signals. In other cases the
> whole second timeout may be much too long.

I'm not opposed to it.  How do you suggest we do that?

> > +	/*
> > +	 * In case we woke up for another reason than completion
> > +	 * make sure to disable the capture.
> > +	 */
> > +	regmap_write(pc->regmap, PWM_CPT_EDGE(channel), CPT_EDGE_DISABLED);
> 
> The comment here is slightly confusing because it implies that disabling
> the capture should be done conditionally, whereas it is always disabled.

Not really.  We do it unconditionally for reason explained.

It says:

  "disable the capture just in case X happens"

rather than

  "disable the capture if X happens".

Perhaps the language is too subtle.  I can reword for clarity.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
