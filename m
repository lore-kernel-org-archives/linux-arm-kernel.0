From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 26 Jan 2017 12:16:18 +0000
Subject: [PATCH] pwm: fix undefined behavior in stm32_pwm_apply
In-Reply-To: <20170125223155.1388582-1-arnd@arndb.de>
References: <20170125223155.1388582-1-arnd@arndb.de>
Message-ID: <20170126121618.s66oob576faozd6z@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 25 Jan 2017, Arnd Bergmann wrote:

> The stm32_pwm_apply randomly sets the polarity or doesn't,
> as pointed out by this gcc warning:
> 
> drivers/pwm/pwm-stm32.c: In function 'stm32_pwm_apply':
> drivers/pwm/pwm-stm32.c:204:33: error: 'curstate.polarity' may be used uninitialized in this function [-Werror=maybe-uninitialized]
> 
> I assume it was meant to compare the new state to the current
> state rather than an uninitialized stack variable, so let's
> do that instead.
> 
> Fixes: bafffb6e7bd1 ("pwm: Add driver for STM32 plaftorm")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/pwm/pwm-stm32.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Fix from the author already applied.

> diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
> index ce6232ebefe1..6139512aab7b 100644
> --- a/drivers/pwm/pwm-stm32.c
> +++ b/drivers/pwm/pwm-stm32.c
> @@ -189,7 +189,6 @@ static void stm32_pwm_disable(struct stm32_pwm *priv, int ch)
>  static int stm32_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>  			   struct pwm_state *state)
>  {
> -	struct pwm_state curstate;
>  	bool enabled;
>  	struct stm32_pwm *priv = to_stm32_pwm_dev(chip);
>  	int ret;
> @@ -201,7 +200,7 @@ static int stm32_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>  		return 0;
>  	}
>  
> -	if (state->polarity != curstate.polarity)
> +	if (state->polarity != pwm->state.polarity)
>  		stm32_pwm_set_polarity(priv, pwm->hwpwm, state->polarity);
>  
>  	ret = stm32_pwm_config(priv, pwm->hwpwm,

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
