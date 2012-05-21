From: gregkh@linuxfoundation.org (Greg KH)
Date: Mon, 21 May 2012 06:03:10 -0700
Subject: [PATCH v2 01/12] usb: otg: add notify_connect_change callback
In-Reply-To: <20120521093840.GM8633@arwen.pp.htv.fi>
References: <1337592237-5090-1-git-send-email-richard.zhao@freescale.com>
 <1337592237-5090-2-git-send-email-richard.zhao@freescale.com>
 <20120521092635.GL8633@arwen.pp.htv.fi>
 <20120521093614.GL30755@b20223-02.ap.freescale.net>
 <20120521093840.GM8633@arwen.pp.htv.fi>
Message-ID: <20120521130310.GA18926@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 21, 2012 at 12:38:41PM +0300, Felipe Balbi wrote:
> On Mon, May 21, 2012 at 05:36:16PM +0800, Richard Zhao wrote:
> > On Mon, May 21, 2012 at 12:26:36PM +0300, Felipe Balbi wrote:
> > > On Mon, May 21, 2012 at 05:23:46PM +0800, Richard Zhao wrote:
> > > > This let usb phy driver has a chance to change hw settings when connect
> > > > status change.
> > > > 
> > > > Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
> > > > ---
> > > >  include/linux/usb/otg.h |   13 +++++++++++++
> > > >  1 files changed, 13 insertions(+), 0 deletions(-)
> > > > 
> > > > diff --git a/include/linux/usb/otg.h b/include/linux/usb/otg.h
> > > > index 38ab3f4..385641d 100644
> > > > --- a/include/linux/usb/otg.h
> > > > +++ b/include/linux/usb/otg.h
> > > > @@ -117,6 +117,10 @@ struct usb_phy {
> > > >  	int	(*set_suspend)(struct usb_phy *x,
> > > >  				int suspend);
> > > >  
> > > > +	/* notify phy connect status change */
> > > > +	int	(*notify_connect_change)(struct usb_phy *x,
> > > > +					 int port,
> > > > +					 int connected);
> > > >  };
> > > >  
> > > >  
> > > > @@ -252,6 +256,15 @@ usb_phy_set_suspend(struct usb_phy *x, int suspend)
> > > >  }
> > > >  
> > > >  static inline int
> > > > +usb_phy_notify_connect_change(struct usb_phy *x, int port, int connected)
> > > > +{
> > > > +	if (x->notify_connect_change != NULL)
> > > 
> > > you don't need this != NULL. See that no other wrapper has it. Keep
> > > consistency.
> > notify_connect_change callback is not a must. I just let the phy driver
> > have a chance to do whatever it needs to do.
> 
> what I meant was:
> 
> -	if (x->notify_connect_change != NULL)
> +	if (x->notify_connect_change)
> 
> > > Also, this is the kind of stuff that I have been queueing for Greg so I
> > > should be in Cc.
> > Ah, I'm really sorry. I just find out I used the result of get_maintainer
> > for v1 patchset.
> 
> hmm... ok, looks like I should patch MAINTAINERS file for that :-p
> 
> Greg, is it ok ?

Yes, please send me a patch for MAINTAINERS for this.

greg k-h
