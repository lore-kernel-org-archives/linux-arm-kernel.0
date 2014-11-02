From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Sun, 02 Nov 2014 21:47:11 +0100
Subject: [PATCH v6 1/7] pinctrl: rockchip: add suspend/resume functions
In-Reply-To: <1414583525-17395-2-git-send-email-zyw@rock-chips.com>
References: <1414583525-17395-1-git-send-email-zyw@rock-chips.com>
 <1414583525-17395-2-git-send-email-zyw@rock-chips.com>
Message-ID: <17050885.jWlDmdlhNv@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chris,

Am Mittwoch, 29. Oktober 2014, 19:51:59 schrieb Chris Zhong:
> support suspend/resume of pinctrl, it allows handling sleep mode
> for hogged pins in pinctrl

I've now applied patches 1 and 2 of your series to my v3.19-pinctrl/next 
branch and will be sending a pull request to LinusW shortly.

So _if_ a v7 becomes necessary you don't need to include these two patches 
anymore.


Heiko


> 
> Signed-off-by: Chris Zhong <zyw@rock-chips.com>
> Tested-by: Doug Anderson <dianders@chromium.org>
> Reviewed-by: Doug Anderson <dianders@chromium.org>
> Tested-by: Heiko Stuebner <heiko@sntech.de>
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>
> 
> ---
> 
> Changes in v6: None
> Changes in v5:
> - reset-author
> - use "__maybe_unused" annotation
> 
> Changes in v4:
> - use SIMPLE_DEV_PM_OPS for suspend/resume struct
> 
> Changes in v3: None
> Changes in v2: None
> 
>  drivers/pinctrl/pinctrl-rockchip.c |   18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/drivers/pinctrl/pinctrl-rockchip.c
> b/drivers/pinctrl/pinctrl-rockchip.c index 016f457..172ad1d 100644
> --- a/drivers/pinctrl/pinctrl-rockchip.c
> +++ b/drivers/pinctrl/pinctrl-rockchip.c
> @@ -1770,6 +1770,23 @@ static struct rockchip_pin_ctrl
> *rockchip_pinctrl_get_soc_data( return ctrl;
>  }
> 
> +static int __maybe_unused rockchip_pinctrl_suspend(struct device *dev)
> +{
> +	struct rockchip_pinctrl *info = dev_get_drvdata(dev);
> +
> +	return pinctrl_force_sleep(info->pctl_dev);
> +}
> +
> +static int __maybe_unused rockchip_pinctrl_resume(struct device *dev)
> +{
> +	struct rockchip_pinctrl *info = dev_get_drvdata(dev);
> +
> +	return pinctrl_force_default(info->pctl_dev);
> +}
> +
> +static SIMPLE_DEV_PM_OPS(rockchip_pinctrl_dev_pm_ops,
> rockchip_pinctrl_suspend, +			 rockchip_pinctrl_resume);
> +
>  static int rockchip_pinctrl_probe(struct platform_device *pdev)
>  {
>  	struct rockchip_pinctrl *info;
> @@ -1983,6 +2000,7 @@ static struct platform_driver rockchip_pinctrl_driver
> = { .driver = {
>  		.name	= "rockchip-pinctrl",
>  		.owner	= THIS_MODULE,
> +		.pm = &rockchip_pinctrl_dev_pm_ops,
>  		.of_match_table = rockchip_pinctrl_dt_match,
>  	},
>  };
