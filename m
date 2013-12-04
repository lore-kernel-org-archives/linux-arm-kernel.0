From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Wed, 04 Dec 2013 15:33:07 +0400
Subject: =?UTF-8?B?UmU6IFtQQVRDSF0gQVJNOiBkdHM6IGkuTVgyNzogQ29uZmlndXJlIEdQSU9z?=
 =?UTF-8?B?IGFzICJpbnB1dCIgYnkgZGVmYXVsdA==?=
In-Reply-To: <20131204121508.7123c6c5@ipc1.ka-ro>
References: <1385795000-29764-1-git-send-email-shc_work@mail.ru>
 <1386152166.195844894@f118.i.mail.ru>
 <20131204121508.7123c6c5@ipc1.ka-ro>
Message-ID: <1386156787.576977781@f410.i.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > > > > > > > > On Sat, Nov 30, 2013 at 11:03:20AM +0400, Alexander Shiyan wrote:
> > > > > > > > > > This patch changes the default direction for pins used
> > > > > > > > > > as GPIO to "input". This prevents a short circuit on the
> > > > > > > > > > configuration stage when GPIO-pin is connected to the
> > > > > > > > > > other output pin.
> > > > > > > > > 
> > > > > > > > > Markus,
> > > > > > > > > 
> > > > > > > > > Does it make sense to you?
> > > > > > > > 
> > > > > > > > I am not sure if this really happens. However, it does make sense and I
> > > > > > > > can't see any disadvantages in changing the default GPIO mux direction to
> > > > > > > > input.
> > > > > > > > 
> > > > > > > What happens, if the bootloader already set up a pin as output and
> > > > > > > linux later does the pinconfig stuff?
> > > > > > > If the pin is reconfigured as input then, this may produce an unwanted
> > > > > > > glitch on the pin. IMO the pinconfig driver should not touch the pin
> > > > > > > direction, but leave it to the gpio driver to set that up. 
> > > > > > 
> > > > > > Such pin can be overridden by board DTS.
> > > > > > 
> > > > > So, which pins will be configured with the default direction?
> > > > > If pins are not stated in DT they should be not configured at all, I
> > > > > suppose.
> > > > 
> > > > Yes. We talk about GPIOs defined in DTS.
> > > > Just one example: We have one GPIO pin connected to switch between ground
> > > > and resistor to pullup (gpio-key driver). When pinctrl driver will initialize pin for the
> > > > driver (before gpio_direction_input() in the driver), direction will be set to output
> > > > and this may cause short circuit.
> > > > 
> > > The pin direction should be determined by the GPIO driver, not the
> > 
> > Direction determined by driver that use this GPIO pin,
> > setup this direction should be by GPIO driver.
> > 
> > > pinctrl driver. Pins that have been set up correctly by the bootloader
> > > must not change their direction when the pinctrl driver reconfigures
> > > the pins!
> > 
> > Yes. But this is another topic for discussion, it does not concern with this patch.
> > 
> If the pin direction is not being determined by the pinctrl driver the
> patch to change the default direction would not be necessary.
> 
> Otherwise this patch would try to exorcise the devil with the help of
> beelzebub.
> 
> A short between to outputs is to be prevented as well as a temporary
> reconfiguration of an output pin to input.

Current "pinctrl-imx1-core.c" touch direction register for any pin.
As far this not fixed, this will be a temporary solution.

---
