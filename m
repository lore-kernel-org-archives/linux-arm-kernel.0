From: Claudiu.Beznea@microchip.com (m18063)
Date: Mon, 26 Jun 2017 11:43:01 +0300
Subject: [PATCH v2 5/6] pwm: mediatek: add PWM_CLK_DIV_MAX
In-Reply-To: <1498194505-30930-6-git-send-email-zhi.mao@mediatek.com>
References: <1498194505-30930-1-git-send-email-zhi.mao@mediatek.com>
 <1498194505-30930-6-git-send-email-zhi.mao@mediatek.com>
Message-ID: <8eaabcb6-c7b1-efcc-7dae-967a38feb8f1@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 23.06.2017 08:08, Zhi Mao wrote:
> Replace "7" with "PWM_CLK_DIV_MAX" in function:mtk_pwm_config()
> to improve the code readablity.
> 
> Signed-off-by: Zhi Mao <zhi.mao@mediatek.com>
> ---
>  drivers/pwm/pwm-mediatek.c |    6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pwm/pwm-mediatek.c b/drivers/pwm/pwm-mediatek.c
> index 554a042..e5f6425 100644
> --- a/drivers/pwm/pwm-mediatek.c
> +++ b/drivers/pwm/pwm-mediatek.c
> @@ -30,6 +30,8 @@
>  #define PWMDWIDTH		0x2c
>  #define PWMTHRES		0x30
>  
> +#define PWM_CLK_DIV_MAX		7
> +
>  enum {
>  	MTK_CLK_MAIN = 0,
>  	MTK_CLK_TOP,
> @@ -130,8 +132,10 @@ static int mtk_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
>  		clkdiv++;
>  	}
>  
> -	if (clkdiv > 7)
> +	if (clkdiv > PWM_CLK_DIV_MAX) {
You forgot to:
		mtk_pwm_clk_disable(chip, pwm);
> +		dev_err(chip->dev, "period %d not supported\n", period_ns);
>  		return -EINVAL;
> +	}
>  
>  	mtk_pwm_writel(pc, pwm->hwpwm, PWMCON, BIT(15) | clkdiv);
>  	mtk_pwm_writel(pc, pwm->hwpwm, PWMDWIDTH, period_ns / resolution);
> 
