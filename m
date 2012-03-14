From: aisheng.dong@freescale.com (Dong Aisheng)
Date: Wed, 14 Mar 2012 14:42:25 +0800
Subject: [PATCH v1 2/5] mmc: mxs-mmc: add dt probe support
In-Reply-To: <20120313174238.CE9133E053B@localhost>
References: <1331628428-24017-1-git-send-email-b29396@freescale.com>
 <1331628428-24017-3-git-send-email-b29396@freescale.com>
 <20120313174238.CE9133E053B@localhost>
Message-ID: <20120314064224.GA25735@shlinux2.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 14, 2012 at 01:42:38AM +0800, Grant Likely wrote:
> On Tue, 13 Mar 2012 16:47:05 +0800, Dong Aisheng <b29396@freescale.com> wrote:
> > From: Dong Aisheng <dong.aisheng@linaro.org>
> > 
> > Signed-off-by: Dong Aisheng <dong.aisheng@linaro.org>
> > 
> > ---
> > The patch is still using a private way for dma part binding
> > since the common dma binding is still under discussion.
> > http://www.spinics.net/lists/linux-omap/msg65528.html
> > 
> > Will update to use common dma binding when it hits mainline.
> > ---
> >  .../devicetree/bindings/mmc/fsl-mxs-mmc.txt        |   23 ++++++
> >  drivers/mmc/host/mxs-mmc.c                         |   82 +++++++++++++++++++-
> >  2 files changed, 102 insertions(+), 3 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/mmc/fsl-mxs-mmc.txt b/Documentation/devicetree/bindings/mmc/fsl-mxs-mmc.txt
> > new file mode 100644
> > index 0000000..adc1142
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mmc/fsl-mxs-mmc.txt
> > @@ -0,0 +1,23 @@
> > +* FREESCALE MXS MMC peripheral
> > +
> > +Required properties:
> > +- compatible : Should be "fsl,<chip>-mmc"
> > +- reg : Should contain registers location and length
> > +- interrupts : Should contain interrupt.
> > +  The format is <irq_err irq_dma>.
> > +- dma_channel: Should contain the dma channel it uses
> 
> Don't use '_' in property names.
> 
Yes, my mistake.

> The is a generic dma binding being drafted that uses a phandle to the dma
> controller and the ability to encode channel numbers.  You may want to take
> a look at it.
> 
I will look at it.
Thanks for the reminder.

...
> > +	dmares->flags = IORESOURCE_DMA;
> > +	ret = of_property_read_u32(np, "dma_channel", &dmares->start);
> > +	if (ret) {
> > +		dev_err(&pdev->dev, "unable to get dmares from dt\n");
> > +		return NULL;
> > +	}
> > +	dmares->end = dmares->start;
> > +
> > +	return dmares;
> > +}
> > +
> > +static int __devinit mxs_mmc_get_of_property(struct platform_device *pdev,
> > +				struct mxs_mmc_platform_data **ppdata)
> > +{
> > +	struct device_node *np = pdev->dev.of_node;
> > +	struct mxs_mmc_platform_data *pdata = *ppdata;
> > +
> > +	if (!np)
> > +		return -ENODEV;
> > +
> > +	pdata = kzalloc(sizeof(*pdata), GFP_KERNEL);
> 
> Ditto
> 
Got it.

> Fix up those comments and you can add my:
> 
> Acked-by: Grant Likely <grant.likely@secretlab.ca>
> 
Thanks.

Regards
Dong Aisheng
