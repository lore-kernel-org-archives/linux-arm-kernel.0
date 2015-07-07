From: dan.carpenter@oracle.com (Dan Carpenter)
Date: Tue, 7 Jul 2015 18:01:57 +0300
Subject: [PATCH 3/5] usb: isp1760: udc: add missing
 usb_ep_set_maxpacket_limit()
In-Reply-To: <1436277773-14274-4-git-send-email-r.baldyga@samsung.com>
References: <1436277773-14274-1-git-send-email-r.baldyga@samsung.com>
 <1436277773-14274-4-git-send-email-r.baldyga@samsung.com>
Message-ID: <20150707150156.GE4341@mwanda>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 07, 2015 at 04:02:51PM +0200, Robert Baldyga wrote:
> Should use usb_ep_set_maxpacket_limit instead of setting
> maxpacket value manually.
> 

This is a behavior change, right, since now we're setting
ep->ep.maxpacket and ep->ep.maxpacket_limit where before we only set
the first.  I don't understand.  This patch description is not clear.

regards,
dan carpenter

> Signed-off-by: Robert Baldyga <r.baldyga@samsung.com>
> ---
>  drivers/usb/isp1760/isp1760-udc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/isp1760/isp1760-udc.c b/drivers/usb/isp1760/isp1760-udc.c
> index 18ebf5b1..3699962 100644
> --- a/drivers/usb/isp1760/isp1760-udc.c
> +++ b/drivers/usb/isp1760/isp1760-udc.c
> @@ -1382,11 +1382,11 @@ static void isp1760_udc_init_eps(struct isp1760_udc *udc)
>  		 * This fits in the 8kB FIFO without double-buffering.
>  		 */
>  		if (ep_num == 0) {
> -			ep->ep.maxpacket = 64;
> +			usb_ep_set_maxpacket_limit(&ep->ep, 64);
>  			ep->maxpacket = 64;
>  			udc->gadget.ep0 = &ep->ep;
>  		} else {
> -			ep->ep.maxpacket = 512;
> +			usb_ep_set_maxpacket_limit(&ep->ep, 512);
>  			ep->maxpacket = 0;
>  			list_add_tail(&ep->ep.ep_list, &udc->gadget.ep_list);
>  		}
