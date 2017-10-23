From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 23 Oct 2017 09:55:06 +0800
Subject: [PATCH] phy: add combo phy driver for HiSilicon STB SoCs
In-Reply-To: <066fef03-7c21-fe7c-218a-fdec446500da@ti.com>
References: <1508042882-20922-1-git-send-email-shawnguo@kernel.org>
 <066fef03-7c21-fe7c-218a-fdec446500da@ti.com>
Message-ID: <20171023015504.GG8700@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kishon,

Thanks for taking time to review the patch.

This combo phy support PCIe and USB3 on HiSilicon STB SoC.  We will
address all your comments and add USB3 support in the new version.

On Wed, Oct 18, 2017 at 06:13:31PM +0530, Kishon Vijay Abraham I wrote:
> > diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile
> > index 3a52dcb09566..11754b293fb4 100644
> > --- a/drivers/phy/Makefile
> > +++ b/drivers/phy/Makefile
> > @@ -6,6 +6,7 @@ obj-$(CONFIG_GENERIC_PHY)		+= phy-core.o
> >  obj-$(CONFIG_PHY_LPC18XX_USB_OTG)	+= phy-lpc18xx-usb-otg.o
> >  obj-$(CONFIG_PHY_XGENE)			+= phy-xgene.o
> >  obj-$(CONFIG_PHY_PISTACHIO_USB)		+= phy-pistachio-usb.o
> > +
> 
> spurious blank space..

Left from rebasing the change to latest kernel.  Fixed.  Thanks.

> >  obj-$(CONFIG_ARCH_SUNXI)		+= allwinner/
> >  obj-$(CONFIG_ARCH_MESON)		+= amlogic/
> >  obj-$(CONFIG_LANTIQ)			+= lantiq/

<snip>

> > +static struct phy *histb_combphy_xlate(struct device *dev,
> > +				       struct of_phandle_args *args)
> > +{
> > +	struct histb_combphy_priv *priv = dev_get_drvdata(dev);
> > +
> > +	if (args->args_count < 1) {
> > +		dev_err(dev, "DT did not pass correct no of args\n");
> > +		return ERR_PTR(-ENODEV);
> > +	}
> > +
> > +	priv->mode = args->args[0];
> > +
> > +	if (priv->mode > COMBPHY_MODE_SATA) {
> 
> this should use generic bindings from include/dt-bindings/phy/phy.h.

Great.  Thanks for the info.  Will use it.

> > +		dev_err(dev, "DT did not pass correct phy mode\n");
> > +		return ERR_PTR(-ENODEV);
> > +	}
> > +
> > +	return priv->phy;
> > +}

<snip>

> > +	phy_provider = devm_of_phy_provider_register(dev, histb_combphy_xlate);
> > +	if (IS_ERR(phy_provider)) {
> > +		dev_err(dev, "failed to register phy provider\n");
> > +		return PTR_ERR(phy_provider);
> > +	}
> > +
> > +	return 0;
> 
> return PTR_ERR_OR_ZERO(phy_provider) instead?

Yes.  Thanks for the suggestion.

Shawn
