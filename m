From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 20 Aug 2013 10:35:51 +0800
Subject: [PATCH 2/3] dma: imx-sdma: Add ROM script addresses to driver
In-Reply-To: <20130819173912.GF31036@pengutronix.de>
References: <1376914563-10912-1-git-send-email-s.hauer@pengutronix.de>
 <1376914563-10912-3-git-send-email-s.hauer@pengutronix.de>
 <20130819144136.GC28297@S2101-09.ap.freescale.net>
 <20130819173912.GF31036@pengutronix.de>
Message-ID: <20130820023545.GA29114@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 19, 2013 at 07:39:12PM +0200, Sascha Hauer wrote:
> On Mon, Aug 19, 2013 at 10:41:38PM +0800, Shawn Guo wrote:
> > Copy devicetree mailing list.
> > 
> > > @@ -352,8 +521,15 @@ static struct platform_device_id sdma_devtypes[] = {
> > >  MODULE_DEVICE_TABLE(platform, sdma_devtypes);
> > >  
> > >  static const struct of_device_id sdma_dt_ids[] = {
> > > -	{ .compatible = "fsl,imx31-sdma", .data = &sdma_imx31, },
> > > +	{ .compatible = "fsl,imx6q-sdma", .data = &sdma_imx6q, },
> > > +	{ .compatible = "fsl,imx53-sdma", .data = &sdma_imx53, },
> > > +	{ .compatible = "fsl,imx51-sdma", .data = &sdma_imx51, },
> > > +	{ .compatible = "fsl,imx35-to2-sdma", .data = &sdma_imx35_to2, },
> > > +	{ .compatible = "fsl,imx35-to1-sdma", .data = &sdma_imx35_to1, },
> > >  	{ .compatible = "fsl,imx35-sdma", .data = &sdma_imx35, },

<snip>

> > Also, I do not know how we will play these tapeout specific compatible
> > in device tree.  As you know, we currently do not have tapeout but only
> > chip specific DTS, since we expect kernel will figure out the
> > tapeout/revision and handle the differences accordingly.
> 
> In fact the kernel does figure out the tapeout version, but I don't have
> access to it in the driver.

Yeah.  But since we're using SoC for IP versioning and the version could
vary even for same SoC between different revisions, I think we will see
such need of accessing SoC revision from device driver more and more.
Thus, we will need a generic approach for that sooner or later, I guess.

One approach I can think of is that we define a property "revision"
under node "soc", and ask platform code to fill this property by calling
of_update_property().  Then drivers can simply get it via device tree
/soc/revision.

> 
> Currently we have a problem anyway. We have the firmware names in the
> dts, but the firmware is tapeout specific for i.MX31/35.
> 
> So I think our options are:
> 
> - remove the tapeout specifics from the devicetrees, this would mean to
>   also remove the firmware names.
> - keep the tapeout specifics in the devicetree, then we could even add
>   some more like I did ;)

If I understand this option correctly, we will need something like
imx35-to1.dtsi and imx35-to2.dtsi, and board level dts authors need to
include the correct one per the chip revision on their boards.  What
about some board that solder both revisions, and socket board that can
change chips?  I do not think it's going to work.

> 
> I don't know what's the best way to proceed. For now I could remove the
> tapeout specific bindings, this way we would get the ROM script
> addresses at least for i.MX25/5/6.

Yeah, it's still something nice.

Shawn
