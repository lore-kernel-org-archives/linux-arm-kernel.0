From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 31 Jan 2013 09:05:11 +0100
Subject: [PATCH 2/6] usb: add devicetree helpers for determining dr_mode
 and phy_type
In-Reply-To: <20130131023034.GF9777@nchen-desktop>
References: <1359559782-14552-1-git-send-email-s.hauer@pengutronix.de>
 <1359559782-14552-3-git-send-email-s.hauer@pengutronix.de>
 <20130131023034.GF9777@nchen-desktop>
Message-ID: <20130131080511.GK1906@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 31, 2013 at 10:30:36AM +0800, Peter Chen wrote:
> On Wed, Jan 30, 2013 at 04:29:38PM +0100, Sascha Hauer wrote:
> > From: Michael Grzeschik <m.grzeschik@pengutronix.de>
> > 
> > This adds two little devicetree helper functions for determining the
> > dr_mode (host, peripheral, otg) and phy_type (utmi, ulpi,...) from
> > the devicetree.
> > 
> > Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
> > Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > ---
> >  drivers/usb/usb-common.c |   69 ++++++++++++++++++++++++++++++++++++++++++++++
> >  include/linux/usb/of.h   |   27 ++++++++++++++++++
> >  include/linux/usb/otg.h  |    7 +++++
> >  include/linux/usb/phy.h  |    9 ++++++
> >  4 files changed, 112 insertions(+)
> >  create mode 100644 include/linux/usb/of.h
> > 
> > diff --git a/drivers/usb/usb-common.c b/drivers/usb/usb-common.c
> > index d29503e..1c0292c 100644
> > --- a/drivers/usb/usb-common.c
> > +++ b/drivers/usb/usb-common.c
> > @@ -14,6 +14,9 @@
> >  #include <linux/kernel.h>
> >  #include <linux/module.h>
> >  #include <linux/usb/ch9.h>
> > +#include <linux/of.h>
> > +#include <linux/usb/of.h>
> > +#include <linux/usb/otg.h>
> >  
> >  const char *usb_speed_string(enum usb_device_speed speed)
> >  {
> > @@ -32,4 +35,70 @@ const char *usb_speed_string(enum usb_device_speed speed)
> >  }
> >  EXPORT_SYMBOL_GPL(usb_speed_string);
> >  
> > +#ifdef CONFIG_OF
> > +static const char *usb_dr_modes[] = {
> > +	[USB_DR_MODE_UNKNOWN]		= "",
> > +	[USB_DR_MODE_HOST]		= "host",
> > +	[USB_DR_MODE_PERIPHERAL]	= "peripheral",
> > +	[USB_DR_MODE_OTG]		= "otg",
> > +};
> > +
> > +/**
> > + * of_usb_get_dr_mode - Get dual role mode for given device_node
> > + * @np:	Pointer to the given device_node
> > + *
> > + * The function gets phy interface string from property 'dr_mode',
> > + * and returns the correspondig enum usb_phy_dr_mode
> > + */
> > +enum usb_phy_dr_mode of_usb_get_dr_mode(struct device_node *np)
> The word "phy" at usb_phy_dr_mode may cause misunderstand, just usb_dr_mode
> is ok

ok, changed.

> > +{
> > +	const char *dr_mode;
> > +	int err, i;
> > +
> > +	err = of_property_read_string(np, "dr_mode", &dr_mode);
> > +	if (err < 0)
> > +		return USB_DR_MODE_UNKNOWN;
> > +
> > +	for (i = 0; i < ARRAY_SIZE(usb_dr_modes); i++)
> > +		if (!strcasecmp(dr_mode, usb_dr_modes[i]))
> > +			return i;
> Just curious, why not using strcmp?

Probably because this is based on drivers/of/of_net.c which uses
strcasecmp. I never heard that devicetrees are case insensitive, so
I'll change this to strcmp.

> > +
> > +	return USB_DR_MODE_UNKNOWN;
> > +}
> > +
> > +#ifdef CONFIG_OF
> > +enum usb_phy_interface of_usb_get_phy_mode(struct device_node *np);
> > +enum usb_phy_dr_mode of_usb_get_dr_mode(struct device_node *np);
> > +#else
> > +static inline enum usb_phy_interface of_usb_get_phy_mode(struct device_node *np)
> > +{
> > +	return USBPHY_INTERFACE_MODE_NA;
> > +}
> > +
> > +static inline enum usb_phy_dr_mode of_usb_get_dr_mode(struct device_node *np)
> > +{
> > +	return USB_DR_MODE_UNKNOWN;
> > +}
> For, dr_mode, if value has not existed, you use *_UNKNOWN, why
> for usbphy,  you use *_NA. It is better uniform.

yup, fixed.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
