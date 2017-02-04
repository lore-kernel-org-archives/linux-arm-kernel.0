From: shawnguo@kernel.org (Shawn Guo)
Date: Sat, 4 Feb 2017 15:15:47 +0800
Subject: [PATCH v3 3/3] i2c: zx2967: add i2c controller driver for ZTE's
 zx2967 family
In-Reply-To: <1485435631-32642-3-git-send-email-baoyou.xie@linaro.org>
References: <1485435631-32642-1-git-send-email-baoyou.xie@linaro.org>
 <1485435631-32642-3-git-send-email-baoyou.xie@linaro.org>
Message-ID: <20170204071545.GC3407@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Only a couple of comments below.  Otherwise, the patch looks fine to me.

On Thu, Jan 26, 2017 at 09:00:31PM +0800, Baoyou Xie wrote:

<snip>

> +static int zx2967_i2c_flush_fifos(struct zx2967_i2c_info *zx_i2c)
> +{
> +	u32 val;
> +	u32 offset;
> +
> +	if (zx_i2c->msg_rd) {
> +		offset = REG_RDCONF;
> +		val = I2C_RFIFO_RESET;
> +	} else {
> +		offset = REG_WRCONF;
> +		val = I2C_WFIFO_RESET;
> +	}
> +
> +	val |= zx2967_i2c_readl(zx_i2c, offset);
> +	zx2967_i2c_writel(zx_i2c, val, offset);
> +
> +	return 0;

Since the function will never return other values than 0, should we
simply define the return type as void?

> +}

<snip>

> +static int zx2967_i2c_probe(struct platform_device *pdev)
> +{
> +	struct zx2967_i2c_info *zx_i2c;
> +	void __iomem *reg_base;
> +	struct resource *res;
> +	struct clk *clk;
> +	int ret;
> +
> +	zx_i2c = devm_kzalloc(&pdev->dev, sizeof(*zx_i2c), GFP_KERNEL);
> +	if (!zx_i2c)
> +		return -ENOMEM;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
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
> +	ret = platform_get_irq(pdev, 0);
> +	if (ret < 0)
> +		return ret;
> +	zx_i2c->irq = ret;
> +
> +	ret = device_property_read_u32(&pdev->dev, "clock-frequency",
> +				       &zx_i2c->clk_freq);
> +	if (ret) {
> +		dev_err(&pdev->dev, "missing clock-frequency");
> +		return ret;
> +	}
> +
> +	zx_i2c->reg_base = reg_base;
> +	zx_i2c->clk = clk;
> +	zx_i2c->dev = &pdev->dev;
> +
> +	zx_i2c->pin_ctrl = devm_pinctrl_get_select_default(&pdev->dev);
> +	if (IS_ERR(zx_i2c->pin_ctrl)) {
> +		if (PTR_ERR(zx_i2c->pin_ctrl) == -EPROBE_DEFER)
> +			return -EPROBE_DEFER;
> +		dev_info(&pdev->dev, "no pinctrl handle\n");
> +	}

You do not need this boilerplate code for request "default" pin state,
since device core will automatically issue the call.  See section "Pin
control requests from drivers" in Documentation/pinctrl.txt for more
info.

Shawn
