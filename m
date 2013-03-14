From: balbi@ti.com (Felipe Balbi)
Date: Thu, 14 Mar 2013 11:00:05 +0200
Subject: [PATCH 14/14] usb: udc-core: add judgement logic for
 usb_gadget_connect
In-Reply-To: <1363240242-25775-15-git-send-email-peter.chen@freescale.com>
References: <1363240242-25775-1-git-send-email-peter.chen@freescale.com>
 <1363240242-25775-15-git-send-email-peter.chen@freescale.com>
Message-ID: <20130314090005.GB14443@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Mar 14, 2013 at 01:50:42PM +0800, Peter Chen wrote:
> - If there is no vbus control to indicate connection.
> and disconnect, we can pullup dp when we load gadget module.
> - If we have vbus control logic, the dp is better pull up
> when there is a vbus session.
> 
> Signed-off-by: Peter Chen <peter.chen@freescale.com>
> ---
>  drivers/usb/gadget/udc-core.c |   10 ++++++++--
>  1 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/gadget/udc-core.c b/drivers/usb/gadget/udc-core.c
> index 4d90bdf..4b56f7c 100644
> --- a/drivers/usb/gadget/udc-core.c
> +++ b/drivers/usb/gadget/udc-core.c
> @@ -278,7 +278,10 @@ static int udc_bind_to_driver(struct usb_udc *udc, struct usb_gadget_driver *dri
>  		driver->unbind(gadget);
>  		goto err1;
>  	}
> -	usb_gadget_connect(gadget);
> +	if (!gadget->ops->vbus_session ||
> +			(gadget->ops->vbus_session
> +				&& gadget->vbus_active))
> +		usb_gadget_connect(gadget);
>  
>  	kobject_uevent(&udc->dev.kobj, KOBJ_CHANGE);
>  	return 0;
> @@ -384,7 +387,10 @@ static ssize_t usb_udc_softconn_store(struct device *dev,
>  
>  	if (sysfs_streq(buf, "connect")) {
>  		usb_gadget_udc_start(gadget, udc->driver);
> -		usb_gadget_connect(gadget);
> +		if (!gadget->ops->vbus_session ||
> +				(gadget->ops->vbus_session
> +					&& gadget->vbus_active))
> +			usb_gadget_connect(gadget);

this patch is incomplete. What happens if this test fails ? Who will
connect pullup then ?

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130314/6cfd0ff2/attachment.sig>
