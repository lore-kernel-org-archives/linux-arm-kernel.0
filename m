From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Fri, 8 Aug 2014 00:32:56 +0200
Subject: [PATCH v2] usb: gadget: at91_udc: move prepare clk into process
 context
In-Reply-To: <53E39A0E.8020008@raritan.com>
References: <1407424296-12359-1-git-send-email-ronald.wahl@raritan.com>
 <53E39A0E.8020008@raritan.com>
Message-ID: <20140807223256.GM3214@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

For the next revision, please include the changelog after the --- marker
and before the diffstat. Else, this looks good to me, with the same
comment as Boris on the PLLB gating. We will take care of that later.

Regards

On 07/08/2014 at 17:23:58 +0200, Ronald Wahl wrote :
> Hi,
> 
> actually this should have been patch v3 and not v2. Anyway, the
> major difference is that I moved setting the clock rate into process
> context as well as it may also sleep.
> 
> - ron
> 
> On 07.08.2014 17:11, Ronald Wahl wrote:
> >Commit 7628083227b6bc4a7e33d7c381d7a4e558424b6b added clock preparation in
> >interrupt context. This is not allowed as it might sleep. Move clock
> >preparation and setting clock rate into process context (at91udc_probe).
> >
> >Signed-off-by: Ronald Wahl <ronald.wahl@raritan.com>
> >---
> >  drivers/usb/gadget/udc/at91_udc.c | 44 ++++++++++++++++++++++++++++-----------
> >  1 file changed, 32 insertions(+), 12 deletions(-)
> >
> >diff --git a/drivers/usb/gadget/udc/at91_udc.c b/drivers/usb/gadget/udc/at91_udc.c
> >index cfd18bc..0d685d0 100644
> >--- a/drivers/usb/gadget/udc/at91_udc.c
> >+++ b/drivers/usb/gadget/udc/at91_udc.c
> >@@ -870,12 +870,10 @@ static void clk_on(struct at91_udc *udc)
> >  		return;
> >  	udc->clocked = 1;
> >
> >-	if (IS_ENABLED(CONFIG_COMMON_CLK)) {
> >-		clk_set_rate(udc->uclk, 48000000);
> >-		clk_prepare_enable(udc->uclk);
> >-	}
> >-	clk_prepare_enable(udc->iclk);
> >-	clk_prepare_enable(udc->fclk);
> >+	if (IS_ENABLED(CONFIG_COMMON_CLK))
> >+		clk_enable(udc->uclk);
> >+	clk_enable(udc->iclk);
> >+	clk_enable(udc->fclk);
> >  }
> >
> >  static void clk_off(struct at91_udc *udc)
> >@@ -884,10 +882,10 @@ static void clk_off(struct at91_udc *udc)
> >  		return;
> >  	udc->clocked = 0;
> >  	udc->gadget.speed = USB_SPEED_UNKNOWN;
> >-	clk_disable_unprepare(udc->fclk);
> >-	clk_disable_unprepare(udc->iclk);
> >+	clk_disable(udc->fclk);
> >+	clk_disable(udc->iclk);
> >  	if (IS_ENABLED(CONFIG_COMMON_CLK))
> >-		clk_disable_unprepare(udc->uclk);
> >+		clk_disable(udc->uclk);
> >  }
> >
> >  /*
> >@@ -1780,14 +1778,24 @@ static int at91udc_probe(struct platform_device *pdev)
> >  	}
> >
> >  	/* don't do anything until we have both gadget driver and VBUS */
> >+	if (IS_ENABLED(CONFIG_COMMON_CLK)) {
> >+		clk_set_rate(udc->uclk, 48000000);
> >+		retval = clk_prepare(udc->uclk);
> >+		if (retval)
> >+			goto fail1;
> >+	}
> >+	retval = clk_prepare(udc->fclk);
> >+	if (retval)
> >+		goto fail1a;
> >+
> >  	retval = clk_prepare_enable(udc->iclk);
> >  	if (retval)
> >-		goto fail1;
> >+		goto fail1b;
> >  	at91_udp_write(udc, AT91_UDP_TXVC, AT91_UDP_TXVC_TXVDIS);
> >  	at91_udp_write(udc, AT91_UDP_IDR, 0xffffffff);
> >  	/* Clear all pending interrupts - UDP may be used by bootloader. */
> >  	at91_udp_write(udc, AT91_UDP_ICR, 0xffffffff);
> >-	clk_disable_unprepare(udc->iclk);
> >+	clk_disable(udc->iclk);
> >
> >  	/* request UDC and maybe VBUS irqs */
> >  	udc->udp_irq = platform_get_irq(pdev, 0);
> >@@ -1795,7 +1803,7 @@ static int at91udc_probe(struct platform_device *pdev)
> >  			0, driver_name, udc);
> >  	if (retval < 0) {
> >  		DBG("request irq %d failed\n", udc->udp_irq);
> >-		goto fail1;
> >+		goto fail1c;
> >  	}
> >  	if (gpio_is_valid(udc->board.vbus_pin)) {
> >  		retval = gpio_request(udc->board.vbus_pin, "udc_vbus");
> >@@ -1848,6 +1856,13 @@ fail3:
> >  		gpio_free(udc->board.vbus_pin);
> >  fail2:
> >  	free_irq(udc->udp_irq, udc);
> >+fail1c:
> >+	clk_unprepare(udc->iclk);
> >+fail1b:
> >+	clk_unprepare(udc->fclk);
> >+fail1a:
> >+	if (IS_ENABLED(CONFIG_COMMON_CLK))
> >+		clk_unprepare(udc->uclk);
> >  fail1:
> >  	if (IS_ENABLED(CONFIG_COMMON_CLK) && !IS_ERR(udc->uclk))
> >  		clk_put(udc->uclk);
> >@@ -1896,6 +1911,11 @@ static int __exit at91udc_remove(struct platform_device *pdev)
> >  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> >  	release_mem_region(res->start, resource_size(res));
> >
> >+	if (IS_ENABLED(CONFIG_COMMON_CLK))
> >+		clk_unprepare(udc->uclk);
> >+	clk_unprepare(udc->fclk);
> >+	clk_unprepare(udc->iclk);
> >+
> >  	clk_put(udc->iclk);
> >  	clk_put(udc->fclk);
> >  	if (IS_ENABLED(CONFIG_COMMON_CLK))
> >

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
