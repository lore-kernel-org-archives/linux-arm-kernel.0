From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 9 Mar 2015 17:44:57 +0100
Subject: [PATCH] RFC: let gpiod_get_optional et all return NULL when
 GPIOLIB is not enabled
In-Reply-To: <20150306085957.GC10717@pengutronix.de>
References: <1423731809-4800-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <CACRpkdb6KcZx3WfTqUKemhQ0_OsqxBGQb_P5cXXZvgc3riakdA@mail.gmail.com>
 <20150306085957.GC10717@pengutronix.de>
Message-ID: <CACRpkdYq70V8SG4XOPBCGWs__J4ehknZSucpO5OdXpMDj8GPKA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 6, 2015 at 9:59 AM, Uwe Kleine-K?nig
<u.kleine-koenig@pengutronix.de> wrote:
> On Fri, Mar 06, 2015 at 09:26:26AM +0100, Linus Walleij wrote:
>> On Thu, Feb 12, 2015 at 10:03 AM, Uwe Kleine-K?nig
>> <u.kleine-koenig@pengutronix.de> wrote:
>>
>> > I wonder if gpiod_get_optional et all should be changed to return NULL
>> > instead.
>>
>> This is actually the norm in most subsystems returning cookie
>> pointers, clk, regulator, pinctrl... a NULL pointer is a functional
>> noop. But normally then NULL is returned from all stubs, not
>> just optional.
>>
>> Alexandre, what do you say?
>>
>> > The obvious downside is that if the device tree specifies a
>> > reset-gpio and the kernel just fails to use it because there is some
>> > code missing, this should better be an error. (The adau1977 code has
>> > this problem already know, but when changing devm_gpiod_get_optional all
>> > callers are affected.)
>>
>> Device Tree-specific problems is not something we design
>> subsystems for, we try to just accomodate them. I'm not
>> sure I fully understand what you mean here.
> Consider you have a device that has:
>
>         enable-gpio = <&gpio3 12 0>;
>
> and you do in your driver:
>
>         enablegpio = devm_gpiod_get_optional(... "enable" ...);
>
> . If GPIOLIB is off, enablegpio gets assigned NULL and the driver
> continues happily without enabling the device which most likely is a
> bug.
>
> So IMHO the logic in devm_gpiod_get_optional for the GPIOLIB=n case
> should be:
>
>         if (device_has_gpio())
>                 return ERR_PTR(-ENOSYS);
>         else
>                 return NULL;
>
> . device_has_gpio should use similar logic like gpiod_get_index to check
> if there is a gpio. If this is considered to be too complicated for a
> disabled subsystem, returning -ENOSYS unconditionally is better than
> NULL.

Aha Oh that's complex.

I cannot answer that myself, it needs feedback from the OF/DT
maintainers before I even dare to think anything, as it is related
to how hardware is described :/

Added devicetree-list and DT/OF maintainers to To: line to get
some feedback on this.

Yours,
Linus Walleij
