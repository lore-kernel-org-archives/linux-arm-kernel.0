From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Wed, 18 Aug 2010 23:13:15 +0200 (CEST)
Subject: [PATCH v3] ARM: i.MX27 pcm970: Add camera support
In-Reply-To: <20100818203352.GF15536@sirena.org.uk>
References: <Pine.LNX.4.64.1008122224070.17224@axis700.grange>
	<1281863312-16264-1-git-send-email-m.grzeschik@pengutronix.de>
	<Pine.LNX.4.64.1008160018060.27810@axis700.grange>
	<20100818203352.GF15536@sirena.org.uk>
Message-ID: <Pine.LNX.4.64.1008182311530.17895@axis700.grange>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 18 Aug 2010, Mark Brown wrote:

> On Wed, Aug 18, 2010 at 10:05:25PM +0200, Guennadi Liakhovetski wrote:
> 
> > 1. unbalanced regulator enable. IMHO, this is no exception to the general 
> > enable / disable, alloc / free, lock / unlock etc. call balancing rule. If 
> > your regulator has to stay enabled for the whole system run-time, you 
> > don't have to (even try to) enable it multiple times. Please, either make 
> > enabling / disabling symmetric, or leave only one enable in the 
> > initialisation call.
> 
> If the regulator needs to be on all the time on a given board then
> forcing this with always_on in the constraints is much more idiomatic
> and straightforward.
> 
> > > +static int pcm970_camera_power_bus(struct device *dev, int toggle)
> > > +{
> > > +	struct regulator *regulator;
> > > +
> > > +	regulator = regulator_get(NULL, "imx_cam_vcc");
> > > +	if (IS_ERR(regulator)) {
> > > +		pr_err("unable to get regulator: %ld\n", PTR_ERR(regulator));
> > > +		return -ENODEV;
> > > +	} else {
> > > +		if (!regulator_is_enabled(regulator) && toggle)
> > > +			regulator_enable(regulator);
> > > +	}
> > > +	return 0;
> > > +}
> 
> This is all very suspicious - your regulator_get() should be using the
> struct device it was passed to look up the regulator by supply name
> (probably "cam_vcc").  The regulator_is_enabled() call is going to break
> if the supply is shared, too.
> 
> It all looks like something that I'd expect the camera driver to be
> taking care of for itself, there's nothing board specific in here.
> 
> > > +	regulator = regulator_get(NULL, "imx_cam_vcc");
> > > +	if (IS_ERR(regulator)) {
> > > +		pr_err("unable to get regulator: %ld\n", PTR_ERR(regulator));
> > > +		return -ENODEV;
> > > +	} else if (!regulator_is_enabled(regulator)) {
> > > +		regulator_enable(regulator);
> > > +	}
> 
> Again, this looks like you need to add regulator support to the camera
> driver.

No, don't think so. This is a generic camera sensor, that can be attached 
to any video-capable SoC or built into a USB webcam. It knows nothing 
about where it's getting its power from.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
