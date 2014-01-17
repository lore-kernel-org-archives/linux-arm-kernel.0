From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 17 Jan 2014 22:53:31 +0100
Subject: More GPIO madness on iMX6 - and the crappy ARM port of Linux
In-Reply-To: <20140117204342.GG15937@n2100.arm.linux.org.uk>
References: <20140117184731.GE15937@n2100.arm.linux.org.uk>
 <52D98712.3070103@wwwdotorg.org>
 <20140117202015.GE25911@pengutronix.de>
 <20140117204342.GG15937@n2100.arm.linux.org.uk>
Message-ID: <CACRpkdYvZaXL6OWUXB2a3=rstsWRe4btvuXx9hzgnXZttaYezw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[CC:ing the comaintainer and linux-gpio for generic questions...]

On Fri, Jan 17, 2014 at 9:43 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Fri, Jan 17, 2014 at 09:20:15PM +0100, Uwe Kleine-K?nig wrote:

>>  e) add a flag to all gpio-chips signalling which case gpio_get_value
>>     implements (i.e: return
>>       - the actual value on the pad; or
>>       - zero.
>>     ). This is not orthogonal to b) - d)
>>
>> > > 2. What should be reported in /sys/kernel/debug/gpio for an output?
>> It should report the same thing as gpio_get_value in 1.
>
> There's another solution here.  /sys/kernel/debug/gpio is there to allow
> us to see the state of the GPIOs, right?  Well, if the asked-for output
> value can be different from the read-back output value, how about fixing
> this so that the _debug_ can report back what the desired output state
> as well as the current input state.
>
> This would mean that this file becomes something like:
>
>  gpio-86  (usb_otg_vbus        ) dir:out out:hi in:lo
>
> which makes it clear that either the pad is being asked to output a high
> level, but for some reason reading the input side is returning low state.
> It also lets you see what was asked of the output, and what was (in
> theory) written to the output.

I really like the looks of this. That kind of helpful stuff is exactly
what the debugfs files shall be used for.

> It may _also_ be a good idea to do (e) - have a per-gpiochip flag which
> indicates the behaviour here, and omit the "out:" or "in:" as appropriate.

That also seems like a good idea.

> Finally, consider that some drivers should be provided this information.
> For example, the bitbanging I2C driver needs this for:
>
>         scllo(adap);
>         sda = getsda(adap);
>         scl = (adap->getscl == NULL) ? 0 : getscl(adap);
>         if (scl) {
>                 printk(KERN_WARNING "%s: SCL stuck high!\n", name);
>                 goto bailout;
>         }
>         if (!sda) {
>                 printk(KERN_WARNING "%s: SDA unexpected low "
>                        "while pulling SCL low!\n", name);
>                 goto bailout;
>         }
>
>         sclhi(adap);
>         sda = getsda(adap);
>         scl = (adap->getscl == NULL) ? 1 : getscl(adap);
>         if (!scl) {
>                 printk(KERN_WARNING "%s: SCL stuck low!\n", name);
>                 goto bailout;
>         }
>         if (!sda) {
>                 printk(KERN_WARNING "%s: SDA unexpected low "
>                        "while pulling SCL high!\n", name);
>                 goto bailout;
>         }
>
> Now, if getscl() always returns zero when scllo() is called (because the
> pin is set as an output) the test is pretty useless - it turns into a
> verification that yes, the hardware does return zero from the pad register
> when the pin is set as an output.

If we can come up with a good API for it this seems useful as
well. The bit-banged I2C is a perfectly valid usecase.

I guess we could discuss adding that to the new gpiod API so
we get some traction around that and start to clean things up properly.
I'd really prefer not to see it in the legacy API.

Yours,
Linus Walleij
