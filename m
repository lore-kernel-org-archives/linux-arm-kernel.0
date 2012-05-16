From: richard.zhao@freescale.com (Richard Zhao)
Date: Wed, 16 May 2012 16:36:27 +0800
Subject: [PATCH v1 4/7] usb: chipidea: add imx driver binding
In-Reply-To: <20120515140355.GA15199@n2100.arm.linux.org.uk>
References: <1337090303-16046-1-git-send-email-richard.zhao@freescale.com>
 <1337090303-16046-5-git-send-email-richard.zhao@freescale.com>
 <20120515140355.GA15199@n2100.arm.linux.org.uk>
Message-ID: <20120516083626.GA21051@b20223-02.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 15, 2012 at 03:03:55PM +0100, Russell King - ARM Linux wrote:
> On Tue, May 15, 2012 at 09:58:20PM +0800, Richard Zhao wrote:
> > +	plat_ci = platform_device_alloc("ci_hdrc", (int)res->start);
> > +	if (!plat_ci) {
> > +		dev_err(&pdev->dev, "can't allocate ci_hdrc platform device\n");
> > +		return -ENOMEM;
> > +	}
> > +
> > +	ret = platform_device_add_resources(plat_ci, pdev->resource,
> > +					    pdev->num_resources);
> > +	if (ret) {
> > +		dev_err(&pdev->dev, "can't add resources to platform device\n");
> > +		goto put_platform;
> > +	}
> > +
> > +	ret = platform_device_add_data(plat_ci, &ci13xxx_imx_udc_driver,
> > +				       sizeof(ci13xxx_imx_udc_driver));
> > +	if (ret)
> > +		goto put_platform;
> > +
> > +	plat_ci->dev.dma_mask =
> > +		kmalloc(sizeof(*pdev->dev.dma_mask), GFP_KERNEL);
> > +	if (!plat_ci->dev.dma_mask) {
> > +		ret = -ENOMEM;
> > +		goto put_platform;
> > +	}
> > +	*plat_ci->dev.dma_mask = DMA_BIT_MASK(32);
> > +	plat_ci->dev.coherent_dma_mask = DMA_BIT_MASK(32);
> > +
> > +	ret = platform_device_add(plat_ci);
> 
> Is there a reason not to use platform_device_register_full() ?
platform_device_register_full() allocate the dma_mask but
platform_device_unregister() didn't free it. I have to free it
manually? Sounds strange.

Thanks
Richard
> 
> Also, you don't set the parent device - is there a dependency between
> 'pdev' and this new platform device you're creating?  If so, it should
> be a child of 'pdev'.
> 
