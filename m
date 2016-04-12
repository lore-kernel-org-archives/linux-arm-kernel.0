From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 12 Apr 2016 12:56:09 +0200
Subject: [RESEND 10/11] pwm: sti: Enable PWM Capture
In-Reply-To: <1456932729-9667-11-git-send-email-lee.jones@linaro.org>
References: <1456932729-9667-1-git-send-email-lee.jones@linaro.org>
 <1456932729-9667-11-git-send-email-lee.jones@linaro.org>
Message-ID: <20160412105609.GF18882@ulmo.ba.sec>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 02, 2016 at 03:32:08PM +0000, Lee Jones wrote:
> Once all functionality is in place, we provide the means to
> enable PWM Capture.  Here we are simply obtaining the
> associated regmap and twiddling the relevant enable register
> bits.
> 
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/pwm/pwm-sti.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/pwm/pwm-sti.c b/drivers/pwm/pwm-sti.c
> index 8de9b4a..93cf20e 100644
> --- a/drivers/pwm/pwm-sti.c
> +++ b/drivers/pwm/pwm-sti.c
> @@ -279,6 +279,13 @@ static int sti_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
>  				pwm->hwpwm);
>  			goto out;
>  		}
> +
> +		ret = regmap_field_write(pc->pwm_cpt_en, 1);
> +		if (ret) {
> +			dev_err(dev, "failed to enable PWM capture:%d\n",
> +				pwm->hwpwm);
> +			goto out;
> +		}

Should this perhaps be part of the driver's ->capture() implementation?
It seems redundant to have this logic enabled if we may never use it.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160412/2e44a93e/attachment.sig>
