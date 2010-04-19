From: amit.kucheria@canonical.com (Amit Kucheria)
Date: Mon, 19 Apr 2010 04:03:40 +0300
Subject: [PATCHv4 2.6.34-rc4 5/7] mxc: Add generic USB HW
	initialization for MX51
In-Reply-To: <20100417170706.GY30801@buzzloop.caiaq.de>
References: <1271445371-18501-1-git-send-email-Dinh.Nguyen@freescale.com>
	<1271445371-18501-2-git-send-email-Dinh.Nguyen@freescale.com>
	<1271445371-18501-3-git-send-email-Dinh.Nguyen@freescale.com>
	<1271445371-18501-4-git-send-email-Dinh.Nguyen@freescale.com>
	<1271445371-18501-5-git-send-email-Dinh.Nguyen@freescale.com>
	<20100417170706.GY30801@buzzloop.caiaq.de>
Message-ID: <20100419010340.GB15308@matterhorn.verdurent.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10 Apr 17, Daniel Mack wrote:
> On Fri, Apr 16, 2010 at 02:16:09PM -0500, Dinh.Nguyen at freescale.com wrote:
> > This patch adds USB HW initializiation code to /plat-mxc/ehci.c.
> > 	-Stops and resets USB HW
> > 	-Sets some specific PHY settings
> > 	-Stop and restart the USB HW.
> > Renames mxc_set_usbcontrol to mxc_initialize_usb_hw.
> > 
> > This patch applies to 2.6.34-rc4.
> 
> Yes, the whole series looks _much_ better now, thanks!
> Some minor things below.
> 
> 
> > Signed-off-by: Dinh Nguyen <Dinh.Nguyen@freescale.com>
> > ---
> >  arch/arm/plat-mxc/ehci.c                  |  128 ++++++++++++++++++++++++++++-
> >  arch/arm/plat-mxc/include/mach/mxc_ehci.h |    2 +-
> >  2 files changed, 127 insertions(+), 3 deletions(-)
> > 
> > diff --git a/arch/arm/plat-mxc/ehci.c b/arch/arm/plat-mxc/ehci.c
> > index cb0b638..35ff1c1 100644
> > --- a/arch/arm/plat-mxc/ehci.c
> > +++ b/arch/arm/plat-mxc/ehci.c
> > @@ -1,5 +1,6 @@
> >  /*
> >   * Copyright (c) 2009 Daniel Mack <daniel@caiaq.de>
> > + * Copyright (C) 2010 Freescale Semiconductor, Inc.
> >   *
> >   * This program is free software; you can redistribute it and/or modify it
> >   * under the terms of the GNU General Public License as published by the
> > @@ -18,6 +19,7 @@
> >  
> >  #include <linux/platform_device.h>
> >  #include <linux/io.h>
> > +#include <linux/delay.h>
> >  
> >  #include <mach/hardware.h>
> >  #include <mach/mxc_ehci.h>
> > @@ -50,9 +52,14 @@
> >  #define MX35_H1_TLL_BIT		(1 << 5)
> >  #define MX35_H1_USBTE_BIT	(1 << 4)
> >  
> > -int mxc_set_usbcontrol(int port, unsigned int flags)
> > +int mxc_intialize_usb_hw(int port, unsigned int flags)
> 
> This patch and the next one should be merged into one. The reason is
> that you rename a function here and the next patch follows that change.
> Especially when bisecting, this can lead to uncompilable checkouts of
> the tree when stopping in the middle.

Also, patch 3 really belongs with this patch too since the #defines in
patch 3 are used here.

-- 
----------------------------------------------------------------------
Amit Kucheria, Kernel Engineer || amit.kucheria at canonical.com
----------------------------------------------------------------------
