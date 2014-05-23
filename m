From: Ying.Liu@freescale.com (Liu Ying)
Date: Fri, 23 May 2014 14:40:04 +0800
Subject: [PATCH] pwm: imx: set can_sleep flag for imx_pwm_v2
In-Reply-To: <1400824114-27148-1-git-send-email-shawn.guo@freescale.com>
References: <1400824114-27148-1-git-send-email-shawn.guo@freescale.com>
Message-ID: <537EED44.7030906@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

On 05/23/2014 01:48 PM, Shawn Guo wrote:
> The .config() hook of imx_pwm_data_v2 calls clk_get_rate() which might
> sleep, so we need to set can_sleep flag on it.
> 
> Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
> ---
>  drivers/pwm/pwm-imx.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/pwm/pwm-imx.c b/drivers/pwm/pwm-imx.c
> index d797c7b84c3f..ab3809fb36a7 100644
> --- a/drivers/pwm/pwm-imx.c
> +++ b/drivers/pwm/pwm-imx.c
> @@ -272,6 +272,9 @@ static int imx_pwm_probe(struct platform_device *pdev)
>  	imx->config = data->config;
>  	imx->set_enable = data->set_enable;
>  
> +	if (data == &imx_pwm_data_v2)
> +		imx->chip.can_sleep = true;
> +
>  	ret = pwmchip_add(&imx->chip);
>  	if (ret < 0)
>  		return ret;
> 

clk_prepare_enable()/clk_disable_unprepare() called in imx_pwm_config() may sleep.

So, the can_sleep flag should be true for both i.MX PWM v1 and v2, right?

-- 
Liu Ying
