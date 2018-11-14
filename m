From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 14 Nov 2018 13:15:04 +0100
Subject: [PATCH 3/4] bus: ts-nbus: convert to atomic PWM API
In-Reply-To: <20181026184157.16371-3-u.kleine-koenig@pengutronix.de>
References: <20181026184157.16371-1-u.kleine-koenig@pengutronix.de>
 <20181026184157.16371-3-u.kleine-koenig@pengutronix.de>
Message-ID: <20181114121504.GE2620@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 26, 2018 at 08:41:57PM +0200, Uwe Kleine-K?nig wrote:
> The legacy PWM API should be removed in the long run, so convert a user
> to the atomic PWM API.
> 
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/bus/ts-nbus.c | 20 +++++++-------------
>  1 file changed, 7 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/bus/ts-nbus.c b/drivers/bus/ts-nbus.c
> index 073fd9011154..51f5ed870ad1 100644
> --- a/drivers/bus/ts-nbus.c
> +++ b/drivers/bus/ts-nbus.c
> @@ -282,7 +282,7 @@ EXPORT_SYMBOL_GPL(ts_nbus_write);
>  static int ts_nbus_probe(struct platform_device *pdev)
>  {
>  	struct pwm_device *pwm;
> -	struct pwm_args pargs;
> +	struct pwm_state pstate;
>  	struct device *dev = &pdev->dev;
>  	struct ts_nbus *ts_nbus;
>  	int ret;
> @@ -305,25 +305,19 @@ static int ts_nbus_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> -	pwm_get_args(pwm, &pargs);
> -	if (!pargs.period) {
> +	pwm_get_state_default(pwm, &pstate);
> +	if (!pstate.period) {
>  		dev_err(&pdev->dev, "invalid PWM period\n");
>  		return -EINVAL;
>  	}
>  
> -	/*
> -	 * FIXME: pwm_apply_args() should be removed when switching to
> -	 * the atomic PWM API.
> -	 */
> -	pwm_apply_args(pwm);
> -	ret = pwm_config(pwm, pargs.period, pargs.period);
> +	/* We can start the FPGA and populate the peripherals now. */
> +	pstate.enabled = true;
> +	pstate.duty_cycle = pstate.period;
> +	ret = pwm_apply_state(pwm, &pstate);
>  	if (ret < 0)
>  		return ret;
>  
> -	/*
> -	 * we can now start the FPGA and populate the peripherals.
> -	 */
> -	pwm_enable(pwm);
>  	ts_nbus->pwm = pwm;
>  
>  	/*

This looks suspiciously like the PWM is actually powering this bus. It
would've been better to model that as a PWM driven regulator rather than
an PWM consumer.

Either way I don't see why pwm_get_state_default() would be useful here.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181114/6e41b905/attachment.sig>
