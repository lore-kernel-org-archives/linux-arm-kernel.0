From: linux@roeck-us.net (Guenter Roeck)
Date: Thu, 23 Aug 2012 06:39:31 -0700
Subject: [PATCH] spi/s3c64xx: Drop extra calls to spi_master_get in
 suspend/remove functions
In-Reply-To: <1d0b01cd80f1$d77eaf90$867c0eb0$%kim@samsung.com>
References: <1345173265-1721-1-git-send-email-linux@roeck-us.net>
 <1d0b01cd80f1$d77eaf90$867c0eb0$%kim@samsung.com>
Message-ID: <20120823133931.GB24319@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 23, 2012 at 02:40:45PM +0900, Kukjin Kim wrote:
> Guenter Roeck wrote:
> > 
> > Suspend and resume functions call spi_master_get() without matching
> > spi_master_put(). The extra references are unnecessary and cause
> > subsequent
> > module unload attempts to fail. Drop the calls.
> > 
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> 
> Acked-by: Kukjin Kim <kgene.kim@samsung.com>
> 
> (Cc'ed Mark Brown who is handling spi now)
> 
> Guenter, maybe you need to re-send this patch to Mark so that he can apply
> ;-)
> 
Guess you are right - and I did copy Mark on my later patches. Mark, I just
bounced the patch to you, so you should have it now.

Thanks,
Guenter

> Thanks.
> 
> Best regards,
> Kgene.
> --
> Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
> SW Solution Development Team, Samsung Electronics Co., Ltd.
> 
> > ---
> >  drivers/spi/spi-s3c64xx.c |    8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
> > index 646a765..d7a87df 100644
> > --- a/drivers/spi/spi-s3c64xx.c
> > +++ b/drivers/spi/spi-s3c64xx.c
> > @@ -1409,7 +1409,7 @@ static int s3c64xx_spi_remove(struct platform_device
> > *pdev)
> >  #ifdef CONFIG_PM
> >  static int s3c64xx_spi_suspend(struct device *dev)
> >  {
> > -	struct spi_master *master = spi_master_get(dev_get_drvdata(dev));
> > +	struct spi_master *master = dev_get_drvdata(dev);
> >  	struct s3c64xx_spi_driver_data *sdd =
> > spi_master_get_devdata(master);
> > 
> >  	spi_master_suspend(master);
> > @@ -1428,7 +1428,7 @@ static int s3c64xx_spi_suspend(struct device *dev)
> > 
> >  static int s3c64xx_spi_resume(struct device *dev)
> >  {
> > -	struct spi_master *master = spi_master_get(dev_get_drvdata(dev));
> > +	struct spi_master *master = dev_get_drvdata(dev);
> >  	struct s3c64xx_spi_driver_data *sdd =
> > spi_master_get_devdata(master);
> >  	struct s3c64xx_spi_info *sci = sdd->cntrlr_info;
> > 
> > @@ -1452,7 +1452,7 @@ static int s3c64xx_spi_resume(struct device *dev)
> >  #ifdef CONFIG_PM_RUNTIME
> >  static int s3c64xx_spi_runtime_suspend(struct device *dev)
> >  {
> > -	struct spi_master *master = spi_master_get(dev_get_drvdata(dev));
> > +	struct spi_master *master = dev_get_drvdata(dev);
> >  	struct s3c64xx_spi_driver_data *sdd =
> > spi_master_get_devdata(master);
> > 
> >  	clk_disable(sdd->clk);
> > @@ -1463,7 +1463,7 @@ static int s3c64xx_spi_runtime_suspend(struct device
> > *dev)
> > 
> >  static int s3c64xx_spi_runtime_resume(struct device *dev)
> >  {
> > -	struct spi_master *master = spi_master_get(dev_get_drvdata(dev));
> > +	struct spi_master *master = dev_get_drvdata(dev);
> >  	struct s3c64xx_spi_driver_data *sdd =
> > spi_master_get_devdata(master);
> > 
> >  	clk_enable(sdd->src_clk);
> > --
> > 1.7.9.7
> 
> 
