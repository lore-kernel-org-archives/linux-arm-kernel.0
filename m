From: balbi@ti.com (Felipe Balbi)
Date: Mon, 27 Apr 2015 15:55:29 -0500
Subject: [RFC 5/6] usb: gadget: atmel_usba: use atmel_io.h to provide
 on-chip IO
In-Reply-To: <20150326115647.GD16148@samfundet.no>
References: <1427370354-21247-1-git-send-email-ben.dooks@codethink.co.uk>
 <1427370354-21247-6-git-send-email-ben.dooks@codethink.co.uk>
 <20150326115647.GD16148@samfundet.no>
Message-ID: <20150427205529.GH25136@saruman.tx.rr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 26, 2015 at 12:56:47PM +0100, Hans-Christian Egtvedt wrote:
> Around Thu 26 Mar 2015 11:45:53 +0000 or thereabout, Ben Dooks wrote:
> > Use <linux/atmel_io.h> to provide IO accessors which work on both
> > AVR32 and ARM for on-chip peripherals.
> > 
> > Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> 
> Acked-by: Hans-Christian Egtvedt <egtvedt@samfundet.no>
> 
> > --
> > CC: Nicolas Ferre <nicolas.ferre@atmel.com>
> > CC: Felipe Balbi <balbi@ti.com>
> > CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > CC: linux-usb at vger.kernel.org
> > ---
> >  drivers/usb/gadget/udc/atmel_usba_udc.c |  1 +
> >  drivers/usb/gadget/udc/atmel_usba_udc.h | 12 +++---------
> >  2 files changed, 4 insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/usb/gadget/udc/atmel_usba_udc.c b/drivers/usb/gadget/udc/atmel_usba_udc.c
> > index be2f503..6735585 100644
> > --- a/drivers/usb/gadget/udc/atmel_usba_udc.c
> > +++ b/drivers/usb/gadget/udc/atmel_usba_udc.c
> > @@ -13,6 +13,7 @@
> >  #include <linux/init.h>
> >  #include <linux/interrupt.h>
> >  #include <linux/io.h>
> > +#include <linux/atmel_io.h>
> >  #include <linux/slab.h>
> >  #include <linux/device.h>
> >  #include <linux/dma-mapping.h>
> > diff --git a/drivers/usb/gadget/udc/atmel_usba_udc.h b/drivers/usb/gadget/udc/atmel_usba_udc.h
> > index 92bd486..3d40aa3 100644
> > --- a/drivers/usb/gadget/udc/atmel_usba_udc.h
> > +++ b/drivers/usb/gadget/udc/atmel_usba_udc.h
> > @@ -191,15 +191,9 @@
> >  	 | USBA_BF(name, value))
> >  
> >  /* Register access macros */
> > -#ifdef CONFIG_AVR32
> > -#define usba_io_readl	__raw_readl
> > -#define usba_io_writel	__raw_writel
> > -#define usba_io_writew	__raw_writew
> > -#else
> > -#define usba_io_readl	readl_relaxed
> > -#define usba_io_writel	writel_relaxed
> > -#define usba_io_writew	writew_relaxed
> > -#endif
> > +#define usba_io_readl	atmel_oc_readl
> > +#define usba_io_writel	atmel_oc_writel
> > +#define usba_io_writew	atmel_oc_writew
> 
> Same comment as earlier patch, it would be nice to remove the define
> usba_io_{read,write}{l,w} defines in a follow-up patch.

I'm fine with this too. Is this targetted at v4.2 ?

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150427/3e26756e/attachment.sig>
