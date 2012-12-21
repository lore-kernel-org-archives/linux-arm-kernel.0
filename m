From: pratikp@codeaurora.org (Pratik Patel)
Date: Fri, 21 Dec 2012 14:27:03 -0800
Subject: [RFC 3/5] ARM: CTI: Convert CTI helpers to AMBA bus driver
In-Reply-To: <1355348588-22318-4-git-send-email-jon-hunter@ti.com>
References: <1355348588-22318-1-git-send-email-jon-hunter@ti.com>
 <1355348588-22318-4-git-send-email-jon-hunter@ti.com>
Message-ID: <20121221222703.GB2658@pratikp-linux.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 12, 2012 at 03:43:06PM -0600, Jon Hunter wrote:
> +
> +/**
> + * cti_irq_ack - acknowledges the CTI trigger output
> + * @cti: CTI instance
> + *
> + * Acknowledges the CTI trigger output by writting to the appropriate
> + * bit in the CTI interrupt acknowledge register.
> + */
> +int cti_irq_ack(struct cti *cti)
> +{
> +	u32 v;
> +
> +	if (!cti || !cti->enabled)
> +		return -EINVAL;
> +
> +	v = cti_readl(cti, CTIINTACK);

Just curious if CTIINTACK is a read-write register? This is a
read-only for us.

> +	v |= BIT(cti->trig_out);
> +	cti_writel(v, cti, CTIINTACK);
> +
> +	return 0;
> +}
> +
> +
> +static int cti_probe(struct amba_device *dev, const struct amba_id *id)
> +{
> +	struct cti *cti;
> +	struct device_node *np = dev->dev.of_node;
> +	int rc;
> +
> +	if (!np) {
> +		dev_err(&dev->dev, "device-tree not found!\n");
> +		return -ENODEV;
> +	}
> +
> +	cti = devm_kzalloc(&dev->dev, sizeof(struct cti), GFP_KERNEL);
> +	if (!cti) {
> +		dev_err(&dev->dev, "memory allocation failed!\n");
> +		return -ENOMEM;
> +	}
> +
> +	rc = of_property_read_string_index(np, "arm,cti-name", 0, &cti->name);
> +	if (rc) {
> +		dev_err(&dev->dev, "no name found for CTI!\n");
> +		return rc;
> +	}

Shouldn't the CTI driver have some kind of clock management that
it does for itself?

> +
> +	if (!dev->irq[0]) {
> +		dev_err(&dev->dev, "no CTI interrupt found!\n");
> +		return -ENODEV;
> +	}
> +
> +	cti->irq = dev->irq[0];
> +	cti->base = of_iomap(np, 0);
> +	if (!cti->base) {
> +		dev_err(&dev->dev, "unable to map CTI registers!\n");
> +		return -ENOMEM;
> +	}
> +
> +	cti->dev = &dev->dev;
> +	amba_set_drvdata(dev, cti);
> +	list_add_tail(&cti->node, &cti_list);
> +
> +	/*
> +	 * AMBA bus driver has already enabled RPM and incremented
> +	 * use-count, so now we can safely decrement the use-count
> +	 * and allow the CTI driver to manage RPM for the device.
> +	 */
> +	pm_runtime_put(&dev->dev);
> +
> +	dev_info(&dev->dev, "ARM CTI driver");
> +
> +	return 0;
> +}
> +

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
