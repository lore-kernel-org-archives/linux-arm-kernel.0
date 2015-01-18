From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Sun, 18 Jan 2015 18:34:28 +0100
Subject: [PATCH 2/2] USB: gadget: atmel_usba_udc: Enable/disable USB PLL
 on Vbus change
In-Reply-To: <1421592681-28317-3-git-send-email-sylvain.rochet@finsecur.com>
References: <20150117110710.GB24176@gradator.net>
 <1421592681-28317-1-git-send-email-sylvain.rochet@finsecur.com>
 <1421592681-28317-3-git-send-email-sylvain.rochet@finsecur.com>
Message-ID: <20150118183428.0556daac@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 18 Jan 2015 15:51:21 +0100
Sylvain Rochet <sylvain.rochet@finsecur.com> wrote:

> Prepare_enable on rising edge, disable_unprepare on falling edge. Reduce
> power consumption if USB PLL is not already necessary for OHCI or EHCI.
> If USB host is not connected we can sleep with USB PLL stopped.
> 
> This driver does not support suspend/resume yet, not suspending if we
> are still attached to an USB host is fine for what I need, this patch
> allow suspending with USB PLL stopped when USB device is not currently
> used.
> 
> Signed-off-by: Sylvain Rochet <sylvain.rochet@finsecur.com>
> ---
>  drivers/usb/gadget/udc/atmel_usba_udc.c | 95 ++++++++++++++++++++++++---------
>  drivers/usb/gadget/udc/atmel_usba_udc.h |  4 ++
>  2 files changed, 73 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/usb/gadget/udc/atmel_usba_udc.c b/drivers/usb/gadget/udc/atmel_usba_udc.c
> index e207d75..986677b 100644
> --- a/drivers/usb/gadget/udc/atmel_usba_udc.c
> +++ b/drivers/usb/gadget/udc/atmel_usba_udc.c
> @@ -315,6 +315,38 @@ static inline void usba_cleanup_debugfs(struct usba_udc *udc)
>  }
>  #endif
>  

[...]

>  
>  	if (gpio_is_valid(udc->vbus_pin)) {
>  		if (!devm_gpio_request(&pdev->dev, udc->vbus_pin, "atmel_usba_udc")) {
> -			ret = devm_request_irq(&pdev->dev,
> -					gpio_to_irq(udc->vbus_pin),
> -					usba_vbus_irq, 0,
> +			ret = devm_request_threaded_irq(&pdev->dev,
> +					gpio_to_irq(udc->vbus_pin), NULL,
> +					usba_vbus_irq_thread, IRQF_NO_SUSPEND | IRQF_ONESHOT,

You should drop the IRQF_NO_SUSPEND flag. If you want to wakeup on VBUS
change you should use enable_irq_wake instead.



-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
