From: mgr@pengutronix.de (Michael Grzeschik)
Date: Sun, 15 Aug 2010 10:55:32 +0200
Subject: [PATCH v2] ARM: i.MX27 pcm970: Add camera support
In-Reply-To: <Pine.LNX.4.64.1008122224070.17224@axis700.grange>
References: <1280827245-5762-2-git-send-email-m.grzeschik@pengutronix.de>
	<1281512303-14303-1-git-send-email-m.grzeschik@pengutronix.de>
	<Pine.LNX.4.64.1008112201510.32197@axis700.grange>
	<20100811210703.GH13418@pengutronix.de>
	<Pine.LNX.4.64.1008122224070.17224@axis700.grange>
Message-ID: <20100815085532.GA6818@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 12, 2010 at 10:27:57PM +0200, Guennadi Liakhovetski wrote:
> On Wed, 11 Aug 2010, Michael Grzeschik wrote:
> 
> > On Wed, Aug 11, 2010 at 10:10:38PM +0200, Guennadi Liakhovetski wrote:
> > > On Wed, 11 Aug 2010, Michael Grzeschik wrote:
> > > 
> > > > Adds the glue code for the pcm970 baseboard. It has a power regulator
> > > > which is registered first and instrumented in the power hook of
> > > > soc_camera_link to turn on the power for the camera device.
> > > 
> > > Ok, this looks better now, with this you don't have to patch the driver 
> > > any more. But - are you sure you really need both - the power callback and 
> > > the lateinitcall doing the same - requesting the regulator and enabling 
> > > it. I think, just the power callback should suffice.
> > 
> > Yes, i left it this way because we just need to look for the gpio
> > expander only once. Since the power callback will be called everytime we
> > try to handle a camera, this part of code don't has to be there. With
> > the late_initcall we can leave the power-on-off behaviour of the
> > callback functions simple and as intended. After we initialized all the
> > i2c cameras, we do the final check for the gpio in the late_initcall.
> > For this we again, have to switch power on, look for the expander and
> > power off again, independent of which cameras has been found.
> 
> Do you mean, that your GPIO expander is also powered from the same 
> regulator, as the camera sensor? But you request and enable the regulator 
> in pcm970_baseboard_init_late() and do not disable it there again. Is this 
> required for your expander to preserve the state? I am not familiar with 
> the regulator API - does it count enables and disables? In which case, 
> with the below patch it would stay on permanently?

There is no case for this version of patch in which the power regulator
will stay turned on. Since we trigger the gpio on the expander,
the camera module with the expander on board has to stay turned on.
Otherwise our gpio setting will be lost. I send v3 now. In this version
the regulator will not be turned off again.

Thanks for helping on this,
Michael

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
