From: gregkh@linuxfoundation.org (Greg KH)
Date: Mon, 21 May 2012 10:47:42 -0700
Subject: [PATCH v2 01/12] usb: otg: add notify_connect_change callback
In-Reply-To: <201205211936.40359.marex@denx.de>
References: <1337592237-5090-1-git-send-email-richard.zhao@freescale.com>
 <1337592237-5090-2-git-send-email-richard.zhao@freescale.com>
 <20120521130556.GB18926@kroah.com>
 <201205211936.40359.marex@denx.de>
Message-ID: <20120521174742.GA31739@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 21, 2012 at 07:36:40PM +0200, Marek Vasut wrote:
> Dear Greg KH,
> 
> > On Mon, May 21, 2012 at 05:23:46PM +0800, Richard Zhao wrote:
> > > This let usb phy driver has a chance to change hw settings when connect
> > > status change.
> > > 
> > > Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
> > > ---
> > > 
> > >  include/linux/usb/otg.h |   13 +++++++++++++
> > >  1 files changed, 13 insertions(+), 0 deletions(-)
> > > 
> > > diff --git a/include/linux/usb/otg.h b/include/linux/usb/otg.h
> > > index 38ab3f4..385641d 100644
> > > --- a/include/linux/usb/otg.h
> > > +++ b/include/linux/usb/otg.h
> > > @@ -117,6 +117,10 @@ struct usb_phy {
> > > 
> > >  	int	(*set_suspend)(struct usb_phy *x,
> > >  	
> > >  				int suspend);
> > > 
> > > +	/* notify phy connect status change */
> > > +	int	(*notify_connect_change)(struct usb_phy *x,
> > > +					 int port,
> > > +					 int connected);
> > > 
> > >  };
> > 
> > No, please make this two different callbacks.  As you see in your code
> > when you implemented this, you really have:
> > 	if (connected) {
> > 		do this...
> > 	} else {
> > 		do that...
> > 	}
> > 
> > So you there is no consolidation in the driver, so just make it 2
> > callbacks, especially as someone wanted to make connected -1 just for a
> > tristate, which would be impossible to document properly...
> 
> Or he could make connected an enum maybe ?

No, again, that will make nothing easier on the driver end at all.

What's the problem with different functions that people keep resisting?

greg k-h
