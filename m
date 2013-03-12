From: balbi@ti.com (Felipe Balbi)
Date: Tue, 12 Mar 2013 11:47:37 +0200
Subject: [RFC PATCH 3/3] usb: udc-core: add judgement logic for
 usb_gadget_connect
In-Reply-To: <1363078999-7361-3-git-send-email-peter.chen@freescale.com>
References: <1363078999-7361-1-git-send-email-peter.chen@freescale.com>
 <1363078999-7361-3-git-send-email-peter.chen@freescale.com>
Message-ID: <20130312094737.GD15163@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 12, 2013 at 05:03:19PM +0800, Peter Chen wrote:
> - If there is no vbus control to indicate connection
> and disconnect, we can pullup dp when we load gadget module.
> - If we have vbus control logic, the dp is better pulled up
> when there is a vbus session.
> 
> Signed-off-by: Peter Chen <peter.chen@freescale.com>
> ---
>  drivers/usb/gadget/udc-core.c |   24 ++++++++++++++++--------
>  1 files changed, 16 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/usb/gadget/udc-core.c b/drivers/usb/gadget/udc-core.c
> index 2a9cd36..4b56f7c 100644
> --- a/drivers/usb/gadget/udc-core.c
> +++ b/drivers/usb/gadget/udc-core.c
> @@ -262,6 +262,7 @@ EXPORT_SYMBOL_GPL(usb_del_gadget_udc);
>  static int udc_bind_to_driver(struct usb_udc *udc, struct usb_gadget_driver *driver)
>  {
>  	int ret;
> +	struct usb_gadget *gadget = udc->gadget;
>  
>  	dev_dbg(&udc->dev, "registering UDC driver [%s]\n",
>  			driver->function);
> @@ -269,15 +270,18 @@ static int udc_bind_to_driver(struct usb_udc *udc, struct usb_gadget_driver *dri
>  	udc->driver = driver;
>  	udc->dev.driver = &driver->driver;
>  
> -	ret = driver->bind(udc->gadget, driver);
> +	ret = driver->bind(gadget, driver);

this small cleanup (s/udc->gadget/gadget) deserves a separate patch.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130312/428625d4/attachment.sig>
