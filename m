From: richard.zhao@freescale.com (Richard Zhao)
Date: Tue, 22 May 2012 08:27:59 +0800
Subject: [PATCH v2 01/12] usb: otg: add notify_connect_change callback
In-Reply-To: <201205212127.51020.marex@denx.de>
References: <1337592237-5090-1-git-send-email-richard.zhao@freescale.com>
 <201205212032.21757.marex@denx.de>
 <20120521184014.GA21692@kroah.com>
 <201205212127.51020.marex@denx.de>
Message-ID: <20120522002759.GD6206@b20223-02.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 21, 2012 at 09:27:50PM +0200, Marek Vasut wrote:
> Dear Greg KH,
> 
> > On Mon, May 21, 2012 at 08:32:21PM +0200, Marek Vasut wrote:
> > > Dear Greg KH,
> > > 
> > > > On Mon, May 21, 2012 at 07:36:40PM +0200, Marek Vasut wrote:
> > > > > Dear Greg KH,
> > > > > 
> > > > > > On Mon, May 21, 2012 at 05:23:46PM +0800, Richard Zhao wrote:
> > > > > > > This let usb phy driver has a chance to change hw settings when
> > > > > > > connect status change.
> > > > > > > 
> > > > > > > Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
> > > > > > > ---
> > > > > > > 
> > > > > > >  include/linux/usb/otg.h |   13 +++++++++++++
> > > > > > >  1 files changed, 13 insertions(+), 0 deletions(-)
> > > > > > > 
> > > > > > > diff --git a/include/linux/usb/otg.h b/include/linux/usb/otg.h
> > > > > > > index 38ab3f4..385641d 100644
> > > > > > > --- a/include/linux/usb/otg.h
> > > > > > > +++ b/include/linux/usb/otg.h
> > > > > > > @@ -117,6 +117,10 @@ struct usb_phy {
> > > > > > > 
> > > > > > >  	int	(*set_suspend)(struct usb_phy *x,
> > > > > > >  	
> > > > > > >  				int suspend);
> > > > > > > 
> > > > > > > +	/* notify phy connect status change */
> > > > > > > +	int	(*notify_connect_change)(struct usb_phy *x,
> > > > > > > +					 int port,
> > > > > > > +					 int connected);
> > > > > > > 
> > > > > > >  };
> > > > > > 
> > > > > > No, please make this two different callbacks.  As you see in your
> > > > > > code
> > > > > > 
> > > > > > when you implemented this, you really have:
> > > > > > 	if (connected) {
> > > > > > 	
> > > > > > 		do this...
> > > > > > 	
> > > > > > 	} else {
> > > > > > 	
> > > > > > 		do that...
> > > > > > 	
> > > > > > 	}
> > > > > > 
> > > > > > So you there is no consolidation in the driver, so just make it 2
> > > > > > callbacks, especially as someone wanted to make connected -1 just
> > > > > > for a tristate, which would be impossible to document properly...
> > > > > 
> > > > > Or he could make connected an enum maybe ?
> > > > 
> > > > No, again, that will make nothing easier on the driver end at all.
> > > > 
> > > > What's the problem with different functions that people keep resisting?
> > > 
> > > The structure grows a few bytes ... so the kernel eats a bit more ram.
> > 
> > The time it took you to write this email just made up for that extra
> > ram, sorry :)
> 
> Heh :-) But is this email constantly allocated in your kernel space?
> 
> > It doesn't matter, have people leaned nothing from our past mistakes?
> 
> All right, I won't argue with you. Richard, let's obey.
Sure. I'll change it. I think Greq's point here is maintenance. And
4-byte ram consume don't cost to be noticed.

Thanks
Richard
> 
> > greg k-h
> 
> Best regards,
> Marek Vasut
> 
