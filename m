From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 11 May 2017 16:29:30 +0200
Subject: [PATCH v2 3/3] gpiolib: Add GPIO initialization
In-Reply-To: <20170507094524.vi4uhu52m67nlfa6@pengutronix.de>
References: <1440920686-6892-1-git-send-email-mpa@pengutronix.de>
 <1440920686-6892-4-git-send-email-mpa@pengutronix.de>
 <20170207110950.zy5pzo2hq6hrvmr5@pengutronix.de>
 <20170506203230.7ogwvdrzogvvlu67@pengutronix.de>
 <CACRpkdZeYXcXo5g-4wH8M7vK6gTFRHH4VMXqC7XJ_iwXUpL8HA@mail.gmail.com>
 <20170507094524.vi4uhu52m67nlfa6@pengutronix.de>
Message-ID: <CACRpkdZPwH3vPjdCgCjYW4Q5OvbE5O0RLJ4bV-QLR2nVLy4kAQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 7, 2017 at 11:45 AM, Uwe Kleine-K?nig
<u.kleine-koenig@pengutronix.de> wrote:
> [Me]

>> >    IMHO it is sensible to allow requesting a gpio that is completely
>> >    hogged and just prevent changing direction and (if it's an output)
>> >    value.
>>
>> No it doesn't make sense at all to take something that is hogged
>> because it is completely unintuitive to the very word "hog".
>
> What I want is that it is possible to restrict the usage of a GPIO more
> fine-grained. For example only fix the direction to input but allow a
> driver to still read out it's value. Or fix the direction to output but
> allow changing the level.

So let me understand this right.

For something input-only, return -EINVAL from .direction_output()
and vice versa mutatis mutandis for something output-only.

This semantic is set at runtime when using these functions.

Why can't you do this in the specific driver? Why does that have
to be handled by the core? I mean of course we can add a
flag to the gpio_desc if you think it's gonna be a common case,
but then I want an indication that there is a bunch of drivers that
need this done in the core.

> So the semantic of a hogged gpio as
> implemented today is a special case of my new use cases. So it seems
> naturally to extend the already existing concept.

I disagree and the DT maintainer Rob Herring already said he kind
of dislikes the hogs already, so let's not expand their use beyond
what is already being done, which is explicit hogging.

> And concerning the meaning of hogging: It still takes some freedom from
> others, just not everything because you can still request the line. So
> not being a native English speaker the word still fits for me.

IMO this breaks Rusty Russell's API Design Manifesto,
levels 7 and 6:

7. The obvious use is (probably) the correct one.
6. The name tells you how to use it.

In my case, just no. It is not obvuous and does not tell me how
to use it.

Something like gpio-line-initial-directions, gpio-line-initial-values
etc does.

> And technically it is sensible to implement the new use cases and
> today's hogging together and so it is also sensible IMHO to use the same
> mechanism in the device tree.

I disagree with that, sorry.

But let's ask for more opinions.

> So to stick to your suggestion I would have in the end for two lines
> io12 that must be 0 for ESD reasons and io13 that drives the RST-line of
> a companion DSP that should be kept low until userspace is ready and
> then allow being driven high via gpioctl:
>
>         io12 {
>                 gpio-hog;
>                 gpio = <4 0>;
>                 output-low;
>         };
>
>         io13 {
>                 gpio-init;
>                 gpio = <5 0>;
>                 output-low;
>                 fixed-direction;
>         };
>
> For me it looks artificial to not use "gpio-hog" for the 2nd
> specification but if that is the compromise that we can agree on, that's
> ok for me.

This looks OK to me.

> Orthogonal to gpio-hog being used for this or not, I like
>
>         output-low;
>         fixed-direction;
>
> better than
>
>         output-low-init;
>
> as the former is more intuitive.

Those are OK with me but I guess with

fixed-direction-output;
fixed-direction-input;

I still don't really understand the fixed-direction thing.

If that is a property of the *hardware* it should not be in the
device tree IMO. It should be in the driver and derived from
the compatible string.

If that is a property of the *use case* in *this system*
then something like this makes sense: we may need to
restrict it further for electrical reasons, that is nice.

I think you will have a problem with Rob on this though, he's not
a big fan of these hogging nodes and I'm not sure he's gonna like
the gpio-init nodes much.

If you send some patch, make sure to get it ACKed by Rob.

Yours,
Linus Walleij
