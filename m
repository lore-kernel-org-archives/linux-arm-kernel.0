From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Wed, 21 Jan 2015 10:20:16 +0100
Subject: [PATCHv4 2/3] USB: gadget: atmel_usba_udc: Enable Vbus signal
 IRQ in UDC start instead of UDC probe
In-Reply-To: <1421789010-21900-3-git-send-email-sylvain.rochet@finsecur.com>
References: <1421789010-21900-1-git-send-email-sylvain.rochet@finsecur.com>
 <1421789010-21900-3-git-send-email-sylvain.rochet@finsecur.com>
Message-ID: <20150121102016.064a33ce@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sylvain,

On Tue, 20 Jan 2015 22:23:29 +0100
Sylvain Rochet <sylvain.rochet@finsecur.com> wrote:

> Vbus IRQ handler needs a started UDC driver to work because it uses
> udc->driver, which is set by the UDC start handler. The previous way
> chosen was to return from interrupt if udc->driver is NULL using a
> spinlock.
> 
> This patch now request the Vbus signal IRQ in UDC start instead of UDC
> probe and release the IRQ in UDC stop before udc->driver is set back to
> NULL. This way we don't need the check about udc->driver in interruption
> handler, therefore we don't need the spinlock as well anymore.
> 
> This was chosen against using set_irq_flags() to request a not auto
> enabled IRQ (IRQF_NOAUTOEN flag) because set_irq_flags() can't change
> just one flag, therefore it must be called with all flags, without
> respecting what the AIC previously did. Naively copying IRQ flags
> currently set by the AIC looked like error-prone if defaults flags
> change at some point in the future.
> 
> Signed-off-by: Sylvain Rochet <sylvain.rochet@finsecur.com>
> Suggested-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> ---
>  drivers/usb/gadget/udc/atmel_usba_udc.c | 64 ++++++++++++++++-----------------
>  1 file changed, 32 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/usb/gadget/udc/atmel_usba_udc.c b/drivers/usb/gadget/udc/atmel_usba_udc.c
> index e207d75..546da63 100644
> --- a/drivers/usb/gadget/udc/atmel_usba_udc.c
> +++ b/drivers/usb/gadget/udc/atmel_usba_udc.c
> @@ -1729,10 +1729,6 @@ static irqreturn_t usba_vbus_irq(int irq, void *devid)
>  
>  	spin_lock(&udc->lock);
>  
> -	/* May happen if Vbus pin toggles during probe() */
> -	if (!udc->driver)
> -		goto out;
> -
>  	vbus = vbus_is_present(udc);
>  	if (vbus != udc->vbus_prev) {
>  		if (vbus) {
> @@ -1753,7 +1749,6 @@ static irqreturn_t usba_vbus_irq(int irq, void *devid)
>  		udc->vbus_prev = vbus;
>  	}
>  
> -out:
>  	spin_unlock(&udc->lock);
>  
>  	return IRQ_HANDLED;
> @@ -1767,23 +1762,27 @@ static int atmel_usba_start(struct usb_gadget *gadget,
>  	unsigned long flags;
>  
>  	spin_lock_irqsave(&udc->lock, flags);
> -
>  	udc->devstatus = 1 << USB_DEVICE_SELF_POWERED;
>  	udc->driver = driver;
>  	spin_unlock_irqrestore(&udc->lock, flags);
>  
>  	ret = clk_prepare_enable(udc->pclk);
>  	if (ret)
> -		return ret;
> +		goto err_pclk;
>  	ret = clk_prepare_enable(udc->hclk);
> -	if (ret) {
> -		clk_disable_unprepare(udc->pclk);
> -		return ret;
> -	}
> +	if (ret)
> +		goto err_hclk;
>  
>  	udc->vbus_prev = 0;
> -	if (gpio_is_valid(udc->vbus_pin))
> -		enable_irq(gpio_to_irq(udc->vbus_pin));
> +	if (gpio_is_valid(udc->vbus_pin)) {
> +		ret = request_irq(gpio_to_irq(udc->vbus_pin),
> +				usba_vbus_irq, 0,
> +				"atmel_usba_udc", udc);
> +		if (ret) {
> +			udc->vbus_pin = -ENODEV;

I guess you're trying to protect against free_irq by changing the
vbus_pin value (making it an invalid gpio id), but I think you should
leave it unchanged for two reasons:
1) If the request_irq call temporary fails (an ENOMEM for example) then
you should be able to retry later, and modifying the vbus_pin value
will prevent that.
2) atmel_usba_stop will never be called if the atmel_usba_start failed,
so there's no need to protect against this free_irq.

Best Regards,

Boris

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
