From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu, 6 Nov 2014 10:52:35 +0100
Subject: [PATCH] leds: leds-gpio: Convert gpio_blink_set() to use GPIO
 descriptors
In-Reply-To: <2455157.3p7mHhT8im@vostro.rjw.lan>
References: <1414755658-96293-1-git-send-email-mika.westerberg@linux.intel.com>
 <545843B1.3020101@nvidia.com> <2455157.3p7mHhT8im@vostro.rjw.lan>
Message-ID: <CAMuHMdXn9W2S7N+YGfjDxQozMtRZCVdTzzdDps6YfOv2FqVBmw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mika, Rafael,

On Tue, Nov 4, 2014 at 11:50 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Tuesday, November 04, 2014 12:10:41 PM Alexandre Courbot wrote:
>> On 10/31/2014 08:40 PM, Mika Westerberg wrote:
>> > Commit 21f2aae91e902aad ("leds: leds-gpio: Add support for GPIO
>> > descriptors") already converted most of the driver to use GPIO descriptors.
>> > What is still missing is the platform specific hook gpio_blink_set() and
>> > board files which pass legacy GPIO numbers to this driver in platform data.
>> >
>> > In this patch we handle the former and convert gpio_blink_set() to take
>> > GPIO descriptor instead. In order to do this we convert the existing four
>> > users to accept GPIO descriptor and translate it to legacy GPIO number in
>> > the platform code. This effectively "pushes" legacy GPIO number usage from
>> > the driver to platforms.
>> >
>> > Also add comment to the remaining block describing that it is legacy code
>> > path and we are getting rid of it eventually.
>> >
>> > Suggested-by: Linus Walleij <linus.walleij@linaro.org>
>> > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
>>
>> Acked-by: Alexandre Courbot <acourbot@nvidia.com>
>
> Patch applied, thanks everyone!

"leds: leds-gpio: Add support for GPIO descriptors" broke leds-gpio on
non-DT platforms for me:

    gpiod_direction_output: invalid GPIO
    leds-gpio: probe of leds-gpio failed with error -22

(desc is NULL in gpiod_direction_output()).

DT shmobile reference/multi-platform are fine.

I noticed the hard way, as I wanted to add some LEDs to a new platform,
but couldn't get it work. It turned out it also had stopped working on
r8a7740/armadillo-legacy, so I started bisecting...

Unfortunately the offending patch can't just be reverted.
Reverting all three of these on pm/linux-next fixed the issue, though:
c673a2b400810352 leds: leds-gpio: Convert gpio_blink_set() to use GPIO descripto
a43f2cbbb009f962 leds: leds-gpio: Make use of device property API
5c51277a9ababfa4 leds: leds-gpio: Add support for GPIO descriptors

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
