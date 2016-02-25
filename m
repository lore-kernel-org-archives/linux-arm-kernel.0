From: heikki.krogerus@linux.intel.com (Heikki Krogerus)
Date: Thu, 25 Feb 2016 13:42:06 +0200
Subject: [PATCH 11/50] pinctrl: cherryview: Use devm_pinctrl_register()
 for pinctrl registration
In-Reply-To: <1456319775-3216-12-git-send-email-ldewangan@nvidia.com>
References: <1456319775-3216-1-git-send-email-ldewangan@nvidia.com>
 <1456319775-3216-12-git-send-email-ldewangan@nvidia.com>
Message-ID: <20160225114206.GA29434@kuha.fi.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Feb 24, 2016 at 06:45:36PM +0530, Laxman Dewangan wrote:
> Use devm_pinctrl_register() for pin control registration.
> 
> Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> ---
>  drivers/pinctrl/intel/pinctrl-cherryview.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pinctrl/intel/pinctrl-cherryview.c b/drivers/pinctrl/intel/pinctrl-cherryview.c
> index 4251e07..1152b8a 100644
> --- a/drivers/pinctrl/intel/pinctrl-cherryview.c
> +++ b/drivers/pinctrl/intel/pinctrl-cherryview.c
> @@ -1526,7 +1526,8 @@ static int chv_pinctrl_probe(struct platform_device *pdev)
>  	pctrl->pctldesc.pins = pctrl->community->pins;
>  	pctrl->pctldesc.npins = pctrl->community->npins;
>  
> -	pctrl->pctldev = pinctrl_register(&pctrl->pctldesc, &pdev->dev, pctrl);
> +	pctrl->pctldev = devm_pinctrl_register(&pdev->dev, &pctrl->pctldesc,
> +					       pctrl);
>  	if (IS_ERR(pctrl->pctldev)) {
>  		dev_err(&pdev->dev, "failed to register pinctrl driver\n");
>  		return PTR_ERR(pctrl->pctldev);

You missed one pinctrl_unregister() call inside chv_pinctrl_probe().
Check right below this point where chv_gpio_probe() is called.

> @@ -1548,7 +1549,6 @@ static int chv_pinctrl_remove(struct platform_device *pdev)
>  	struct chv_pinctrl *pctrl = platform_get_drvdata(pdev);
>  
>  	gpiochip_remove(&pctrl->chip);
> -	pinctrl_unregister(pctrl->pctldev);
>  
>  	return 0;
>  }
> -- 
> 2.1.4

Thanks,

-- 
heikki
