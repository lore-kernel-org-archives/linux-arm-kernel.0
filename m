From: mina86@mina86.com (Michal Nazarewicz)
Date: Wed, 08 Jul 2015 15:47:21 +0200
Subject: [PATCH v2 4/5] staging: emxx_udc: add missing
 usb_ep_set_maxpacket_limit()
In-Reply-To: <1436346323-31593-5-git-send-email-r.baldyga@samsung.com>
References: <1436346323-31593-1-git-send-email-r.baldyga@samsung.com>
 <1436346323-31593-5-git-send-email-r.baldyga@samsung.com>
Message-ID: <xa1ta8v6damu.fsf@mina86.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 08 2015, Robert Baldyga wrote:
> Since maxpacket_limit was introduced all UDC drivers should use
> usb_ep_set_maxpacket_limit() function instead of setting maxpacket value
> manually. ep.maxpacket_limit contains actual maximum maxpacket value
> supported by hardware which is needed by epautoconf.
>
> Signed-off-by: Robert Baldyga <r.baldyga@samsung.com>

Acked-by: Michal Nazarewicz <mina86@mina86.com>

> ---
>  drivers/staging/emxx_udc/emxx_udc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/staging/emxx_udc/emxx_udc.c b/drivers/staging/emxx_udc/emxx_udc.c
> index 4178d96..3b7aa36 100644
> --- a/drivers/staging/emxx_udc/emxx_udc.c
> +++ b/drivers/staging/emxx_udc/emxx_udc.c
> @@ -3203,7 +3203,8 @@ static void __init nbu2ss_drv_ep_init(struct nbu2ss_udc *udc)
>  		ep->ep.name = gp_ep_name[i];
>  		ep->ep.ops = &nbu2ss_ep_ops;
>  
> -		ep->ep.maxpacket = (i == 0 ? EP0_PACKETSIZE : EP_PACKETSIZE);
> +		usb_ep_set_maxpacket_limit(&ep->ep,
> +				i == 0 ? EP0_PACKETSIZE : EP_PACKETSIZE);

I would break line just after ( like so:

+		usb_ep_set_maxpacket_limit(
+				&ep->ep, i ? EP_PACKETSIZE : EP0_PACKETSIZE);

>  
>  		list_add_tail(&ep->ep.ep_list, &udc->gadget.ep_list);
>  		INIT_LIST_HEAD(&ep->queue);
> -- 
> 1.9.1
>

-- 
Best regards,                                         _     _
.o. | Liege of Serenely Enlightened Majesty of      o' \,=./ `o
..o | Computer Science,  Micha? ?mina86? Nazarewicz    (o o)
ooo +--<mpn@google.com>--<xmpp:mina86@jabber.org>--ooO--(_)--Ooo--
