From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Fri, 23 Jan 2015 15:43:17 +0800
Subject: [PATCHv6 2/5] USB: gadget: atmel_usba_udc: Request an auto
 disabled Vbus signal IRQ instead of an auto enabled IRQ request followed by
 IRQ disable
In-Reply-To: <1421945805-31129-3-git-send-email-sylvain.rochet@finsecur.com>
References: <1421945805-31129-1-git-send-email-sylvain.rochet@finsecur.com>
 <1421945805-31129-3-git-send-email-sylvain.rochet@finsecur.com>
Message-ID: <0F74BBB2-B515-4A36-8C71-25F58A4D1AB6@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> On Jan 23, 2015, at 12:56 AM, Sylvain Rochet <sylvain.rochet@finsecur.com> wrote:
> 
> Vbus IRQ handler needs a started UDC driver to work because it uses
> udc->driver, which is set by the UDC start handler. The previous way
> chosen was to return from interrupt if udc->driver is NULL using a
> spinlock around the check.
> 
> We now request an auto disabled (IRQ_NOAUTOEN) Vbus signal IRQ instead
> of an auto enabled IRQ followed by disable_irq(). This way we remove the
> very small timeslot of enabled IRQ which existed previously between
> request() and disable(). We don't need anymore to check if udc->driver
> is NULL in IRQ handler.
> 
> Signed-off-by: Sylvain Rochet <sylvain.rochet@finsecur.com>
> Suggested-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> Acked-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> ---
> drivers/usb/gadget/udc/atmel_usba_udc.c | 9 ++-------
> 1 file changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/usb/gadget/udc/atmel_usba_udc.c b/drivers/usb/gadget/udc/atmel_usba_udc.c
> index 40e5fc7..f9f305f 100644
> --- a/drivers/usb/gadget/udc/atmel_usba_udc.c
> +++ b/drivers/usb/gadget/udc/atmel_usba_udc.c
> @@ -1745,10 +1745,6 @@ static irqreturn_t usba_vbus_irq(int irq, void *devid)
> 
> 	spin_lock(&udc->lock);
> 
> -	/* May happen if Vbus pin toggles during probe() */
> -	if (!udc->driver)
> -		goto out;
> -
> 	vbus = vbus_is_present(udc);
> 	if (vbus != udc->vbus_prev) {
> 		if (vbus) {
> @@ -1769,7 +1765,6 @@ static irqreturn_t usba_vbus_irq(int irq, void *devid)
> 		udc->vbus_prev = vbus;
> 	}
> 
> -out:
> 	spin_unlock(&udc->lock);
> 
> 	return IRQ_HANDLED;
> @@ -2109,6 +2104,8 @@ static int usba_udc_probe(struct platform_device *pdev)
> 
> 	if (gpio_is_valid(udc->vbus_pin)) {
> 		if (!devm_gpio_request(&pdev->dev, udc->vbus_pin, "atmel_usba_udc")) {
> +			irq_set_status_flags(gpio_to_irq(udc->vbus_pin),
> +					IRQ_NOAUTOEN);

not happy about still using the broken gpio_to_irq API

Linus can pass the IRQ via board file?

and via DT we can use IRQ directly

Best Regards,
J.
> 			ret = devm_request_irq(&pdev->dev,
> 					gpio_to_irq(udc->vbus_pin),
> 					usba_vbus_irq, 0,
> @@ -2118,8 +2115,6 @@ static int usba_udc_probe(struct platform_device *pdev)
> 				dev_warn(&udc->pdev->dev,
> 					 "failed to request vbus irq; "
> 					 "assuming always on\n");
> -			} else {
> -				disable_irq(gpio_to_irq(udc->vbus_pin));
> 			}
> 		} else {
> 			/* gpio_request fail so use -EINVAL for gpio_is_valid */
> -- 
> 2.1.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
