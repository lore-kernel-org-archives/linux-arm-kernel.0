From: fabrice.gasnier@st.com (Fabrice Gasnier)
Date: Mon, 28 May 2018 09:20:10 +0200
Subject: [PATCH] pwm: stm32: fix build warning with CONFIG_DMA_ENGINE
 disabled
In-Reply-To: <20180525210843.1821071-1-arnd@arndb.de>
References: <20180525210843.1821071-1-arnd@arndb.de>
Message-ID: <91444ee7-40fa-5022-ca4d-1c15e0807347@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/25/2018 11:08 PM, Arnd Bergmann wrote:
> Without dmaengine support, we get a harmless warning about an
> unused function:
> 
> drivers/pwm/pwm-stm32.c:166:12: error: 'stm32_pwm_capture' defined but not used [-Werror=unused-function]
> 
> Changing the #ifdef to an IS_ENABLED() check shuts up that warning
> and is slightly nicer to read.
> 
> Fixes: 53e38fe73f94 ("pwm: stm32: Add capture support")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/pwm/pwm-stm32.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
Hi Arnd,

Acked-by: Fabrice Gasnier <fabrice.gasnier@st.com>

Thanks,
Fabrice
> 
> diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
> index 60bfc07c4912..97bbc1f18fd6 100644
> --- a/drivers/pwm/pwm-stm32.c
> +++ b/drivers/pwm/pwm-stm32.c
> @@ -484,9 +484,7 @@ static int stm32_pwm_apply_locked(struct pwm_chip *chip, struct pwm_device *pwm,
>  static const struct pwm_ops stm32pwm_ops = {
>  	.owner = THIS_MODULE,
>  	.apply = stm32_pwm_apply_locked,
> -#if IS_ENABLED(CONFIG_DMA_ENGINE)
> -	.capture = stm32_pwm_capture,
> -#endif
> +	.capture = IS_ENABLED(CONFIG_DMA_ENGINE) ? stm32_pwm_capture : NULL,
>  };
>  
>  static int stm32_pwm_set_breakinput(struct stm32_pwm *priv,
> 
