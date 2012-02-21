From: sameo@linux.intel.com (Samuel Ortiz)
Date: Tue, 21 Feb 2012 12:17:05 +0100
Subject: [PATCH v4 1/2] mfd: Add anatop mfd driver
In-Reply-To: <1328734286-30091-1-git-send-email-paul.liu@linaro.org>
References: <1324980994-18462-1-git-send-email-paul.liu@linaro.org>
 <1328734286-30091-1-git-send-email-paul.liu@linaro.org>
Message-ID: <20120221111705.GV5387@sortiz-mobl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,

I didn't get patch #2, so I don't get to see how the read/write functions ar
eused for example.

On Thu, Feb 09, 2012 at 04:51:25AM +0800, Ying-Chun Liu (PaulLiu) wrote:
> From: "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>
> 
> Anatop is a mfd chip embedded in Freescale i.MX6Q SoC.
> Anatop provides regulators and thermal.
> This driver handles the address space and the operation of the mfd device.
A few comments here:



> +static u32 anatop_read(struct anatop *adata, u32 addr, int bit_shift, int bits)
> +{
> +	u32 val;
> +	int mask;
> +	if (bits == 32)
> +		mask = 0xff;
> +	else
> +		mask = (1 << bits) - 1;
> +
> +	val = ioread32(adata->ioreg+addr);
> +	val = (val >> bit_shift) & mask;
> +	return val;
> +}
> +
> +static void anatop_write(struct anatop *adata, u32 addr, int bit_shift,
> +			 int bits, u32 data)
> +{
> +	u32 val;
> +	int mask;
> +	if (bits == 32)
> +		mask = 0xff;
> +	else
> +		mask = (1 << bits) - 1;
> +
> +	val = ioread32(adata->ioreg+addr) & ~(mask << bit_shift);
> +	iowrite32((data << bit_shift) | val, adata->ioreg);
> +}
Don't you need some sort of read/write atomic routine as well ? Locking would
be needed then...


> +static const struct of_device_id of_anatop_regulator_match[] = {
> +	{
> +		.compatible = "fsl,anatop-regulator",
> +	},
> +	{
> +		.compatible = "fsl,anatop-thermal",
> +	},
> +	{ },
> +};
> +
> +static int of_anatop_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct device_node *np = dev->of_node;
> +	u64 ofaddr;
> +	u64 ofsize;
> +	void *ioreg;
> +	struct anatop *drvdata;
> +	int ret = 0;
> +	const __be32 *rval;
> +
> +	rval = of_get_address(np, 0, &ofsize, NULL);
> +	if (rval)
> +		ofaddr = be32_to_cpu(*rval);
> +	else
> +		return -EINVAL;
> +
> +	ioreg = ioremap(ofaddr, ofsize);
> +	if (!ioreg)
> +		return -EINVAL;
> +	drvdata = devm_kzalloc(dev, sizeof(struct anatop), GFP_KERNEL);
> +	if (!drvdata)
> +		return -EINVAL;
> +	drvdata->ioreg = ioreg;
> +	drvdata->read = anatop_read;
> +	drvdata->write = anatop_write;
> +	platform_set_drvdata(pdev, drvdata);
> +	of_platform_bus_probe(np, of_anatop_regulator_match, dev);
> +	return ret;
> +}
So it seems that your driver here does nothing but extending your device tree
definition. Correct me if I'm wrong, aren't you trying to fix a broken device
tree definition here ?

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
