From: j.anaszewski@samsung.com (Jacek Anaszewski)
Date: Thu, 31 Mar 2016 09:13:26 +0200
Subject: [PATCH v5 10/46] leds: pwm: use pwm_get_args() where appropriate
In-Reply-To: <1459368249-13241-11-git-send-email-boris.brezillon@free-electrons.com>
References: <1459368249-13241-1-git-send-email-boris.brezillon@free-electrons.com>
 <1459368249-13241-11-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <56FCCE16.8040200@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Boris,

On 03/30/2016 10:03 PM, Boris Brezillon wrote:
> The PWM framework has clarified the concept of reference PWM config
> (the platform dependent config retrieved from the DT or the PWM
> lookup table) and real PWM state.
>
> Use pwm_get_args() when the PWM user wants to retrieve this reference
> config and not the current state.
>
> This is part of the rework allowing the PWM framework to support
> hardware readout and expose real PWM state even when the PWM has
> just been requested (before the user calls pwm_config/enable/disable()).
>
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> ---
>   drivers/leds/leds-pwm.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/leds/leds-pwm.c b/drivers/leds/leds-pwm.c
> index 4783bac..b48231c 100644
> --- a/drivers/leds/leds-pwm.c
> +++ b/drivers/leds/leds-pwm.c
> @@ -91,6 +91,7 @@ static int led_pwm_add(struct device *dev, struct led_pwm_priv *priv,
>   		       struct led_pwm *led, struct device_node *child)
>   {
>   	struct led_pwm_data *led_data = &priv->leds[priv->num_leds];
> +	struct pwm_args pargs = { };
>   	int ret;
>
>   	led_data->active_low = led->active_low;
> @@ -117,7 +118,8 @@ static int led_pwm_add(struct device *dev, struct led_pwm_priv *priv,
>   	else
>   		led_data->cdev.brightness_set_blocking = led_pwm_set_blocking;
>
> -	led_data->period = pwm_get_period(led_data->pwm);
> +	pwm_get_args(led_data->pwm, &pargs);
> +	led_data->period = pargs.period;
>   	if (!led_data->period && (led->pwm_period_ns > 0))
>   		led_data->period = led->pwm_period_ns;
>
>

Acked-by: Jacek Anaszewski <j.anaszewski@samsung.com>

-- 
Best regards,
Jacek Anaszewski
