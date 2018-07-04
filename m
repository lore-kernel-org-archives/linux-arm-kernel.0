From: alexandre.belloni@bootlin.com (Alexandre Belloni)
Date: Wed, 4 Jul 2018 10:57:11 +0200
Subject: [PATCH v2] mtd: atmel-quadspi: add suspend/resume hooks
In-Reply-To: <d2264ba9-78db-a3e8-fe4d-5c04f241468c@microchip.com>
References: <1528101993-4772-1-git-send-email-claudiu.beznea@microchip.com>
 <d2264ba9-78db-a3e8-fe4d-5c04f241468c@microchip.com>
Message-ID: <20180704085711.GI14626@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/07/2018 11:42:25+0300, Tudor Ambarus wrote:
> Hi, Claudiu,
> 
> On 06/04/2018 11:46 AM, Claudiu Beznea wrote:
> > Implement suspend/resume hooks.
> > 
> > Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> > ---
> > 
> > Changes in v2:
> > - use __maybe_unused instead of #ifdef CONFIG_PM_SLEEP
> > 
> >  drivers/mtd/spi-nor/atmel-quadspi.c | 21 +++++++++++++++++++++
> >  1 file changed, 21 insertions(+)
> > 
> > diff --git a/drivers/mtd/spi-nor/atmel-quadspi.c b/drivers/mtd/spi-nor/atmel-quadspi.c
> > index 6c5708bacad8..ceaaef47f02e 100644
> > --- a/drivers/mtd/spi-nor/atmel-quadspi.c
> > +++ b/drivers/mtd/spi-nor/atmel-quadspi.c
> > @@ -737,6 +737,26 @@ static int atmel_qspi_remove(struct platform_device *pdev)
> >  	return 0;
> >  }
> >  
> > +static int __maybe_unused atmel_qspi_suspend(struct device *dev)
> > +{
> > +	struct atmel_qspi *aq = dev_get_drvdata(dev);
> > +
> > +	clk_disable_unprepare(aq->clk);
> > +
> > +	return 0;
> > +}
> > +
> > +static int __maybe_unused atmel_qspi_resume(struct device *dev)
> > +{
> > +	struct atmel_qspi *aq = dev_get_drvdata(dev);
> > +
> > +	clk_prepare_enable(aq->clk);
> 
> You missed to verify the return value of clk_prepare_enable. Otherwise looks

Which will never fail, there is no point in checking it.

> good. I've also looked over the test with suspending while copying on a ubifs
> mounted on QSPI NOR, looks good too.
> 
> After checking the return value, please add:
> Reviewed-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> 

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
