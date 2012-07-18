From: linuxzsc@gmail.com (Richard Zhao)
Date: Wed, 18 Jul 2012 21:49:34 +0800
Subject: [PATCH v2 1/2] USB: chipidea: add imx usbmisc support
In-Reply-To: <5006BD64.8020403@pengutronix.de>
References: <1342607348-8587-1-git-send-email-richard.zhao@freescale.com>
 <1342607348-8587-2-git-send-email-richard.zhao@freescale.com>
 <20120718105204.GF30009@pengutronix.de>
 <20120718111916.GL21635@b20223-02.ap.freescale.net>
 <20120718133938.GA2198@richard-laptop>
 <5006BD64.8020403@pengutronix.de>
Message-ID: <20120718134932.GB2198@richard-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 18, 2012 at 03:43:00PM +0200, Marc Kleine-Budde wrote:
> On 07/18/2012 03:39 PM, Richard Zhao wrote:
> > [snip]
> >>>>  static struct ci13xxx_platform_data ci13xxx_imx_platdata __devinitdata  = {
> >>>>  	.name			= "ci13xxx_imx",
> >>>>  	.flags			= CI13XXX_REQUIRE_TRANSCEIVER |
> >>>> @@ -120,6 +140,9 @@ static int __devinit ci13xxx_imx_probe(struct platform_device *pdev)
> >>>>  		*pdev->dev.dma_mask = DMA_BIT_MASK(32);
> >>>>  		dma_set_coherent_mask(&pdev->dev, *pdev->dev.dma_mask);
> >>>>  	}
> >>>> +
> >>>> +	usbmisc_ops->init(&pdev->dev);
> >>>
> >>> usbmisc_ops can be NULL and also can return an error.
> >> Yes. And I find it can not work when usbmisc is module.
> > It's hard to resolve module dependency. How about build all imx related
> > things into a single module? ci13xxx_imx module init will call
> > usbmisc_imx6q_drv_init, usbmisc_imx53_drv_init etc.
> 
> Why not call a single imx_usbmisc_init. The usbmisc can call the correct
> function inside. The right init function can be selected via the
> compatible in the device tree.
Different SoC has different usbmisc driver and I have to register the
driver. A single imx_usbmisc_init shows nothing different. It doesn't
know what driver to register. Hope I got what you meant.

Thanks
Richard
> 
> Marc
> -- 
> Pengutronix e.K.                  | Marc Kleine-Budde           |
> Industrial Linux Solutions        | Phone: +49-231-2826-924     |
> Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
> Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |
> 
