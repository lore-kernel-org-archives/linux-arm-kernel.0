From: aisheng.dong@freescale.com (Dong Aisheng)
Date: Fri, 27 Apr 2012 21:18:53 +0800
Subject: gpio irqs broken on imx27 with dt
In-Reply-To: <20120427125048.GN20039@pengutronix.de>
References: <20120427125048.GN20039@pengutronix.de>
Message-ID: <20120427131852.GH826@shlinux2.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 27, 2012 at 02:50:48PM +0200, Uwe Kleine-K?nig wrote:
> Hello,
> 
> I experience problems on using gpio irqs on an imx27 based machine
> booting with dt.
> 
> I think one problem is:
> 
>         if (mxc_gpio_hwtype == IMX21_GPIO) {
>                 /* setup one handler for all GPIO interrupts */
>                 if (pdev->id == 0)
>                         irq_set_chained_handler(port->irq,
>                                                 mx2_gpio_irq_handler);
> 	} ...
> 
> because the inner if doesn't trigger as dt-created gpio devices have all
> pdev->id == -1.
> 
> I havn't looked deeper into it yet, but I think another problem is that
> gpios don't start at 0 and so the usual
> 
Yes, for dt, gpio base is allocated dynamically.
See gpiochip_find_base.

> 	#define OTG_PHY_CS_GPIO (GPIO_PORTB + 23)
> 
> doesn't work either (which might be expected, but doesn't necessarily
> needs to fail?!). (You could argue I shouldn't hardcode gpio numbers any
> more, but as not all device drivers are oftree aware yet I need to get
> of the ground somehow.)
> 
I guess dt user never know a pin's gpio number since they're allocated
dynamically. User should only parse it from device tree then it can be safe
to use.

Regards
Dong Aisheng
