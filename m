From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 19 Aug 2013 19:39:12 +0200
Subject: [PATCH 2/3] dma: imx-sdma: Add ROM script addresses to driver
In-Reply-To: <20130819144136.GC28297@S2101-09.ap.freescale.net>
References: <1376914563-10912-1-git-send-email-s.hauer@pengutronix.de>
 <1376914563-10912-3-git-send-email-s.hauer@pengutronix.de>
 <20130819144136.GC28297@S2101-09.ap.freescale.net>
Message-ID: <20130819173912.GF31036@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 19, 2013 at 10:41:38PM +0800, Shawn Guo wrote:
> Copy devicetree mailing list.
> 
> > @@ -352,8 +521,15 @@ static struct platform_device_id sdma_devtypes[] = {
> >  MODULE_DEVICE_TABLE(platform, sdma_devtypes);
> >  
> >  static const struct of_device_id sdma_dt_ids[] = {
> > -	{ .compatible = "fsl,imx31-sdma", .data = &sdma_imx31, },
> > +	{ .compatible = "fsl,imx6q-sdma", .data = &sdma_imx6q, },
> > +	{ .compatible = "fsl,imx53-sdma", .data = &sdma_imx53, },
> > +	{ .compatible = "fsl,imx51-sdma", .data = &sdma_imx51, },
> > +	{ .compatible = "fsl,imx35-to2-sdma", .data = &sdma_imx35_to2, },
> > +	{ .compatible = "fsl,imx35-to1-sdma", .data = &sdma_imx35_to1, },
> >  	{ .compatible = "fsl,imx35-sdma", .data = &sdma_imx35, },
> 
> Do we need to bind the compatible with sdma_imx35_to2 like below?
> 
>   	{ .compatible = "fsl,imx35-sdma", .data = &sdma_imx35_to2, },

If we do this we assume that every i.MX35 is TO2. TO1 revisions will
misbehave then. I intentionally didn't do this so that the current
binding continues to work as before without script addresses.

> 
> Otherwise, we will need to patch sdma_imx35 with proper .script_addrs
> assignment?
> 
> Also, I do not know how we will play these tapeout specific compatible
> in device tree.  As you know, we currently do not have tapeout but only
> chip specific DTS, since we expect kernel will figure out the
> tapeout/revision and handle the differences accordingly.

In fact the kernel does figure out the tapeout version, but I don't have
access to it in the driver.

Currently we have a problem anyway. We have the firmware names in the
dts, but the firmware is tapeout specific for i.MX31/35.

So I think our options are:

- remove the tapeout specifics from the devicetrees, this would mean to
  also remove the firmware names.
- keep the tapeout specifics in the devicetree, then we could even add
  some more like I did ;)

I don't know what's the best way to proceed. For now I could remove the
tapeout specific bindings, this way we would get the ROM script
addresses at least for i.MX25/5/6.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
