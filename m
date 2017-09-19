From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 19 Sep 2017 15:09:20 +0100
Subject: [PATCH 2/2] tee: optee: allow selection of ti-smc as a calling
 method
In-Reply-To: <20170918205005.30235-2-afd@ti.com>
References: <20170918205005.30235-1-afd@ti.com>
 <20170918205005.30235-2-afd@ti.com>
Message-ID: <20170919140920.GG30715@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 18, 2017 at 03:50:05PM -0500, Andrew F. Davis wrote:
> On TI platforms OP-TEE must be called using a modified SMC call,
> allow the selection of this though DT.
> 
> Signed-off-by: Andrew F. Davis <afd@ti.com>
> ---
>  Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.txt | 2 ++
>  drivers/tee/optee/core.c                                           | 2 ++
>  2 files changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.txt b/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.txt
> index d38834c67dff..a3275ecdf186 100644
> --- a/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.txt
> +++ b/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.txt
> @@ -20,6 +20,8 @@ the reference implementation maintained by Linaro.
>                     "hvc" : HVC #0, with the register assignments specified
>  		           in drivers/tee/optee/optee_smc.h
>  
> +                   "ti-smc" : Similar to "smc" with TI specific register
> +		              adjustments

... which are what, exactly? Specified where?

As Rob said, this should really have a new compat string.

Thanks,
Mark.

>  
>  
>  Example:
> diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
> index 7952357df9c8..dfa9de590d98 100644
> --- a/drivers/tee/optee/core.c
> +++ b/drivers/tee/optee/core.c
> @@ -441,6 +441,8 @@ static optee_invoke_fn *get_invoke_func(struct device_node *np)
>  		return optee_smccc_hvc;
>  	else if (!strcmp("smc", method))
>  		return optee_smccc_smc;
> +	else if (!strcmp("ti-smc", method))
> +		return arm_ti_smccc_smc;
>  
>  	pr_warn("invalid \"method\" property: %s\n", method);
>  	return ERR_PTR(-EINVAL);
> -- 
> 2.14.1
> 
