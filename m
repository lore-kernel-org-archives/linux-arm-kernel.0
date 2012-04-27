From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 27 Apr 2012 23:50:45 +0200
Subject: gpio irqs broken on imx27 with dt
In-Reply-To: <20120427125048.GN20039@pengutronix.de>
References: <20120427125048.GN20039@pengutronix.de>
Message-ID: <20120427215045.GC20478@pengutronix.de>
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

How about

	static int once = 0;

	if (mxc_gpio_hwtype == IMX21_GPIO) {
		/* setup one handler for all GPIO interrupts */
		if (!once) {
			irq_set_chained_handler(port->irq,
						mx2_gpio_irq_handler);
			once = 1;
		}

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
