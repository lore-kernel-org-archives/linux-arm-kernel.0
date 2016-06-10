From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 10 Jun 2016 14:48:10 +0200
Subject: [PATCH v8 6/9] pwms: pwm-ti*: Get the clock from the PWMSS
 parent when using old bindings
In-Reply-To: <1462291015-1919-7-git-send-email-fcooper@ti.com>
References: <1462291015-1919-1-git-send-email-fcooper@ti.com>
 <1462291015-1919-7-git-send-email-fcooper@ti.com>
Message-ID: <20160610124810.GE27142@ulmo.ba.sec>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 03, 2016 at 10:56:52AM -0500, Franklin S Cooper Jr wrote:
> When using the old eCAP and ePWM bindings for AM335x and AM437x the clock
> can be retrieved from the PWMSS parent. Newer bindings will insure that
> this clock is provided via device tree.
> 
> Therefore, update this driver to support the newer and older bindings. In
> the case of the older binding being used give a warning.
> 
> Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
> ---
>  drivers/pwm/pwm-tiecap.c   | 7 +++++++
>  drivers/pwm/pwm-tiehrpwm.c | 7 +++++++
>  2 files changed, 14 insertions(+)
> 
> diff --git a/drivers/pwm/pwm-tiecap.c b/drivers/pwm/pwm-tiecap.c
> index 616af76..a0833c8 100644
> --- a/drivers/pwm/pwm-tiecap.c
> +++ b/drivers/pwm/pwm-tiecap.c
> @@ -195,6 +195,7 @@ static const struct pwm_ops ecap_pwm_ops = {
>  };
>  
>  static const struct of_device_id ecap_of_match[] = {
> +	{ .compatible	= "ti,am3352-ecap" },
>  	{ .compatible	= "ti,am33xx-ecap" },
>  	{},
>  };
> @@ -213,6 +214,12 @@ static int ecap_pwm_probe(struct platform_device *pdev)
>  		return -ENOMEM;
>  
>  	clk = devm_clk_get(&pdev->dev, "fck");
> +
> +	if (IS_ERR(clk) && of_device_is_compatible(pdev->dev.of_node, "ti,am33xx-ecap")) {
> +		dev_warn(&pdev->dev, "Binding is obsolete.\n");
> +		clk = devm_clk_get(pdev->dev.parent, "fck");
> +	}

I rewrote this slightly for readability:

	struct device_node *np = pdev->dev.of_node;

	if (IS_ERR(clk)) {
		if (of_device_is_compatible(np, "ti,am33xx-ecap")) {
			...
		}
	}

>  	if (IS_ERR(clk)) {
>  		dev_err(&pdev->dev, "failed to get clock\n");
>  		return PTR_ERR(clk);
> diff --git a/drivers/pwm/pwm-tiehrpwm.c b/drivers/pwm/pwm-tiehrpwm.c
> index 6a41e66..cee29a2 100644
> --- a/drivers/pwm/pwm-tiehrpwm.c
> +++ b/drivers/pwm/pwm-tiehrpwm.c
> @@ -426,6 +426,7 @@ static const struct pwm_ops ehrpwm_pwm_ops = {
>  };
>  
>  static const struct of_device_id ehrpwm_of_match[] = {
> +	{ .compatible	= "ti,am3352-ehrpwm" },
>  	{ .compatible	= "ti,am33xx-ehrpwm" },
>  	{},
>  };
> @@ -444,6 +445,12 @@ static int ehrpwm_pwm_probe(struct platform_device *pdev)
>  		return -ENOMEM;
>  
>  	clk = devm_clk_get(&pdev->dev, "fck");
> +
> +	if (IS_ERR(clk) && of_device_is_compatible(pdev->dev.of_node, "ti,am33xx-ecap")) {
> +		dev_warn(&pdev->dev, "Binding is obsolete.\n");
> +		clk = devm_clk_get(pdev->dev.parent, "fck");
> +	}
> +

Same here.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160610/3e44f461/attachment.sig>
