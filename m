From: peter.chen@freescale.com (Peter Chen)
Date: Tue, 5 Nov 2013 10:48:01 +0800
Subject: [PATCH v3 01/11] usb: phy-mxs: Add platform judgement code
In-Reply-To: <20131105022948.GE19770@S2101-09.ap.freescale.net>
References: <1383616183-10511-1-git-send-email-peter.chen@freescale.com>
 <1383616183-10511-2-git-send-email-peter.chen@freescale.com>
 <20131105022948.GE19770@S2101-09.ap.freescale.net>
Message-ID: <20131105024800.GA13472@shlinux1.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 05, 2013 at 10:29:50AM +0800, Shawn Guo wrote:
> On Tue, Nov 05, 2013 at 09:49:33AM +0800, Peter Chen wrote:
> > The mxs-phy has several bugs and features at different
> > versions, the driver code can get it through of_device_id.data.
> > 
> > Signed-off-by: Peter Chen <peter.chen@freescale.com>
> > ---
> >  drivers/usb/phy/phy-mxs-usb.c |   59 ++++++++++++++++++++++++++++++++++------
> >  1 files changed, 50 insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/usb/phy/phy-mxs-usb.c b/drivers/usb/phy/phy-mxs-usb.c
> > index fdd33b4..8b9d80c 100644
> > --- a/drivers/usb/phy/phy-mxs-usb.c
> > +++ b/drivers/usb/phy/phy-mxs-usb.c
> > @@ -1,5 +1,5 @@
> >  /*
> > - * Copyright 2012 Freescale Semiconductor, Inc.
> > + * Copyright 2012-2013 Freescale Semiconductor, Inc.
> >   * Copyright (C) 2012 Marek Vasut <marex@denx.de>
> >   * on behalf of DENX Software Engineering GmbH
> >   *
> > @@ -20,6 +20,7 @@
> >  #include <linux/delay.h>
> >  #include <linux/err.h>
> >  #include <linux/io.h>
> > +#include <linux/of_device.h>
> >  
> >  #define DRIVER_NAME "mxs_phy"
> >  
> > @@ -34,13 +35,55 @@
> >  #define BM_USBPHY_CTRL_ENUTMILEVEL2		BIT(14)
> >  #define BM_USBPHY_CTRL_ENHOSTDISCONDETECT	BIT(1)
> >  
> > +#define to_mxs_phy(p) container_of((p), struct mxs_phy, phy)
> > +
> > +/* Do disconnection between PHY and controller without vbus */
> > +#define MXS_PHY_DISCONNECT_LINE_WITHOUT_VBUS	BIT(0)
> > +
> > +/*
> > + * The PHY will be in messy if there is an wakeup after putting
> > + * bus to suspend (set portsc.suspendM) but before setting PHY to low
> > + * power mode (set portsc.phcd).
> > + */
> > +#define MXS_PHY_ABNORAML_IN_SUSPEND		BIT(1)
> > +
> > +/*
> > + * The SOF sends too fast after resuming, it will cause disconnection
> > + * between host and high speed device.
> > + */
> > +#define MXS_PHY_SENDING_SOF_TOO_FAST		BIT(2)
> > +
> > +struct mxs_phy_platform_flag {
> > +	unsigned int flags;
> > +};
> 
> We should design it as a structure not only for flags but any data that
> we may need to define.  That said, mxs_phy_platform_flag is not a good
> name to me.  I think mxs_phy_data should be more scalable and future
> proof, considering one day we may have more to add into the structure.
> 
> > +
> > +static const struct mxs_phy_platform_flag imx23_phy_data = {
> > +	.flags = MXS_PHY_ABNORAML_IN_SUSPEND | MXS_PHY_SENDING_SOF_TOO_FAST,
> > +};
> > +
> > +static const struct mxs_phy_platform_flag imx6q_phy_data = {
> > +	.flags = MXS_PHY_SENDING_SOF_TOO_FAST |
> > +		MXS_PHY_DISCONNECT_LINE_WITHOUT_VBUS,
> > +};
> > +
> > +static const struct mxs_phy_platform_flag imx6sl_phy_data = {
> > +	.flags = MXS_PHY_DISCONNECT_LINE_WITHOUT_VBUS,
> > +};
> > +
> > +static const struct of_device_id mxs_phy_dt_ids[] = {
> > +	{ .compatible = "fsl,imx6sl-usbphy", .data = &imx6sl_phy_data, },
> > +	{ .compatible = "fsl,imx6q-usbphy", .data = &imx6q_phy_data, },
> > +	{ .compatible = "fsl,imx23-usbphy", .data = &imx23_phy_data, },
> > +	{ /* sentinel */ }
> > +};
> > +MODULE_DEVICE_TABLE(of, mxs_phy_dt_ids);
> > +
> >  struct mxs_phy {
> >  	struct usb_phy phy;
> >  	struct clk *clk;
> > +	unsigned int flags;
> 
> Here, we should have a pointer to struct mxs_phy_data.
> 

Will change both of two names.

Peter

> >  
> > -#define to_mxs_phy(p) container_of((p), struct mxs_phy, phy)
> > -
> >  static int mxs_phy_hw_init(struct mxs_phy *mxs_phy)
> >  {
> >  	int ret;
> > @@ -131,6 +174,9 @@ static int mxs_phy_probe(struct platform_device *pdev)
> >  	struct clk *clk;
> >  	struct mxs_phy *mxs_phy;
> >  	int ret;
> > +	const struct of_device_id *of_id =
> > +			of_match_device(mxs_phy_dt_ids, &pdev->dev);
> > +	const struct mxs_phy_platform_flag *platform_flag = of_id->data;
> >  
> >  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> >  	base = devm_ioremap_resource(&pdev->dev, res);
> > @@ -163,6 +209,7 @@ static int mxs_phy_probe(struct platform_device *pdev)
> >  	ATOMIC_INIT_NOTIFIER_HEAD(&mxs_phy->phy.notifier);
> >  
> >  	mxs_phy->clk = clk;
> > +	mxs_phy->flags = platform_flag->flags;
> >  
> >  	platform_set_drvdata(pdev, &mxs_phy->phy);
> >  
> > @@ -182,12 +229,6 @@ static int mxs_phy_remove(struct platform_device *pdev)
> >  	return 0;
> >  }
> >  
> > -static const struct of_device_id mxs_phy_dt_ids[] = {
> > -	{ .compatible = "fsl,imx23-usbphy", },
> > -	{ /* sentinel */ }
> > -};
> > -MODULE_DEVICE_TABLE(of, mxs_phy_dt_ids);
> > -
> >  static struct platform_driver mxs_phy_driver = {
> >  	.probe = mxs_phy_probe,
> >  	.remove = mxs_phy_remove,
> > -- 
> > 1.7.1
> > 
> > 

-- 

Best Regards,
Peter Chen
