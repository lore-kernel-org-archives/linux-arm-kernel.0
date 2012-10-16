From: tony@atomide.com (Tony Lindgren)
Date: Tue, 16 Oct 2012 09:49:36 -0700
Subject: [PATCH v2 2/3] ARM: OMAP4: add _dev_attr_ to ocp2scp for
 representing usb_phy
In-Reply-To: <20121011004413.GW12552@atomide.com>
References: <1349675983-23803-1-git-send-email-kishon@ti.com>
 <1349675983-23803-3-git-send-email-kishon@ti.com>
 <20121011004413.GW12552@atomide.com>
Message-ID: <20121016164936.GR15569@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tony Lindgren <tony@atomide.com> [121010 17:46]:
> Hi,
> 
> * Kishon Vijay Abraham I <kishon@ti.com> [121007 23:01]:
> > In order to reflect devices(usb_phy) attached to ocp2scp bus, ocp2scp
> > is assigned a device attribute to represent the attached devices.
> ...
> 
> > --- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> > +++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> > @@ -21,6 +21,7 @@
> >  #include <linux/io.h>
> >  #include <linux/platform_data/gpio-omap.h>
> >  #include <linux/power/smartreflex.h>
> > +#include <linux/platform_data/omap_ocp2scp.h>
> >  
> >  #include <plat/omap_hwmod.h>
> >  #include <plat/i2c.h>
> > @@ -2681,6 +2682,32 @@ static struct omap_hwmod_class omap44xx_ocp2scp_hwmod_class = {
> >  	.sysc	= &omap44xx_ocp2scp_sysc,
> >  };
> >  
> > +/* ocp2scp dev_attr */
> > +static struct resource omap44xx_usb_phy_and_pll_addrs[] = {
> > +	{
> > +		.name		= "usb_phy",
> > +		.start		= 0x4a0ad080,
> > +		.end		= 0x4a0ae000,
> > +		.flags		= IORESOURCE_MEM,
> > +	},
> > +	{
> > +		/* XXX: Remove this once control module driver is in place */
> > +		.name		= "ctrl_dev",
> > +		.start		= 0x4a002300,
> > +		.end		= 0x4a002303,
> > +		.flags		= IORESOURCE_MEM,
> > +	},
> > +	{ }
> > +};
> 
> Why don't you set the CONTROL_DEV_CONF as a fixed regulator?

After some more investigating, we may be able to set it up as a
regulator or clock later on. But as a regression fix, this seems
OK for me.

Benoit, is this OK for you?

Regards,

Tony
