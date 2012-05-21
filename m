From: marex@denx.de (Marek Vasut)
Date: Mon, 21 May 2012 04:38:20 +0200
Subject: [PATCH 4/4] MXS-MMC: Add wp-inverted property
In-Reply-To: <20120521013915.GN5427@S2101-09.ap.freescale.net>
References: <1337562140-5739-1-git-send-email-marex@denx.de>
 <1337562140-5739-4-git-send-email-marex@denx.de>
 <20120521013915.GN5427@S2101-09.ap.freescale.net>
Message-ID: <201205210438.20794.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Shawn Guo,

> Copy Chris and linux-mmc, as I assume that the patch should go via mmc
> tree after the merge window.
> 
> On Mon, May 21, 2012 at 03:02:20AM +0200, Marek Vasut wrote:
> > The write-protect GPIO is inverted on some boards. Handle such case.
> > 
> > Signed-off-by: Marek Vasut <marex@denx.de>
> > Cc: Shawn Guo <shawn.guo@linaro.org>
> > Cc: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Acked-by: Shawn Guo <shawn.guo@linaro.org>
> 
> A coupe of nits though:
> 
> The subject prefix can better be "mmc: mxs-mmc: ".

Want me to resend it ?

> 
> > ---
> > 
> >  Documentation/devicetree/bindings/mmc/mxs-mmc.txt |    1 +
> >  drivers/mmc/host/mxs-mmc.c                        |   11 ++++++++++-
> >  2 files changed, 11 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/mmc/mxs-mmc.txt
> > b/Documentation/devicetree/bindings/mmc/mxs-mmc.txt index
> > 14d870a..0a7d2cd 100644
> > --- a/Documentation/devicetree/bindings/mmc/mxs-mmc.txt
> > +++ b/Documentation/devicetree/bindings/mmc/mxs-mmc.txt
> > 
> > @@ -13,6 +13,7 @@ Required properties:
> >  Optional properties:
> >  - wp-gpios: Specify GPIOs for write protection
> > 
> > +- wp-inverted: Set if the write protection GPIO is inverted
> > 
> >  Examples:
> > diff --git a/drivers/mmc/host/mxs-mmc.c b/drivers/mmc/host/mxs-mmc.c
> > index 277161d..119beb9 100644
> > --- a/drivers/mmc/host/mxs-mmc.c
> > +++ b/drivers/mmc/host/mxs-mmc.c
> > @@ -164,16 +164,23 @@ struct mxs_mmc_host {
> > 
> >  	spinlock_t			lock;
> >  	int				sdio_irq_en;
> >  	int				wp_gpio;
> > 
> > +	int				wp_inverted:1;
> > 
> >  };
> >  
> >  static int mxs_mmc_get_ro(struct mmc_host *mmc)
> >  {
> >  
> >  	struct mxs_mmc_host *host = mmc_priv(mmc);
> > 
> > +	int ret;
> > 
> >  	if (!gpio_is_valid(host->wp_gpio))
> >  	
> >  		return -EINVAL;
> > 
> > -	return gpio_get_value(host->wp_gpio);
> > +	ret = gpio_get_value(host->wp_gpio);
> > +
> > +	if (host->wp_inverted)
> > +		ret = !ret;
> > +
> > +	return ret;
> 
> The above lines can just be the one below?
> 
> 	return (host->wp_inverted) ? !ret : ret;

I'd prefer to avoid the ternary operator, it's more readable as it is.

> 
> >  }

Best regards,
Marek Vasut
