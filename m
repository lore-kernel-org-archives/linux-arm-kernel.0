From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 12 Jun 2015 11:14:37 +0200
Subject: [PATCH 1/2] PWM: atmel: fix incorrect CDTY value after enabling
In-Reply-To: <1432559996-4415-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1432559996-4415-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <20150612091434.GA19400@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 25, 2015 at 03:19:55PM +0200, Alexandre Belloni wrote:
> CUPD is not flushed before enabling the channel so it will update CDTY/CPRD just
> after one period. So we always set CUPD, even when the channel is not enabled.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---
>  drivers/pwm/pwm-atmel.c | 35 ++++++++++++++++++-----------------
>  1 file changed, 18 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-atmel.c b/drivers/pwm/pwm-atmel.c
> index d3c22de9ee47..89f9ca41d9af 100644
> --- a/drivers/pwm/pwm-atmel.c
> +++ b/drivers/pwm/pwm-atmel.c
> @@ -155,24 +155,25 @@ static void atmel_pwm_config_v1(struct pwm_chip *chip, struct pwm_device *pwm,
>  	struct atmel_pwm_chip *atmel_pwm = to_atmel_pwm_chip(chip);
>  	unsigned int val;
>  
> -	if (test_bit(PWMF_ENABLED, &pwm->flags)) {
> -		/*
> -		 * If the PWM channel is enabled, using the update register,
> -		 * it needs to set bit 10 of CMR to 0
> -		 */
> -		atmel_pwm_ch_writel(atmel_pwm, pwm->hwpwm, PWMV1_CUPD, dty);
>  
> -		val = atmel_pwm_ch_readl(atmel_pwm, pwm->hwpwm, PWM_CMR);
> -		val &= ~PWM_CMR_UPD_CDTY;
> -		atmel_pwm_ch_writel(atmel_pwm, pwm->hwpwm, PWM_CMR, val);
> -	} else {
> -		/*
> -		 * If the PWM channel is disabled, write value to duty and
> -		 * period registers directly.
> -		 */
> -		atmel_pwm_ch_writel(atmel_pwm, pwm->hwpwm, PWMV1_CDTY, dty);
> -		atmel_pwm_ch_writel(atmel_pwm, pwm->hwpwm, PWMV1_CPRD, prd);
> -	}
> +	atmel_pwm_ch_writel(atmel_pwm, pwm->hwpwm, PWMV1_CUPD, dty);
> +
> +	val = atmel_pwm_ch_readl(atmel_pwm, pwm->hwpwm, PWM_CMR);
> +	val &= ~PWM_CMR_UPD_CDTY;
> +	atmel_pwm_ch_writel(atmel_pwm, pwm->hwpwm, PWM_CMR, val);
> +
> +	/*
> +	 * If the PWM channel is enabled, only update CDTY by using the update
> +	 * register, it needs to set bit 10 of CMR to 0
> +	 */
> +	if (test_bit(PWMF_ENABLED, &pwm->flags))
> +		return;
> +	/*
> +	 * If the PWM channel is disabled, write value to duty and period
> +	 * registers directly.
> +	 */
> +	atmel_pwm_ch_writel(atmel_pwm, pwm->hwpwm, PWMV1_CDTY, dty);
> +	atmel_pwm_ch_writel(atmel_pwm, pwm->hwpwm, PWMV1_CPRD, prd);
>  }
>  
>  static void atmel_pwm_config_v2(struct pwm_chip *chip, struct pwm_device *pwm,

Applied, thanks.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150612/86c39533/attachment.sig>
