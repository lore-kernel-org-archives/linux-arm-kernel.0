From: pratikp@codeaurora.org (Pratik Patel)
Date: Thu, 3 Jan 2013 10:47:52 -0800
Subject: [RFC 3/5] ARM: CTI: Convert CTI helpers to AMBA bus driver
In-Reply-To: <50E48934.6070201@ti.com>
References: <1355348588-22318-1-git-send-email-jon-hunter@ti.com>
 <1355348588-22318-4-git-send-email-jon-hunter@ti.com>
 <20121221222703.GB2658@pratikp-linux.qualcomm.com>
 <50E48934.6070201@ti.com>
Message-ID: <20130103184752.GB30277@pratikp-linux.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 02, 2013 at 01:23:32PM -0600, Jon Hunter wrote:
> 
> On 12/21/2012 04:27 PM, Pratik Patel wrote:
> > On Wed, Dec 12, 2012 at 03:43:06PM -0600, Jon Hunter wrote:
> >> +
> >> +/**
> >> + * cti_irq_ack - acknowledges the CTI trigger output
> >> + * @cti: CTI instance
> >> + *
> >> + * Acknowledges the CTI trigger output by writting to the appropriate
> >> + * bit in the CTI interrupt acknowledge register.
> >> + */
> >> +int cti_irq_ack(struct cti *cti)
> >> +{
> >> +	u32 v;
> >> +
> >> +	if (!cti || !cti->enabled)
> >> +		return -EINVAL;
> >> +
> >> +	v = cti_readl(cti, CTIINTACK);
> > 
> > Just curious if CTIINTACK is a read-write register? This is a
> > read-only for us.
> > 
> >> +	v |= BIT(cti->trig_out);
> >> +	cti_writel(v, cti, CTIINTACK);
> >> +
> >> +	return 0;
> >> +}
> >> +
> >> +
> >> +static int cti_probe(struct amba_device *dev, const struct amba_id *id)
> >> +{
> >> +	struct cti *cti;
> >> +	struct device_node *np = dev->dev.of_node;
> >> +	int rc;
> >> +
> >> +	if (!np) {
> >> +		dev_err(&dev->dev, "device-tree not found!\n");
> >> +		return -ENODEV;
> >> +	}
> >> +
> >> +	cti = devm_kzalloc(&dev->dev, sizeof(struct cti), GFP_KERNEL);
> >> +	if (!cti) {
> >> +		dev_err(&dev->dev, "memory allocation failed!\n");
> >> +		return -ENOMEM;
> >> +	}
> >> +
> >> +	rc = of_property_read_string_index(np, "arm,cti-name", 0, &cti->name);
> >> +	if (rc) {
> >> +		dev_err(&dev->dev, "no name found for CTI!\n");
> >> +		return rc;
> >> +	}
> > 
> > Shouldn't the CTI driver have some kind of clock management that
> > it does for itself?
> 
> It does by using runtime PM. If you look at the cti_get/put functions,
> you will see calls to pm_runtime_get/put. These calls will enable the
> AMBA apb-clock. If you need to enable additional clocks then you could
> register pm runtime resume/idle call backs to do this.
> 

Ok

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
