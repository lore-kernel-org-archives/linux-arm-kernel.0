From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 22 Mar 2013 12:39:38 -0400
Subject: [PATCH v3] pinctrl: mvebu: prevent walking off the end of
 group array
In-Reply-To: <1363434272-23172-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1363196884-20193-1-git-send-email-jason@lakedaemon.net>
 <1363434272-23172-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <20130322163938.GL13280@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linus,

On Sat, Mar 16, 2013 at 12:44:32PM +0100, Sebastian Hesselbarth wrote:
> From: David Woodhouse <dwmw2@infradead.org>
> 
> While investigating (ab)use of krealloc, David found this bug.  It's
> unlikely to occur, but now we detect the condition and error out
> appropriately.
> 
> Signed-off-by: David Woodhouse <David.Woodhouse@intel.com>
> Signed-off-by: Jason Cooper <jason@lakedaemon.net>
> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> ---
> Jason, David,
> 
> I tested the patch on Dove and fixed all remaining issues.
> 
> Thomas, Gregory, Andrew should test on their platforms, too.
> 
> Sebastian
> 
> Changes from v2:
>  - fix counting of available array space
>  - fix return code handling
> 
> Changes from v1:
>  - correct typo (s/ nt / int /) I should've caught before sending.
> 
>  drivers/pinctrl/mvebu/pinctrl-mvebu.c |   33 +++++++++++++++++++++------------
>  1 file changed, 21 insertions(+), 12 deletions(-)

Does this look good to you?

fwiw,

Acked-by: Jason Cooper <jason@lakedaemon.net>

thx,

Jason.

> ---
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: David Woodhouse <dwmw2@infradead.org>
> Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Cc: Gregory Clement <gregory.clement@free-electrons.com>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Stephen Warren <swarren@wwwdotorg.org>
> Cc: Linux ARM Kernel <linux-arm-kernel@lists.infradead.org>
> Cc: linux-kernel at vger.kernel.org
> ---
> diff --git a/drivers/pinctrl/mvebu/pinctrl-mvebu.c b/drivers/pinctrl/mvebu/pinctrl-mvebu.c
> index c689c04..aa77fb7a 100644
> --- a/drivers/pinctrl/mvebu/pinctrl-mvebu.c
> +++ b/drivers/pinctrl/mvebu/pinctrl-mvebu.c
> @@ -478,8 +478,12 @@ static struct pinctrl_ops mvebu_pinctrl_ops = {
>  	.dt_free_map = mvebu_pinctrl_dt_free_map,
>  };
>  
> -static int _add_function(struct mvebu_pinctrl_function *funcs, const char *name)
> +static int _add_function(struct mvebu_pinctrl_function *funcs, int *funcsize,
> +			const char *name)
>  {
> +	if (*funcsize <= 0)
> +		return -EOVERFLOW;
> +
>  	while (funcs->num_groups) {
>  		/* function already there */
>  		if (strcmp(funcs->name, name) == 0) {
> @@ -488,8 +492,12 @@ static int _add_function(struct mvebu_pinctrl_function *funcs, const char *name)
>  		}
>  		funcs++;
>  	}
> +
> +	/* append new unique function */
>  	funcs->name = name;
>  	funcs->num_groups = 1;
> +	(*funcsize)--;
> +
>  	return 0;
>  }
>  
> @@ -497,12 +505,12 @@ static int mvebu_pinctrl_build_functions(struct platform_device *pdev,
>  					 struct mvebu_pinctrl *pctl)
>  {
>  	struct mvebu_pinctrl_function *funcs;
> -	int num = 0;
> +	int num = 0, funcsize = pctl->desc.npins;
>  	int n, s;
>  
>  	/* we allocate functions for number of pins and hope
> -	 * there are less unique functions than pins available */
> -	funcs = devm_kzalloc(&pdev->dev, pctl->desc.npins *
> +	 * there are fewer unique functions than pins available */
> +	funcs = devm_kzalloc(&pdev->dev, funcsize *
>  			     sizeof(struct mvebu_pinctrl_function), GFP_KERNEL);
>  	if (!funcs)
>  		return -ENOMEM;
> @@ -510,26 +518,27 @@ static int mvebu_pinctrl_build_functions(struct platform_device *pdev,
>  	for (n = 0; n < pctl->num_groups; n++) {
>  		struct mvebu_pinctrl_group *grp = &pctl->groups[n];
>  		for (s = 0; s < grp->num_settings; s++) {
> +			int ret;
> +
>  			/* skip unsupported settings on this variant */
>  			if (pctl->variant &&
>  			    !(pctl->variant & grp->settings[s].variant))
>  				continue;
>  
>  			/* check for unique functions and count groups */
> -			if (_add_function(funcs, grp->settings[s].name))
> +			ret = _add_function(funcs, &funcsize,
> +					    grp->settings[s].name);
> +			if (ret == -EOVERFLOW)
> +				dev_err(&pdev->dev,
> +					"More functions than pins(%d)\n",
> +					pctl->desc.npins);
> +			if (ret < 0)
>  				continue;
>  
>  			num++;
>  		}
>  	}
>  
> -	/* with the number of unique functions and it's groups known,
> -	   reallocate functions and assign group names */
> -	funcs = krealloc(funcs, num * sizeof(struct mvebu_pinctrl_function),
> -			 GFP_KERNEL);
> -	if (!funcs)
> -		return -ENOMEM;
> -
>  	pctl->num_functions = num;
>  	pctl->functions = funcs;
>  
> -- 
> 1.7.10.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
