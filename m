From: Wenyou.Yang@microchip.com (Wenyou.Yang at microchip.com)
Date: Tue, 25 Oct 2016 00:48:42 +0000
Subject: [PATCH v1] char: hw_random: atmel-rng: disable TRNG during suspend
In-Reply-To: <b0554c1e-e13a-9fe3-ebf4-5d8b0aa16b15@atmel.com>
References: <1477296208-28335-1-git-send-email-wenyou.yang@atmel.com>
 <b0554c1e-e13a-9fe3-ebf4-5d8b0aa16b15@atmel.com>
Message-ID: <F9F4555C4E01D7469D37975B62D0EFBB414538@CHN-SV-EXMX07.mchp-main.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> -----Original Message-----
> From: Nicolas Ferre [mailto:nicolas.ferre at atmel.com]
> Sent: 2016?10?24? 20:07
> To: Wenyou Yang - A41535 <Wenyou.Yang@microchip.com>; Herbert Xu
> <herbert@gondor.apana.org.au>; Matt Mackall <mpm@selenic.com>
> Cc: linux-crypto at vger.kernel.org; Wenyou Yang - A41535
> <Wenyou.Yang@microchip.com>; linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH v1] char: hw_random: atmel-rng: disable TRNG during
> suspend
> 
> Le 24/10/2016 ? 10:03, Wenyou Yang a ?crit :
> > To fix the over consumption on the VDDCore due to the TRNG enabled,
> > disable the TRNG during suspend, not only disable the user interface
> > clock (which is controlled by PMC). Because the user interface clock
> > is independent from any clock that may be used in the entropy source
> > logic circuitry.
> >
> > Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
> > ---
> >
> >  drivers/char/hw_random/atmel-rng.c | 16 ++++++++++++++--
> >  1 file changed, 14 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/char/hw_random/atmel-rng.c
> > b/drivers/char/hw_random/atmel-rng.c
> > index 0fcc9e6..2e2d09a 100644
> > --- a/drivers/char/hw_random/atmel-rng.c
> > +++ b/drivers/char/hw_random/atmel-rng.c
> > @@ -48,6 +48,16 @@ static int atmel_trng_read(struct hwrng *rng, void *buf,
> size_t max,
> >  		return 0;
> >  }
> >
> > +static void atmel_trng_enable(struct atmel_trng *trng) {
> > +	writel(TRNG_KEY | 1, trng->base + TRNG_CR); }
> > +
> > +static void atmel_trng_disable(struct atmel_trng *trng) {
> > +	writel(TRNG_KEY, trng->base + TRNG_CR); }
> > +
> >  static int atmel_trng_probe(struct platform_device *pdev)  {
> >  	struct atmel_trng *trng;
> > @@ -71,7 +81,7 @@ static int atmel_trng_probe(struct platform_device *pdev)
> >  	if (ret)
> >  		return ret;
> >
> > -	writel(TRNG_KEY | 1, trng->base + TRNG_CR);
> > +	atmel_trng_enable(trng);
> >  	trng->rng.name = pdev->name;
> >  	trng->rng.read = atmel_trng_read;
> >
> > @@ -94,7 +104,7 @@ static int atmel_trng_remove(struct platform_device
> > *pdev)
> >
> >  	hwrng_unregister(&trng->rng);
> >
> > -	writel(TRNG_KEY, trng->base + TRNG_CR);
> > +	atmel_trng_disable(trng);
> >  	clk_disable_unprepare(trng->clk);
> >
> >  	return 0;
> > @@ -105,6 +115,7 @@ static int atmel_trng_suspend(struct device *dev)
> > {
> >  	struct atmel_trng *trng = dev_get_drvdata(dev);
> >
> > +	atmel_trng_disable(trng);
> >  	clk_disable_unprepare(trng->clk);
> >
> >  	return 0;
> > @@ -114,6 +125,7 @@ static int atmel_trng_resume(struct device *dev)
> > {
> >  	struct atmel_trng *trng = dev_get_drvdata(dev);
> >
> > +	atmel_trng_enable(trng);
> >  	return clk_prepare_enable(trng->clk);
> 
> Isn't it the other way around:
> enable the user interface first, then enable the internal clock? like:
> 
> clk_prepare_enable(trng->clk);
> atmel_trng_enable(trng);

Yes, I thought so.

But the datasheet said, "The user interface clock is independent from any clock that may be used in the entropy source logic circuitry.
The source of entropy can be enabled before enabling the user interface clock."
It seems the TRNG can be enabled before enabling the peripheral clock.


Best Regards,
Wenyou Yang
