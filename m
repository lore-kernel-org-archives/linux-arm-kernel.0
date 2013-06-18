From: balbi@ti.com (Felipe Balbi)
Date: Tue, 18 Jun 2013 11:37:12 +0300
Subject: [PATCH] USB: initialize or shutdown PHY when add or remove host
 controller
In-Reply-To: <51C01B80.3050803@ti.com>
References: <1371539701-11441-1-git-send-email-chao.xie@marvell.com>
 <20130618080130.GC5461@arwen.pp.htv.fi> <51C0191F.2050104@ti.com>
 <20130618082428.GF5461@arwen.pp.htv.fi> <51C01B80.3050803@ti.com>
Message-ID: <20130618083712.GJ5461@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Jun 18, 2013 at 11:34:08AM +0300, Roger Quadros wrote:
> >>> On Tue, Jun 18, 2013 at 03:15:01AM -0400, Chao Xie wrote:
> >>>> Some controller need software to initialize PHY before add
> >>>> host controller, and shut down PHY after remove host controller.
> >>>> Add the generic code for these controllers so they do not need
> >>>> do it in its own host controller driver.
> >>>>
> >>>> Signed-off-by: Chao Xie <chao.xie@marvell.com>
> >>>> ---
> >>>>  drivers/usb/core/hcd.c |   19 ++++++++++++++++++-
> >>>>  1 files changed, 18 insertions(+), 1 deletions(-)
> >>>>
> >>>> diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
> >>>> index d53547d..b26196b 100644
> >>>> --- a/drivers/usb/core/hcd.c
> >>>> +++ b/drivers/usb/core/hcd.c
> >>>> @@ -43,6 +43,7 @@
> >>>>  
> >>>>  #include <linux/usb.h>
> >>>>  #include <linux/usb/hcd.h>
> >>>> +#include <linux/usb/phy.h>
> >>>>  
> >>>>  #include "usb.h"
> >>>>  
> >>>> @@ -2531,12 +2532,22 @@ int usb_add_hcd(struct usb_hcd *hcd,
> >>>>  	 */
> >>>>  	set_bit(HCD_FLAG_RH_RUNNING, &hcd->flags);
> >>>>  
> >>>> +	/* Initialize the PHY before other hardware operation. */
> >>>> +	if (hcd->phy) {
> >>>
> >>> this looks wrong for two reasons:
> >>>
> >>> a) you're not grabbing the PHY here.
> >>>
> >>> 	You can't just assume another entity grabbed your PHY for you.
> >>
> >> Isn't that done in the controller drivers e.g. ehci-fsl.c, ohci-omap, etc?
> > 
> > right, and what I'm saying is that it should all be re-factored into
> > ehci-hcd core :-)
> > 
> >> If the controllers don't want HCD core to manage the PHY they can just set it
> >> to some error code.
> > 
> > they shouldn't have the choice, otherwise it'll be a bit of a PITA to
> > maintain the code. ehci core tries to grab the PHY, if it's not there,
> > try to continue anyway. Assume it's not needed.
> > 
> 
> OK fine, but ehci-omap is a weird case as it needs a slightly different
> sequence as to when PHY is initialized depending on which mode it is. (Transceiver
> or transceiver-less). please see this fix.
> http://www.spinics.net/lists/stable/msg12106.html
> 
> All I'm saying as that ehci-omap needs a way to tell hcd core that it needs PHY
> handling for itself.

why don't you do that always ? Meaning, why don't you *always* take PHY
out of suspend ? If PHY is suspended, you can't wakeup unless you have
(in OMAP case) pad wakeup working, right ?

Moreover, if you can suspend the PHY and still wakup, that's something
we need to teach the PHY layer about. Currently it doesn't know anything
about such wakeup capable PHYs ;-)

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130618/311b1b74/attachment.sig>
