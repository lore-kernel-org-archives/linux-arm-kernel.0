From: sre@kernel.org (Sebastian Reichel)
Date: Sun, 22 Mar 2015 11:40:54 +0100
Subject: [PATCH 2/7] power: mxs_power: add driver for mxs power subsystem
In-Reply-To: <1426984203-9133-3-git-send-email-stefan.wahren@i2se.com>
References: <1426984203-9133-1-git-send-email-stefan.wahren@i2se.com>
 <1426984203-9133-3-git-send-email-stefan.wahren@i2se.com>
Message-ID: <20150322104053.GA5394@earth>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sun, Mar 22, 2015 at 12:29:58AM +0000, Stefan Wahren wrote:
> This patch adds a minimal driver for the Freescale i.MX23, i.MX28
> power subsystem. It's required to trigger the probing of the underlying
> drivers like on-chip regulators.
> 
> [...]
>
> +config MXS_POWER
> +	tristate "Freescale MXS power subsystem support"
> +	depends on ARCH_MXS

please add "|| COMPILE_TEST"

> +	help
> +	  Say Y here to enable support for the Freescale i.MX23/i.MX28
> +	  power subsystem. This is a requirement to get access to on-chip
> +	  regulators, battery charger and many more.
>
> [...]
>
> +static int mxs_power_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct device_node *np = dev->of_node;
> +	struct resource *res;
> +	struct mxs_power_data *data;
> +	struct power_supply_config psy_cfg = {};
> +	void __iomem *v5ctrl_addr;
> +
> +	if (!np) {
> +		dev_err(dev, "missing device tree\n");
> +		return -EINVAL;
> +	}
> +
> +	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	data->base_addr = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(data->base_addr))
> +		return PTR_ERR(data->base_addr);
> +
> +	psy_cfg.drv_data = data;
> +
> +	data->ac = power_supply_register(dev, &ac_desc, &psy_cfg);
> +	if (IS_ERR(data->ac))
> +		return PTR_ERR(data->ac);

You can use devm_power_supply_register to simplify the driver
a bit more.

> +	platform_set_drvdata(pdev, data);
> +
> +	v5ctrl_addr = data->base_addr + HW_POWER_5VCTRL_OFFSET;
> +
> +	/* Make sure the current limit of the linregs are disabled. */
> +	writel(BM_POWER_5VCTRL_ENABLE_LINREG_ILIMIT,
> +	       v5ctrl_addr + HW_POWER_CTRL_CLR);
> +
> +	return of_platform_populate(np, NULL, NULL, dev);
> +}
> +
> [...]

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150322/76b83142/attachment.sig>
