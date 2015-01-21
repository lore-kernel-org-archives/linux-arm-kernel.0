From: sylvain.rochet@finsecur.com (Sylvain Rochet)
Date: Wed, 21 Jan 2015 14:18:37 +0100
Subject: [PATCHv4 2/3] USB: gadget: atmel_usba_udc: Enable Vbus signal
 IRQ in UDC start instead of UDC probe
In-Reply-To: <20150121102016.064a33ce@bbrezillon>
References: <1421789010-21900-1-git-send-email-sylvain.rochet@finsecur.com>
 <1421789010-21900-3-git-send-email-sylvain.rochet@finsecur.com>
 <20150121102016.064a33ce@bbrezillon>
Message-ID: <20150121131837.GA12825@gradator.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Boris,

On Wed, Jan 21, 2015 at 10:20:16AM +0100, Boris Brezillon wrote:
> >  
> >  	udc->vbus_prev = 0;
> > -	if (gpio_is_valid(udc->vbus_pin))
> > -		enable_irq(gpio_to_irq(udc->vbus_pin));
> > +	if (gpio_is_valid(udc->vbus_pin)) {
> > +		ret = request_irq(gpio_to_irq(udc->vbus_pin),
> > +				usba_vbus_irq, 0,
> > +				"atmel_usba_udc", udc);
> > +		if (ret) {
> > +			udc->vbus_pin = -ENODEV;
> 
> I guess you're trying to protect against free_irq by changing the
> vbus_pin value (making it an invalid gpio id), but I think you should
> leave it unchanged for two reasons:
> 1) If the request_irq call temporary fails (an ENOMEM for example) then
> you should be able to retry later, and modifying the vbus_pin value
> will prevent that.
> 2) atmel_usba_stop will never be called if the atmel_usba_start failed,
> so there's no need to protect against this free_irq.

Indeed.

By the way, I just discovered irq_set_status_flags(irq, IRQ_NOAUTOEN); ? 
so I am going for a v5 and the previous part is not relevant anymore.

Sylvain
