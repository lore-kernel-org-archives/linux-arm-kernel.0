From: richard.zhao@freescale.com (Richard Zhao)
Date: Mon, 16 Jul 2012 16:38:38 +0800
Subject: [PATCH 12/12] USB: chipidea: add imx usbmisc support
In-Reply-To: <20120716082520.GN24458@pengutronix.de>
References: <1342076512-19207-1-git-send-email-richard.zhao@freescale.com>
 <1342076512-19207-13-git-send-email-richard.zhao@freescale.com>
 <20120716082520.GN24458@pengutronix.de>
Message-ID: <20120716083837.GI21635@b20223-02.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 16, 2012 at 10:25:20AM +0200, Sascha Hauer wrote:
> On Thu, Jul 12, 2012 at 03:01:52PM +0800, Richard Zhao wrote:
> > i.MX usb controllers shares non-core registers, which may include
> > SoC specific controls. We take it as a usbmisc device and usbmisc
> > driver export functions needed by ci13xxx_imx driver.
> > 
> > For example, Sabrelite board has bad over-current design, we can
> > usbmisc to disable over-current detect.
> > 
> > Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
> > ---
> >  .../devicetree/bindings/usb/imx-usbmisc.txt        |   15 ++
> >  drivers/usb/chipidea/Makefile                      |    2 +-
> >  drivers/usb/chipidea/ci13xxx_imx.c                 |    4 +
> >  drivers/usb/chipidea/imx_usbmisc.c                 |  144 ++++++++++++++++++++
> >  4 files changed, 164 insertions(+), 1 deletion(-)
> >  create mode 100644 Documentation/devicetree/bindings/usb/imx-usbmisc.txt
> >  create mode 100644 drivers/usb/chipidea/imx_usbmisc.c
> > 
> > diff --git a/Documentation/devicetree/bindings/usb/imx-usbmisc.txt b/Documentation/devicetree/bindings/usb/imx-usbmisc.txt
> > new file mode 100644
> > index 0000000..09f01ca
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/usb/imx-usbmisc.txt
> > @@ -0,0 +1,15 @@
> > +* Freescale i.MX non-core registers
> > +
> > +Required properties:
> > +- compatible: Should be "fsl,imx6q-usbmisc"
> > +- reg: Should contain registers location and length
> > +
> > +Optional properties:
> > +- fsl,disable-over-current: disable over current detect
> > +
> > +Examples:
> > +usbmisc at 02184800 {
> > +	compatible = "fsl,imx6q-usbmisc";
> > +	reg = <0x02184800 0x200>;
> > +	fsl,disable-over-current;
> > +};
> > diff --git a/drivers/usb/chipidea/Makefile b/drivers/usb/chipidea/Makefile
> > index 3f56b76..46fc31c 100644
> > --- a/drivers/usb/chipidea/Makefile
> > +++ b/drivers/usb/chipidea/Makefile
> > @@ -17,5 +17,5 @@ ifneq ($(CONFIG_PCI),)
> >  endif
> >  
> >  ifneq ($(CONFIG_OF_DEVICE),)
> > -	obj-$(CONFIG_USB_CHIPIDEA)	+= ci13xxx_imx.o
> > +	obj-$(CONFIG_USB_CHIPIDEA)	+= ci13xxx_imx.o imx_usbmisc.o
> >  endif
> > diff --git a/drivers/usb/chipidea/ci13xxx_imx.c b/drivers/usb/chipidea/ci13xxx_imx.c
> > index b3173d8..dd7f3a3 100644
> > --- a/drivers/usb/chipidea/ci13xxx_imx.c
> > +++ b/drivers/usb/chipidea/ci13xxx_imx.c
> > @@ -24,6 +24,8 @@
> >  
> >  #include "ci.h"
> >  
> > +int imx_usbmisc_init(struct device *usbdev);
> > +
> >  #define pdev_to_phy(pdev) \
> >  	((struct usb_phy *)platform_get_drvdata(pdev))
> >  #define ci_to_imx_data(ci) \
> > @@ -142,6 +144,8 @@ static int __devinit ci13xxx_imx_probe(struct platform_device *pdev)
> >  		dma_set_coherent_mask(&pdev->dev, *pdev->dev.dma_mask);
> >  	}
> >  
> > +	imx_usbmisc_init(&pdev->dev);
> > +
> >  	platform_set_drvdata(pdev, data);
> >  
> >  	plat_ci = ci13xxx_add_device(&pdev->dev,
> > diff --git a/drivers/usb/chipidea/imx_usbmisc.c b/drivers/usb/chipidea/imx_usbmisc.c
> > new file mode 100644
> > index 0000000..33a8ec0
> > --- /dev/null
> > +++ b/drivers/usb/chipidea/imx_usbmisc.c
> > @@ -0,0 +1,144 @@
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
> > +#include <linux/of_platform.h>
> > +#include <linux/clk.h>
> > +#include <linux/err.h>
> > +#include <asm/io.h>
> 
> linux/io.h
> 
> > +
> > +struct usbmisc;
> > +
> > +struct soc_data {
> > +	int (*init) (struct usbmisc *usbmisc, int id);
> > +	void (*exit) (struct usbmisc *usbmisc, int id);
> > +};
> > +
> > +struct usbmisc {
> > +	struct soc_data *soc_data;
> > +	void __iomem *base;
> > +	struct clk *clk;
> > +
> > +	int dis_oc:1;
> > +};
> > +
> > +/* Since we only have one usbmisc device at runtime, we global variables */
> > +static struct usbmisc *usbmisc;
> 
> NACK
Right, it's a bad design. I'm considering change it too. Maybe I will
move it out this patch series. As I asked you in another mail in this
thread, do you think it's good to put it here or in mach-imx/ ?
> 
> What you've done here exactly matches your current usecase but is not
> enough for any of the other usecases I can think of. Even the i.MX6 has
> three USB ports, each of them has a overcurrent disable bit. Also, there
> are more flags, like:
Yes, I'll change it to support different usb with different properties.
> 
> - use internal phy
> - power pin polarity
> - ttl enabled
I focus on imx6 now. So I think the property can be added when it's
needed. Now I only use disable oc.
> 
> I think the best you can do here is to add the flags to the
> fsl,imx6q-usb device nodes:
> 
> 	usb at 02184000 { /* USB OTG */
> 		compatible = "fsl,imx6q-usb", "fsl,imx27-usb";
> 		reg = <0x02184000 0x200>;
> 		interrupts = <0 43 0x04>;
> 		fsl,usbphy = <&usbphy1>;
> 		status = "disabled";
> 		fsl,disable-over-current;
> 		<other flags>;
> 	};
> 
> Then add a usbmisc device which does not contain any flags. During
> initialization of the fsl,imx6q-usb device you can then pass a pointer
> to its device node to imx_usbmisc_init.
Good suggestion.

Thanks
Richard
> 
> Sascha
> 
> -- 
> Pengutronix e.K.                           |                             |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
> 
