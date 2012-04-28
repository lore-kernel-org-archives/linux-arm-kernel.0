From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Sat, 28 Apr 2012 12:31:38 +0200
Subject: gpio irqs broken on imx27 with dt
In-Reply-To: <20120427215045.GC20478@pengutronix.de>
References: <20120427125048.GN20039@pengutronix.de>
 <20120427215045.GC20478@pengutronix.de>
Message-ID: <20120428103138.GP20039@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Fri, Apr 27, 2012 at 11:50:45PM +0200, Sascha Hauer wrote:
> On Fri, Apr 27, 2012 at 02:50:48PM +0200, Uwe Kleine-K?nig wrote:
> > I experience problems on using gpio irqs on an imx27 based machine
> > booting with dt.
> > 
> > I think one problem is:
> > 
> >         if (mxc_gpio_hwtype == IMX21_GPIO) {
> >                 /* setup one handler for all GPIO interrupts */
> >                 if (pdev->id == 0)
> >                         irq_set_chained_handler(port->irq,
> >                                                 mx2_gpio_irq_handler);
> > 	} ...
> > 
> > because the inner if doesn't trigger as dt-created gpio devices have all
> > pdev->id == -1.
> 
> How about
> 
> 	static int once = 0;
> 
> 	if (mxc_gpio_hwtype == IMX21_GPIO) {
> 		/* setup one handler for all GPIO interrupts */
> 		if (!once) {
> 			irq_set_chained_handler(port->irq,
> 						mx2_gpio_irq_handler);
> 			once = 1;
> 		}
I did exactly this, but it didn't cure all my problems. And it's ugly
(not much more than testing pdev->id == 0 though). I'm not sure it's
worth to clean that up. (e.g. use a single device for the imx21 type
handling all ports vs. one device per port for the latter types. This
way each device would handle one and only one irq.)

Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
