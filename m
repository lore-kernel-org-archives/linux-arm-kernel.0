From: pratikp@codeaurora.org (Pratik Patel)
Date: Thu, 20 Dec 2012 11:54:35 -0800
Subject: [RFC 4/8] coresight: add CoreSight ETB driver
In-Reply-To: <50D34F8F.5050304@ti.com>
References: <1355858365-11849-1-git-send-email-pratikp@codeaurora.org>
 <1355858365-11849-5-git-send-email-pratikp@codeaurora.org>
 <50D34F8F.5050304@ti.com>
Message-ID: <20121220195435.GB14877@pratikp-linux.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 20, 2012 at 11:49:03AM -0600, Jon Hunter wrote:
> 
> On 12/18/2012 01:19 PM, pratikp at codeaurora.org wrote:
> > From: Pratik Patel <pratikp@codeaurora.org>
> > 
> > This driver manages CoreSight ETB (Embedded Trace Buffer) which
> > acts as a circular buffer sink collecting generated trace data.
> > 
> > Signed-off-by: Pratik Patel <pratikp@codeaurora.org>
> > ---
> >  drivers/coresight/Makefile        |    2 +-
> >  drivers/coresight/coresight-etb.c |  467 +++++++++++++++++++++++++++++++++++++
> >  2 files changed, 468 insertions(+), 1 deletions(-)
> 
> [snip]
> 
> > +static int __devinit etb_probe(struct platform_device *pdev)
> > +{
> > +	int ret;
> > +	struct device *dev = &pdev->dev;
> > +	struct coresight_platform_data *pdata;
> > +	struct etb_drvdata *drvdata;
> > +	struct resource *res;
> > +	struct coresight_desc *desc;
> > +
> > +	if (pdev->dev.of_node) {
> > +		pdata = of_get_coresight_platform_data(dev, pdev->dev.of_node);
> > +		if (IS_ERR(pdata))
> > +			return PTR_ERR(pdata);
> > +		pdev->dev.platform_data = pdata;
> > +	}
> > +
> > +	drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
> > +	if (!drvdata)
> > +		return -ENOMEM;
> > +	drvdata->dev = &pdev->dev;
> > +	platform_set_drvdata(pdev, drvdata);
> > +
> > +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +	if (!res)
> > +		return -ENODEV;
> > +
> > +	drvdata->base = devm_ioremap(dev, res->start, resource_size(res));
> > +	if (!drvdata->base)
> > +		return -ENOMEM;
> > +
> > +	spin_lock_init(&drvdata->spinlock);
> > +
> > +	drvdata->clk = devm_clk_get(dev, "core_clk");
> > +	if (IS_ERR(drvdata->clk))
> > +		return PTR_ERR(drvdata->clk);
> > +
> > +	ret = clk_set_rate(drvdata->clk, CORESIGHT_CLK_RATE_TRACE);
> > +	if (ret)
> > +		return ret;
> > +
> > +	drvdata->buf = devm_kzalloc(dev, ETB_SIZE_WORDS * BYTES_PER_WORD,
> > +				    GFP_KERNEL);
> > +	if (!drvdata->buf)
> > +		return -ENOMEM;
> > +
> > +	desc = devm_kzalloc(dev, sizeof(*desc), GFP_KERNEL);
> > +	if (!desc)
> > +		return -ENOMEM;
> > +	desc->type = CORESIGHT_DEV_TYPE_SINK;
> > +	desc->subtype.sink_subtype = CORESIGHT_DEV_SUBTYPE_SINK_BUFFER;
> 
> Can a source be directly connected to a sink or do you need to have a
> link in between?
> 
> The reason, I ask is because on some Cortex-A8 devices we have ETM
> directly connected to ETB and there is no link per-se to configure.
> 

Source can be directly connected to a sink. I believe the current
code should be able to take care of that but I haven't tried it
since we didn't have such a case.

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
