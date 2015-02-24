From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Tue, 24 Feb 2015 19:56:52 +0100 (CET)
Subject: [PATCH 2/2] leds/pwm: Don't disable pwm when setting brightness
 to 0
In-Reply-To: <1423734290-19750-3-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1423734290-19750-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1423734290-19750-3-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1151818200.134325.1424804213026.JavaMail.open-xchange@oxbsltgw03.schlund.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

> Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de> hat am 12. Februar 2015 um
> 10:44 geschrieben:
>
>
> This fixes disabling the LED on i.MX28. The PWM hardware delays using
> the newly set pwm-config until the beginning of a new period. It's very
> likely that pwm_disable is called before the current period ends. In
> case the LED was on brightness=max before the LED stays on because in
> the disabled PWM block the period never ends.
>
> Also only call pwm_enable only once in the probe call back and the
> matching pwm_disable in .remove(). Moreover the pwm is explicitly
> initialized to off.
>
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> ---
> drivers/leds/leds-pwm.c | 10 +++++-----
> 1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/leds/leds-pwm.c b/drivers/leds/leds-pwm.c
> index f668500a2157..5dae0d2dc3dc 100644
> --- a/drivers/leds/leds-pwm.c
> +++ b/drivers/leds/leds-pwm.c
> @@ -44,11 +44,6 @@ static void __led_pwm_set(struct led_pwm_data *led_dat)
> int new_duty = led_dat->duty;
>
> pwm_config(led_dat->pwm, new_duty, led_dat->period);
> -
> - if (new_duty == 0)
> - pwm_disable(led_dat->pwm);
> - else
> - pwm_enable(led_dat->pwm);
> }
>
> static void led_pwm_work(struct work_struct *work)
> @@ -93,6 +88,7 @@ static void led_pwm_cleanup(struct led_pwm_priv *priv)
> led_classdev_unregister(&priv->leds[priv->num_leds].cdev);
> if (priv->leds[priv->num_leds].can_sleep)
> cancel_work_sync(&priv->leds[priv->num_leds].work);
> + pwm_disable(priv->leds[i].pwm);
> }
> }
>

After replacing "i" with "priv->num_leds" in this patch we are able to use pwm
led with trigger heartbeat.

This is the functional part of this issue, since the warning has been fixed [1]

Thanks Stefan

[1] -
http://lists.infradead.org/pipermail/linux-arm-kernel/2014-April/244925.html
