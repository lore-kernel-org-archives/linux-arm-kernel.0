From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 29 Apr 2013 20:26:04 +0100
Subject: [V9 PATCH 01/12] usb: phy: protect phy init and shutdown for
 mutiple deivces
In-Reply-To: <20130429182441.GA1632@arwen.pp.htv.fi>
References: <1366784606-1813-1-git-send-email-chao.xie@marvell.com>
 <1366784606-1813-2-git-send-email-chao.xie@marvell.com>
 <20130429182441.GA1632@arwen.pp.htv.fi>
Message-ID: <20130429192604.GL14496@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 29, 2013 at 09:24:41PM +0300, Felipe Balbi wrote:
> On Wed, Apr 24, 2013 at 02:23:15AM -0400, Chao Xie wrote:
> > diff --git a/include/linux/usb/phy.h b/include/linux/usb/phy.h
> > index 6b5978f..98d7e60 100644
> > --- a/include/linux/usb/phy.h
> > +++ b/include/linux/usb/phy.h
> > @@ -87,6 +87,14 @@ struct usb_phy {
> >  	/* to support controllers that have multiple transceivers */
> >  	struct list_head	head;
> >  
> > +	/*
> > +	 * PHY may be shared by multiple devices.
> > +	 * mutex and refcount are used to make sure PHY only initialize or
> > +	 * shutdown once.
> 
> bad grammar in this sentence.
> 
> > +	 */
> > +	struct mutex		phy_mutex;
> > +	unsigned int		refcount;
> 
> why don't you use an atomic_t ?

Possibly because of this:

+       mutex_lock(&x->phy_mutex);                                              
+       if (x->refcount++ == 0 && x->init)                                      
+               ret = x->init(x);                                               
+       mutex_unlock(&x->phy_mutex);                                            

This code structure has the effect that with two concurrent callers, one
will be blocked while the other calls the init function, and both will
not pass until the init function has completed.

Using an atomic type does not provide that guarantee.  Consider:

	if (atomic_inc_return(&x->atomic) == 1 && x->init)
		ret = x->init(x);

when two concurrent callers occur.  Or even consider one caller to the
shutdown function and another which comes into the init path while the
shutdown function is still running.

Atomic types are all well and good but they are also horrendously
dangerous when abused in ways like you're suggesting.
