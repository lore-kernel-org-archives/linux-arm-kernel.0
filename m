From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 4 Apr 2012 14:54:46 +0800
Subject: [PATCH v5 08/16] pwm: Add NVIDIA Tegra SoC support
In-Reply-To: <1332945238-14897-9-git-send-email-thierry.reding@avionic-design.de>
References: <1332945238-14897-1-git-send-email-thierry.reding@avionic-design.de>
 <1332945238-14897-9-git-send-email-thierry.reding@avionic-design.de>
Message-ID: <20120404065444.GE7264@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 28, 2012 at 04:33:50PM +0200, Thierry Reding wrote:
...
> +static struct pwm_ops tegra_pwm_ops = {

const

> +	.config = tegra_pwm_config,
> +	.enable = tegra_pwm_enable,
> +	.disable = tegra_pwm_disable,
> +	.owner = THIS_MODULE,
> +};
> +
> +static int tegra_pwm_probe(struct platform_device *pdev)
> +{
> +	struct tegra_pwm_chip *pwm;
> +	struct resource *r;
> +	int ret;
> +
> +	pwm = devm_kzalloc(&pdev->dev, sizeof(*pwm), GFP_KERNEL);
> +	if (!pwm) {
> +		dev_err(&pdev->dev, "failed to allocate memory\n");
> +		return -ENOMEM;
> +	}
> +
> +	pwm->dev = &pdev->dev;
> +
> +	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!r) {
> +		dev_err(&pdev->dev, "no memory resources defined\n");
> +		return -ENODEV;
> +	}
> +
> +	pwm->mmio_base = devm_request_and_ioremap(&pdev->dev, r);
> +	if (!pwm->mmio_base) {
> +		dev_err(&pdev->dev, "failed to ioremap() region\n");
> +		return -ENODEV;

The kernel doc of devm_request_and_ioremap() suggests -EADDRNOTAVAIL.

> +	}
> +

-- 
Regards,
Shawn
