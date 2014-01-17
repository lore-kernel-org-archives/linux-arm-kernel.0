From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 17 Jan 2014 21:20:15 +0100
Subject: More GPIO madness on iMX6 - and the crappy ARM port of Linux
In-Reply-To: <52D98712.3070103@wwwdotorg.org>
References: <20140117184731.GE15937@n2100.arm.linux.org.uk>
 <52D98712.3070103@wwwdotorg.org>
Message-ID: <20140117202015.GE25911@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 17, 2014 at 12:40:02PM -0700, Stephen Warren wrote:
> On 01/17/2014 11:47 AM, Russell King - ARM Linux wrote:
> > So, we have this wonderful GPIO layer which abstracts GPIO stuff and
> > hides stuff.  It's really wonderful, because you don't have to care
> > about how the GPIOs are actually accessed in drivers anymore.
> ...
> > 1. What should gpio_get_value() return for an output?
> 
> Some HW can't ever read back the value of an output pin, so isn't
> calling gpio_get_value() undefined for output pins?
I remember something like: "If possible it should return what is seen on
the pad, if not, return 0." being the requirement.

Documentation/gpio/gpio-legacy.txt still says that:
When reading the value of an output pin, the value returned should be
what's seen on the pin ... that won't always match the specified output
value, because of issues including open-drain signaling and output
latencies.

[...] However, note that not all platforms can read the value of output
pins; those that can't should always return zero.

Something similar can be found in Documentation/gpio/consumer about
gpiod_get_value.

So you might consider i.MX6 (and also the earlier i.MX SoCs) to violate
a "should" in the requirements. If (not necessarily iff) adding the SION
bit doesn't have other side effects than being able to read out the gpio
value (like increased latencies or power consumption) I'm all for
setting it in every case assuming it is available for all pins.

Other than that I see five possibilities:

 a) keep everything as is. Seems to imply surprises which is bad. Maybe
    at least improve the docs to have the information that the return
    value of gpio_get_value might not be usefull in the same paragraph
    as what should be reported.
 b) check if for the requested gpio pad the SION bit is set and read the
    pad value if it is, return 0 otherwise. (But note, after thinking
    again I don't believe this to be possible, because there is usually >1
    pad that can output a given gpio. Moreover AFAIK the information to
    which pads a given gpio can be routed is missing in the kernel. That
    could be fixed, that would result in a big table though. (And the
    first problem is still unfixed.))
 c) When gpio_get_value is requested for a gpio, set SION temporarily.
    This has the same implementation problems as b) tough.
 d) Read out the pad value unconditionally and return that.
    I didn't check if it always returns 0 if SION is unset though. That
    should be asserted first (or otherwise check if there are
    possibilities to find out if the pad value is valid).
 e) add a flag to all gpio-chips signalling which case gpio_get_value
    implements (i.e: return
      - the actual value on the pad; or
      - zero.
    ). This is not orthogonal to b) - d)

> > 2. What should be reported in /sys/kernel/debug/gpio for an output?
It should report the same thing as gpio_get_value in 1.

> Shouldn't it indicate that the pin is an output, and say nothing about
> the input value?
It's usefull at times to be able to read an output pin. So I'm against
discarding the value on all platforms because some platforms are unable
to provide it.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
