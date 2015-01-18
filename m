From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Sun, 18 Jan 2015 17:56:21 +0100
Subject: [PATCH 2/2] USB: gadget: atmel_usba_udc: Enable/disable USB PLL
 on Vbus change
In-Reply-To: <1421592681-28317-3-git-send-email-sylvain.rochet@finsecur.com>
References: <20150117110710.GB24176@gradator.net>
 <1421592681-28317-1-git-send-email-sylvain.rochet@finsecur.com>
 <1421592681-28317-3-git-send-email-sylvain.rochet@finsecur.com>
Message-ID: <20150118175621.6b519cdc@bbrezillon>
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
> +static int start_clock(struct usba_udc *udc)
> +{
> +	int ret;
> +
> +	if (udc->clocked)
> +		return 0;
> +
> +	ret = clk_prepare_enable(udc->pclk);
> +	if (ret)
> +		return ret;
> +	ret = clk_prepare_enable(udc->hclk);
> +	if (ret) {
> +		clk_disable_unprepare(udc->pclk);
> +		return ret;
> +	}
> +
> +	udc->clocked = true;
> +	return ret;
> +}
> +
> +static int stop_clock(struct usba_udc *udc)
> +{
> +	if (!udc->clocked)
> +		return 0;
> +
> +	clk_disable_unprepare(udc->hclk);
> +	clk_disable_unprepare(udc->pclk);
> +
> +	udc->clocked = false;
> +	return 0;
> +}
> +
>  static int vbus_is_present(struct usba_udc *udc)
>  {
>  	if (gpio_is_valid(udc->vbus_pin))
> @@ -1719,42 +1751,55 @@ static irqreturn_t usba_udc_irq(int irq, void *devid)
>  	return IRQ_HANDLED;
>  }
>  
> -static irqreturn_t usba_vbus_irq(int irq, void *devid)
> +static irqreturn_t usba_vbus_irq_thread(int irq, void *devid)
>  {
>  	struct usba_udc *udc = devid;
>  	int vbus;
> +	int ret;
>  
>  	/* debounce */
>  	udelay(10);
>  
> -	spin_lock(&udc->lock);
> +	mutex_lock(&udc->vbus_mutex);
>  
>  	/* May happen if Vbus pin toggles during probe() */
> -	if (!udc->driver)
> +	spin_lock(&udc->lock);

Since this lock is taken in irq context (usba_udc_irq) and this
handler is not called in irq context anymore you should use
spin_lock_irqsave/unlock_irqrestore here.

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
