From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 6 Jan 2012 08:56:17 +0000
Subject: [PATCH 5/6] ARM: mxc: add dt support for audmux-v2
In-Reply-To: <1325820343-11875-6-git-send-email-richard.zhao@linaro.org>
References: <1325820343-11875-1-git-send-email-richard.zhao@linaro.org>
 <1325820343-11875-6-git-send-email-richard.zhao@linaro.org>
Message-ID: <20120106085617.GK11810@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 06, 2012 at 11:25:42AM +0800, Richard Zhao wrote:
> +#ifdef CONFIG_OF
> +
> +static int audmux_v2_probe(struct platform_device *pdev)
> +{
> +	struct resource *res;
> +	int ret = 0;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res)
> +		return -ENODEV;
> +	if (!request_mem_region(res->start, resource_size(res), "audmux_v2")) {
> +		dev_err(&pdev->dev, "request_mem_region failed\n");
> +		return -EBUSY;
> +	}
> +
> +	audmux_base = ioremap(res->start, resource_size(res));
> +	if (!audmux_base) {
> +		dev_err(&pdev->dev, "ioremap failed\n");
> +		ret = -ENODEV;
> +		goto failed_ioremap;
> +	}
> +
> +	audmux_clk = clk_get(NULL, "audmux");

NAK.  You have a struct device.  Use it.
