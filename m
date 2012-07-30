From: richard.zhao@freescale.com (Richard Zhao)
Date: Mon, 30 Jul 2012 17:39:56 +0800
Subject: [PATCH v3 1/3] USB: chipidea: add imx usbmisc support
In-Reply-To: <20120730093244.GQ30009@pengutronix.de>
References: <1343298916-11101-1-git-send-email-richard.zhao@freescale.com>
 <1343298916-11101-2-git-send-email-richard.zhao@freescale.com>
 <20120730093244.GQ30009@pengutronix.de>
Message-ID: <20120730093956.GI3347@b20223-02.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 30, 2012 at 11:32:44AM +0200, Sascha Hauer wrote:
> On Thu, Jul 26, 2012 at 06:35:14PM +0800, Richard Zhao wrote:
> > i.MX usb controllers shares non-core registers, which may include
> > SoC specific controls. We take it as a usbmisc device and usbmisc
> > driver set operations needed by ci13xxx_imx driver.
> > 
> > For example, Sabrelite board has bad over-current design, we can
> > usbmisc to disable over-current detect.
> > 
> > Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
> > ---
> >  .../devicetree/bindings/usb/ci13xxx-imx.txt        |    2 +
> >  .../devicetree/bindings/usb/usbmisc-imx.txt        |   12 ++
> >  drivers/usb/chipidea/Makefile                      |    3 +-
> >  drivers/usb/chipidea/ci13xxx_imx.c                 |   72 ++++++++-
> >  drivers/usb/chipidea/usbmisc_imx6q.c               |  155 ++++++++++++++++++++
> >  5 files changed, 242 insertions(+), 2 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/usb/usbmisc-imx.txt
> >  create mode 100644 drivers/usb/chipidea/usbmisc_imx6q.c
> > 
> > diff --git a/Documentation/devicetree/bindings/usb/ci13xxx-imx.txt b/Documentation/devicetree/bindings/usb/ci13xxx-imx.txt
> > index 2c29041..06105ce 100644
> > --- a/Documentation/devicetree/bindings/usb/ci13xxx-imx.txt
> > +++ b/Documentation/devicetree/bindings/usb/ci13xxx-imx.txt
> > @@ -8,6 +8,7 @@ Required properties:
> >  Optional properties:
> >  - fsl,usbphy: phandler of usb phy that connects to the only one port
> >  - vbus-supply: regulator for vbus
> > +- disable-over-current: disable over current detect
> >  
> >  Examples:
> >  usb at 02184000 { /* USB OTG */
> > @@ -15,4 +16,5 @@ usb at 02184000 { /* USB OTG */
> >  	reg = <0x02184000 0x200>;
> >  	interrupts = <0 43 0x04>;
> >  	fsl,usbphy = <&usbphy1>;
> > +	disable-over-current;
> >  };
> > diff --git a/Documentation/devicetree/bindings/usb/usbmisc-imx.txt b/Documentation/devicetree/bindings/usb/usbmisc-imx.txt
> > new file mode 100644
> > index 0000000..4fa500d
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/usb/usbmisc-imx.txt
> > @@ -0,0 +1,12 @@
> > +* Freescale i.MX non-core registers
> > +
> > +Required properties:
> > +- compatible: Should be one of below:
> > +	"fsl,imx6q-usbmisc" for imx6q
> > +- reg: Should contain registers location and length
> > +
> > +Examples:
> > +usbmisc at 02184800 {
> > +	compatible = "fsl,imx6q-usbmisc";
> > +	reg = <0x02184800 0x200>;
> > +};
> > diff --git a/drivers/usb/chipidea/Makefile b/drivers/usb/chipidea/Makefile
> > index 5c66d9c..36f94c9d 100644
> > --- a/drivers/usb/chipidea/Makefile
> > +++ b/drivers/usb/chipidea/Makefile
> > @@ -15,5 +15,6 @@ ifneq ($(CONFIG_PCI),)
> >  endif
> >  
> >  ifneq ($(CONFIG_OF_DEVICE),)
> > -	obj-$(CONFIG_USB_CHIPIDEA)	+= ci13xxx_imx.o
> > +	obj-$(CONFIG_USB_CHIPIDEA)	+= ci13xxx-imx.o
> > +	ci13xxx-imx-y			:= ci13xxx_imx.o usbmisc_imx6q.o
> >  endif
> > diff --git a/drivers/usb/chipidea/ci13xxx_imx.c b/drivers/usb/chipidea/ci13xxx_imx.c
> > index ef60d06..d178889 100644
> > --- a/drivers/usb/chipidea/ci13xxx_imx.c
> > +++ b/drivers/usb/chipidea/ci13xxx_imx.c
> > @@ -22,6 +22,7 @@
> >  #include <linux/regulator/consumer.h>
> >  
> >  #include "ci.h"
> > +#include "ci13xxx_imx.h"
> >  
> >  #define pdev_to_phy(pdev) \
> >  	((struct usb_phy *)platform_get_drvdata(pdev))
> > @@ -34,6 +35,48 @@ struct ci13xxx_imx_data {
> >  	struct regulator *reg_vbus;
> >  };
> >  
> > +static const struct usbmisc_ops *usbmisc_ops;
> > +
> > +/* Common functions shared by usbmisc drivers */
> > +
> > +int usbmisc_set_ops(const struct usbmisc_ops *ops)
> > +{
> > +	if (usbmisc_ops)
> > +		return -EBUSY;
> > +
> > +	usbmisc_ops = ops;
> > +
> > +	return 0;
> > +}
> > +
> > +void usbmisc_unset_ops(const struct usbmisc_ops *ops)
> > +{
> > +	usbmisc_ops = NULL;
> > +}
> > +
> > +int usbmisc_get_init_data(struct device *dev, struct usbmisc_usb_device *usbdev)
> > +{
> > +	struct device_node *np = dev->of_node;
> > +	int id;
> > +
> > +	usbdev->dev = dev;
> > +
> > +	id = of_alias_get_id(np, "usb");
> > +	if (id < 0) {
> > +		dev_err(dev, "Failed to get alias id, errno %d\n", id);
> > +		memset(usbdev, 0, sizeof(*usbdev));
> > +		return id;
> > +	}
> > +	usbdev->index = id;
> > +
> > +	if (of_find_property(np, "disable-over-current", NULL))
> > +		usbdev->disable_oc = 1;
> > +
> > +	return 0;
> > +}
> > +
> > +/* End of common functions shared by usbmisc drivers*/
> > +
> >  static struct ci13xxx_platform_data ci13xxx_imx_platdata __devinitdata  = {
> >  	.name			= "ci13xxx_imx",
> >  	.flags			= CI13XXX_REQUIRE_TRANSCEIVER |
> > @@ -120,6 +163,16 @@ static int __devinit ci13xxx_imx_probe(struct platform_device *pdev)
> >  		*pdev->dev.dma_mask = DMA_BIT_MASK(32);
> >  		dma_set_coherent_mask(&pdev->dev, *pdev->dev.dma_mask);
> >  	}
> > +
> > +	if (usbmisc_ops && usbmisc_ops->init) {
> > +		ret = usbmisc_ops->init(&pdev->dev);
> > +		if (ret) {
> > +			dev_err(&pdev->dev,
> > +				"usbmisc init failed, ret=%d\n", ret);
> > +			return ret;
> > +		}
> > +	}
> > +
> >  	plat_ci = ci13xxx_add_device(&pdev->dev,
> >  				pdev->resource, pdev->num_resources,
> >  				&ci13xxx_imx_platdata);
> > @@ -189,7 +242,24 @@ static struct platform_driver ci13xxx_imx_driver = {
> >  	 },
> >  };
> >  
> > -module_platform_driver(ci13xxx_imx_driver);
> > +static int __init ci13xxx_imx_drv_init(void)
> > +{
> > +	int ret;
> > +
> > +	ret = usbmisc_imx6q_drv_init();
> > +	if (ret)
> > +		return ret;
> > +
> > +	return platform_driver_register(&ci13xxx_imx_driver);
> > +}
> > +module_init(ci13xxx_imx_drv_init);
> 
> You do this change because you need to make sure that on i.MX6 the
> usbmisc device is probed before the chipidea core itself. This won't
> look very nice when the other i.MX SoCs get usbmisc support aswell.
> 
> Wouldn't it be better to add a phandle which points from the chipidea
> cores to the usbmisc device? You could drop the alias then aswell.
> 
> Like this:
> 
> 	usbotg: usb at 02184000 {
> 		compatible = "fsl,imx6q-usb", "fsl,imx27-usb";
> 		reg = <0x02184000 0x200>;
> 		interrupts = <0 43 0x04>;
> 		status = "disabled";
> 		usbmisc = <&usbmisc 0>
> 	};
> 
> <&usbmisc 0> would then mean port 0 of the usbmisc device.
I didn't add the restriction that a usbmisc driver must have a usbmisc
device. I'm not sure whether all SoC and future SoC can be look as
a device.

Peter, do you have any idea?

Thanks
Richard
> 
> If the usbmisc property exists, you can return -EPROBE_DEFER until it is
> available. If it doesn't exist, you just continue without usbmisc
> support (i.MX28)
> 
> Sascha
> 
> 
> -- 
> Pengutronix e.K.                           |                             |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
> 
