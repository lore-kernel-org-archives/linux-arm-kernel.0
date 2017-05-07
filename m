From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Sun, 7 May 2017 11:45:24 +0200
Subject: [PATCH v2 3/3] gpiolib: Add GPIO initialization
In-Reply-To: <CACRpkdZeYXcXo5g-4wH8M7vK6gTFRHH4VMXqC7XJ_iwXUpL8HA@mail.gmail.com>
References: <1440920686-6892-1-git-send-email-mpa@pengutronix.de>
 <1440920686-6892-4-git-send-email-mpa@pengutronix.de>
 <20170207110950.zy5pzo2hq6hrvmr5@pengutronix.de>
 <20170506203230.7ogwvdrzogvvlu67@pengutronix.de>
 <CACRpkdZeYXcXo5g-4wH8M7vK6gTFRHH4VMXqC7XJ_iwXUpL8HA@mail.gmail.com>
Message-ID: <20170507094524.vi4uhu52m67nlfa6@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Linus,

On Sun, May 07, 2017 at 09:30:26AM +0200, Linus Walleij wrote:
> On Sat, May 6, 2017 at 10:32 PM, Uwe Kleine-K?nig
> <u.kleine-koenig@pengutronix.de> wrote:
> 
> >> I'd suggest the following description for these cases:
> >>
> >>  a)
> >>       /*
> >>        * initially configured as low output. Consumer can do
> >>        * gpio_set_value(..., 1); but not gpio_direction_input(...);
> >>        */
> >>       nodename {
> >>               gpio-hog;
> >>               gpios = <...>;
> >>               output-low-init;
> >>       };
> >>
> >>  b)
> >>       /*
> >>        * initially configured as low output. Consumer can do
> >>        * gpio_set_value(..., 1); and gpio_direction_input(...);
> >>        */
> >>       nodename {
> >>               gpio-hog;
> >>               gpios = <...>;
> >>               output-init-low;
> >>       };
> >>
> >>  c)
> >>       /*
> >>        * initially configured as input. Consumer can do
> >>        * gpio_direction_output(..., ...) and then set the value
> >>        * freely.
> >>        */
> >>        nodename {
> >>               gpio-hog;
> >>               gpios = <...>;
> >>               input-init;
> >>       };
> >
> > I thought a bit more about this and the changes that would be necessary
> > to achieve this:
> >
> >  - introduce new flags IS_FIXED_DIR and IS_FIXED_VALUE for struct
> >    gpio_desc::flags and error out accordingly in gpiod_set_direction_*
> >    and gpiod_set_value respectively. Then we have:
> >
> >         - already existing hogs: IS_FIXED_DIR | IS_FIXED_VALUE
> >         - a) IS_FIXED_DIR
> >         - b)+c) 0
> >         - d) (if desired) IS_FIXED_VALUE
> 
> I don't really understand IS_FIXED_DIR, if that is a property of the
> hardware then that is something the driver should be handling,
> i.e. the driver must know if a line is fixed direction (only input or only
> output). Same for IS_FIXED_VALUE.

It's not about the hardware haven an input-only GPIO, but on the board
it might be bad to drive the GPIO because another device already drives
it.

> Or do you mean it is something else, like these are only software
> flags for hogs? Then they should be HOG_IS_FIXED_DIR etc.
> 
> >  - don't auto-request hogged pins
> >    Currently hogged pins are not available for consumers to be
> >    requested. This needs to be changed at least for the three (or four)
> >    new cases.
> 
> But look at the dictionary definition of "hog":
> https://en.wiktionary.org/wiki/hog
> 
> The usage here is as in "to hog resources" so:
> 
> 3. A greedy person; one who refuses to share.
> 
> And check the verb form:
> 
> 1. hog (third-person singular simple present hogs, present participle
>   hogging, simple past and past participle hogged)
> (transitive) To greedily take more than one's share, to take precedence
>  at the expense of another or others.
> [quotations]Hey! Quit hogging all the blankets.
> 
> So of course hogs request and hold the lines. That is what hogging
> is all about.
> 
> >    IMHO it is sensible to allow requesting a gpio that is completely
> >    hogged and just prevent changing direction and (if it's an output)
> >    value.
> 
> No it doesn't make sense at all to take something that is hogged
> because it is completely unintuitive to the very word "hog".

What I want is that it is possible to restrict the usage of a GPIO more
fine-grained. For example only fix the direction to input but allow a
driver to still read out it's value. Or fix the direction to output but
allow changing the level. So the semantic of a hogged gpio as
implemented today is a special case of my new use cases. So it seems
naturally to extend the already existing concept.

And concerning the meaning of hogging: It still takes some freedom from
others, just not everything because you can still request the line. So
not being a native English speaker the word still fits for me.

And technically it is sensible to implement the new use cases and
today's hogging together and so it is also sensible IMHO to use the same
mechanism in the device tree.

> As I have said before: a new property, something like
> "initial-directions" and "initial-values" need to be created and
> handled separately for this, without even involving the hogging
> mechanism.
> 
> You need to introduce something in parallel from the hogs that
> does not request the lines, but just sets up initial values and
> directions on them and then leave them to be acquired later.
> 
> We already keep track of the direction inside the gpio_desc
> and we have callbacks to read that up from the hardware if
> supported, and I guess the  same goes for initial values.
> 
> I just don't see what you need here and why you want to expand
> the hog concept beyond its intuitive use?
> 
> I say define something new in device tree with an intuitive name,
> that does what you want it to do: just sets up initial direction and
> optional value (on outputs) using the existing callbacks and then just
> gets out of the way. No hogging.

So to stick to your suggestion I would have in the end for two lines
io12 that must be 0 for ESD reasons and io13 that drives the RST-line of
a companion DSP that should be kept low until userspace is ready and
then allow being driven high via gpioctl:

	io12 {
		gpio-hog;
		gpio = <4 0>;
		output-low;
	};

	io13 {
		gpio-init;
		gpio = <5 0>;
		output-low;
		fixed-direction;
	};

For me it looks artificial to not use "gpio-hog" for the 2nd
specification but if that is the compromise that we can agree on, that's
ok for me.

Orthogonal to gpio-hog being used for this or not, I like

	output-low;
	fixed-direction;

better than

	output-low-init;

as the former is more intuitive.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
