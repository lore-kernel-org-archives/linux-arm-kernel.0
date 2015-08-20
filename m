From: balbi@ti.com (Felipe Balbi)
Date: Thu, 20 Aug 2015 11:48:08 -0500
Subject: [PATCH v5 01/46] usb: gadget: encapsulate endpoint claiming
 mechanism
In-Reply-To: <55D6001E.3000504@hackerion.com>
References: <1438351258-31578-1-git-send-email-r.baldyga@samsung.com>
 <1438351258-31578-2-git-send-email-r.baldyga@samsung.com>
 <20150820153553.GD1639@saruman.tx.rr.com>
 <55D6001E.3000504@hackerion.com>
Message-ID: <20150820164808.GB4938@saruman.tx.rr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 20, 2015 at 06:28:14PM +0200, Robert Baldyga wrote:
> Hi Felipe,
> 
> On 08/20/2015 05:35 PM, Felipe Balbi wrote:
> [...]
> >just letting you know that this regresses all gadget drivers making them
> >try to disable previously disabled endpoints and enable previously
> >enabled endpoints.
> >
> >I have a possible fix (see below) but then it shows a problem on the
> >host side when using with g_zero (see further below):
> >
> >commit 3b8932100aacb6cfbffe288ca93025d8b8430c00
> >Author: Felipe Balbi <balbi@ti.com>
> >Date:   Wed Aug 19 18:05:27 2015 -0500
> >
> >     usb: gadget: fix ep->claimed lifetime
> >
> >     In order to fix a regression introduced by commit
> >     cc476b42a39d ("usb: gadget: encapsulate endpoint
> >     claiming mechanism") we have to introduce a simple
> >     helper to check if a particular is enabled or not.
> >
> >     After that, we need to move ep->claimed lifetime to
> >     usb_ep_enable() and usb_ep_disable() since those
> >     are the only functions which actually enable and
> >     disable endpoints.
> >
> >     A follow-up patch will come to drop all driver_data
> >     checks from function drivers, since those are, now,
> >     pointless.
> >
> >     Fixes: cc476b42a39d ("usb: gadget: encapsulate endpoint
> >     	claiming mechanism")
> >     Cc: Robert Baldyga <r.baldyga@samsung.com>
> >     Signed-off-by: Felipe Balbi <balbi@ti.com>
> >
> >diff --git a/drivers/usb/gadget/epautoconf.c b/drivers/usb/gadget/epautoconf.c
> >index 978435a51038..ad45070cd76f 100644
> >--- a/drivers/usb/gadget/epautoconf.c
> >+++ b/drivers/usb/gadget/epautoconf.c
> >@@ -126,7 +126,6 @@ found_ep:
> >  	ep->address = desc->bEndpointAddress;
> >  	ep->desc = NULL;
> >  	ep->comp_desc = NULL;
> >-	ep->claimed = true;
> 
> Removing this line causes autoconfig can return the same endpoint many
> times. This probably causes problems with g_zero.
> 
> I will try to fix it ASAP.

I was considering the same thing, but the lifetime of ->claimed doesn't
look correct to me either way. Note that once the flag is enabled, it
won't get disabled by most gadget drivers.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150820/e52d8009/attachment-0001.sig>
