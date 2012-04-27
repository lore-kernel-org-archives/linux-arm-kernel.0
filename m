From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 27 Apr 2012 14:50:48 +0200
Subject: gpio irqs broken on imx27 with dt
Message-ID: <20120427125048.GN20039@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

I experience problems on using gpio irqs on an imx27 based machine
booting with dt.

I think one problem is:

        if (mxc_gpio_hwtype == IMX21_GPIO) {
                /* setup one handler for all GPIO interrupts */
                if (pdev->id == 0)
                        irq_set_chained_handler(port->irq,
                                                mx2_gpio_irq_handler);
	} ...

because the inner if doesn't trigger as dt-created gpio devices have all
pdev->id == -1.

I havn't looked deeper into it yet, but I think another problem is that
gpios don't start at 0 and so the usual

	#define OTG_PHY_CS_GPIO (GPIO_PORTB + 23)

doesn't work either (which might be expected, but doesn't necessarily
needs to fail?!). (You could argue I shouldn't hardcode gpio numbers any
more, but as not all device drivers are oftree aware yet I need to get
of the ground somehow.)

I'm leaving for the weekend now, so just wanted you to inform that there
is a problem. Shawn, maybe you have an idea?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
