From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Tue, 14 Jul 2015 14:11:02 +0300
Subject: [PATCH v2 47/48] usb: musb: gadget: add musb_match_ep() function
In-Reply-To: <1436866776-5004-48-git-send-email-r.baldyga@samsung.com>
References: <1436866776-5004-1-git-send-email-r.baldyga@samsung.com>
 <1436866776-5004-48-git-send-email-r.baldyga@samsung.com>
Message-ID: <55A4EE46.6000402@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 7/14/2015 12:39 PM, Robert Baldyga wrote:

> Add 'match_ep' callback to utilize chip-specific knowledge in endpoint matching
> process. Functions does the same that was done by chip-specific code inside
> of epautoconf. Now this code can be removed from there to separate generic code
> from platform specific logic.

> Signed-off-by: Robert Baldyga <r.baldyga@samsung.com>

[...]
> diff --git a/drivers/usb/musb/musb_gadget.c b/drivers/usb/musb/musb_gadget.c
> index 043248a..5f1eb35 100644
> --- a/drivers/usb/musb/musb_gadget.c
> +++ b/drivers/usb/musb/musb_gadget.c
> @@ -1684,6 +1684,49 @@ static int musb_gadget_pullup(struct usb_gadget *gadget, int is_on)
>   	return 0;
>   }
>
> +#ifdef CONFIG_BLACKFIN
> +static struct usb_ep *musb_find_ep(struct usb_gadget *g,
> +		const char *name)
> +{
> +	struct usb_ep *ep;
> +
> +	list_for_each_entry(ep, &g->ep_list, ep_list) {
> +		if (0 == strcmp(ep->name, name))

    Please make the immediate value the 2nd operand of ==.

> +			return ep;
> +	}
> +
> +	return NULL;
> +}
> +
> +static struct usb_ep *match_match_ep(struct usb_gadget *g,
> +		struct usb_endpoint_descriptor *desc,
> +		struct usb_ss_ep_comp_descriptor *ep_comp)
> +{
> +	struct usb_ep *ep = NULL;
> +	u8 type = usb_endpoint_type(desc);
> +
> +	if ((USB_ENDPOINT_XFER_BULK == type) ||
> +			(USB_ENDPOINT_XFER_ISOC == type)) {

    Likewise.

> +		if (USB_DIR_IN & desc->bEndpointAddress)

    The same about &.

> +			ep = musb_find_ep(g, "ep5in");
> +		else
> +			ep = musb_find_ep(g, "ep6out");
> +	} else if (USB_ENDPOINT_XFER_INT == type) {

    Likewise.

> +		if (USB_DIR_IN & desc->bEndpointAddress)
> +			ep = musb_find_ep(g, "ep1in");
> +		else
> +			ep = musb_find_ep(g, "ep2out");
> +	}

    This string of *if* statements is asking to be *switch* instead.

[...]

WBR, Sergei
