From: stern@rowland.harvard.edu (Alan Stern)
Date: Tue, 10 Jul 2012 10:24:07 -0400 (EDT)
Subject: [PATCH v9 REBASE 6/9] USB: notify phy when root hub port connect
 change
In-Reply-To: <20120710014450.GF26888@b20223-02.ap.freescale.net>
Message-ID: <Pine.LNX.4.44L0.1207101021580.1308-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 10 Jul 2012, Richard Zhao wrote:

> > > @@ -4037,6 +4038,13 @@ static void hub_port_connect_change(struct usb_hub *hub, int port1,
> > >  		}
> > >  	}
> > >  
> > > +	if (unlikely(hcd->phy && !hdev->parent)) {
> > 
> > Why is this "unlikely"?  And why mark it as such, is this a "fast path"
> > that needs the compiler to know this hint to optimize things here?
> > 
> > Please don't use likely() or unlikely() except in places it really is
> > needed, _and_ you have measured the difference.  Have you done so in
> > this place?
> It's from a comment by Alan Stern.
> http://www.spinics.net/lists/linux-usb/msg64987.html

That comment was made in a somewhat different context.  At the time 
the code was part of an interrupt handler; now it isn't.

> Actually, for my board, it's not unlikely. But for others which don't
> have notify_connect/disconnect, it's unlikely.
> 
> Because it's not unlikely for all boards, I prefer remove "unlikely".

It's no longer a big deal one way or another.  I don't care about the 
"unlikely" because it's on a cold path running in process context.  Go 
ahead and remove it.

Alan Stern
