From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Tue, 21 Oct 2014 23:20:11 +0200
Subject: [PATCH v3 1/6] pinctrl: rockchip: add suspend/resume functions
In-Reply-To: <1413862968-2691-1-git-send-email-zyw@rock-chips.com>
References: <1413862894-2623-1-git-send-email-zyw@rock-chips.com>
 <1413862968-2691-1-git-send-email-zyw@rock-chips.com>
Message-ID: <3477070.K1aFAOaaEU@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chris,

Am Montag, 20. Oktober 2014, 20:42:48 schrieb zyw at rock-chips.com:
> From: Chris <zyw@rock-chips.com>

Please use your full name like "Chris Zhong"

> 
> support suspend/resume of pinctrl, it allows handling sleep mode
> for hogged pins in pinctrl
> 
> Signed-off-by: Chris <zyw@rock-chips.com>
> Signed-off-by: Chris Zhong <zyw@rock-chips.com>

also, please use only one Signed-off-by line for yourself :-)


> ---
> 
> Changes in v3: None
> Changes in v2: None
> 
>  drivers/pinctrl/pinctrl-rockchip.c |   29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/drivers/pinctrl/pinctrl-rockchip.c
> b/drivers/pinctrl/pinctrl-rockchip.c index d0f3c18..d384d99 100644
> --- a/drivers/pinctrl/pinctrl-rockchip.c
> +++ b/drivers/pinctrl/pinctrl-rockchip.c
> @@ -1795,6 +1795,31 @@ static struct rockchip_pin_ctrl
> *rockchip_pinctrl_get_soc_data( return ctrl;
>  }
> 
> +#ifdef CONFIG_PM
> +static int rockchip_pinctrl_suspend(struct platform_device *pdev,
> +				    pm_message_t state)
> +{
> +	struct rockchip_pinctrl *info;
> +
> +	info = platform_get_drvdata(pdev);
> +	if (!info)
> +		return -EINVAL;
> +
> +	return pinctrl_force_sleep(info->pctl_dev);
> +}
> +
> +static int rockchip_pinctrl_resume(struct platform_device *pdev)
> +{
> +	struct rockchip_pinctrl *info;
> +
> +	info = platform_get_drvdata(pdev);
> +	if (!info)
> +		return -EINVAL;
> +
> +	return pinctrl_force_default(info->pctl_dev);
> +}
> +#endif
> +
>  static int rockchip_pinctrl_probe(struct platform_device *pdev)
>  {
>  	struct rockchip_pinctrl *info;
> @@ -2010,6 +2035,10 @@ static struct platform_driver rockchip_pinctrl_driver
> = { .owner	= THIS_MODULE,
>  		.of_match_table = rockchip_pinctrl_dt_match,
>  	},
> +	#ifdef CONFIG_PM
> +	.suspend = rockchip_pinctrl_suspend,
> +	.resume = rockchip_pinctrl_resume,
> +	#endif

as Dmitry already pointed out, this is the legacy suspend interface and should 
not be used anymore.


>  };
> 
>  static int __init rockchip_pinctrl_drv_register(void)
