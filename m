From: leilk.liu@mediatek.com (leilk liu)
Date: Tue, 12 May 2015 20:39:16 +0800
Subject: [PATCH 2/3] spi: mediatek: Add spi bus for Mediatek MT8173
In-Reply-To: <20150508175306.GG2761@sirena.org.uk>
References: <1431075343-7887-1-git-send-email-leilk.liu@mediatek.com>
 <1431075343-7887-3-git-send-email-leilk.liu@mediatek.com>
 <20150508175306.GG2761@sirena.org.uk>
Message-ID: <1431434356.2128.9.camel@mhfsdcap03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks for your review.

On Fri, 2015-05-08 at 18:53 +0100, Mark Brown wrote:
> On Fri, May 08, 2015 at 04:55:42PM +0800, leilk.liu at mediatek.com wrote:
> > From: Leilk Liu <leilk.liu@mediatek.com>
> > 
> > This patch adds basic spi bus for MT8173.
> 
> Please try to only CC relevant people on patches, you've got a very
> broad CC list here and I'm not sure I understand why everyone is on it.
> Sending people irrelevant patches adds to the volume of mail people have
> to handle which takes time away from other things.
> 

I use scripts/get_maintainer.pl on the patches and keep all maintainers.
I'll further refine the list in the future.

> > +config SPI_MT65XX
> > +	tristate "MediaTek SPI controller"
> > +	depends on ARCH_MEDIATEK || COMPILE_TEST
> > +	select SPI_BITBANG
> 
> Unless your controller is geniunely bitbanging you shouldn't be using
> the bitbang framework, modern drivers should implement set_cs() and
> transfer_one() instead.  You should also be using the core helpers for
> DMA mapping.
> 

I will implement set_cs() and transfer_one() instead in next patch.

Could you tell me more details about "You should also be using the core
helpers for DMA mapping"?

> The driver looks basically good other than this, it shouldn't be too
> much work (and ought to save you some code) to refactor to the modern
> interfaces.
> 
> > +#define IDLE 0
> > +#define INPROGRESS 1
> > +#define PAUSED 2
> > +
> > +#define PACKET_SIZE 1024
> 
> You should namespace the constants you're using to avoid clashes with
> headers.
> 
> > +static const struct of_device_id mtk_spi_of_match[] = {
> > +	{ .compatible = "mediatek,mt6589-spi", .data = (void *)COMPAT_MT6589},
> > +	{ .compatible = "mediatek,mt8173-spi", .data = (void *)COMPAT_MT8173},
> > +	{}
> > +};
> > +MODULE_DEVICE_TABLE(of, mtk_spi_of_match);
> 
> There were three compatible strings listed in the DT binding but only
> two here.
> 

MT6589 and MT8135 is compatible; 
For MT8135 IC, it can use the follow way in dts to probe:
  compatible = "mediatek,mt8135-spi", 
	       "mediatek,mt6589-spi";
And I test it's ok on MT8135 platform. So I add struct of_device_id
mtk_spi_of_match like this in spi driver code.

> > +	/*set the software reset bit in SPI_CMD_REG.*/
> 
> /* Spaces please */
> 
> > +static unsigned long mtk_get_device_prop(struct platform_device *pdev)
> > +{
> > +	const struct of_device_id *match;
> > +
> > +	match = of_match_node(mtk_spi_of_match, pdev->dev.of_node);
> > +	return (unsigned long)match->data;
> > +}
> 
> This wrapper doesn't seem to be doing a lot and will crash if we somehow
> manage to get the driver loaded without a match (eg, if someone tries to
> instantiate as a regular platform device).
> 
> > +	ret = clk_prepare_enable(mdata->clk);
> > +	if (ret < 0) {
> > +		dev_err(&pdev->dev, "failed to enable clock (%d)\n", ret);
> > +		goto err;
> > +	}
> 
> I'd expect to see runtime PM callbacks to enable and disable this clock
> in order to minimise power consumption.

In the case of other review comments, I will also fix them in next/OK.
