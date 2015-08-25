From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 25 Aug 2015 16:25:09 +0200
Subject: [PATCH 2/6] gpio: Introduce gpio descriptor 'name'
In-Reply-To: <20150813132813.GX19600@pengutronix.de>
References: <1438680203-13432-1-git-send-email-mpa@pengutronix.de>
 <1438680203-13432-3-git-send-email-mpa@pengutronix.de>
 <CACRpkdYv=-fCj+ts9tTmFsovPN0RPYkOdYh9Dj6oFDJiRV=RUA@mail.gmail.com>
 <20150813132813.GX19600@pengutronix.de>
Message-ID: <CACRpkdYhAe7fpqvixLhZ2t=3hC1w=VHNtWNSJverVb7ng3Qe_Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 13, 2015 at 3:28 PM, Markus Pargmann <mpa@pengutronix.de> wrote:
> On Mon, Aug 10, 2015 at 11:37:06AM +0200, Linus Walleij wrote:
>> On Tue, Aug 4, 2015 at 11:23 AM, Markus Pargmann <mpa@pengutronix.de> wrote:
>>
>> > The latest gpio hogging mechanism assigns each gpio a 'line-name' in the
>> > devicetree. The 'name' field is different from the 'label' field.
>> > 'label' is only used for requested GPIOs to describe its current use by
>> > driver or userspace.
>> >
>> > The 'name' field describes the GPIO itself, not the use. This is most
>> > likely identical to the label in the schematic on the GPIO line and
>> > should help to find this particular GPIO.
>> >
>> > This patch adds a helper function to find gpio descriptors by name
>> > instead of gpio number.
>> >
>> > Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
>>
>> Oh I realized there is a big problem with this.
>>
>> struct gpio_chip already contains this:
>>
>>         const char              *const *names;
>>
>> Now it seems like names can be stored in two places:
>> in an array in the gpio_chip and in a name tag in struct
>> gpio_desc.
>>
>> So how do we handle this?
>>
>> I guess we need to keep just *one* of them, so maybe remove
>> the names array from the struct gpio_chip and add a helper function
>> that sets the names on the descs for the lines like:
>>
>> int gpiochip_set_names(struct gpio_chip *gc, const char * const names);
>>
>> And then refactor all code and chips that use the old names
>> array to use this instead. I don't think they are too many, really.
>
> That sounds good. There are just a few users of this names array, so it
> should all be fine.

OK thanks.

> Just to clarify: The line names will then be the same as this name
> array? So all GPIOs with name/line-names are then exported by their name
> and not the number?

Yeah I consider it a legacy mechanism to achieve the same thing.

The problem with it is that it has a flat namespace and we
need to conform to that.

Yours,
Linus Walleij
