From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Sun, 29 Apr 2012 19:14:18 +0200
Subject: [PATCH 3/3] pwm-core: fix registration of several pwm
In-Reply-To: <1335713330-6488-3-git-send-email-eric@eukrea.com>
References: <1335713330-6488-1-git-send-email-eric@eukrea.com>
 <1335713330-6488-3-git-send-email-eric@eukrea.com>
Message-ID: <20120429171418.GC29827@avionic-0098.adnet.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Eric B?nard wrote:
> * after a pwm is allocated using alloc_pwms, ret contains the number
> of the pwm and is returned by pwmchip_add so the calling driver
> (pwm-imx in my case) fails with the following log :
> mxc_pwm: probe of mxc_pwm.1 failed with error 1
> mxc_pwm: probe of mxc_pwm.2 failed with error 2
> mxc_pwm: probe of mxc_pwm.3 failed with error 3
> 
> * this patch fix error handling in pwmchip_add
> 
> Signed-off-by: Eric B?nard <eric@eukrea.com>
> ---
>  drivers/pwm/core.c |    7 +++++--
>  1 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> index a7be0bc..d3438e4 100644
> --- a/drivers/pwm/core.c
> +++ b/drivers/pwm/core.c
> @@ -216,8 +216,10 @@ int pwmchip_add(struct pwm_chip *chip)
>  		goto out;
>  
>  	chip->pwms = kzalloc(chip->npwm * sizeof(*pwm), GFP_KERNEL);
> -	if (!chip->pwms)
> -		return -ENOMEM;
> +	if (!chip->pwms) {
> +		ret = -ENOMEM;
> +		goto out;
> +	}

Good catch!

>  
>  	chip->base = ret;
>  
> @@ -239,6 +241,7 @@ int pwmchip_add(struct pwm_chip *chip)
>  	if (IS_ENABLED(CONFIG_OF))
>  		of_pwmchip_add(chip);
>  
> +	ret = 0;
>  out:
>  	mutex_unlock(&pwm_lock);
>  	return ret;

pwmchip_add() is meant to return a negative error-code on failure, so a
positive return values would still indicate success, therefore any callers
should check explicitly for (ret < 0) instead of just (ret). However in this
case it might be safer to make the return value explicitly 0 in case of
success.

I'd like to fold this into the existing series as well, if that's okay with
you.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120429/9288c84e/attachment.sig>
