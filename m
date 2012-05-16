From: richard.zhao@freescale.com (Richard Zhao)
Date: Wed, 16 May 2012 21:08:24 +0800
Subject: [PATCH v1 4/7] usb: chipidea: add imx driver binding
In-Reply-To: <878vgscq4b.fsf@ashishki-desk.ger.corp.intel.com>
References: <1337090303-16046-1-git-send-email-richard.zhao@freescale.com>
 <1337090303-16046-5-git-send-email-richard.zhao@freescale.com>
 <878vgscq4b.fsf@ashishki-desk.ger.corp.intel.com>
Message-ID: <20120516130823.GA30755@b20223-02.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 16, 2012 at 02:38:44PM +0300, Alexander Shishkin wrote:
> Richard Zhao <richard.zhao@freescale.com> writes:
> 
> > Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
> 
> Besides things that were already pointed out, some minor comments below:
Thanks for your review.

> 
> > ---
> >  drivers/usb/chipidea/Makefile      |    2 +-
> >  drivers/usb/chipidea/ci13xxx_imx.c |  177 ++++++++++++++++++++++++++++++++++++
> >  2 files changed, 178 insertions(+), 1 deletions(-)
> >  create mode 100644 drivers/usb/chipidea/ci13xxx_imx.c
> >
> > diff --git a/drivers/usb/chipidea/Makefile b/drivers/usb/chipidea/Makefile
> > index 0f34c0c..6821385 100644
> > --- a/drivers/usb/chipidea/Makefile
> > +++ b/drivers/usb/chipidea/Makefile
> > @@ -14,5 +14,5 @@ ifneq ($(CONFIG_ARCH_MSM),)
> >  endif
> >  
> >  ifneq ($(CONFIG_ARCH_MXC),)
> > -	obj-$(CONFIG_USB_CHIPIDEA)	+= phy-imx-utmi.o
> > +	obj-$(CONFIG_USB_CHIPIDEA)	+= phy-imx-utmi.o ci13xxx_imx.o
> >  endif
> > diff --git a/drivers/usb/chipidea/ci13xxx_imx.c b/drivers/usb/chipidea/ci13xxx_imx.c
> > new file mode 100644
> > index 0000000..5f36f07
> > --- /dev/null
> > +++ b/drivers/usb/chipidea/ci13xxx_imx.c
> > @@ -0,0 +1,177 @@
> > +/*
> > + * Copyright 2012 Freescale Semiconductor, Inc.
> > + *
> > + * The code contained herein is licensed under the GNU General Public
> > + * License. You may obtain a copy of the GNU General Public License
> > + * Version 2 or later at the following locations:
> > + *
> > + * http://www.opensource.org/licenses/gpl-license.html
> > + * http://www.gnu.org/copyleft/gpl.html
> > + */
> > +
> > +#include <linux/module.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/of_platform.h>
> > +#include <linux/of_gpio.h>
> > +#include <linux/pm_runtime.h>
> > +#include <linux/usb/ulpi.h>
> > +#include <linux/usb/gadget.h>
> > +#include <linux/usb/chipidea.h>
> > +#include <linux/usb/otg.h>
> > +#include <linux/dma-mapping.h>
> > +
> > +#include "ci.h"
> > +
> > +#define pdev_to_phy(pdev) \
> > +	((struct usb_phy *)platform_get_drvdata(pdev))
> > +
> > +static void ci13xxx_imx_notify_event(struct ci13xxx *udc, unsigned event)
> > +{
> > +#if 0
> > +	struct device *dev = udc->gadget.dev.parent;
> > +	int val;
> > +
> > +	switch (event) {
> > +	case CI13XXX_CONTROLLER_RESET_EVENT:
> > +		dev_dbg(dev, "CI13XXX_CONTROLLER_RESET_EVENT received\n");
> > +		writel(0, USB_AHBBURST);
> > +		writel(0, USB_AHBMODE);
> > +		break;
> > +	case CI13XXX_CONTROLLER_STOPPED_EVENT:
> > +		dev_dbg(dev, "CI13XXX_CONTROLLER_STOPPED_EVENT received\n");
> > +		/*
> > +		 * Put the transceiver in non-driving mode. Otherwise host
> > +		 * may not detect soft-disconnection.
> > +		 */
> > +		val = usb_phy_io_read(udc->transceiver, ULPI_FUNC_CTRL);
> > +		val &= ~ULPI_FUNC_CTRL_OPMODE_MASK;
> > +		val |= ULPI_FUNC_CTRL_OPMODE_NONDRIVING;
> > +		usb_phy_io_write(udc->transceiver, val, ULPI_FUNC_CTRL);
> > +		break;
> > +	default:
> > +		dev_dbg(dev, "unknown ci13xxx_udc event\n");
> > +		break;
> > +	}
> > +#endif
> > +}
> > +
> > +static struct ci13xxx_udc_driver ci13xxx_imx_udc_driver = {
> > +	.name			= "ci13xxx_imx",
> > +	.flags			= CI13XXX_REGS_SHARED |
> > +				  CI13XXX_PULLUP_ON_VBUS |
> > +				  CI13XXX_DISABLE_STREAMING,
> > +	.capoffset		= 0x100,
> 
> There's a DEF_CAPOFFSET for this in <linux/usb/chipidea.h>, because this
> is really a single most popular offset of the capability registers in
> chipidea controllers.
Thanks.
> 
> > +
> > +	.notify_event		= ci13xxx_imx_notify_event,
> > +};
> > +
> > +static int ci13xxx_imx_probe(struct platform_device *pdev)
> > +{
> > +	struct platform_device *plat_ci, *phy_pdev;
> > +	struct device_node *phy_np;
> > +	struct resource *res;
> > +	int hub_reset, vbus_pwr;
> > +	int ret;
> > +
> > +	dev_dbg(&pdev->dev, "ci13xxx_imx_probe\n");
> 
> Certain people don't take kindly to adding debug prints like this one. :)
Removed. Thanks.
> 
> > +
> > +	phy_np = of_parse_phandle(pdev->dev.of_node, "fsl,usbphy", 0);
> > +	if (phy_np) {
> > +		phy_pdev = of_find_device_by_node(phy_np);
> > +		if (phy_pdev) {
> > +			struct usb_phy *phy;
> > +			phy = pdev_to_phy(phy_pdev);
> > +			if (phy)
> > +				usb_phy_init(phy);
> > +		}
> > +		of_node_put(phy_np);
> > +	}
> > +
> > +	hub_reset = of_get_named_gpio(pdev->dev.of_node, "fsl,hub-reset", 0);
> > +	if (hub_reset > 0 &&
> > +	    devm_gpio_request(&pdev->dev, hub_reset, "hub-reset")) {
> > +		gpio_direction_output(hub_reset, 0);
> > +		udelay(10);
> > +		gpio_direction_output(hub_reset, 1);
> > +	}
> > +
> > +	/* we only support host now, so enable vbus here */
> > +	vbus_pwr = of_get_named_gpio(pdev->dev.of_node, "fsl,vbus-power", 0);
> > +	if (vbus_pwr > 0 &&
> > +	    devm_gpio_request(&pdev->dev, vbus_pwr, "vbus-pwr")) {
> > +		gpio_direction_output(vbus_pwr, 1);
> > +	}
> > +
> > +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +	if (!res) {
> > +		dev_err(&pdev->dev, "can't get device resources\n");
> > +		return -ENOENT;
> > +	}
> > +
> > +	plat_ci = platform_device_alloc("ci_hdrc", (int)res->start);
> 
> Regarding the instance id here: you probably want to use something more
> meaningful than the starting address. I was thinking about stealing id
> allocator from Felipe's dwc3 (dwc3_get_device_id()), but decided to
> first deal with more important things.
hmm... Is dwc3_get_device_id() really meaningful than base address?
It just record the sequence number.

Thanks
Richard
> 
> I was considering using idr for this, but it kind of feels like an
> overkill for this purpose. So I'm wondering if it makes sense to
> generalize dwc3_get_device_id() so that other drivers can make use of
> it?
> 
 
