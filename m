From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Fri, 7 Sep 2018 15:37:39 +0200
Subject: [PATCH 04/10] phy: dphy: Add configuration helpers
In-Reply-To: <3617916.Vq2Smf1hnZ@avalon>
References: <cover.ee6158898d563fcc01d45c9652501180bccff0f0.1536138624.git-series.maxime.ripard@bootlin.com>
 <aa491b814100a670ad16b646765005efbdae05d9.1536138624.git-series.maxime.ripard@bootlin.com>
 <3617916.Vq2Smf1hnZ@avalon>
Message-ID: <20180907133739.6lvlw7wsdk4ffeua@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 05, 2018 at 04:46:05PM +0300, Laurent Pinchart wrote:
> Hi Maxime,
> 
> Thank you for the patch.
> 
> On Wednesday, 5 September 2018 12:16:35 EEST Maxime Ripard wrote:
> > The MIPI D-PHY spec defines default values and boundaries for most of the
> > parameters it defines. Introduce helpers to help drivers get meaningful
> > values based on their current parameters, and validate the boundaries of
> > these parameters if needed.
> > 
> > Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
> > ---
> >  drivers/phy/Kconfig               |   8 ++-
> >  drivers/phy/Makefile              |   1 +-
> >  drivers/phy/phy-core-mipi-dphy.c  | 160 +++++++++++++++++++++++++++++++-
> >  include/linux/phy/phy-mipi-dphy.h |   6 +-
> >  4 files changed, 175 insertions(+)
> >  create mode 100644 drivers/phy/phy-core-mipi-dphy.c
> > 
> > diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
> > index 5c8d452e35e2..06bd22bd1f4a 100644
> > --- a/drivers/phy/Kconfig
> > +++ b/drivers/phy/Kconfig
> > @@ -15,6 +15,14 @@ config GENERIC_PHY
> >  	  phy users can obtain reference to the PHY. All the users of this
> >  	  framework should select this config.
> > 
> > +config GENERIC_PHY_MIPI_DPHY
> > +	bool "MIPI D-PHY support"
> > +	help
> > +	  Generic MIPI D-PHY support.
> > +
> > +	  Provides a number of helpers a core functions for MIPI D-PHY
> > +	  drivers to us.
> 
> Do we really need to make this user-selectable ?

Probably not :)

> >  config PHY_LPC18XX_USB_OTG
> >  	tristate "NXP LPC18xx/43xx SoC USB OTG PHY driver"
> >  	depends on OF && (ARCH_LPC18XX || COMPILE_TEST)
> > diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile
> > index 84e3bd9c5665..71c29d2b9af7 100644
> > --- a/drivers/phy/Makefile
> > +++ b/drivers/phy/Makefile
> > @@ -4,6 +4,7 @@
> >  #
> > 
> >  obj-$(CONFIG_GENERIC_PHY)		+= phy-core.o
> > +obj-$(CONFIG_GENERIC_PHY_MIPI_DPHY)	+= phy-core-mipi-dphy.o
> >  obj-$(CONFIG_PHY_LPC18XX_USB_OTG)	+= phy-lpc18xx-usb-otg.o
> >  obj-$(CONFIG_PHY_XGENE)			+= phy-xgene.o
> >  obj-$(CONFIG_PHY_PISTACHIO_USB)		+= phy-pistachio-usb.o
> > diff --git a/drivers/phy/phy-core-mipi-dphy.c
> > b/drivers/phy/phy-core-mipi-dphy.c new file mode 100644
> > index 000000000000..6c1ddc7734a2
> > --- /dev/null
> > +++ b/drivers/phy/phy-core-mipi-dphy.c
> > @@ -0,0 +1,160 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Copyright (C) 2013 NVIDIA Corporation
> > + * Copyright (C) 2018 Cadence Design Systems Inc.
> > + */
> > +
> > +#include <linux/errno.h>
> > +#include <linux/export.h>
> > +#include <linux/kernel.h>
> > +#include <linux/time64.h>
> > +
> > +#include <linux/phy/phy.h>
> > +#include <linux/phy/phy-mipi-dphy.h>
> > +
> > +/*
> > + * Default D-PHY timings based on MIPI D-PHY specification. Derived from
> > the
> > + * valid ranges specified in Section 6.9, Table 14, Page 40 of the D-PHY
> > + * specification (v1.2) with minor adjustments.
> 
> Could you list those adjustments ?

I will. This was taken from the Tegra DSI driver, so I'm not sure what
these are exactly, but that should be addressed.

> > + */
> > +int phy_mipi_dphy_get_default_config(unsigned long pixel_clock,
> > +				     unsigned int bpp,
> > +				     unsigned int lanes,
> > +				     struct phy_configure_opts_mipi_dphy *cfg)
> > +{
> > +	unsigned long hs_clk_rate;
> > +	unsigned long ui;
> > +
> > +	if (!cfg)
> > +		return -EINVAL;
> 
> Should we really expect cfg to be NULL ?

It avoids a kernel panic and it's not in a hot patch, so I'd say yes?

Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180907/85bfed67/attachment.sig>
