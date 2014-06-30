From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 30 Jun 2014 18:49:00 +0200
Subject: [PATCH] regulator: convert to use gpio_desc internally
In-Reply-To: <20140630163931.GD32514@n2100.arm.linux.org.uk>
References: <E1X1IOQ-0007fV-1w@rmk-PC.arm.linux.org.uk>
 <CACRpkdY_w=Vjv0fL5Ay-CkCpvuyjvwyBhOd4wYr0LcmJD6i4qA@mail.gmail.com>
 <20140630163931.GD32514@n2100.arm.linux.org.uk>
Message-ID: <CACRpkda5BjAwphVEkCg6-oUR0yN=RMhjP6FL=Oripy7bQ-aSng@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 30, 2014 at 6:39 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:

> Bear in mind that Mark has already committed this patch - rather too
> hastily I think.  I've no idea why he didn't wait for your review
> before doing so, that would have been the appropriate thing to have
> done.

Well, he's usually just as quick at pulling them out when there
is trouble so let's hope that happens.

>> >  #include <linux/gpio.h>
>>
>> ^ This include should not be needed anymore after using
>> <linux/gpio/consumer.h> I presume?
>
> No, because we still need to use the legacy API to request the GPIO.

Oh :-/

I have a hard time seeing that mixture here due to the nature
of patch, sorry.

>> > @@ -1660,10 +1661,13 @@ static int regulator_ena_gpio_request(struct regulator_dev *rdev,
>> >                                 const struct regulator_config *config)
>> >  {
>> >         struct regulator_enable_gpio *pin;
>> > +       struct gpio_desc *gpiod;
>> >         int ret;
>> >
>> > +       gpiod = gpio_to_desc(config->ena_gpio);
>>
>> So this point is where we will optionally first look for a descriptor
>> from the device
>> itself, like devm_gpiod_get(&rdev->dev, "enable"); or so. (For a later
>> patch.) That
>> should work smoothly with DT I think (but haven't tried, admittedly).
>
> This is where the problem comes.  devm_gpiod_get() can only be used once
> per GPIO, so there's no sharing possible when using this interface.
> Since we need to share GPIOs here, we can't use any GPIO interface which
> ensures exclusivity.
>
> Consider the case where you have two regulators wired up to a single
> control GPIO.  DT would specify the same GPIO in two regulator
> descriptions.  The GPIO interfaces will allow the GPIO to be "got"
> for the first regulator to be probed, and fail the second one with
> -EBUSY.
>
> That's what this code is trying to avoid.

OK that's a snag.

Alexandre: do you have a good idea about how we solve the
multiple consumer problem for GPIO descriptors?

I can think of things like tagging lines as allowing multiple consumers
in the gpiochip (in the gpiochip node, in the DT case) or simply just
allowing this for any GPIO, or just allow it if obtained using a certain
variant gpiod_multiple_consumer_get() call.

Ideas?

Yours,
Linus Walleij
