From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 30 Jan 2013 20:33:27 +0100
Subject: [PATCH 4/6] usb: chipidea: add PTW and PTS handling
In-Reply-To: <5109505E.7040204@parrot.com>
References: <1359559782-14552-1-git-send-email-s.hauer@pengutronix.de>
 <1359559782-14552-5-git-send-email-s.hauer@pengutronix.de>
 <5109505E.7040204@parrot.com>
Message-ID: <20130130193327.GA1906@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 30, 2013 at 05:54:54PM +0100, Matthieu CASTET wrote:
> > diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
> > index 57cae1f..dcb650f 100644
> > --- a/drivers/usb/chipidea/core.c
> > +++ b/drivers/usb/chipidea/core.c
> > @@ -67,6 +67,8 @@
> >  #include <linux/usb/gadget.h>
> >  #include <linux/usb/otg.h>
> >  #include <linux/usb/chipidea.h>
> > +#include <linux/usb/of.h>
> > +#include <linux/phy.h>
> >  
> >  #include "ci.h"
> >  #include "udc.h"
> > @@ -211,6 +213,42 @@ static int hw_device_init(struct ci13xxx *ci, void __iomem *base)
> >  	return 0;
> >  }
> >  
> > +static void hw_phymode_configure(struct ci13xxx *ci)
> > +{
> > +	u32 portsc;
> > +
> > +	/*
> > +	 * The lpm version has the corresponding bits in the devlc register.
> > +	 * Currently not implemented.
> > +	 */
> > +	if (ci->hw_bank.lpm)
> > +		return;
> Why you don't implement it ?
> 
> If you don't implement it, I believe you should add a warning in order to catch
> it when used with lpm devices.

I'm against adding a warning because current users seem to go well
without this setting. Adding a warning would lead to more confusion than
it would help.

I could try and implement it, though I'm unsure about the register
layout.

What I know from an earlier post from you is this:

#define LPM_PTS(d)  (((d)>>29)&7)
#define LPM_STS     BIT(28) /* serial transceiver select */
#define LPM_PTW     BIT(27) /* parallel transceiver width */

Do you also know how LPM_PTS is decoded?

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
