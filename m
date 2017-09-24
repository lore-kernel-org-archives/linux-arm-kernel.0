From: jic23@kernel.org (Jonathan Cameron)
Date: Sun, 24 Sep 2017 13:10:27 +0100
Subject: [PATCH 2/3] iio: trigger: stm32-timer: fix a corner case to
 write preset
In-Reply-To: <1505729132-1369-3-git-send-email-fabrice.gasnier@st.com>
References: <1505729132-1369-1-git-send-email-fabrice.gasnier@st.com>
 <1505729132-1369-3-git-send-email-fabrice.gasnier@st.com>
Message-ID: <20170924131027.2d6c5d90@archlinux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 18 Sep 2017 12:05:31 +0200
Fabrice Gasnier <fabrice.gasnier@st.com> wrote:

> Balance timer start routine that sets ARPE: clear it in stop routine.
> This fixes a corner case, when timer is used successively as trigger
> (with sampling_frequency start/stop routines), then as a counter
> (with preset).
> 
> Fixes: 93fbe91b5521 ("iio: Add STM32 timer trigger driver")
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>

Applied to the fixes-togreg-post-rc1 branch of iio.git and
marked for stable.

Thanks,

Jonathan
> ---
>  drivers/iio/trigger/stm32-timer-trigger.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/trigger/stm32-timer-trigger.c b/drivers/iio/trigger/stm32-timer-trigger.c
> index 34cc25b..eb212f8c 100644
> --- a/drivers/iio/trigger/stm32-timer-trigger.c
> +++ b/drivers/iio/trigger/stm32-timer-trigger.c
> @@ -174,6 +174,7 @@ static void stm32_timer_stop(struct stm32_timer_trigger *priv)
>  		clk_disable(priv->clk);
>  
>  	/* Stop timer */
> +	regmap_update_bits(priv->regmap, TIM_CR1, TIM_CR1_ARPE, 0);
>  	regmap_update_bits(priv->regmap, TIM_CR1, TIM_CR1_CEN, 0);
>  	regmap_write(priv->regmap, TIM_PSC, 0);
>  	regmap_write(priv->regmap, TIM_ARR, 0);
