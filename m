From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Wed, 24 Jan 2018 17:42:15 +0200
Subject: [RFC PATCH 2/2] gpio: provide a consumer when requesting a gpio
In-Reply-To: <20180124130705.GN3055@rfolt0960.corp.atmel.com>
References: <20180115162407.6314-1-ludovic.desroches@microchip.com>
 <20180115162407.6314-3-ludovic.desroches@microchip.com>
 <CACRpkdbsYyHRz826K0QA=Y7Dvf_sm714o5601KBD7Zo4+1hrQA@mail.gmail.com>
 <20180118152228.GX2989@rfolt0960.corp.atmel.com>
 <20180124130705.GN3055@rfolt0960.corp.atmel.com>
Message-ID: <CAHp75VeuX8kGumtiu6iBhJ+AL+Ug3dm5Pb_tQ8YYYU9SH+QSZA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 24, 2018 at 3:07 PM, Ludovic Desroches
<ludovic.desroches@microchip.com> wrote:
> On Thu, Jan 18, 2018 at 04:22:28PM +0100, Ludovic Desroches wrote:
>> On Thu, Jan 18, 2018 at 11:30:00AM +0100, Linus Walleij wrote:
>> > On Mon, Jan 15, 2018 at 5:24 PM, Ludovic Desroches
>> > <ludovic.desroches@microchip.com> wrote:

>> > I think we need to think over what is a good way to share ownership
>> > of a pin.
>> >
>> > Russell pointed me to a similar problem incidentally and I briefly looked
>> > into it: there are cases when several devices may need to hold the
>> > same pin.
>> >
>> > Can't we just look up the associated gpio_chip from the GPIO range,
>> > and in case the pin is connected between the pin controller and
>> > the GPIO chip, then we allow the gpiochip to also take a
>> > reference?

How do you find my proposal about introducing ownership level (not
requested yet; exclusive; shared)?

>> It's the probably the way to go, it was Maxime's proposal and Andy seems
>> to agree this solution.

Confirm with caveat that this is a fix for subset of cases.

> If pin_request() is called with gpio_range not NULL, it means that the
> requests comes from a GPIO chip and the pin controller handles this pin.
> In this case, I would say the pin is connected between the pin
> controller and the GPIO chip. Is my assumption right?
>
> I am not sure it will fit all the cases:

I think it doesn't cover cases when you have UART + UART + GPIO (I
posted early a use case example).

But at least it doesn't move things in a wrong direction.

> - case 1: device A requests the pin (pinctrl-default state) and mux it
>   as a GPIO. Later,it requests the pin as a GPIO (gpiolib). This 'weird'
>   situation happens because some strict pin controllers were not declared
>   as strict and/or pinconf is needed.
>
> - case 2: device A requests the pin (pinctrl-default state). Device B
>   requests the pin as a GPIO (gpiolib).
>
> In case 1, pin_request must not return an error. In case 2, pin_request
> must return an error even if the pin is connected between the pin
> controller and the GPIO chip.

For these cases looks OK to me.

>> > I.e. in that case you just allow gpio_owner to proceed and take the
>> > pin just like with a non-strict controller.

-- 
With Best Regards,
Andy Shevchenko
