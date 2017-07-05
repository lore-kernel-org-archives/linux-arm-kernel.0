From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Wed, 5 Jul 2017 13:09:44 +0200
Subject: [PATCH v3 2/6] pwm: mediatek: fix pwm source clock selection
In-Reply-To: <1498802721-32455-3-git-send-email-zhi.mao@mediatek.com>
References: <1498802721-32455-1-git-send-email-zhi.mao@mediatek.com>
 <1498802721-32455-3-git-send-email-zhi.mao@mediatek.com>
Message-ID: <d009712e-f0a2-2dc7-2f64-ad8cfa21f98d@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 06/30/2017 08:05 AM, Zhi Mao wrote:
> In original code, the pwm output frequency is not correct
> when set bit<3>=1 to PWMCON register.
> 
> Signed-off-by: Zhi Mao <zhi.mao@mediatek.com>
> ---
>   drivers/pwm/pwm-mediatek.c |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pwm/pwm-mediatek.c b/drivers/pwm/pwm-mediatek.c
> index 5c11bc7..d08b5b3 100644
> --- a/drivers/pwm/pwm-mediatek.c
> +++ b/drivers/pwm/pwm-mediatek.c
> @@ -91,7 +91,7 @@ static int mtk_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
>   	if (clkdiv > 7)
>   		return -EINVAL;
>   
> -	mtk_pwm_writel(pc, pwm->hwpwm, PWMCON, BIT(15) | BIT(3) | clkdiv);
> +	mtk_pwm_writel(pc, pwm->hwpwm, PWMCON, BIT(15) | clkdiv);

Just for clarification, BIT(15) enables old PWM mode, which ignores 
CLKSEL (BIT(3)). Therefore setting BIT(3) does not have any effect and 
can be discarded.

Am I correct? I took mt7623n datasheet for reference.

Regards,
Matthias

>   	mtk_pwm_writel(pc, pwm->hwpwm, PWMDWIDTH, period_ns / resolution);
>   	mtk_pwm_writel(pc, pwm->hwpwm, PWMTHRES, duty_ns / resolution);
>   
> 
