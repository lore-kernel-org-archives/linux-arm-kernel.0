From: richard.zhao@freescale.com (Richard Zhao)
Date: Tue, 10 Jul 2012 09:44:51 +0800
Subject: [PATCH v9 REBASE 6/9] USB: notify phy when root hub port connect
 change
In-Reply-To: <20120709165757.GA6024@kroah.com>
References: <1341673008-29808-1-git-send-email-richard.zhao@freescale.com>
 <1341673008-29808-7-git-send-email-richard.zhao@freescale.com>
 <20120709165757.GA6024@kroah.com>
Message-ID: <20120710014450.GF26888@b20223-02.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 09, 2012 at 09:57:57AM -0700, Greg KH wrote:
> On Sat, Jul 07, 2012 at 10:56:45PM +0800, Richard Zhao wrote:
> > Phy may need to change settings when port connect change.
> > 
> > Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
> > Tested-by: Subodh Nijsure <snijsure@grid-net.com>
> > ---
> >  drivers/usb/core/hub.c |    8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> > index 4cc8dc9..2ba9d84 100644
> > --- a/drivers/usb/core/hub.c
> > +++ b/drivers/usb/core/hub.c
> > @@ -20,6 +20,7 @@
> >  #include <linux/usb.h>
> >  #include <linux/usbdevice_fs.h>
> >  #include <linux/usb/hcd.h>
> > +#include <linux/usb/otg.h>
> >  #include <linux/usb/quirks.h>
> >  #include <linux/kthread.h>
> >  #include <linux/mutex.h>
> > @@ -4037,6 +4038,13 @@ static void hub_port_connect_change(struct usb_hub *hub, int port1,
> >  		}
> >  	}
> >  
> > +	if (unlikely(hcd->phy && !hdev->parent)) {
> 
> Why is this "unlikely"?  And why mark it as such, is this a "fast path"
> that needs the compiler to know this hint to optimize things here?
> 
> Please don't use likely() or unlikely() except in places it really is
> needed, _and_ you have measured the difference.  Have you done so in
> this place?
It's from a comment by Alan Stern.
http://www.spinics.net/lists/linux-usb/msg64987.html

Actually, for my board, it's not unlikely. But for others which don't
have notify_connect/disconnect, it's unlikely.

Because it's not unlikely for all boards, I prefer remove "unlikely".

Thanks
Richard
> 
> thanks,
> 
> greg k-h
> 
