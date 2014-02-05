From: jg1.han@samsung.com (Jingoo Han)
Date: Wed, 05 Feb 2014 14:01:00 +0900
Subject: [PATCH] backlight: add PWM dependencies
In-Reply-To: <1391518634-6472-1-git-send-email-linus.walleij@linaro.org>
References: <1391518634-6472-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <000401cf222f$43263b20$c972b160$%han@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, February 04, 2014 9:57 PM, Linus Walleij wrote:
> 
> In some compilations the LM3630A and LP855X backlight drivers
> fail like this:
> 
> drivers/built-in.o: In function `lm3630a_pwm_ctrl':
> drivers/video/backlight/lm3630a_bl.c:168: undefined reference to `pwm_config'
> drivers/video/backlight/lm3630a_bl.c:172: undefined reference to `pwm_disable'
> drivers/video/backlight/lm3630a_bl.c:170: undefined reference to `pwm_enable'
> drivers/built-in.o: In function `lp855x_pwm_ctrl':
> drivers/video/backlight/lp855x_bl.c:249: undefined reference to `pwm_config'
> drivers/video/backlight/lp855x_bl.c:253: undefined reference to `pwm_disable'
> drivers/video/backlight/lp855x_bl.c:251: undefined reference to `pwm_enable'
> 
> This is because both drivers depend on the PWM framework, so
> add this dependency to their Kconfig entries.

However, even though, when CONFIG_PWM is not enabled, the problem
should not happen. pwm_config(),pwm_disable(), and pwm_enable()
are already defined for CONFIG_PWM=n case as below.

./include/linux/pwm.h
#if IS_ENABLED(CONFIG_PWM) || IS_ENABLED(CONFIG_HAVE_PWM)
	.....
#else
static inline struct pwm_device *pwm_request(int pwm_id, const char *label)
{
        return ERR_PTR(-ENODEV);
}

static inline void pwm_free(struct pwm_device *pwm)
{
}

static inline int pwm_config(struct pwm_device *pwm, int duty_ns, int period_ns)
{
        return -EINVAL;
}

static inline int pwm_enable(struct pwm_device *pwm)
{
        return -EINVAL;
}

static inline void pwm_disable(struct pwm_device *pwm)
{
}
#endif

Is there 'drivers/pwm/core.o'?
I reproduced this problem by commenting core.o with CONFIG_PWM=y.

.config
CONFIG_PWM=y

./drivers/pwm/Makefile
@@ -1,4 +1,4 @@
-obj-$(CONFIG_PWM)              += core.o
+#obj-$(CONFIG_PWM)             += core.o

In this case, the following build errors happen.
Even though, CONFIG_PWM is enabled, the same errors happen.
Would you give me the more detailed information?
Ex. how to reproduce the problem.

drivers/built-in.o: In function `lm3630a_pwm_ctrl':
drivers/video/backlight/lm3630a_bl.c:168: undefined reference to `pwm_config'
drivers/video/backlight/lm3630a_bl.c:172: undefined reference to `pwm_disable'
drivers/video/backlight/lm3630a_bl.c:170: undefined reference to `pwm_enable'
drivers/built-in.o: In function `lm3630a_probe':
drivers/video/backlight/lm3630a_bl.c:422: undefined reference to `devm_pwm_get'
drivers/built-in.o: In function `lp855x_pwm_ctrl':
drivers/video/backlight/lp855x_bl.c:249: undefined reference to `pwm_config'
drivers/video/backlight/lp855x_bl.c:253: undefined reference to `pwm_disable'
drivers/video/backlight/lp855x_bl.c:251: undefined reference to `pwm_enable'
drivers/video/backlight/lp855x_bl.c:242: undefined reference to `devm_pwm_get'

Thank you.

Best regards,
Jingoo Han

> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/video/backlight/Kconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/video/backlight/Kconfig b/drivers/video/backlight/Kconfig
> index 5a3eb2ecb525..0604c3348761 100644
> --- a/drivers/video/backlight/Kconfig
> +++ b/drivers/video/backlight/Kconfig
> @@ -371,6 +371,7 @@ config BACKLIGHT_AAT2870
>  config BACKLIGHT_LM3630A
>  	tristate "Backlight Driver for LM3630A"
>  	depends on BACKLIGHT_CLASS_DEVICE && I2C
> +	depends on PWM
>  	select REGMAP_I2C
>  	help
>  	  This supports TI LM3630A Backlight Driver
> @@ -387,6 +388,7 @@ config BACKLIGHT_LM3639
>  config BACKLIGHT_LP855X
>  	tristate "Backlight driver for TI LP855X"
>  	depends on BACKLIGHT_CLASS_DEVICE && I2C
> +	depends on PWM
>  	help
>  	  This supports TI LP8550, LP8551, LP8552, LP8553, LP8555, LP8556 and
>  	  LP8557 backlight driver.
> --
> 1.8.5.3
