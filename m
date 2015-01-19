From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 19 Jan 2015 17:55:18 +0100
Subject: [PATCHv3 2/2] USB: gadget: atmel_usba_udc: Enable/disable USB
 PLL on Vbus change
In-Reply-To: <1421601875-9436-3-git-send-email-sylvain.rochet@finsecur.com>
References: <20150118175621.6b519cdc@bbrezillon>
 <1421601875-9436-1-git-send-email-sylvain.rochet@finsecur.com>
 <1421601875-9436-3-git-send-email-sylvain.rochet@finsecur.com>
Message-ID: <54BD36F6.8030408@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 18/01/2015 18:24, Sylvain Rochet a ?crit :
> Prepare_enable on rising edge, disable_unprepare on falling edge. Reduce

Please re-write which "edge" we are talking about: "... falling edge of
the Vbus signal" for example.

> power consumption if USB PLL is not already necessary for OHCI or EHCI.

Is a verb missing in the previous sentence?

> If USB host is not connected we can sleep with USB PLL stopped.
> 
> This driver does not support suspend/resume yet, not suspending if we
> are still attached to an USB host is fine for what I need, this patch
> allow suspending with USB PLL stopped when USB device is not currently
> used.

Can you please make it more clear. Several separated sentences seem
necessary here.

