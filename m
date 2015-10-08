From: chunfeng.yun@mediatek.com (chunfeng yun)
Date: Thu, 8 Oct 2015 20:05:58 +0800
Subject: [PATCH v9 4/5] xhci: mediatek: support MTK xHCI host controller
In-Reply-To: <560D1CA9.1050009@linaro.org>
References: <1443495698-32233-1-git-send-email-chunfeng.yun@mediatek.com>
 <1443495698-32233-5-git-send-email-chunfeng.yun@mediatek.com>
 <560D1CA9.1050009@linaro.org>
Message-ID: <1444305958.26198.14.camel@mhfsdcap03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
On Thu, 2015-10-01 at 12:44 +0100, Daniel Thompson wrote:
> On 29/09/15 04:01, Chunfeng Yun wrote:
> > There some vendor quirks for MTK xhci host controller:
> > 1. It defines some extra SW scheduling parameters for HW
> >    to minimize the scheduling effort for synchronous and
> >    interrupt endpoints. The parameters are put into reseved
> >    DWs of slot context and endpoint context.
> > 2. Its IMODI unit for Interrupter Moderation register is
> >    8 times as much as that defined in xHCI spec.
> > 3. Its TDS in  Normal TRB defines a number of packets that
> >    remains to be transferred for a TD after processing all
> >    Max packets in all previous TRBs.
> >
> > Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> 
> I've done some basic soak tests, both with a directly attached USB3 HDD 
> and, given the extra code to manage isochronous xfer, also with a hub, 
> disc and two audio interfaces.
> 
> Tested-by: Daniel Thompson <daniel.thompson@linaro.org>
> 
> 
> > diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
> > index 57f40a1..243f696 100644
> > --- a/drivers/usb/host/xhci-ring.c
> > +++ b/drivers/usb/host/xhci-ring.c
> > @@ -68,6 +68,7 @@
> >   #include <linux/slab.h>
> >   #include "xhci.h"
> >   #include "xhci-trace.h"
> > +#include "xhci-mtk.h"
> >
> >   /*
> >    * Returns zero if the TRB isn't in this segment, otherwise it returns the DMA
> > @@ -3044,18 +3045,27 @@ static u32 xhci_td_remainder(struct xhci_hcd *xhci, int transferred,
> >   			      struct urb *urb, unsigned int num_trbs_left)
> >   {
> >   	u32 maxp, total_packet_count;
> > +	u32 skip_current_trb = 0;
> 
> A bit of a nitpick but why do we need skip_current_trb? Testing 
> (xhci->quirks & XHCI_MTK_HOST) twice would make what the code does, and 
> why, more obvious.
> 
I am not sure which way it is better, so add variable of
skip_current_trb to reduce test times.

> Anyhow with that looked at, and the caveat that I'm not much of USB 
> expert, you're welcome to add my Reviewed-by: to v10.
> 

Thanks a lot
> >
> > -	if (xhci->hci_version < 0x100)
> > -		return ((td_total_len - transferred) >> 10);
> > -
> > -	maxp = GET_MAX_PACKET(usb_endpoint_maxp(&urb->ep->desc));
> > -	total_packet_count = DIV_ROUND_UP(td_total_len, maxp);
> > +	if (xhci->hci_version < 0x100) {
> > +		/* for MTK xHCI, TD size doesn't include this TRB */
> > +		if (xhci->quirks & XHCI_MTK_HOST)
> > +			skip_current_trb = 1;
> > +		else
> > +			return ((td_total_len - transferred) >> 10);
> > +	}
> >
> >   	/* One TRB with a zero-length data packet. */
> >   	if (num_trbs_left == 0 || (transferred == 0 && trb_buff_len == 0) ||
> >   	    trb_buff_len == td_total_len)
> >   		return 0;
> >
> > +	if (skip_current_trb)
> > +		trb_buff_len = 0;
> > +
> > +	maxp = GET_MAX_PACKET(usb_endpoint_maxp(&urb->ep->desc));
> > +	total_packet_count = DIV_ROUND_UP(td_total_len, maxp);
> > +
> >   	/* Queueing functions don't count the current TRB into transferred */
> >   	return (total_packet_count - ((transferred + trb_buff_len) / maxp));
> >   }
> 
> 
> Daniel.
> 
