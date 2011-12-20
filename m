From: balbi@ti.com (Felipe Balbi)
Date: Tue, 20 Dec 2011 13:23:19 +0200
Subject: [PATCH 5/8] s3c-hsudc: use udc_start and udc_stop functions
In-Reply-To: <201112191941.45881.heiko@sntech.de>
References: <201112191938.22254.heiko@sntech.de>
 <201112191941.45881.heiko@sntech.de>
Message-ID: <20111220112317.GF31842@legolas.emea.dhcp.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Dec 19, 2011 at 07:41:45PM +0100, Heiko St?bner wrote:
> udc_start and udc_stop reduce code duplication in comparison to
> start and stop generalising calls done by all drivers
> (i.e. bind and unbind) and moving these calls to common code.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  drivers/usb/gadget/s3c-hsudc.c |   44 ++++++++++++---------------------------
>  1 files changed, 14 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/usb/gadget/s3c-hsudc.c b/drivers/usb/gadget/s3c-hsudc.c
> index 8792830..d17cbcf 100644
> --- a/drivers/usb/gadget/s3c-hsudc.c
> +++ b/drivers/usb/gadget/s3c-hsudc.c
> @@ -282,8 +282,7 @@ static void s3c_hsudc_nuke_ep(struct s3c_hsudc_ep *hsep, int status)
>   * All the endpoints are stopped and any pending transfer requests if any on
>   * the endpoint are terminated.
>   */
> -static void s3c_hsudc_stop_activity(struct s3c_hsudc *hsudc,
> -			  struct usb_gadget_driver *driver)
> +static void s3c_hsudc_stop_activity(struct s3c_hsudc *hsudc)
>  {
>  	struct s3c_hsudc_ep *hsep;
>  	int epnum;
> @@ -295,10 +294,6 @@ static void s3c_hsudc_stop_activity(struct s3c_hsudc *hsudc,
>  		hsep->stopped = 1;
>  		s3c_hsudc_nuke_ep(hsep, -ESHUTDOWN);
>  	}
> -
> -	spin_unlock(&hsudc->lock);
> -	driver->disconnect(&hsudc->gadget);
> -	spin_lock(&hsudc->lock);
>  }
>  
>  /**
> @@ -1135,16 +1130,15 @@ static irqreturn_t s3c_hsudc_irq(int irq, void *_dev)
>  	return IRQ_HANDLED;
>  }
>  
> -static int s3c_hsudc_start(struct usb_gadget_driver *driver,
> -		int (*bind)(struct usb_gadget *))
> +static int s3c_hsudc_start(struct usb_gadget *gadget,
> +		struct usb_gadget_driver *driver)
>  {
>  	struct s3c_hsudc *hsudc = the_controller;

I remember commenting that this 'the_controller' global could be
dropped. I will add a patch to this series myself this time otherwise we
will not have time to get this in during 3.3 merge window, but next time
please make sure you fix all comments (or give reasons not to do so)
before sending another version.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20111220/3d738792/attachment-0001.sig>
