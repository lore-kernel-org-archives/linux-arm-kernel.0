From: mporter@ti.com (Matt Porter)
Date: Tue, 11 Sep 2012 14:06:32 -0400
Subject: [PATCH 1/2] spi: omap2-mcspi: add pinctrl support
In-Reply-To: <20120911180041.GH23092@atomide.com>
References: <1347385599-27558-1-git-send-email-mporter@ti.com>
 <1347385599-27558-2-git-send-email-mporter@ti.com>
 <20120911180041.GH23092@atomide.com>
Message-ID: <20120911180632.GN27758@beef>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 11, 2012 at 11:00:41AM -0700, Tony Lindgren wrote:
> * Matt Porter <mporter@ti.com> [120911 10:46]:
> > Adds pinctrl support to support OMAP platforms that boot from DT
> > and rely on pinctrl support to set pinmuxes.
> > 
> > Signed-off-by: Matt Porter <mporter@ti.com>
> > ---
> >  drivers/spi/spi-omap2-mcspi.c |    9 +++++++++
> >  1 file changed, 9 insertions(+)
> > 
> > diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
> > index b2fb141..6c67cdb 100644
> > --- a/drivers/spi/spi-omap2-mcspi.c
> > +++ b/drivers/spi/spi-omap2-mcspi.c
> > @@ -38,6 +38,8 @@
> >  #include <linux/pm_runtime.h>
> >  #include <linux/of.h>
> >  #include <linux/of_device.h>
> > +#include <linux/pinctrl/consumer.h>
> > +#include <linux/err.h>
> >  
> >  #include <linux/spi/spi.h>
> >  
> > @@ -1124,6 +1126,7 @@ static int __devinit omap2_mcspi_probe(struct platform_device *pdev)
> >  	static int		bus_num = 1;
> >  	struct device_node	*node = pdev->dev.of_node;
> >  	const struct of_device_id *match;
> > +	struct pinctrl *pinctrl;
> >  
> >  	master = spi_alloc_master(&pdev->dev, sizeof *mcspi);
> >  	if (master == NULL) {
> > @@ -1219,6 +1222,12 @@ static int __devinit omap2_mcspi_probe(struct platform_device *pdev)
> >  	if (status < 0)
> >  		goto dma_chnl_free;
> >  
> > +	pinctrl = devm_pinctrl_get_select_default(&pdev->dev);
> > +	if (IS_ERR(pinctrl)) {
> > +		status = PTR_ERR(pinctrl);
> > +		goto dma_chnl_free;
> > +	}
> > +
> >  	pm_runtime_use_autosuspend(&pdev->dev);
> >  	pm_runtime_set_autosuspend_delay(&pdev->dev, SPI_AUTOSUSPEND_TIMEOUT);
> >  	pm_runtime_enable(&pdev->dev);
> 
> You should just print out a warning here as most boards don't
> have pinctrl implemented at this point, or may never have.

It will not hit this error path on the boards without pinctrl due
to the second part of the series. The error check is for some really
unexpected failure in the pinctrl core and parsing functionality where
we want it to bail out.

-Matt
