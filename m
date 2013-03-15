From: peter.chen@freescale.com (Peter Chen)
Date: Fri, 15 Mar 2013 20:26:59 +0800
Subject: [PATCH 14/14] usb: udc-core: add judgement logic for
 usb_gadget_connect
In-Reply-To: <20130315103701.GA21445@arwen.pp.htv.fi>
References: <1363240242-25775-1-git-send-email-peter.chen@freescale.com>
 <1363240242-25775-15-git-send-email-peter.chen@freescale.com>
 <20130314090005.GB14443@arwen.pp.htv.fi>
 <20130314092438.GB26420@nchen-desktop>
 <20130314101904.GD32369@arwen.pp.htv.fi>
 <20130315060615.GB28361@nchen-desktop>
 <20130315075128.GF5074@arwen.pp.htv.fi>
 <20130315100408.GG28361@nchen-desktop>
 <20130315103701.GA21445@arwen.pp.htv.fi>
Message-ID: <20130315122658.GB32470@nchen-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 15, 2013 at 12:37:01PM +0200, Felipe Balbi wrote:
> >   */
> >  static inline int usb_gadget_disconnect(struct usb_gadget *gadget)
> >  {
> > +	int ret = 0;
> > +
> >  	if (!gadget->ops->pullup)
> >  		return -EOPNOTSUPP;
> > -	return gadget->ops->pullup(gadget, 0);
> > +
> > +	if (gadget->connection == 1)
> > +		ret = gadget->ops->pullup(gadget, 0);
> > +
> > +	if (!ret)
> > +		gadget->connection --;
> > +
> > +	return ret;
> >  }
> 
> this might be a good idea. But we already have something similar,
> although it's managed at composite device level.

Yes, I know, it should only be managed at one place at last.

> Maybe we need to move
> that to the gadget layer. Still, I don't want to let UDC drivers call
> usb_gadget_connect()/disconnect() directly.
> 
> It's easy enough for udc-core to handle that.


Below are all cases I can think about pullup_dp

1. No vbus interrupt support udc driver, manage pullup at load/unload
gadget module.
2. For vbus interrupt supported udc driver, manage pullup at vbus interrupt
3. For gadget module, like uvc, it will call pullup_dp through its app.

Are there any cases? We need to design one solution to cover all
cases, then, we can try to delete the duplicate pullup calling at
all udc drivers, and make it be generic.

-- 

Best Regards,
Peter Chen
