From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 27 Jun 2011 13:44:43 +0200
Subject: [PATCH 0/2] RFC: gpio: driver-local pin configuration
In-Reply-To: <BANLkTinxptCJRETreCpUoV-nU2K4fuFcmQ@mail.gmail.com>
References: <1307695731-28018-1-git-send-email-linus.walleij@stericsson.com>
	<BANLkTinxptCJRETreCpUoV-nU2K4fuFcmQ@mail.gmail.com>
Message-ID: <BANLkTimMSChGFUSnFWFHv3nNUca_Fyawaw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 27, 2011 at 12:57 PM, Stijn Devriendt <highguy@gmail.com> wrote:
> On Fri, Jun 10, 2011 at 10:48 AM, Linus Walleij
> <linus.walleij@stericsson.com> wrote:
>>
>> Background: Grant didn't like the idea of an ioctl() like
>> configuration function in the struct gpio_chip vtable, so we
>> decided to see if it was wiser to go back to the initial suggestion
>> of making it possible for drivers to dereference the struct
>> gpio_chip and perform driver-local operations via regular
>> function calls instead.
>>
> I couldn't find Grant's rationale in an e-mail thread somewhere, but
> except from the few comments I passed on, I liked the approach.

Grant gave me these comments in person. Grant, maybe you
can restate? I might be referring it the wrong way.

> I rather dislike exposing the gpio_to_chip. It makes implementations
> work around gpiolib completely. We might as well strip it out
> completely then and go back to drivers doing platform specific GPIO
> register accesses.

Myself I am pretty neutral and happy with any of these two
approaches, I just want to be able to migrate my U300 and Nomadik
drivers to gpio_chip and irq_chip, and without a handle on the memory
map I cannot do that.

>> This one is then exposed in the chip-specific header ?in
>> <linux/gpio/u300.h>, and all the configuration defines that
>> were previously globally generic in <linux/gpio.h> are also
>> moved there and made driver-specific without any attempt of
>> generalizing this.
>>
> How about a SPI flash that has its chip select hooked up to a
> GPIO that requires setting open-drain for example. Now that
> SPI-driver needs to be aware of each independent gpio-chip
> implementation.

Yes. To make the driver platform neutral, it needs to for example
provide a callback in the platform data like (* set_pin_bias) or so,
and then your platform has to implement this biasing.

In this specific case that kind of stuff would likely be preferable
to have in the platform anyway, but I understand what you mean.

In the pinctrl framework I try to handle all such pin control stuff
with the intention of letting the GPIO drivers wrap it if they
prefer, but in this framework platforms could also handle GPIO
and pin control in an orthogonal way, which would likely be
preferable in most cases.

Linus Walleij
