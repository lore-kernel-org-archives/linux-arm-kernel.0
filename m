From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 12 Mar 2013 11:08:48 +0000
Subject: [PATCH 1/1] ARM: OMAP: gpmc: request CS address space for
 ethernet chips
In-Reply-To: <1362935902-29720-1-git-send-email-javier.martinez@collabora.co.uk>
References: <1362935902-29720-1-git-send-email-javier.martinez@collabora.co.uk>
Message-ID: <20130312110848.GG30923@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 10, 2013 at 06:18:22PM +0100, Javier Martinez Canillas wrote:
> +static int gpmc_probe_ethernet_child(struct platform_device *pdev,
> +				     struct device_node *child)
> +{
> +	int ret, cs;
> +	unsigned long base;
> +	struct resource res;
> +	struct platform_device *of_dev;
> +
> +	if (of_property_read_u32(child, "reg", &cs) < 0) {
> +		dev_err(&pdev->dev, "%s has no 'reg' property\n",
> +			child->full_name);
> +		return -ENODEV;
> +	}
> +
> +	if (of_address_to_resource(child, 0, &res)) {
> +		dev_err(&pdev->dev, "%s has malformed 'reg' property\n",
> +			child->full_name);
> +		return -ENODEV;
> +	}
> +
> +	ret = gpmc_cs_request(cs, resource_size(&res), &base);
> +	if (IS_ERR_VALUE(ret)) {

NAK.  ret < 0 is the correct way to test here.  Don't use IS_ERR_VALUE
unless you have a _very_ good reason to.  That's a good bit of advice
for everything in linux/err.h.  Don't use *anything* from there without
a damned good reason.
