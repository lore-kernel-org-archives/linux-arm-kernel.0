From: hzpeterchen@gmail.com (Peter Chen)
Date: Wed, 10 Aug 2016 11:11:46 +0800
Subject: [PATCH v5 5/6] usb: chipidea: let chipidea core device of_node
 equal's glue layer device of_node
In-Reply-To: <147078813636.20133.1120685098868481913@sboyd-linaro>
References: <1470646331-23227-1-git-send-email-peter.chen@nxp.com>
 <1470646331-23227-6-git-send-email-peter.chen@nxp.com>
 <147078813636.20133.1120685098868481913@sboyd-linaro>
Message-ID: <20160810031146.GE1879@shlinux2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 09, 2016 at 05:15:36PM -0700, Stephen Boyd wrote:
> Quoting Peter Chen (2016-08-08 01:52:10)
> > From: Peter Chen <peter.chen@freescale.com>
> > 
> > At device tree, we have no device node for chipidea core,
> > the glue layer's node is the parent node for host and udc
> > device. But in related driver, the parent device is chipidea
> > core. So, in order to let the common driver get parent's node,
> > we let the core's device node equals glue layer device node.
> > 
> > Signed-off-by: Peter Chen <peter.chen@freescale.com>
> > Tested-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
> > Tested-by Joshua Clayton <stillcompiling@gmail.com>
> > ---
> >  drivers/usb/chipidea/core.c | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> > 
> > diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
> > index 69426e6..b189dc7 100644
> > --- a/drivers/usb/chipidea/core.c
> > +++ b/drivers/usb/chipidea/core.c
> > @@ -954,6 +954,15 @@ static int ci_hdrc_probe(struct platform_device *pdev)
> >                 dev_err(dev, "unable to init phy: %d\n", ret);
> >                 return ret;
> >         }
> > +       /*
> > +        * At device tree, we have no device node for chipidea core,
> > +        * the glue layer's node is the parent node for host and udc
> > +        * device. But in related driver, the parent device is chipidea
> > +        * core. So, in order to let the common driver get parent's node,
> > +        * we let the core's device node equals glue layer's node.
> > +        */
> > +       if (dev->parent && dev->parent->of_node)
> > +               dev->of_node = dev->parent->of_node;
> 
> Can this be done earlier? Perhaps after hw_device_init() in this probe
> routine? That would allow me to remove the awkward parent searching in
> my ULPI DT awareness patch.

The reason why I locate it there is to avoid "goto label" for error
path during PHY's get and initialization operation.

Ok, to simplify your work, I will change it at next version.

-- 

Best Regards,
Peter Chen
