From: marex@denx.de (Marek Vasut)
Date: Mon, 21 May 2012 19:36:40 +0200
Subject: [PATCH v2 01/12] usb: otg: add notify_connect_change callback
In-Reply-To: <20120521130556.GB18926@kroah.com>
References: <1337592237-5090-1-git-send-email-richard.zhao@freescale.com>
 <1337592237-5090-2-git-send-email-richard.zhao@freescale.com>
 <20120521130556.GB18926@kroah.com>
Message-ID: <201205211936.40359.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Greg KH,

> On Mon, May 21, 2012 at 05:23:46PM +0800, Richard Zhao wrote:
> > This let usb phy driver has a chance to change hw settings when connect
> > status change.
> > 
> > Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
> > ---
> > 
> >  include/linux/usb/otg.h |   13 +++++++++++++
> >  1 files changed, 13 insertions(+), 0 deletions(-)
> > 
> > diff --git a/include/linux/usb/otg.h b/include/linux/usb/otg.h
> > index 38ab3f4..385641d 100644
> > --- a/include/linux/usb/otg.h
> > +++ b/include/linux/usb/otg.h
> > @@ -117,6 +117,10 @@ struct usb_phy {
> > 
> >  	int	(*set_suspend)(struct usb_phy *x,
> >  	
> >  				int suspend);
> > 
> > +	/* notify phy connect status change */
> > +	int	(*notify_connect_change)(struct usb_phy *x,
> > +					 int port,
> > +					 int connected);
> > 
> >  };
> 
> No, please make this two different callbacks.  As you see in your code
> when you implemented this, you really have:
> 	if (connected) {
> 		do this...
> 	} else {
> 		do that...
> 	}
> 
> So you there is no consolidation in the driver, so just make it 2
> callbacks, especially as someone wanted to make connected -1 just for a
> tristate, which would be impossible to document properly...

Or he could make connected an enum maybe ?

> 
> greg k-h
> 
> > @@ -252,6 +256,15 @@ usb_phy_set_suspend(struct usb_phy *x, int suspend)
> > 
> >  }
> >  
> >  static inline int
> > 
> > +usb_phy_notify_connect_change(struct usb_phy *x, int port, int
> > connected) +{
> > +	if (x->notify_connect_change != NULL)
> > +		return x->notify_connect_change(x, port, connected);
> > +	else
> > +		return 0;
> > +}
> > +
> > +static inline int
> > 
> >  otg_start_srp(struct usb_otg *otg)
> >  {
> >  
> >  	if (otg && otg->start_srp)

Best regards,
Marek Vasut
