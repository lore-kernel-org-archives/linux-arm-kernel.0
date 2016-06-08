From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Wed, 8 Jun 2016 08:33:01 +0200
Subject: [PATCH] pinctrl: at91-pio4: fix non-exported functions
In-Reply-To: <1465319265-27630-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1465319265-27630-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <20160608063301.GG373@odux.rfo.atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 07, 2016 at 06:07:45PM +0100, Ben Dooks wrote:
> The atmel_pctl_find_group_by_pin() and the atmel_pinctrl_remove()
> functions are not exported, so fix the warnings about these
> being exported without definitions by making them static.
> 
> drivers/pinctrl/pinctrl-at91-pio4.c:424:20: warning: symbol 'atmel_pctl_find_group_by_pin' was not declared. Should it be static?
> drivers/pinctrl/pinctrl-at91-pio4.c:1077:5: warning: symbol 'atmel_pinctrl_remove' was not declared. Should it be static?
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---
> Cc: Ludovic Desroches <ludovic.desroches@atmel.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-gpio at vger.kernel.org

Thanks for fixing this. It conflicts with 'pinctrl: make non-modular
drivers really non modular' patches because of atmel_pinctrl_remove
removal.

Acked-by: Ludovic Desroches <ludovic.desroches@atmel.com>

> ---
>  drivers/pinctrl/pinctrl-at91-pio4.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pinctrl/pinctrl-at91-pio4.c b/drivers/pinctrl/pinctrl-at91-pio4.c
> index a025b40..22c6ad0 100644
> --- a/drivers/pinctrl/pinctrl-at91-pio4.c
> +++ b/drivers/pinctrl/pinctrl-at91-pio4.c
> @@ -421,8 +421,8 @@ static int atmel_pctl_get_group_pins(struct pinctrl_dev *pctldev,
>  	return 0;
>  }
>  
> -struct atmel_group *atmel_pctl_find_group_by_pin(struct pinctrl_dev *pctldev,
> -						 unsigned pin)
> +static struct atmel_group *
> +atmel_pctl_find_group_by_pin(struct pinctrl_dev *pctldev, unsigned pin)
>  {
>  	struct atmel_pioctrl *atmel_pioctrl = pinctrl_dev_get_drvdata(pctldev);
>  	int i;
> @@ -1074,7 +1074,7 @@ clk_prepare_enable_error:
>  	return ret;
>  }
>  
> -int atmel_pinctrl_remove(struct platform_device *pdev)
> +static int atmel_pinctrl_remove(struct platform_device *pdev)
>  {
>  	struct atmel_pioctrl *atmel_pioctrl = platform_get_drvdata(pdev);
>  
> -- 
> 2.8.1
> 
