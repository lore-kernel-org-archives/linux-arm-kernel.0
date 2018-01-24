From: ludovic.desroches@microchip.com (Ludovic Desroches)
Date: Wed, 24 Jan 2018 14:07:05 +0100
Subject: [RFC PATCH 2/2] gpio: provide a consumer when requesting a gpio
In-Reply-To: <20180118152228.GX2989@rfolt0960.corp.atmel.com>
References: <20180115162407.6314-1-ludovic.desroches@microchip.com>
 <20180115162407.6314-3-ludovic.desroches@microchip.com>
 <CACRpkdbsYyHRz826K0QA=Y7Dvf_sm714o5601KBD7Zo4+1hrQA@mail.gmail.com>
 <20180118152228.GX2989@rfolt0960.corp.atmel.com>
Message-ID: <20180124130705.GN3055@rfolt0960.corp.atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 18, 2018 at 04:22:28PM +0100, Ludovic Desroches wrote:
> On Thu, Jan 18, 2018 at 11:30:00AM +0100, Linus Walleij wrote:
> > On Mon, Jan 15, 2018 at 5:24 PM, Ludovic Desroches
> > <ludovic.desroches@microchip.com> wrote:
> > 
> > > It can be useful for the pinmuxing layer to know which device is
> > > requesting a GPIO. Add a consumer variant for gpiod_request to
> > > reach this goal.
> > >
> > > GPIO chips managed by pin controllers should provide the new
> > > request_consumer operation. They can rely on
> > > gpiochip_generic_request_consumer instead of
> > > gpiochip_generic_request.
> > >
> > > Signed-off-by: Ludovic Desroches <ludovic.desroches@microchip.com>
> > 
> > I think we need to think over what is a good way to share ownership
> > of a pin.
> > 
> > Russell pointed me to a similar problem incidentally and I briefly looked
> > into it: there are cases when several devices may need to hold the
> > same pin.
> > 
> > Can't we just look up the associated gpio_chip from the GPIO range,
> > and in case the pin is connected between the pin controller and
> > the GPIO chip, then we allow the gpiochip to also take a
> > reference?
> > 
> 
> It's the probably the way to go, it was Maxime's proposal and Andy seems
> to agree this solution.
> 

If pin_request() is called with gpio_range not NULL, it means that the
requests comes from a GPIO chip and the pin controller handles this pin.
In this case, I would say the pin is connected between the pin
controller and the GPIO chip. Is my assumption right?

I am not sure it will fit all the cases:

- case 1: device A requests the pin (pinctrl-default state) and mux it
  as a GPIO. Later,it requests the pin as a GPIO (gpiolib). This 'weird'
  situation happens because some strict pin controllers were not declared
  as strict and/or pinconf is needed.

- case 2: device A requests the pin (pinctrl-default state). Device B
  requests the pin as a GPIO (gpiolib).

In case 1, pin_request must not return an error. In case 2, pin_request
must return an error even if the pin is connected between the pin
controller and the GPIO chip.

> > I.e. in that case you just allow gpio_owner to proceed and take the
> > pin just like with a non-strict controller.

Regards

Ludovic
