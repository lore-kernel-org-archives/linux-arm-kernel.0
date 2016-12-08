From: robin.murphy@arm.com (Robin Murphy)
Date: Thu, 8 Dec 2016 15:20:49 +0000
Subject: [PATCH V1] pinctrl:pxa:pinctrl-pxa2xx:- No need of devm functions
In-Reply-To: <1481207730-6332-1-git-send-email-arvind.yadav.cs@gmail.com>
References: <1481207730-6332-1-git-send-email-arvind.yadav.cs@gmail.com>
Message-ID: <28f80351-a89d-06b4-bd8e-d4a1810ee3c5@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/12/16 14:35, Arvind Yadav wrote:
> In functions pxa2xx_build_functions, the memory allocated for
> 'functions' is live within the function only. After the
> allocation it is immediately freed with devm_kfree. There is
> no need to allocate memory for 'functions' with devm function
> so replace devm_kcalloc  with kcalloc and devm_kfree with kfree.
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
> ---
>  drivers/pinctrl/pxa/pinctrl-pxa2xx.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pinctrl/pxa/pinctrl-pxa2xx.c b/drivers/pinctrl/pxa/pinctrl-pxa2xx.c
> index 866aa3c..47b8e3a 100644
> --- a/drivers/pinctrl/pxa/pinctrl-pxa2xx.c
> +++ b/drivers/pinctrl/pxa/pinctrl-pxa2xx.c
> @@ -277,7 +277,7 @@ static int pxa2xx_build_functions(struct pxa_pinctrl *pctl)
>  	 * alternate function, 6 * npins is an absolute high limit of the number
>  	 * of functions.
>  	 */
> -	functions = devm_kcalloc(pctl->dev, pctl->npins * 6,
> +	functions = kcalloc(pctl->npins * 6,
>  				 sizeof(*functions), GFP_KERNEL);

AFAICS, this is allocating a mere 72 bytes. Why not just declare

	struct pxa_pinctrl_function functions[6] = {0};

locally and save *all* the bother?

Robin.

>  	if (!functions)
>  		return -ENOMEM;
> @@ -289,10 +289,12 @@ static int pxa2xx_build_functions(struct pxa_pinctrl *pctl)
>  	pctl->functions = devm_kmemdup(pctl->dev, functions,
>  				       pctl->nfuncs * sizeof(*functions),
>  				       GFP_KERNEL);
> -	if (!pctl->functions)
> +	if (!pctl->functions) {
> +		kfree(functions);
>  		return -ENOMEM;
> +	}
>  
> -	devm_kfree(pctl->dev, functions);
> +	kfree(functions);
>  	return 0;
>  }
>  
> 
