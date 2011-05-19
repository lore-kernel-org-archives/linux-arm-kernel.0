From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 19 May 2011 21:03:53 +0200
Subject: [PATCH 5/8] ARM i.MX Allow to compile together i.MX1/21/25/27
In-Reply-To: <20110519180456.GA21172@pengutronix.de>
References: <1305823648-2428-1-git-send-email-s.hauer@pengutronix.de>
	<1305823648-2428-6-git-send-email-s.hauer@pengutronix.de>
	<20110519180456.GA21172@pengutronix.de>
Message-ID: <20110519190352.GS30963@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 19, 2011 at 08:04:56PM +0200, Uwe Kleine-K?nig wrote:
> On Thu, May 19, 2011 at 06:47:25PM +0200, Sascha Hauer wrote:
> > This allows for all armv4 and armv5 based i.MX systems to be compiled
> > together in one kernel. To accomplish this we need ARM_PATCH_PHYS_VIRT
> > and AUTO_ZRELADDR which is selected in Kconfig. This breaks execute
> > in place support. It would be possible to keep XIP support, but the
> > needed Kconfig magix is just too ugly.
> s/magix/magic/
> I think the magic isn't that ugly (or the magic you think of is more
> ugly than mine :-).
> 
> 
> 	choice
> 		prompt "Freescale CPU family:"
> 		default ARCH_MX3
> 
> 	config TRALALA_MX1
> 		bool "MX1"
> 		select CAN_HAVE_IMX1
> 		...
> 
> 	config TRALALA_MX21
> 		bool "i.MX21"
> 		select CAN_HAVE_IMX21
> 		...
> 
> 	config TRALALA_ARM_V4_V5
> 		bool "i.MX1, i.MX21, i.MX25, i.MX27"
> 		depends on ARM_PATCH_PHYS_VIRT && AUTO_ZRELADDR
> 		select CAN_HAVE_IMX1
> 		select CAN_HAVE_IMX21
> 		select CAN_HAVE_IMX25
> 		select CAN_HAVE_IMX27
> 
> 	config TRALALA_MX3
> 		....

This is exactly the magic I had in mind and I don't really like another
set of *_IMX* kconfig entries.

> >  
> >  config SOC_IMX21
> >  	bool
> > +	select ARCH_MX2
> ARCH_MX21 isn't needed?

Nope, I removed it along the way. It's unused.

> > index a5353fc..0202ca0 100644
> > --- a/arch/arm/plat-mxc/Kconfig
> > +++ b/arch/arm/plat-mxc/Kconfig
> > @@ -14,20 +14,12 @@ choice
> >  	prompt "Freescale CPU family:"
> >  	default ARCH_MX3
> >  
> > -config ARCH_MX1
> > -	bool "MX1-based"
> > +config ARCH_IMX_V4_V5
> > +	select ARM_PATCH_PHYS_VIRT
> > +	select AUTO_ZRELADDR
> select EXPERIMENTAL

Hm, yes. Though I would really prefer removing the depency on
EXPERIMENTAL.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
