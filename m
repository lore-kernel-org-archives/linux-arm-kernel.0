From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Tue, 21 Oct 2014 09:50:13 -0700
Subject: [PATCH v3 1/6] pinctrl: rockchip: add suspend/resume functions
In-Reply-To: <1413862968-2691-1-git-send-email-zyw@rock-chips.com>
References: <1413862894-2623-1-git-send-email-zyw@rock-chips.com>
 <1413862968-2691-1-git-send-email-zyw@rock-chips.com>
Message-ID: <20141021165013.GD8609@dtor-ws>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chris,

On Mon, Oct 20, 2014 at 08:42:48PM -0700, zyw at rock-chips.com wrote:
> From: Chris <zyw@rock-chips.com>
> 
> support suspend/resume of pinctrl, it allows handling sleep mode
> for hogged pins in pinctrl
> 
> Signed-off-by: Chris <zyw@rock-chips.com>
> Signed-off-by: Chris Zhong <zyw@rock-chips.com>
> ---
> 
> Changes in v3: None
> Changes in v2: None
> 
>  drivers/pinctrl/pinctrl-rockchip.c |   29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/drivers/pinctrl/pinctrl-rockchip.c b/drivers/pinctrl/pinctrl-rockchip.c
> index d0f3c18..d384d99 100644
> --- a/drivers/pinctrl/pinctrl-rockchip.c
> +++ b/drivers/pinctrl/pinctrl-rockchip.c
> @@ -1795,6 +1795,31 @@ static struct rockchip_pin_ctrl *rockchip_pinctrl_get_soc_data(
>  	return ctrl;
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

I do not think info can ever be NULL here, can it?

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

You are using legacy-style PM methods which we are trying to get away
from. The preferred style is:

static int __maybe_unused rockchip_pinctrl_suspend(struct device *dev)
{
	...
}

static in __maybe_unused rockchip_pinctrl_resume(struct device *dev)
{
	...
}

static SIMPLE_DE_PM_OPS(rockchip_pinctrl_pm_ops,
			rockchip_pinctrl_suspend, rockchip_pinctrl_resume);

> +
>  static int rockchip_pinctrl_probe(struct platform_device *pdev)
>  {
>  	struct rockchip_pinctrl *info;
> @@ -2010,6 +2035,10 @@ static struct platform_driver rockchip_pinctrl_driver = {
>  		.owner	= THIS_MODULE,
>  		.of_match_table = rockchip_pinctrl_dt_match,

And here

		.pm = &rockchip_pinctrl_pm_ops,
>  	},

Thanks.

-- 
Dmitry
