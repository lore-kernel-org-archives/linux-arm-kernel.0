From: suzuki.katsuhiro@socionext.com (Katsuhiro Suzuki)
Date: Wed, 21 Feb 2018 22:15:52 +0900
Subject: [PATCH 2/2] ASoC: support ROHM BD28623 codec
In-Reply-To: <20180221122639.GH8334@sirena.org.uk>
References: <20180221043311.25840-1-suzuki.katsuhiro@socionext.com>
 <20180221043311.25840-3-suzuki.katsuhiro@socionext.com>
 <20180221122639.GH8334@sirena.org.uk>
Message-ID: <002601d3ab16$195fdf20$4c1f9d60$@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Mark,

> -----Original Message-----
> From: Mark Brown [mailto:broonie at kernel.org]
> Sent: Wednesday, February 21, 2018 9:27 PM
> To: Suzuki, Katsuhiro <suzuki.katsuhiro@socionext.com>
> Cc: alsa-devel at alsa-project.org; Rob Herring <robh+dt@kernel.org>; devicetree at vger.kernel.org; Masami Hiramatsu
> <masami.hiramatsu@linaro.org>; Jassi Brar <jaswinder.singh@linaro.org>; linux-arm-kernel at lists.infradead.org;
> linux-kernel at vger.kernel.org
> Subject: Re: [PATCH 2/2] ASoC: support ROHM BD28623 codec
> 
> On Wed, Feb 21, 2018 at 01:33:11PM +0900, Katsuhiro Suzuki wrote:
> 
> > +++ b/sound/soc/codecs/bd28623.c
> > @@ -0,0 +1,258 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * ROHM BD28623MUV class D speaker amplifier codec driver.
> > + *
> 
> Please make the entire comment C++ so this looks intentional.
> 
> > +		dev_err(dev, "Failed to enable supplies: %d\n", ret);
> > +		return ret;
> > +	}
> > +
> > +	gpiod_set_value(bd->reset_gpio, 0);
> 
> Since this GPIO is not needed in atomic contexts you should use the
> _cansleep() versions of the GPIO functions - it doesn't cost you
> anything and means that if for some reason someone wired this up to a
> GPIO that can't be used in atomic context the driver will just work.
> 

Thank you, I'll fix it.


> > +	bd->reset_gpio = devm_gpiod_get_optional(dev, "reset",
> > +						 GPIOD_OUT_HIGH);
> 
> > +	bd->mute_gpio = devm_gpiod_get_optional(dev, "mute",
> > +						GPIOD_OUT_HIGH);
> 
> These properties were documented as mandatory in the binding but are
> optional here.  It's fine that they're optional but I'd expect the
> binding to be consistent with this.
> 

These GPIO is optional if board vendor connects directly RSTX and MUTEX pins
to VCC. So I think I should fix DT-bindings document.


> > +static int bd28623_remove(struct platform_device *pdev)
> > +{
> > +	struct bd28623_priv *bd = platform_get_drvdata(pdev);
> > +
> > +	regulator_bulk_disable(ARRAY_SIZE(bd->supplies), bd->supplies);
> > +
> > +	return 0;
> > +}
> 
> We don't enable the supplies explicitly as part of the probe function so
> it feels wrong to disable on remove() - I'm sure it is fine in practice
> as-is but I'd have to think too hard to confirm that.  I'd put this in a
> component level remove function instead so that it's consistent.

Ah, indeed. I will use component driver's remove() function instead of platform.

Thank you for review!


Regards,
--
Katsuhiro Suzuki
