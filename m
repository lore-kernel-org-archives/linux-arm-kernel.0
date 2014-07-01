From: gnurou@gmail.com (Alexandre Courbot)
Date: Tue, 1 Jul 2014 09:59:01 +0900
Subject: [PATCH] regulator: convert to use gpio_desc internally
In-Reply-To: <CACRpkda5BjAwphVEkCg6-oUR0yN=RMhjP6FL=Oripy7bQ-aSng@mail.gmail.com>
References: <E1X1IOQ-0007fV-1w@rmk-PC.arm.linux.org.uk>
 <CACRpkdY_w=Vjv0fL5Ay-CkCpvuyjvwyBhOd4wYr0LcmJD6i4qA@mail.gmail.com>
 <20140630163931.GD32514@n2100.arm.linux.org.uk>
 <CACRpkda5BjAwphVEkCg6-oUR0yN=RMhjP6FL=Oripy7bQ-aSng@mail.gmail.com>
Message-ID: <CAAVeFuK8YPFh3gHRt7_n00SBN6raGj2KxU_rY3GFrQq4dT3LTA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 1, 2014 at 1:49 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Mon, Jun 30, 2014 at 6:39 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
>
>> Bear in mind that Mark has already committed this patch - rather too
>> hastily I think.  I've no idea why he didn't wait for your review
>> before doing so, that would have been the appropriate thing to have
>> done.
>
> Well, he's usually just as quick at pulling them out when there
> is trouble so let's hope that happens.
>
>>> >  #include <linux/gpio.h>
>>>
>>> ^ This include should not be needed anymore after using
>>> <linux/gpio/consumer.h> I presume?
>>
>> No, because we still need to use the legacy API to request the GPIO.
>
> Oh :-/
>
> I have a hard time seeing that mixture here due to the nature
> of patch, sorry.
>
>>> > @@ -1660,10 +1661,13 @@ static int regulator_ena_gpio_request(struct regulator_dev *rdev,
>>> >                                 const struct regulator_config *config)
>>> >  {
>>> >         struct regulator_enable_gpio *pin;
>>> > +       struct gpio_desc *gpiod;
>>> >         int ret;
>>> >
>>> > +       gpiod = gpio_to_desc(config->ena_gpio);
>>>
>>> So this point is where we will optionally first look for a descriptor
>>> from the device
>>> itself, like devm_gpiod_get(&rdev->dev, "enable"); or so. (For a later
>>> patch.) That
>>> should work smoothly with DT I think (but haven't tried, admittedly).
>>
>> This is where the problem comes.  devm_gpiod_get() can only be used once
>> per GPIO, so there's no sharing possible when using this interface.
>> Since we need to share GPIOs here, we can't use any GPIO interface which
>> ensures exclusivity.
>>
>> Consider the case where you have two regulators wired up to a single
>> control GPIO.  DT would specify the same GPIO in two regulator
>> descriptions.  The GPIO interfaces will allow the GPIO to be "got"
>> for the first regulator to be probed, and fail the second one with
>> -EBUSY.
>>
>> That's what this code is trying to avoid.
>
> OK that's a snag.
>
> Alexandre: do you have a good idea about how we solve the
> multiple consumer problem for GPIO descriptors?
>
> I can think of things like tagging lines as allowing multiple consumers
> in the gpiochip (in the gpiochip node, in the DT case) or simply just
> allowing this for any GPIO, or just allow it if obtained using a certain
> variant gpiod_multiple_consumer_get() call.

Ah right, we cannot obtain a GPIO descriptor to compare to until we
call gpiod_get() ourselves.

We could compare on the (dev, func, index) triplet instead of the GPIO
number, but that looks a little bit overkill (and won't work if we mix
integers and descriptors).

Requiring DT tagging to allow sharing would break DT compatibility I'm afraid.

Maybe it is simply time to revisit our policy regarding shared GPIOs,
at least for the gpiod interface. For the integer representation we
had a truly legitimate reason for not allowing sharing, since anyone
could forge a GPIO number, request it, and mess up with the system.

The gpiod interface does not allow that, and GPIOs are now assigned by
a trusted authority (the board file, DT, or ACPI firmware designer).
If that authority thinks that, for any reason, a GPIO ought to be
shared by two devices because the driver knows how to handle this, or
because it is guaranteed that the two functions will never be used at
the same time, who are we to forbid this? We had other requests to
allow limited GPIO sharing in the past, and this should also satisfy
them.

However, there is at least one loophole since one can currently forge
a GPIO number, call gpio_to_desc() on it, and hijack any GPIO they
want. All the same, one can directly call gpio_get_value() and spoof
on any currently-requested GPIO value. This is not a new problem - but
the current issue might give us a chance to address it.

How about we add a SHAREABLE flag to the descriptors that indicates
whether a GPIO can be shared. I can then see one of the following two
policies being applied:

1) GPIOs are marked shareable individually by their first user, and
regulator would do this for its enable_gpio. I'm not sure I am fond of
this one as it requires explicit driver support.
2) GPIOs are shareable by default, and remain that way as long as they
are obtained using the gpiod interface exclusively. A call to
gpio_to_desc() or gpio_request_one() would mark the GPIO as
non-shareable until it is released by the integer interface (and would
fail if the GPIO is already requested by gpiod). Any integer interface
call on a gpiod-requested GPIO would now simply fail with -EPERM.

I am not sure whether 2) covers all the requirements to allow gpiod to
be "secure", but if it does, then I suggest we give it a shot
(although at least a few drivers will certainly need fixing, but such
is life). This would add a very welcome layer of security and
guarantee gpiod users that nobody can spoof or mess otherwise with
their GPIOs unless the board or firmware designer allows it.

Oh and as a side-effect it should also fix the present issue.

Alex.
