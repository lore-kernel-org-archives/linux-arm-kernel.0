From: balbi@ti.com (Felipe Balbi)
Date: Tue, 20 Dec 2011 13:29:31 +0200
Subject: [PATCH 8/8] s3c-hsudc: remove the_controller global
In-Reply-To: <201112191943.35591.heiko@sntech.de>
References: <201112191938.22254.heiko@sntech.de>
 <201112191943.35591.heiko@sntech.de>
Message-ID: <20111220112930.GI31842@legolas.emea.dhcp.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 19, 2011 at 07:43:35PM +0100, Heiko St?bner wrote:
> Instead use container_of to retrieve the s3c_hsudc from the
> struct usb_gadget pointer.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  drivers/usb/gadget/s3c-hsudc.c |   11 ++++++-----
>  1 files changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/usb/gadget/s3c-hsudc.c b/drivers/usb/gadget/s3c-hsudc.c
> index 8e69758..23cac9d 100644
> --- a/drivers/usb/gadget/s3c-hsudc.c
> +++ b/drivers/usb/gadget/s3c-hsudc.c
> @@ -161,7 +161,6 @@ struct s3c_hsudc {
>  #define ep_index(_ep)		((_ep)->bEndpointAddress & \
>  					USB_ENDPOINT_NUMBER_MASK)
>  
> -static struct s3c_hsudc *the_controller;
>  static const char driver_name[] = "s3c-udc";
>  static const char ep0name[] = "ep0-control";
>  
> @@ -1141,7 +1140,8 @@ static irqreturn_t s3c_hsudc_irq(int irq, void *_dev)
>  static int s3c_hsudc_start(struct usb_gadget *gadget,
>  		struct usb_gadget_driver *driver)
>  {
> -	struct s3c_hsudc *hsudc = the_controller;
> +	struct s3c_hsudc *hsudc =
> +			container_of(gadget, struct s3c_hsudc, gadget);

I have changed all these container_of() to your to_hsudc() helper
function.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20111220/e3d28962/attachment.sig>
