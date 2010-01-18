From: ryan@bluewatersys.com (Ryan Mallon)
Date: Tue, 19 Jan 2010 09:40:20 +1300
Subject: [PATCH] Updated: Fix soft lockup in at91 udc driver
In-Reply-To: <4B4F7576.9090008@bluewatersys.com>
References: <4B4F7576.9090008@bluewatersys.com>
Message-ID: <4B54C734.7090409@bluewatersys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ryan Mallon wrote:
> Fix a potential soft lockup in the AT91 UDC driver by ensuring that the
> UDC clock is enabled inside the interrupt handler. If the UDC clock is
> not enabled then the UDC registers cannot be written to and the
> interrupt cannot be cleared or masked.
> 
> Note that this patch (and other parts of the existing AT91 UDC driver)
> is potentially racy for preempt-rt kernels, but is okay for mainline.
> 
> Signed-off-by: Ryan Mallon <ryan@bluewatersys.com>
> Tested-by: Remy Bohmer <linux@bohmer.net>
> Cc: Andrew Victor <avictor.za@gmail.com>
> Cc: David Brownell <dbrownell@users.sourceforge.net>

Is somebody able to give me an Acked-by for this patch. It has been
verified to correct a soft-lockup issue, and I don't want it getting
lost for another year :-).

Thanks,
~Ryan

> ----
> 
> diff --git a/drivers/usb/gadget/at91_udc.c b/drivers/usb/gadget/at91_udc.c
> index c4997e9..5ba8319 100644
> --- a/drivers/usb/gadget/at91_udc.c
> +++ b/drivers/usb/gadget/at91_udc.c
> @@ -1370,6 +1370,12 @@ static irqreturn_t at91_udc_irq (int irq, void *_udc)
>  {
>  	struct at91_udc		*udc = _udc;
>  	u32			rescans = 5;
> +	int			disable_clock = 0;
> +
> +	if (!udc->clocked) {
> +		clk_on(udc);
> +		disable_clock = 1;
> +	}
>  
>  	while (rescans--) {
>  		u32 status;
> @@ -1458,6 +1464,9 @@ static irqreturn_t at91_udc_irq (int irq, void *_udc)
>  		}
>  	}
>  
> +	if (disable_clock)
> +		clk_off(udc);
> +
>  	return IRQ_HANDLED;
>  }
>  
> 
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel


-- 
Bluewater Systems Ltd - ARM Technology Solution Centre

Ryan Mallon         		5 Amuri Park, 404 Barbadoes St
ryan at bluewatersys.com         	PO Box 13 889, Christchurch 8013
http://www.bluewatersys.com	New Zealand
Phone: +64 3 3779127		Freecall: Australia 1800 148 751
Fax:   +64 3 3779135			  USA 1800 261 2934
