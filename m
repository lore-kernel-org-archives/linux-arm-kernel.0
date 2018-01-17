From: ludovic.desroches@microchip.com (Ludovic Desroches)
Date: Wed, 17 Jan 2018 15:54:58 +0100
Subject: [RFC PATCH 1/2] pinctrl: add consumer variant for gpio request
In-Reply-To: <CAHp75Vd9qrp_gjMcZAHQrg8BsG5zQC6jZrkseo222=Xepce+ew@mail.gmail.com>
References: <20180115162233.6205-1-ludovic.desroches@microchip.com>
 <20180115162233.6205-2-ludovic.desroches@microchip.com>
 <CAHp75VdGp1_hwK7rUq4u_gKpypdV7LYhV4+kQoVb_u7D+a6pwA@mail.gmail.com>
 <20180116090109.GL2989@rfolt0960.corp.atmel.com>
 <CAHp75Vd9qrp_gjMcZAHQrg8BsG5zQC6jZrkseo222=Xepce+ew@mail.gmail.com>
Message-ID: <20180117145458.GO2989@rfolt0960.corp.atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 16, 2018 at 04:33:29PM +0200, Andy Shevchenko wrote:
> On Tue, Jan 16, 2018 at 11:01 AM, Ludovic Desroches
> <ludovic.desroches@microchip.com> wrote:
> > On Mon, Jan 15, 2018 at 10:19:39PM +0200, Andy Shevchenko wrote:
> >> On Mon, Jan 15, 2018 at 6:22 PM, Ludovic Desroches
> >> <ludovic.desroches@microchip.com> wrote:
> >>
> >> Did I miss cover letter for this?
> > It seems: https://lkml.org/lkml/2018/1/15/841
> 
> >> > Add a consumer variant to GPIO request relative functions. The goal
> >> > is to fix the bad ownership, which is arbitrary set to
> >> > "range->name:gpio", of a GPIO.
> >>
> >> Hmm... It's supposed to be name of the owner of the pin range (pin
> >> control device name IIUC).
> 
> > Yes, the owner is the pinctrl device.
> 
> > There is an interesting thread here:
> > https://www.spinics.net/lists/linux-gpio/msg16769.html
> 
> Okay, I have dove into all links provided. Below a set of my thoughts
> with regard to topic.
> 
> > If things have changed and I missed it, please tell me. I have seen some
> > improvements but it still don't fit my needs.
> 
> First of all, the main architectural issue with current pin control
> design is so called "states". It's quite artificial entity which is
> not represented by hardware per se.
> 
> Instead we better to provide an API to pin configuration and pin
> muxing: I would like to switch to *this* pin function with *this* pin
> configuration.
> 

gpio_request_enable() allows to switch to the GPIO pin function.

To clarify the situation, from my point of view there are two issues:

- Several pin controllers didn't enabled the strict mode when they were
  introduced. Nowadays, enabling it will break several DTs. Maybe a DT
  property to enable/disable strict mode could do the trick: we remove
  pinctrl nodes (so pinmux + pinconf) for pins which will be requested
  by gpiod_request() and we set the strict property to true.

- But... The GPIO pin configuration is missing. Some configuration features
  have been added, we can continue to add new ones but I am not sure
  it's the best solution. At the moment, we rely on a single cell to
  manage the configuration. It may not be enough and each time a new pin
  configuration will appear, it will have to be added both to the gpiolib
  and pinconf.

> Second, the pin control and GPIOs are orthogonal as your hardware
> confirms. The propagating pin configuration or muxing via GPIO API
> looks to me a wrong direction.
> 

I agree but it seems we have started to follow this path.

> To the point of the specific issue you are trying to solve.  I would
> rather agree with Maxime:
> 
> "Something like "if the configuration is a gpio, and my pinctrl driver
> is also a gpio controller, and that gpiod_request is being called on
> that pin, hand over the reference"
> 

Sorry, what do you see behind "hand over the reference"?

> Just in case of architectural review imagine a below case. We have two
> UART devices which share same pins, and at the same time their pins
> can be switched to GPIO function. So, use cases and questions:
> - allow potential driver to switch between UARTs at run time
> - allow UART driver to switch mode between no flow control (2 wire
> mode) and HW flow (4 wire mode), though not specifically at run time
> - allow GPIO function for some pins at run time to support OOB wake
> up, for example, when UART is a console
> 

I have the feeling that 1 and 2 are achievable with pinctrl states. 3 may be
also acheviable excepting if the pin is part of a pinctrl state.

> More caveats:
> - switching and reconfiguring pins at run time is a bad idea for the
> start (only some exceptions can be applied, see above) because of
> electrical properties of the devices and potential damage to the
> hardware
> - switching to GPIO is allowed at run time for the purpose of OOB wake source
> - after switching to GPIO and freeing it the pin configuration (and
> perhaps muxing) would return back to previous (before GPIO) settings
> (this would be helpful to case described above: OOB wake up)
> 

I share another case which is the one motivating me to do these patches.

I am writing a driver for a new device which uses several lines. The lines used
depends on the firmware loaded so there is no reason to reserve all the
lines and so the pins corresponding to these lines.

The pins will be requested as GPIOs because the pin controller in this specific
case is bypassed. I mean, if the device uses a line, it will take the ownership
even if it is muxed to a function. I want to prevent this.

Before using the line, I'll request the pin as a GPIO. If an error occurs (this
is why I need to enable the strict mode), it means the pin is already muxed and
we are going to break the device which uses it.

> -- 
> With Best Regards,
> Andy Shevchenko
> --
> To unsubscribe from this list: send the line "unsubscribe linux-gpio" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
