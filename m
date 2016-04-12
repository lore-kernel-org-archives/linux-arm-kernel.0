From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 12 Apr 2016 12:53:14 +0200
Subject: [RESEND 09/11] pwm: sti: Add PWM Capture call-back
In-Reply-To: <1456932729-9667-10-git-send-email-lee.jones@linaro.org>
References: <1456932729-9667-1-git-send-email-lee.jones@linaro.org>
 <1456932729-9667-10-git-send-email-lee.jones@linaro.org>
Message-ID: <20160412105314.GE18882@ulmo.ba.sec>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 02, 2016 at 03:32:07PM +0000, Lee Jones wrote:
> Once a PWM Capture has been initiated, the capture call
> enables a rising edge detection IRQ, then waits.  Once each
> of the 3 phase changes have been recorded the thread then
> wakes.  The remaining part of the call carries out the
> relevant calculations and passes back a formatted string to
> the caller.
> 
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/pwm/pwm-sti.c | 72 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 72 insertions(+)
> 
> diff --git a/drivers/pwm/pwm-sti.c b/drivers/pwm/pwm-sti.c
> index 82a69e4..8de9b4a 100644
> --- a/drivers/pwm/pwm-sti.c
> +++ b/drivers/pwm/pwm-sti.c
> @@ -309,7 +309,79 @@ static void sti_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
>  	clear_bit(pwm->hwpwm, &pc->configured);
>  }
>  
> +static int sti_pwm_capture(struct pwm_chip *chip, struct pwm_device *pwm,
> +			   int channel, char *buf)
> +{
> +	struct sti_pwm_chip *pc = to_sti_pwmchip(chip);
> +	struct sti_pwm_compat_data *cdata = pc->cdata;
> +	struct sti_cpt_data *d = pc->cpt_data[channel];
> +	struct device *dev = pc->dev;
> +	unsigned int f, dc;
> +	unsigned int high, low;
> +	bool level;
> +	int ret;
> +
> +	if (channel > cdata->cpt_num_chan - 1) {
> +		dev_err(dev, "Channel %d is not valid\n", channel);
> +		return -EINVAL;
> +	}
> +
> +	mutex_lock(&d->lock);

Should this perhaps reuse the struct pwm_device's ->lock?

> +
> +	/* Prepare capture measurement */
> +	d->index = 0;
> +	regmap_write(pc->regmap, PWM_CPT_EDGE(channel), CPT_EDGE_RISING);
> +	regmap_field_write(pc->pwm_cpt_int_en, BIT(channel));
> +	ret = wait_event_interruptible_timeout(d->wait, d->index > 1, HZ);

The timeout here should make sure callers don't hang forever. But maybe
you can still make sure that when the PWM gets disabled the wait queue
is woken and perhaps return an appropriate error code to let users know
that the operation was interrupted.

Also, how about letting callers choose the value of the timeout? In some
cases they may be interested in long-running signals. In other cases the
whole second timeout may be much too long.

> +
> +	/*
> +	 * In case we woke up for another reason than completion
> +	 * make sure to disable the capture.
> +	 */
> +	regmap_write(pc->regmap, PWM_CPT_EDGE(channel), CPT_EDGE_DISABLED);

The comment here is slightly confusing because it implies that disabling
the capture should be done conditionally, whereas it is always disabled.

> +
> +	if (ret == -ERESTARTSYS)
> +		goto out;
> +
> +	switch (d->index) {
> +	case 0:
> +	case 1:
> +		/*
> +		 * Getting here could mean :
> +		 *  - input signal is constant of less than 1Hz
> +		 *  - there is no input signal at all
> +		 *
> +		 * In such case the frequency is rounded down to 0
> +		 * level of the supposed constant signal is reported
> +		 * using duty cycle min and max values.
> +		 */
> +		level = gpio_get_value(d->gpio);
> +
> +		ret = sprintf(buf, "0:%u\n", level ? CPT_DC_MAX : 0);
> +		break;
> +	case 2:
> +		/* We have evertying we need */
> +		high = d->snapshot[1] - d->snapshot[0];
> +		low  = d->snapshot[2] - d->snapshot[1];
> +
> +		/* Calculate frequency in Hz */
> +		f = clk_get_rate(pc->cpt_clk) / (1 * (high + low));

The multiplication by 1 is unnecessary.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160412/41c37334/attachment.sig>
