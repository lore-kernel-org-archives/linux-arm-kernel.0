From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 17 Feb 2015 11:54:48 +0000
Subject: [PATCH 01/11] mfd: add the Berlin controller driver
In-Reply-To: <20150217092020.GC4507@kwain>
References: <1423671332-24580-1-git-send-email-antoine.tenart@free-electrons.com>
 <1423671332-24580-2-git-send-email-antoine.tenart@free-electrons.com>
 <20150216124808.GC14545@x1> <20150217092020.GC4507@kwain>
Message-ID: <20150217115447.GA3989@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 17 Feb 2015, Antoine Tenart wrote:
> On Mon, Feb 16, 2015 at 12:48:08PM +0000, Lee Jones wrote:
> > On Wed, 11 Feb 2015, Antoine Tenart wrote:
> > 
> > > --- a/drivers/mfd/Kconfig
> > > +++ b/drivers/mfd/Kconfig
> > > @@ -840,6 +840,11 @@ config STMPE_SPI
> > >  	  This is used to enable SPI interface of STMPE
> > >  endmenu
> > >  
> > > +config MFD_BERLIN_CTRL
> > > +	bool
> > 
> > Missing description.
> > Why can't this driver be built as a module?
> 
> Well, this mfd driver registers various devices as the pinctrl and the
> reset driver. I think we want the pinctrl driver to always be
> registered.
> 
> IMHO we want this driver to always be selected when using a Berlin SoC.

[...]

> > > +#include <linux/mfd/core.h>
> > > +#include <linux/module.h>
> > > +#include <linux/of.h>
> > 
> > kernel.h?
> 
> Is there a reason to add this header here?

I guess not if you're not using any of its macros.  Although, I don't
recall every seeing s driver without it.  I guess you learn something
every day.

[...]

> > > +static int berlin_ctrl_probe(struct platform_device *pdev)
> > > +{
> > > +	struct device *dev = &pdev->dev;
> > > +	const struct of_device_id *match;
> > > +	const struct berlin_ctrl_priv *priv;
> > > +	int ret;
> > > +
> > > +	match = of_match_node(berlin_ctrl_of_match, dev->of_node);
> > > +	if (!match)
> > > +		return -EINVAL;
> > > +
> > > +	priv = match->data;
> > > +
> > > +	ret = mfd_add_devices(dev, 0, priv->devs, priv->ndevs, NULL, -1, NULL);
> > > +	if (ret) {
> > > +		dev_err(dev, "Failed to add devices: %d\n", ret);
> > > +		return ret;
> > > +	}
> > > +
> > > +	return 0;
> > > +}
> > 
> > I'm not sure I see the point in this driver.  Why can't you just
> > register these devices directly from DT?
> 
> All these devices share the same bank of registers and we previously
> used a single node. But with many devices sharing a single node, this is
> problematic to register all the devices from DT. Using this MFD driver
> to do it is a proper solution in this case.

Tell me more.  What are the problems you encountered?

> To provide a regmap to the devices' drivers we also use syscon on the
> chip/system controller nodes.
> 
> > > +MODULE_LICENSE("GPL");

I wonder if these are actually useful if you're always going to be
built-in? 

> > > +MODULE_LICENSE("GPL");
> > 
> > v2
> 
> "GPL" is a valid choice, quoting include/linux.module.h:
> 
> 	"GPL"              [GNU Public License v2 or later]
> 	"GPL v2"           [GNU Public License v2]
> 
> Is there a reason you explicitly want to use GPLv2, and only GPLv2?

Yes, there is disparity between this and the comment in the file
header.  I don't mind which one you amend, but a change is required.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
