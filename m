From: kevin.wells@nxp.com (Kevin Wells)
Date: Mon, 22 Feb 2010 22:41:01 +0100
Subject: [PATCH 01/13] ARM: LPC32XX: Initial architecture header files
In-Reply-To: <a08234131002201117t5bbd350ybaf14613cef0c54f@mail.gmail.com>
References: <1266621969-28847-1-git-send-email-wellsk40@gmail.com>
	<1266621969-28847-2-git-send-email-wellsk40@gmail.com>
	<20100220161248.GA31424@pengutronix.de>
	<a08234131002201112x66a595c4j235bf1a31aef4f92@mail.gmail.com>
	<a08234131002201117t5bbd350ybaf14613cef0c54f@mail.gmail.com>
Message-ID: <083DF309106F364B939360100EC290F805CCDFB589@eu1rdcrdc1wx030.exi.nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Uwe,

I'm going to add the pin mux check to a future patch release.
It's a nice feature and may save some GPIO pin issues down
the road, but respectfully, I want to focus on getting the
release out without adding more changes & features at the
moment. I'll add this capbility in with a new pinmux driver
in the future.

thanks,
Kevin

> 2010/2/20 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> >
> > Hey Kevin,
> >
> > > +/*
> > > + * Note!
> > > + * Muxed GP pins need to be setup to the GP state in the board level
> > > + * code prior to using this driver.
> > This is done by the imx machines, too, and I wonder if it's worth to try
> > to get rid of that or at least let the gpio_direction_... functions fail
> > if the pin isn't muxed as gpio. ?Thoughts?
> >
> HI Uwe,
> 
> In the current function of the driver, the assumption is that if an out
> pin
> is used, it has already been muxed correctly, so requesting an output
> for a pin not muxed as a GPI/O will work fine and even setting it's pin
> level will work, but the level won't appear on the external pin. If
> something decides to switch the mux after that state is programmed,
> then the currently programmed output level will show up on that pin.
> 
> For state muxing, I would prefer to not have the GPIO driver change an
> existing mux state to make a GPIO work. I don't return an error now
> when a output state is used and is not muxed for an output state. But
> its painless to add this.
> 
> GPI pins and GPIO pins configured as inputs always work regardless
> of the muxed pin state and would never need to have a fail check, its
> basically a raw pin state read.
> 
> > I didn't check the alternative functionalities for the gpios on lpc32xx,
> > but what happens if any gpio is requested and the direction configured?
> > Does it interfer with system functions? ?(E.g. if a pin is used in a
> > dedicated say i2c function, does it make the i2c driver non-functional
> > if I do gpio_direction_output(i2cpin, 1)?)
> >
> 
> Setting a GPIO direction or output state will not effect a peripheral pin
> (on this part) when muxed for the peripheral. (ie, setting a GPIO to
> output
> and switching it to low when its shared with a UART pin and the mux is
> setup for UART).
> 
> thanks,
> Kevin
> 
> > Best regards
> > Uwe
> >
> > --
> > Pengutronix e.K. ? ? ? ? ? ? ? ? ? ? ? ? ? | Uwe Kleine-K?nig
> ?|
> > Industrial Linux Solutions ? ? ? ? ? ? ? ? | http://www.pengutronix.de/
> ?|
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
