From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 23 Oct 2017 17:07:26 +0100
Subject: [PATCH v5] atmel_flexcom: Support backup mode
In-Reply-To: <20171023160600.kcjy4ejdllllu62y@dell>
References: <20171019164443.487-1-romain.izard.pro@gmail.com>
 <20171023160600.kcjy4ejdllllu62y@dell>
Message-ID: <20171023160726.ufs37iyuicirwk4f@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 23 Oct 2017, Lee Jones wrote:
> On Thu, 19 Oct 2017, Romain Izard wrote:
> 
> > The controller used by a flexcom module is configured at boot, and left
> > alone after this. As the configuration will be lost after backup mode,
> > restore the state of the flexcom driver on resume.
> > 
> > Signed-off-by: Romain Izard <romain.izard.pro@gmail.com>
> > Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
> > Tested-by: Nicolas Ferre <nicolas.ferre@microchip.com>
> > ---
> > Changes in v5:
> > * extract from the patch series, and send as a standalone patch
> > 
> >  drivers/mfd/atmel-flexcom.c | 65 ++++++++++++++++++++++++++++++++++-----------
> >  1 file changed, 50 insertions(+), 15 deletions(-)
> > 
> > diff --git a/drivers/mfd/atmel-flexcom.c b/drivers/mfd/atmel-flexcom.c
> > index 064bde9cff5a..ef1235c4a179 100644
> > --- a/drivers/mfd/atmel-flexcom.c
> > +++ b/drivers/mfd/atmel-flexcom.c
> > @@ -39,34 +39,44 @@
> >  #define FLEX_MR_OPMODE(opmode)	(((opmode) << FLEX_MR_OPMODE_OFFSET) &	\
> >  				 FLEX_MR_OPMODE_MASK)
> >  
> > +struct atmel_flexcom {
> > +	void __iomem *base;
> > +	u32 opmode;
> > +	struct clk *clk;
> > +};
> >  
> >  static int atmel_flexcom_probe(struct platform_device *pdev)
> >  {
> >  	struct device_node *np = pdev->dev.of_node;
> > -	struct clk *clk;
> >  	struct resource *res;
> > -	void __iomem *base;
> > -	u32 opmode;
> > +	struct atmel_flexcom *afc;
> 
> Nit: I'd prefer if you call this 'ddata'.
> 
> But the concept and implementation is fine, so if you're going to
> change it please do so and apply my:
> 
> Acked-by: Lee Jones <lee.jones@linaro.org>

Also, 'back-up mode' isn't really a thing is it?

How about "Reinstall state on resume" or similar?

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
