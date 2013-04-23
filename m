From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 23 Apr 2013 20:38:05 +0100
Subject: [PATCH v4 11/15] drivers/bus: add ARM CCI support
In-Reply-To: <1360041732-17936-12-git-send-email-nicolas.pitre@linaro.org>
References: <1360041732-17936-1-git-send-email-nicolas.pitre@linaro.org>
 <1360041732-17936-12-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <20130423193805.GC5316@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 05, 2013 at 12:22:08AM -0500, Nicolas Pitre wrote:
> +void disable_cci(int cluster)
> +{
> +	u32 slave_reg = cluster ? CCI400_KF_OFFSET : CCI400_EAG_OFFSET;
> +	writel_relaxed(0x0, info->baseaddr + slave_reg);
> +
> +	while (readl_relaxed(info->baseaddr + CCI_STATUS_OFFSET)
> +						& STATUS_CHANGE_PENDING)
> +			barrier();
> +}
> +EXPORT_SYMBOL_GPL(disable_cci);

This will blow up if the cci driver hasn't been probed - which I guess is
fine.

> +
> +static int cci_driver_probe(struct platform_device *pdev)
> +{
> +	struct resource *res;
> +	int ret = 0;
> +
> +	info = kzalloc(sizeof(*info), GFP_KERNEL);
> +	if (!info) {
> +		dev_err(&pdev->dev, "unable to allocate mem\n");
> +		return -ENOMEM;
> +	}
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res) {
> +		dev_err(&pdev->dev, "No memory resource\n");
> +		ret = -EINVAL;
> +		goto mem_free;
> +	}
> +
> +	if (!request_mem_region(res->start, resource_size(res),
> +				dev_name(&pdev->dev))) {
> +		dev_err(&pdev->dev, "address 0x%x in use\n", (u32) res->start);
> +		ret = -EBUSY;
> +		goto mem_free;
> +	}
> +
> +	info->baseaddr = ioremap(res->start, resource_size(res));

As we are moving stuff over to the devm_* APIs, it would be a good idea to
avoid introducing new code not using those APIs - otherwise it just creates
yet more churn, something which Linus objects to.  Can we please try in
future to avoid creating stuff which then needs to be subsequently modified
for the latest ways to do stuff...
