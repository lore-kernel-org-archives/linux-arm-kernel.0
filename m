From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 23 Jan 2017 10:50:09 +0800
Subject: [PATCH v1 3/3] i2c: zx2967: add i2c controller driver for ZTE's
 zx2967 family
In-Reply-To: <1484901827-16369-3-git-send-email-baoyou.xie@linaro.org>
References: <1484901827-16369-1-git-send-email-baoyou.xie@linaro.org>
 <1484901827-16369-3-git-send-email-baoyou.xie@linaro.org>
Message-ID: <20170123025008.GB5662@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 20, 2017 at 04:43:47PM +0800, Baoyou Xie wrote:
> +static int zx2967_i2c_probe(struct platform_device *pdev)
> +{
> +	struct resource *res;
> +	struct zx2967_i2c_info *zx_i2c = NULL;
> +	struct clk *clk;
> +	void __iomem *reg_base;
> +	int ret = 0;
> +
> +	zx_i2c = devm_kzalloc(&pdev->dev, sizeof(*zx_i2c), GFP_KERNEL);
> +	if (!zx_i2c)
> +		return -ENOMEM;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res) {
> +		dev_err(&pdev->dev, "missing io resource\n");
> +		return -EINVAL;
> +	}
> +
> +	reg_base = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(reg_base))
> +		return PTR_ERR(reg_base);
> +
> +	clk = devm_clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(clk)) {
> +		dev_err(&pdev->dev, "missing controller clock");
> +		return PTR_ERR(clk);
> +	}
> +
> +	ret = clk_prepare_enable(clk);
> +	if (ret) {
> +		dev_err(&pdev->dev, "failed to enable i2c_clk\n");
> +		return ret;
> +	}
> +
> +	of_property_read_u32(pdev->dev.of_node,
> +			"clock-frequency", &zx_i2c->clk_freq);
> +	zx_i2c->reg_base = reg_base;
> +	zx_i2c->clk = clk;
> +	zx_i2c->irq = platform_get_irq(pdev, 0);
> +	zx_i2c->id = pdev->id;
> +	zx_i2c->dev = &pdev->dev;
> +
> +	zx_i2c->pin_scl = devm_pinctrl_get_select(&pdev->dev, "scl");
> +	if (IS_ERR(zx_i2c->pin_scl))
> +		dev_info(&pdev->dev, "scl pin is not specified in dts\n");
> +
> +	zx_i2c->pin_sda = devm_pinctrl_get_select(&pdev->dev, "sda");
> +	if (IS_ERR(zx_i2c->pin_sda))
> +		dev_info(&pdev->dev, "sda pin is not specified in dts\n");

I don't understand why this is necessary.  For most cases, we only need
to specify needed pins in property 'pinctrl-0' and 'default' in
'pinctrl-names', and pinctrl/driver core will just set up the pins for
the device.

Shawn
