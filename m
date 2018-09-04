From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Tue, 04 Sep 2018 11:12:25 +0200
Subject: [PATCH 3/3] media: imx-pxp: add i.MX Pixel Pipeline driver
In-Reply-To: <20180904080408.GJ20333@w540>
References: <20180810151822.18650-1-p.zabel@pengutronix.de>
 <20180810151822.18650-4-p.zabel@pengutronix.de>
 <20180904080408.GJ20333@w540>
Message-ID: <1536052345.3468.1.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jacopo,

thank you for the review!

On Tue, 2018-09-04 at 10:04 +0200, jacopo mondi wrote:
> Hi Philipp,
> 
> On Fri, Aug 10, 2018 at 05:18:22PM +0200, Philipp Zabel wrote:
[...]
> > +static struct pxp_fmt formats[] = {
> > +	{
> > +		.fourcc	= V4L2_PIX_FMT_XBGR32,
> > +		.depth	= 32,
> > +		/* Both capture and output format */
> > +		.types	= MEM2MEM_CAPTURE | MEM2MEM_OUTPUT,
[...]
> > +	}, {
> > +		.fourcc = V4L2_PIX_FMT_YUV32,
> > +		.depth	= 16,
> 
> According to:
> https://www.linuxtv.org/downloads/v4l-dvb-apis-old/packed-yuv.html
> shouldn't this be 32?

Yes, I'll change depth to 32.

[...]
> > +}
> > +
> 
> Multiple blank lines (in a few other places too)
> 
> > +

Found them, will fix them.

[...]
> > +	/* Enable clocks and dump registers */
> > +	clk_prepare_enable(dev->clk);
> > +	pxp_soft_reset(dev);
> > +
> > +	spin_lock_init(&dev->irqlock);
> > +
> > +	ret = v4l2_device_register(&pdev->dev, &dev->v4l2_dev);
> > +	if (ret)
> > +		return ret;
> > +
> > +	atomic_set(&dev->num_inst, 0);
> > +	mutex_init(&dev->dev_mutex);
> > +
> > +	dev->vfd = pxp_videodev;
> 
> The name of the video device is the same for all instances of this
> driver. Is this ok?

I expect that there is only ever going to be one instance on the SoC.

[...]
> > +	v4l2_device_unregister(&dev->v4l2_dev);
> 
> Disable clock?

Yes, I'll fix the clock handling.

[...]
> > +MODULE_DESCRIPTION("i.MX PXP mem2mem scaler/CSC/rotator");
> > +MODULE_AUTHOR("Philipp Zabel <kernel@pengutronix.de>");
> > +MODULE_LICENSE("GPL");
> 
> SPDX header says GPL2.0+

See include/linux/module.h:

/*
?* The following license idents are currently accepted as indicating free
?* software modules
?*
?*??????"GPL"???????????????????????????[GNU Public License v2 or later]
 * [...]
 */

This already seems to be the right choice.

regards
Philipp
