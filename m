From: richard.zhao@freescale.com (Richard Zhao)
Date: Fri, 29 Jun 2012 16:45:10 +0800
Subject: [PATCH v2 3/4] usb: chipidea: ci13xxx-imx: add "dr_mode"
 property to device tree bindings
In-Reply-To: <4FED5D77.3050009@pengutronix.de>
References: <1340891629-13145-1-git-send-email-mkl@pengutronix.de>
 <1340891629-13145-4-git-send-email-mkl@pengutronix.de>
 <20120629014352.GA28923@b20223-02.ap.freescale.net>
 <4FED5D77.3050009@pengutronix.de>
Message-ID: <20120629084509.GB28923@b20223-02.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 29, 2012 at 09:47:03AM +0200, Marc Kleine-Budde wrote:
> 
> Cc'ed Devicetree Discussions
> 
> On 06/29/2012 03:43 AM, Richard Zhao wrote:
> > On Thu, Jun 28, 2012 at 03:53:48PM +0200, Marc Kleine-Budde wrote:
> >> This patch allows the device tree to limit the chipidea to host or
> >> peripheral mode only.
> >>
> >> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> >> ---
> >>  .../devicetree/bindings/usb/ci13xxx-imx.txt        |    3 ++
> >>  drivers/usb/chipidea/ci13xxx_imx.c                 |    3 ++
> >>  drivers/usb/chipidea/core.c                        |   41 +++++++++++++++++---
> >>  include/linux/usb/chipidea.h                       |    9 +++++
> >>  4 files changed, 50 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/Documentation/devicetree/bindings/usb/ci13xxx-imx.txt b/Documentation/devicetree/bindings/usb/ci13xxx-imx.txt
> >> index 5a0ad66..67f97f56 100644
> >> --- a/Documentation/devicetree/bindings/usb/ci13xxx-imx.txt
> >> +++ b/Documentation/devicetree/bindings/usb/ci13xxx-imx.txt
> >> @@ -4,6 +4,8 @@ Required properties:
> >>  - compatible: Should be "fsl,imx27-usb"
> >>  - reg: Should contain registers location and length
> >>  - interrupts: Should contain controller interrupt
> >> +- dr_mode: indicates the working mode for compatible controllers. Can
> >> +  be "host", "peripheral", or "otg". Defaults to "otg" if not defined.
> 
> > By default, it should be decided by capability registers. Only bad hw
> > design needs such settings. So, why not name it as force-xxx? If it's
> > not specific to imx, it doesn't needs to has prefix "fsl,".
> 
> It's not a bad hardware design if you don't route or enable all ports a
> soc offers. In modern socs you cannot enable all ports anyway.
I'm not sure about your case, but generally, it's not about ports.
It's about ID pin. If ID pin is not connect correctly, we may need to
force it to host or device working mode. The 'force" here means it
won't follow the capability registers and ID pin.
> 
> The property isn't prefixed with "fsl,", it's just "dr_mode".
> 
> Why not "force-xxx"? I had a look at Documentation/devicetree/bindings/usb:
> 
> tegra-usb.txt:
> >   - dr_mode : dual role mode. Indicates the working mode for
> >    nvidia,tegra20-ehci compatible controllers.  Can be "host", "peripheral",
> >    or "otg".  Default to "host" if not defined for backward compatibility.
> >       host means this is a host controller
> >       peripheral means it is device controller
> >       otg means it can operate as either ("on the go")
> 
> fsl-usb.txt:
> >  - dr_mode : indicates the working mode for "fsl-usb2-dr" compatible
> >    controllers.  Can be "host", "peripheral", or "otg".  Default to
> >    "host" if not defined for backward compatibility.
> > 
> 
> So why invent something new, if there seems to be a pattern?
I'm not sure they mean the same things, because the default value is
different. Event if they're same, why not make them all with sensible
name?
> 
> >>  
> >>  Optional properties:
> >>  - fsl,usbphy: phandler of usb phy that connects to the only one port
> >> @@ -14,4 +16,5 @@ usb at 02184000 { /* USB OTG */
> >>  	reg = <0x02184000 0x200>;
> >>  	interrupts = <0 43 0x04>;
> >>  	fsl,usbphy = <&usbphy1>;
> >> +	dr_mode= "otg";
> >>  };
> >> diff --git a/drivers/usb/chipidea/ci13xxx_imx.c b/drivers/usb/chipidea/ci13xxx_imx.c
> >> index efae2be..8e926fb 100644
> >> --- a/drivers/usb/chipidea/ci13xxx_imx.c
> >> +++ b/drivers/usb/chipidea/ci13xxx_imx.c
> >> @@ -120,6 +120,9 @@ static int __devinit ci13xxx_imx_probe(struct platform_device *pdev)
> >>  		*pdev->dev.dma_mask = DMA_BIT_MASK(32);
> >>  		dma_set_coherent_mask(&pdev->dev, *pdev->dev.dma_mask);
> >>  	}
> >> +
> >> +	ci13xxx_get_dr_mode(pdev->dev.of_node, &ci13xxx_imx_platdata);
> >> +
> >>  	plat_ci = ci13xxx_add_device(&pdev->dev,
> >>  				pdev->resource, pdev->num_resources,
> >>  				&ci13xxx_imx_platdata);
> >> diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
> >> index 1083585..aa8b1856 100644
> >> --- a/drivers/usb/chipidea/core.c
> >> +++ b/drivers/usb/chipidea/core.c
> >> @@ -63,6 +63,8 @@
> >>  #include <linux/kernel.h>
> >>  #include <linux/slab.h>
> >>  #include <linux/pm_runtime.h>
> >> +#include <linux/of.h>
> >> +#include <linux/of_platform.h>
> >>  #include <linux/usb/ch9.h>
> >>  #include <linux/usb/gadget.h>
> >>  #include <linux/usb/otg.h>
> >> @@ -386,6 +388,23 @@ void ci13xxx_remove_device(struct platform_device *pdev)
> >>  }
> >>  EXPORT_SYMBOL_GPL(ci13xxx_remove_device);
> >>  
> >> +void ci13xxx_get_dr_mode(struct device_node *of_node, struct ci13xxx_platform_data *pdata)
> >> +{
> >> +	const unsigned char *dr_mode;
> >> +
> >> +	dr_mode = of_get_property(of_node, "dr_mode", NULL);
> >> +	if (!dr_mode)
> >> +		return;
> >> +
> >> +	if (!strcmp(dr_mode, "host"))
> >> +		pdata->flags |= CI13XXX_DR_MODE_HOST;
> >> +	else if (!strcmp(dr_mode, "peripheral"))
> >> +		pdata->flags |= CI13XXX_DR_MODE_PERIPHERAL;
> >> +	else if (!strcmp(dr_mode, "otg"))
> >> +		pdata->flags |= CI13XXX_DR_MODE_OTG;
> >> +}
> >> +EXPORT_SYMBOL_GPL(ci13xxx_get_dr_mode);
> 
> > If you make the property name generic, this function is not specific to
> > chipidea. IMHO, the function is simple, if we do it in individual
> > drivers, it's ok too.
> 
> The property name is generic, it's just "dr_mode", but the function is
> chipidea specific, because it's working on the ci13xxx_platform_data.
You may return some common flag.
> 
> >> +
> >>  static int __devinit ci_hdrc_probe(struct platform_device *pdev)
> >>  {
> >>  	struct device	*dev = &pdev->dev;
> >> @@ -446,13 +465,23 @@ static int __devinit ci_hdrc_probe(struct platform_device *pdev)
> >>  	}
> >>  
> >>  	/* initialize role(s) before the interrupt is requested */
> >> -	ret = ci_hdrc_host_init(ci);
> >> -	if (ret)
> >> -		dev_info(dev, "doesn't support host\n");
> >> +	/* default to otg */
> >> +	if (!(ci->platdata->flags & CI13XXX_DR_MODE_MASK))
> >> +		ci->platdata->flags |= CI13XXX_DR_MODE_OTG;
> >> +
> >> +	if (ci->platdata->flags &
> >> +	    (CI13XXX_DR_MODE_HOST | CI13XXX_DR_MODE_OTG)) {
> >> +		ret = ci_hdrc_host_init(ci);
> >> +		if (ret)
> >> +			dev_info(dev, "doesn't support host\n");
> >> +	}
> >>  
> >> -	ret = ci_hdrc_gadget_init(ci);
> >> -	if (ret)
> >> -		dev_info(dev, "doesn't support gadget\n");
> >> +	if (ci->platdata->flags &
> >> +	    (CI13XXX_DR_MODE_PERIPHERAL | CI13XXX_DR_MODE_OTG)) {
> >> +		ret = ci_hdrc_gadget_init(ci);
> >> +		if (ret)
> >> +			dev_info(dev, "doesn't support gadget\n");
> >> +	}
> >>  
> >>  	if (!ci->roles[CI_ROLE_HOST] && !ci->roles[CI_ROLE_GADGET]) {
> >>  		dev_err(dev, "no supported roles\n");
> >> diff --git a/include/linux/usb/chipidea.h b/include/linux/usb/chipidea.h
> >> index 544825d..29ad908 100644
> >> --- a/include/linux/usb/chipidea.h
> >> +++ b/include/linux/usb/chipidea.h
> >> @@ -19,6 +19,12 @@ struct ci13xxx_platform_data {
> >>  #define CI13XXX_REQUIRE_TRANSCEIVER	BIT(1)
> >>  #define CI13XXX_PULLUP_ON_VBUS		BIT(2)
> >>  #define CI13XXX_DISABLE_STREAMING	BIT(3)
> >> +#define CI13XXX_DR_MODE_HOST		BIT(4)
> >> +#define CI13XXX_DR_MODE_PERIPHERAL	BIT(5)
> >> +#define CI13XXX_DR_MODE_OTG		BIT(6)
> > All we need is CI13XXX_DR_FORCE_HOST and CI13XXX_DR_FORCE_DEVICE.
> 
> Okay.
> 
> > 
> > Thanks
> > Richard
> >> +#define CI13XXX_DR_MODE_MASK \
> >> +	(CI13XXX_DR_MODE_HOST | CI13XXX_DR_MODE_PERIPHERAL | \
> >> +	 CI13XXX_DR_MODE_OTG)
> >>  
> >>  #define CI13XXX_CONTROLLER_RESET_EVENT		0
> >>  #define CI13XXX_CONTROLLER_STOPPED_EVENT	1
> >> @@ -35,4 +41,7 @@ struct platform_device *ci13xxx_add_device(struct device *dev,
> >>  /* Remove ci13xxx device */
> >>  void ci13xxx_remove_device(struct platform_device *pdev);
> >>  
> >> +/* Parse of-tree "dr_mode" property */
> >> +void ci13xxx_get_dr_mode(struct device_node *of_node, struct ci13xxx_platform_data *pdata);
> >> +
> >>  #endif
> >> -- 
> >> 1.7.10
> >>
> >>
> > 
> 
> Marc
> -- 
> Pengutronix e.K.                  | Marc Kleine-Budde           |
> Industrial Linux Solutions        | Phone: +49-231-2826-924     |
> Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
> Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |
> 
