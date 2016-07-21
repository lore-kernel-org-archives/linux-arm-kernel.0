From: jonathanh@nvidia.com (Jon Hunter)
Date: Thu, 21 Jul 2016 16:12:05 +0100
Subject: [RFC 6/6] bus: Add support for Tegra NOR controller
In-Reply-To: <1468935397-11926-7-git-send-email-mirza.krak@gmail.com>
References: <1468935397-11926-1-git-send-email-mirza.krak@gmail.com>
 <1468935397-11926-7-git-send-email-mirza.krak@gmail.com>
Message-ID: <222d4179-a72f-56d1-246b-ab66af3057d9@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 19/07/16 14:36, Mirza Krak wrote:
> From: Mirza Krak <mirza.krak@gmail.com>
> 
> The NOR bus can be used to connect high-speed devices such as NOR flash,
> FPGAs, DSPs, CAN chips, Wi-Fi chips etc.
> 
> Signed-off-by: Mirza Krak <mirza.krak@gmail.com>
> ---
>  drivers/bus/Kconfig     |   7 +++
>  drivers/bus/Makefile    |   1 +
>  drivers/bus/tegra-nor.c | 118 ++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 126 insertions(+)
>  create mode 100644 drivers/bus/tegra-nor.c

...

> +static int __init nor_probe(struct platform_device *pdev)
> +{
> +	struct resource *res;
> +	struct clk *clk;
> +	void __iomem *base;
> +	int ret;
> +
> +	/* get the resource */
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	base = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(base))
> +		return PTR_ERR(base);
> +
> +	/* get the clock */
> +	clk = devm_clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(clk))
> +		return PTR_ERR(clk);
> +
> +	ret = clk_prepare_enable(clk);
> +	if (ret)
> +		return ret;
> +
> +	/* parse the device node */
> +	ret = nor_parse_dt(pdev, base);
> +	if (ret) {
> +		dev_err(&pdev->dev, "%s fail to create devices.\n",
> +			pdev->dev.of_node->full_name);
> +		clk_disable_unprepare(clk);
> +		return ret;
> +	}
> +
> +	dev_info(&pdev->dev, "Driver registered.\n");
> +	return 0;
> +}

The reset is defined in the binding, but never used. Should we make sure
the reset is de-asserted in the probe?

Jon

-- 
nvpublic