> Signed-off-by: Sylvain Rochet <sylvain.rochet@finsecur.com>
> ---
>  drivers/usb/gadget/udc/atmel_usba_udc.c | 96 ++++++++++++++++++++++++---------
>  drivers/usb/gadget/udc/atmel_usba_udc.h |  4 ++
>  2 files changed, 74 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/usb/gadget/udc/atmel_usba_udc.c b/drivers/usb/gadget/udc/atmel_usba_udc.c
> index e207d75..9cce50a 100644
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
> @@ -1719,42 +1751,56 @@ static irqreturn_t usba_udc_irq(int irq, void *devid)
>  	return IRQ_HANDLED;
>  }
>  
> -static irqreturn_t usba_vbus_irq(int irq, void *devid)
> +static irqreturn_t usba_vbus_irq_thread(int irq, void *devid)
>  {
>  	struct usba_udc *udc = devid;
>  	int vbus;
> +	int ret;
> +	unsigned long flags;
>  
>  	/* debounce */
>  	udelay(10);
>  
> -	spin_lock(&udc->lock);
> +	mutex_lock(&udc->vbus_mutex);
>  
>  	/* May happen if Vbus pin toggles during probe() */
> -	if (!udc->driver)
> +	spin_lock_irqsave(&udc->lock, flags);
> +	if (!udc->driver) {
> +		spin_unlock_irqrestore(&udc->lock, flags);
>  		goto out;
> +	}
> +	spin_unlock_irqrestore(&udc->lock, flags);

I'm not sure that the protection by spin_lock is needed above.

>  
>  	vbus = vbus_is_present(udc);
>  	if (vbus != udc->vbus_prev) {
>  		if (vbus) {
> +			ret = start_clock(udc);
> +			if (ret)
> +				goto out;
> +
> +			spin_lock_irqsave(&udc->lock, flags);
>  			toggle_bias(1);
>  			usba_writel(udc, CTRL, USBA_ENABLE_MASK);
>  			usba_writel(udc, INT_ENB, USBA_END_OF_RESET);
> +			spin_unlock_irqrestore(&udc->lock, flags);
>  		} else {
> +			spin_lock_irqsave(&udc->lock, flags);
>  			udc->gadget.speed = USB_SPEED_UNKNOWN;
>  			reset_all_endpoints(udc);
>  			toggle_bias(0);
>  			usba_writel(udc, CTRL, USBA_DISABLE_MASK);
> -			if (udc->driver->disconnect) {
> -				spin_unlock(&udc->lock);
> +			spin_unlock_irqrestore(&udc->lock, flags);
> +
> +			stop_clock(udc);
> +
> +			if (udc->driver->disconnect)
>  				udc->driver->disconnect(&udc->gadget);
> -				spin_lock(&udc->lock);
> -			}
>  		}
>  		udc->vbus_prev = vbus;
>  	}
>  
>  out:
> -	spin_unlock(&udc->lock);
> +	mutex_unlock(&udc->vbus_mutex);
>  
>  	return IRQ_HANDLED;
>  }
> @@ -1762,7 +1808,7 @@ out:
>  static int atmel_usba_start(struct usb_gadget *gadget,
>  		struct usb_gadget_driver *driver)
>  {
> -	int ret;
> +	int ret = 0;
>  	struct usba_udc *udc = container_of(gadget, struct usba_udc, gadget);
>  	unsigned long flags;
>  
> @@ -1772,31 +1818,29 @@ static int atmel_usba_start(struct usb_gadget *gadget,
>  	udc->driver = driver;
>  	spin_unlock_irqrestore(&udc->lock, flags);
>  
> -	ret = clk_prepare_enable(udc->pclk);
> -	if (ret)
> -		return ret;
> -	ret = clk_prepare_enable(udc->hclk);
> -	if (ret) {
> -		clk_disable_unprepare(udc->pclk);
> -		return ret;
> -	}
> -
> +	mutex_lock(&udc->vbus_mutex);
>  	udc->vbus_prev = 0;
>  	if (gpio_is_valid(udc->vbus_pin))
>  		enable_irq(gpio_to_irq(udc->vbus_pin));
>  
>  	/* If Vbus is present, enable the controller and wait for reset */
> -	spin_lock_irqsave(&udc->lock, flags);
>  	if (vbus_is_present(udc) && udc->vbus_prev == 0) {
> +		ret = start_clock(udc);
> +		if (ret)
> +			goto out;
> +
> +		spin_lock_irqsave(&udc->lock, flags);
>  		toggle_bias(1);
>  		usba_writel(udc, CTRL, USBA_ENABLE_MASK);
>  		usba_writel(udc, INT_ENB, USBA_END_OF_RESET);
> +		spin_unlock_irqrestore(&udc->lock, flags);
>  
>  		udc->vbus_prev = 1;
>  	}
> -	spin_unlock_irqrestore(&udc->lock, flags);
>  
> -	return 0;
> +out:
> +	mutex_unlock(&udc->vbus_mutex);
> +	return ret;
>  }
>  
>  static int atmel_usba_stop(struct usb_gadget *gadget)
> @@ -1816,8 +1860,7 @@ static int atmel_usba_stop(struct usb_gadget *gadget)
>  	toggle_bias(0);
>  	usba_writel(udc, CTRL, USBA_DISABLE_MASK);
>  
> -	clk_disable_unprepare(udc->hclk);
> -	clk_disable_unprepare(udc->pclk);
> +	stop_clock(udc);
>  
>  	udc->driver = NULL;
>  
> @@ -1997,6 +2040,7 @@ static int usba_udc_probe(struct platform_device *pdev)
>  		return PTR_ERR(hclk);
>  
>  	spin_lock_init(&udc->lock);
> +	mutex_init(&udc->vbus_mutex);
>  	udc->pdev = pdev;
>  	udc->pclk = pclk;
>  	udc->hclk = hclk;
> @@ -2049,9 +2093,9 @@ static int usba_udc_probe(struct platform_device *pdev)
>  
>  	if (gpio_is_valid(udc->vbus_pin)) {
>  		if (!devm_gpio_request(&pdev->dev, udc->vbus_pin, "atmel_usba_udc")) {
> -			ret = devm_request_irq(&pdev->dev,
> -					gpio_to_irq(udc->vbus_pin),
> -					usba_vbus_irq, 0,
> +			ret = devm_request_threaded_irq(&pdev->dev,
> +					gpio_to_irq(udc->vbus_pin), NULL,
> +					usba_vbus_irq_thread, IRQF_ONESHOT,
>  					"atmel_usba_udc", udc);
>  			if (ret) {
>  				udc->vbus_pin = -ENODEV;
> diff --git a/drivers/usb/gadget/udc/atmel_usba_udc.h b/drivers/usb/gadget/udc/atmel_usba_udc.h
> index a70706e..3ceed76 100644
> --- a/drivers/usb/gadget/udc/atmel_usba_udc.h
> +++ b/drivers/usb/gadget/udc/atmel_usba_udc.h
> @@ -308,6 +308,9 @@ struct usba_udc {
>  	/* Protect hw registers from concurrent modifications */
>  	spinlock_t lock;
>  
> +	/* Mutex to prevent concurrent start or stop */
> +	struct mutex vbus_mutex;
> +
>  	void __iomem *regs;
>  	void __iomem *fifo;
>  
> @@ -321,6 +324,7 @@ struct usba_udc {
>  	struct clk *pclk;
>  	struct clk *hclk;
>  	struct usba_ep *usba_ep;
> +	bool clocked;
>  
>  	u16 devstatus;

Otherwise, it looks okay, so once little corrections done, you can add my:
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

Thanks, bye,
-- 
Nicolas Ferre
