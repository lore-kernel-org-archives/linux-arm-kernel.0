From: jun.li@nxp.com (Jun Li)
Date: Wed, 10 Aug 2016 09:00:15 +0000
Subject: [PATCH v5 5/6] usb: chipidea: let chipidea core device of_node
 equal's glue layer device of_node
In-Reply-To: <20160810031146.GE1879@shlinux2>
References: <1470646331-23227-1-git-send-email-peter.chen@nxp.com>
 <1470646331-23227-6-git-send-email-peter.chen@nxp.com>
 <147078813636.20133.1120685098868481913@sboyd-linaro>
 <20160810031146.GE1879@shlinux2>
Message-ID: <AM4PR04MB2130F9E9E9E304D47C44AC46891D0@AM4PR04MB2130.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Peter

> -----Original Message-----
> From: linux-usb-owner at vger.kernel.org [mailto:linux-usb-
> owner at vger.kernel.org] On Behalf Of Peter Chen
> Sent: Wednesday, August 10, 2016 11:12 AM
> To: Stephen Boyd <stephen.boyd@linaro.org>
> Cc: Peter Chen <peter.chen@nxp.com>; gregkh at linuxfoundation.org;
> stern at rowland.harvard.edu; ulf.hansson at linaro.org; broonie at kernel.org;
> sre at kernel.org; robh+dt at kernel.org; shawnguo at kernel.org;
> dbaryshkov at gmail.com; dwmw3 at infradead.org; k.kozlowski at samsung.com; linux-
> arm-kernel at lists.infradead.org; p.zabel at pengutronix.de;
> devicetree at vger.kernel.org; pawel.moll at arm.com; mark.rutland at arm.com;
> linux-usb at vger.kernel.org; arnd at arndb.de; s.hauer at pengutronix.de;
> mail at maciej.szmigiero.name; troy.kisky at boundarydevices.com;
> festevam at gmail.com; oscar at naiandei.net; linux-pm at vger.kernel.org;
> stillcompiling at gmail.com; linux-kernel at vger.kernel.org; mka at chromium.org;
> Peter Chen <peter.chen@freescale.com>
> Subject: Re: [PATCH v5 5/6] usb: chipidea: let chipidea core device
> of_node equal's glue layer device of_node
> 
> On Tue, Aug 09, 2016 at 05:15:36PM -0700, Stephen Boyd wrote:
> > Quoting Peter Chen (2016-08-08 01:52:10)
> > > From: Peter Chen <peter.chen@freescale.com>
> > >
> > > At device tree, we have no device node for chipidea core, the glue
> > > layer's node is the parent node for host and udc device. But in
> > > related driver, the parent device is chipidea core. So, in order to
> > > let the common driver get parent's node, we let the core's device
> > > node equals glue layer device node.
> > >
> > > Signed-off-by: Peter Chen <peter.chen@freescale.com>
> > > Tested-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
> > > Tested-by Joshua Clayton <stillcompiling@gmail.com>
> > > ---
> > >  drivers/usb/chipidea/core.c | 11 +++++++++++
> > >  1 file changed, 11 insertions(+)
> > >
> > > diff --git a/drivers/usb/chipidea/core.c
> > > b/drivers/usb/chipidea/core.c index 69426e6..b189dc7 100644
> > > --- a/drivers/usb/chipidea/core.c
> > > +++ b/drivers/usb/chipidea/core.c
> > > @@ -954,6 +954,15 @@ static int ci_hdrc_probe(struct platform_device
> *pdev)
> > >                 dev_err(dev, "unable to init phy: %d\n", ret);
> > >                 return ret;
> > >         }
> > > +       /*
> > > +        * At device tree, we have no device node for chipidea core,
> > > +        * the glue layer's node is the parent node for host and udc
> > > +        * device. But in related driver, the parent device is
> chipidea
> > > +        * core. So, in order to let the common driver get parent's
> node,
> > > +        * we let the core's device node equals glue layer's node.
> > > +        */
> > > +       if (dev->parent && dev->parent->of_node)
> > > +               dev->of_node = dev->parent->of_node;
> >
> > Can this be done earlier? Perhaps after hw_device_init() in this probe
> > routine? That would allow me to remove the awkward parent searching in
> > my ULPI DT awareness patch.
> 
> The reason why I locate it there is to avoid "goto label" for error path
> during PHY's get and initialization operation.
> 
> Ok, to simplify your work, I will change it at next version.

As iommu need this to be done even more earlier, will you consider to
put it before adding the core's platform device?

Li Jun 
> 
> --
> 
> Best Regards,
> Peter Chen
> --
> To unsubscribe from this list: send the line "unsubscribe linux-usb" in
> the body of a message to majordomo at vger.kernel.org More majordomo info at
> http://vger.kernel.org/majordomo-info.html
