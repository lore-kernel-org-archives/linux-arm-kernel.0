From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 7 May 2017 09:30:26 +0200
Subject: [PATCH v2 3/3] gpiolib: Add GPIO initialization
In-Reply-To: <20170506203230.7ogwvdrzogvvlu67@pengutronix.de>
References: <1440920686-6892-1-git-send-email-mpa@pengutronix.de>
 <1440920686-6892-4-git-send-email-mpa@pengutronix.de>
 <20170207110950.zy5pzo2hq6hrvmr5@pengutronix.de>
 <20170506203230.7ogwvdrzogvvlu67@pengutronix.de>
Message-ID: <CACRpkdZeYXcXo5g-4wH8M7vK6gTFRHH4VMXqC7XJ_iwXUpL8HA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 6, 2017 at 10:32 PM, Uwe Kleine-K?nig
<u.kleine-koenig@pengutronix.de> wrote:

>> I'd suggest the following description for these cases:
>>
>>  a)
>>       /*
>>        * initially configured as low output. Consumer can do
>>        * gpio_set_value(..., 1); but not gpio_direction_input(...);
>>        */
>>       nodename {
>>               gpio-hog;
>>               gpios = <...>;
>>               output-low-init;
>>       };
>>
>>  b)
>>       /*
>>        * initially configured as low output. Consumer can do
>>        * gpio_set_value(..., 1); and gpio_direction_input(...);
>>        */
>>       nodename {
>>               gpio-hog;
>>               gpios = <...>;
>>               output-init-low;
>>       };
>>
>>  c)
>>       /*
>>        * initially configured as input. Consumer can do
>>        * gpio_direction_output(..., ...) and then set the value
>>        * freely.
>>        */
>>        nodename {
>>               gpio-hog;
>>               gpios = <...>;
>>               input-init;
>>       };
>
> I thought a bit more about this and the changes that would be necessary
> to achieve this:
>
>  - introduce new flags IS_FIXED_DIR and IS_FIXED_VALUE for struct
>    gpio_desc::flags and error out accordingly in gpiod_set_direction_*
>    and gpiod_set_value respectively. Then we have:
>
>         - already existing hogs: IS_FIXED_DIR | IS_FIXED_VALUE
>         - a) IS_FIXED_DIR
>         - b)+c) 0
>         - d) (if desired) IS_FIXED_VALUE

I don't really understand IS_FIXED_DIR, if that is a property of the
hardware then that is something the driver should be handling,
i.e. the driver must know if a line is fixed direction (only input or only
output). Same for IS_FIXED_VALUE.

Or do you mean it is something else, like these are only software
flags for hogs? Then they should be HOG_IS_FIXED_DIR etc.

>  - don't auto-request hogged pins
>    Currently hogged pins are not available for consumers to be
>    requested. This needs to be changed at least for the three (or four)
>    new cases.

But look at the dictionary definition of "hog":
https://en.wiktionary.org/wiki/hog

The usage here is as in "to hog resources" so:

3. A greedy person; one who refuses to share.

And check the verb form:

1. hog (third-person singular simple present hogs, present participle
  hogging, simple past and past participle hogged)
(transitive) To greedily take more than one's share, to take precedence
 at the expense of another or others.
[quotations]Hey! Quit hogging all the blankets.

So of course hogs request and hold the lines. That is what hogging
is all about.

>    IMHO it is sensible to allow requesting a gpio that is completely
>    hogged and just prevent changing direction and (if it's an output)
>    value.

No it doesn't make sense at all to take something that is hogged
because it is completely unintuitive to the very word "hog".

As I have said before: a new property, something like
"initial-directions" and "initial-values" need to be created and
handled separately for this, without even involving the hogging
mechanism.

You need to introduce something in parallel from the hogs that
does not request the lines, but just sets up initial values and
directions on them and then leave them to be acquired later.

We already keep track of the direction inside the gpio_desc
and we have callbacks to read that up from the hardware if
supported, and I guess the  same goes for initial values.

I just don't see what you need here and why you want to expand
the hog concept beyond its intuitive use?

I say define something new in device tree with an intuitive name,
that does what you want it to do: just sets up initial direction and
optional value (on outputs) using the existing callbacks and then just
gets out of the way. No hogging.

Yours,
Linus Walleij
