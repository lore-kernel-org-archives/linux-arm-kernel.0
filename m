From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 14 Nov 2018 13:08:14 +0100
Subject: [PATCH 2/4] ARM: S3C24XX: rx1950: make use of atomic PWM API
In-Reply-To: <20181026184157.16371-2-u.kleine-koenig@pengutronix.de>
References: <20181026184157.16371-1-u.kleine-koenig@pengutronix.de>
 <20181026184157.16371-2-u.kleine-koenig@pengutronix.de>
Message-ID: <20181114120814.GD2620@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 26, 2018 at 08:41:56PM +0200, Uwe Kleine-K?nig wrote:
> The legacy PWM API should be removed in the long run, so convert a user
> to the atomic PWM API.
> 
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> ---
>  arch/arm/mach-s3c24xx/mach-rx1950.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/arm/mach-s3c24xx/mach-rx1950.c b/arch/arm/mach-s3c24xx/mach-rx1950.c
> index 7f5a18fa305b..5c4459f9a5f7 100644
> --- a/arch/arm/mach-s3c24xx/mach-rx1950.c
> +++ b/arch/arm/mach-s3c24xx/mach-rx1950.c
> @@ -375,6 +375,7 @@ static struct pwm_lookup rx1950_pwm_lookup[] = {
>  		   PWM_POLARITY_NORMAL),
>  };
>  
> +static struct pwm_state lcd_pwm_state;

You shouldn't need this. The whole point of the atomic API is that the
PWM carries its state, so the proper way to make a change is to query
the current state, make any required modifications and then apply the
new state.

>  static struct pwm_device *lcd_pwm;
>  
>  static void rx1950_lcd_power(int enable)
> @@ -428,15 +429,17 @@ static void rx1950_lcd_power(int enable)
>  
>  		/* GPB1->OUTPUT, GPB1->0 */
>  		gpio_direction_output(S3C2410_GPB(1), 0);
> -		pwm_config(lcd_pwm, 0, LCD_PWM_PERIOD);
> -		pwm_disable(lcd_pwm);
> +		lcd_pwm_state.duty_cycle = 0;
> +		lcd_pwm_state.enabled = false;
> +		pwm_apply_state(lcd_pwm, &lcd_pwm_state);

The correct way to do this would be:

	struct pwm_state state;

	pwm_get_state(lcd_pwm, &state);
	state.enabled = false;
	state.duty_cycle = 0;
	pwm_apply_state(lcd_pwm, &state);

>  
>  		/* GPC0->0, GPC10->0 */
>  		gpio_direction_output(S3C2410_GPC(0), 0);
>  		gpio_direction_output(S3C2410_GPC(10), 0);
>  	} else {
> -		pwm_config(lcd_pwm, LCD_PWM_DUTY, LCD_PWM_PERIOD);
> -		pwm_enable(lcd_pwm);
> +		lcd_pwm_state.duty_cycle = LCD_PWM_DUTY;
> +		lcd_pwm_state.enabled = true;
> +		pwm_apply_state(lcd_pwm, &lcd_pwm_state);

Similarily here.

>  
>  		gpio_direction_output(S3C2410_GPC(0), 1);
>  		gpio_direction_output(S3C2410_GPC(5), 1);
> @@ -491,11 +494,8 @@ static int rx1950_backlight_init(struct device *dev)
>  		return PTR_ERR(lcd_pwm);
>  	}
>  
> -	/*
> -	 * FIXME: pwm_apply_args() should be removed when switching to
> -	 * the atomic PWM API.
> -	 */
> -	pwm_apply_args(lcd_pwm);
> +	pwm_get_state_default(lcd_pwm, &lcd_pwm_state);
> +	lcd_pwm_state.period = LCD_PWM_PERIOD;

This is wrong, though it's probably because the comment is also
confusing. There should be nothing wrong with using pwm_apply_args() in
this case.

While at it, I think the conversion should also be include replacing the
call to pwm_request() by pwm_get(). There's already a PWM lookup table
in the RX1950 board code, so pwm_get() would be able to use that. Note
that for some reason that table contains a period that is different from
LCD_PWM_PERIOD, so I think that should also be addressed. Basically all
the information other than duty cycle should be coming from either DT or
a lookup table.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181114/016e5051/attachment.sig>
