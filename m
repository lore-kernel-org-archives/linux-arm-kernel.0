From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Fri, 8 Mar 2013 19:46:48 +0100
Subject: [PATCH 2/3] can: at91_can: add pinctrl support
In-Reply-To: <513A21E4.6000801@pengutronix.de>
References: <1362763842-14924-1-git-send-email-ludovic.desroches@atmel.com>
 <1362763842-14924-3-git-send-email-ludovic.desroches@atmel.com>
 <513A21E4.6000801@pengutronix.de>
Message-ID: <20130308184648.GE4590@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18:37 Fri 08 Mar     , Marc Kleine-Budde wrote:
> On 03/08/2013 06:30 PM, ludovic.desroches at atmel.com wrote:
> > From: Ludovic Desroches <ludovic.desroches@atmel.com>
> > 
> > Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> > ---
> >  drivers/net/can/at91_can.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> > 
> > diff --git a/drivers/net/can/at91_can.c b/drivers/net/can/at91_can.c
> > index c7f70d4..56fb2aa 100644
> > --- a/drivers/net/can/at91_can.c
> > +++ b/drivers/net/can/at91_can.c
> > @@ -28,6 +28,7 @@
> >  #include <linux/module.h>
> >  #include <linux/netdevice.h>
> >  #include <linux/of.h>
> > +#include <linux/pinctrl/consumer.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/rtnetlink.h>
> >  #include <linux/skbuff.h>
> > @@ -1292,6 +1293,7 @@ static int at91_can_probe(struct platform_device *pdev)
> >  	struct clk *clk;
> >  	void __iomem *addr;
> >  	int err, irq;
> > +	struct pinctrl *pinctrl;
> >  
> >  	devtype_data = at91_can_get_driver_data(pdev);
> >  	if (!devtype_data) {
> > @@ -1314,6 +1316,13 @@ static int at91_can_probe(struct platform_device *pdev)
> >  		goto exit_put;
> >  	}
> >  
> > +	pinctrl = devm_pinctrl_get_select_default(&pdev->dev);
> 
> Is this still needed? I think the pinctrl framework automatically
> enables the default pinctrl for a device if available.
yes this is useless

Best Regards,
J.
> 
> Marc
> 
> > +	if (IS_ERR(pinctrl)) {
> > +		dev_err(&pdev->dev, "Failed to request pinctrl\n");
> > +		err = PTR_ERR(pinctrl);
> > +		goto exit_put;
> > +	}
> > +
> >  	if (!request_mem_region(res->start,
> >  				resource_size(res),
> >  				pdev->name)) {
> > 
> 
> 
> -- 
> Pengutronix e.K.                  | Marc Kleine-Budde           |
> Industrial Linux Solutions        | Phone: +49-231-2826-924     |
> Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
> Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |
> 
