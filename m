From: peter.chen@freescale.com (Peter Chen)
Date: Thu, 27 Dec 2012 16:20:08 +0800
Subject: [PATCH v4 3/7] usb: chipidea: add otg id switch and vbus
 connect/disconnect detect
In-Reply-To: <201212270821.55253.marex@denx.de>
References: <1356591603-23323-1-git-send-email-peter.chen@freescale.com>
 <1356591603-23323-4-git-send-email-peter.chen@freescale.com>
 <201212270821.55253.marex@denx.de>
Message-ID: <20121227082007.GA29123@nchen-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 27, 2012 at 08:21:55AM +0100, Marek Vasut wrote:
> Dear Peter Chen,
> 
> [...]
> > +
> > +#define CI_VBUS_STABLE_TIMEOUT 500
> 
> Shall we not change this to static const int instead ?
Is it a must?
I find the similar at drivers/usb/core/hub.c

2433 #define PORT_RESET_TRIES        5
2434 #define SET_ADDRESS_TRIES       2
2435 #define GET_DESCRIPTOR_TRIES    2
2436 #define SET_CONFIG_TRIES        (2 * (use_both_schemes + 1))
2437 #define USE_NEW_SCHEME(i)       ((i) / 2 == (int)old_scheme_first)
2438         
2439 #define HUB_ROOT_RESET_TIME     50      /* times are in msec */
2440 #define HUB_SHORT_RESET_TIME    10
2441 #define HUB_BH_RESET_TIME       50
2442 #define HUB_LONG_RESET_TIME     200
2443 #define HUB_RESET_TIMEOUT       500
> 
> [...]
> 
> > --- a/drivers/usb/chipidea/udc.c
> > +++ b/drivers/usb/chipidea/udc.c
> > @@ -1371,6 +1371,7 @@ static int ci13xxx_vbus_session(struct usb_gadget
> > *_gadget, int is_active) pm_runtime_get_sync(&_gadget->dev);
> >  			hw_device_reset(ci, USBMODE_CM_DC);
> >  			hw_device_state(ci, ci->ep0out->qh.dma);
> > +			dev_dbg(ci->dev, "Connected to host\n");
> >  		} else {
> >  			hw_device_state(ci, 0);
> >  			if (ci->platdata->notify_event)
> > @@ -1378,6 +1379,7 @@ static int ci13xxx_vbus_session(struct usb_gadget
> > *_gadget, int is_active) CI13XXX_CONTROLLER_STOPPED_EVENT);
> >  			_gadget_stop_activity(&ci->gadget);
> >  			pm_runtime_put_sync(&_gadget->dev);
> > +			dev_dbg(ci->dev, "disconnected from host\n");
> 
> Keep the capital letters at the begining of the sentence consistent -- either 
> start with capital D here or fix the capital C above.
Thanks, I will change "d" to "D".
> 
> >  		}
> >  	}
> 

-- 

Best Regards,
Peter Chen
