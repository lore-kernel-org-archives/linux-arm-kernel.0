From: jon-hunter@ti.com (Jon Hunter)
Date: Tue, 1 May 2012 10:37:39 -0500
Subject: [PATCH 2/5] ARM: OMAP2+: PM: use the power domains registers
 cache for the power states
In-Reply-To: <1335877663-32649-3-git-send-email-j-pihet@ti.com>
References: <1335877663-32649-1-git-send-email-j-pihet@ti.com>
 <1335877663-32649-3-git-send-email-j-pihet@ti.com>
Message-ID: <4FA00343.3020704@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jean,

On 05/01/2012 08:07 AM, jean.pihet at newoldbits.com wrote:
> From: Jean Pihet <j-pihet@ti.com>
> 
> Use the caching API for the previous, current and next power domains states.
> 
> Signed-off-by: Jean Pihet <j-pihet@ti.com>
> ---
>  arch/arm/mach-omap2/powerdomain.c |   32 ++++++++++++++++++++++++++------
>  1 files changed, 26 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
> index 18e1ffc..2058e27 100644
> --- a/arch/arm/mach-omap2/powerdomain.c
> +++ b/arch/arm/mach-omap2/powerdomain.c
> @@ -854,6 +854,8 @@ int pwrdm_set_next_pwrst(struct powerdomain *pwrdm, u8 pwrst)
>  					  smp_processor_id());
>  		/* Program the pwrdm desired target state */
>  		ret = arch_pwrdm->pwrdm_set_next_pwrst(pwrdm, pwrst);
> +		if (!ret)
> +			pwrdm_cache_write(pwrdm, PWRDM_CACHE_NEXT_PWRST, pwrst);
>  	}
>  
>  	return ret;
> @@ -869,13 +871,19 @@ int pwrdm_set_next_pwrst(struct powerdomain *pwrdm, u8 pwrst)
>   */
>  int pwrdm_read_next_pwrst(struct powerdomain *pwrdm)
>  {
> -	int ret = -EINVAL;
> +	int pwrst, ret = -EINVAL;
>  
>  	if (!pwrdm)
>  		return -EINVAL;
>  
> -	if (arch_pwrdm && arch_pwrdm->pwrdm_read_next_pwrst)
> +	if (!pwrdm_cache_read(pwrdm, PWRDM_CACHE_NEXT_PWRST, &pwrst))
> +		return pwrst;
> +
> +	if (arch_pwrdm && arch_pwrdm->pwrdm_read_next_pwrst) {
>  		ret = arch_pwrdm->pwrdm_read_next_pwrst(pwrdm);
> +		if (ret >= 0)
> +			pwrdm_cache_write(pwrdm, PWRDM_CACHE_NEXT_PWRST, ret);
> +	}
>  
>  	return ret;
>  }
> @@ -906,13 +914,19 @@ int pwrdm_read_next_func_pwrst(struct powerdomain *pwrdm)
>   */
>  int pwrdm_read_pwrst(struct powerdomain *pwrdm)
>  {
> -	int ret = -EINVAL;
> +	int pwrst, ret = -EINVAL;
>  
>  	if (!pwrdm)
>  		return -EINVAL;
>  
> -	if (arch_pwrdm && arch_pwrdm->pwrdm_read_pwrst)
> +	if (!pwrdm_cache_read(pwrdm, PWRDM_CACHE_PWRST, &pwrst))
> +		return pwrst;
> +
> +	if (arch_pwrdm && arch_pwrdm->pwrdm_read_pwrst) {
>  		ret = arch_pwrdm->pwrdm_read_pwrst(pwrdm);
> +		if (ret >= 0)
> +			pwrdm_cache_write(pwrdm, PWRDM_CACHE_PWRST, ret);
> +	}

Do we really want to use the cache for the current state? This is
updated by hardware. In the above it appears that once we have read it
once we will just return this value until the cache is invalidated.
Makes me a little nervous.

Cheers
Jon
