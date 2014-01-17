From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 17 Jan 2014 20:43:42 +0000
Subject: More GPIO madness on iMX6 - and the crappy ARM port of Linux
In-Reply-To: <20140117202015.GE25911@pengutronix.de>
References: <20140117184731.GE15937@n2100.arm.linux.org.uk>
 <52D98712.3070103@wwwdotorg.org> <20140117202015.GE25911@pengutronix.de>
Message-ID: <20140117204342.GG15937@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 17, 2014 at 09:20:15PM +0100, Uwe Kleine-K?nig wrote:
> On Fri, Jan 17, 2014 at 12:40:02PM -0700, Stephen Warren wrote:
> > On 01/17/2014 11:47 AM, Russell King - ARM Linux wrote:
> > > So, we have this wonderful GPIO layer which abstracts GPIO stuff and
> > > hides stuff.  It's really wonderful, because you don't have to care
> > > about how the GPIOs are actually accessed in drivers anymore.
> > ...
> > > 1. What should gpio_get_value() return for an output?
> > 
> > Some HW can't ever read back the value of an output pin, so isn't
> > calling gpio_get_value() undefined for output pins?
> I remember something like: "If possible it should return what is seen on
> the pad, if not, return 0." being the requirement.

Yes, these have already been quoted. :)

> Documentation/gpio/gpio-legacy.txt still says that:
> When reading the value of an output pin, the value returned should be
> what's seen on the pin ... that won't always match the specified output
> value, because of issues including open-drain signaling and output
> latencies.
> 
> [...] However, note that not all platforms can read the value of output
> pins; those that can't should always return zero.
> 
> Something similar can be found in Documentation/gpio/consumer about
> gpiod_get_value.

Right - and I've no problem with this wording.  If it's _impossible_ to
read back the output because the hardware has no support for doing so,
then that's absolutely fine - we can't ask the impossible from the
hardware.

My issue here is that it _is_ possible to read back the state of an
output pin on i.MX6 hardware provided stuff is configured correctly.

> Other than that I see five possibilities:
> 
>  a) keep everything as is. Seems to imply surprises which is bad. Maybe
>     at least improve the docs to have the information that the return
>     value of gpio_get_value might not be usefull in the same paragraph
>     as what should be reported.

This I'm not in favour of as it makes the board porter's job
unnecessarily harder.

>  b) check if for the requested gpio pad the SION bit is set and read the
>     pad value if it is, return 0 otherwise. (But note, after thinking
>     again I don't believe this to be possible, because there is usually >1
>     pad that can output a given gpio. Moreover AFAIK the information to
>     which pads a given gpio can be routed is missing in the kernel. That
>     could be fixed, that would result in a big table though. (And the
>     first problem is still unfixed.))

There's no input muxing on the GPIOs as you have for the non-GPIO
functions in iMX6, so I'd be surprised if you could assign a particular
GPIO to more than one pin.  As I understand it as well, the function of
the SION bit is to force the input path to be enabled, and direct the
state of that pin to the GPIO corresponding with that pin.

Note that the hardware returns zero from the pad value if the input path
is not enabled, so this already happens.  Hence why, when I was checking
the state of the GPIOs enabling the regulators, they were showing that
the GPIOs were low, hence regulators disabled, and hence why I've been
looking at the regulator and gpio code all afternoon.

>  c) When gpio_get_value is requested for a gpio, set SION temporarily.
>     This has the same implementation problems as b) tough.
>  d) Read out the pad value unconditionally and return that.
>     I didn't check if it always returns 0 if SION is unset though. That
>     should be asserted first (or otherwise check if there are
>     possibilities to find out if the pad value is valid).

This is what currently happens.

>  e) add a flag to all gpio-chips signalling which case gpio_get_value
>     implements (i.e: return
>       - the actual value on the pad; or
>       - zero.
>     ). This is not orthogonal to b) - d)
> 
> > > 2. What should be reported in /sys/kernel/debug/gpio for an output?
> It should report the same thing as gpio_get_value in 1.

There's another solution here.  /sys/kernel/debug/gpio is there to allow
us to see the state of the GPIOs, right?  Well, if the asked-for output
value can be different from the read-back output value, how about fixing
this so that the _debug_ can report back what the desired output state
as well as the current input state.

This would mean that this file becomes something like:

 gpio-86  (usb_otg_vbus        ) dir:out out:hi in:lo

which makes it clear that either the pad is being asked to output a high
level, but for some reason reading the input side is returning low state.
It also lets you see what was asked of the output, and what was (in
theory) written to the output.  We already have gpio-generic.c tracking
the output state so it doesn't have to read-modify-write the output
register.

It may _also_ be a good idea to do (e) - have a per-gpiochip flag which
indicates the behaviour here, and omit the "out:" or "in:" as appropriate.

Finally, consider that some drivers should be provided this information.
For example, the bitbanging I2C driver needs this for:

        scllo(adap);
        sda = getsda(adap);
        scl = (adap->getscl == NULL) ? 0 : getscl(adap);
        if (scl) {
                printk(KERN_WARNING "%s: SCL stuck high!\n", name);
                goto bailout;
        }
        if (!sda) {
                printk(KERN_WARNING "%s: SDA unexpected low "
                       "while pulling SCL low!\n", name);
                goto bailout;
        }

        sclhi(adap);
        sda = getsda(adap);
        scl = (adap->getscl == NULL) ? 1 : getscl(adap);
        if (!scl) {
                printk(KERN_WARNING "%s: SCL stuck low!\n", name);
                goto bailout;
        }
        if (!sda) {
                printk(KERN_WARNING "%s: SDA unexpected low "
                       "while pulling SCL high!\n", name);
                goto bailout;
        }

Now, if getscl() always returns zero when scllo() is called (because the
pin is set as an output) the test is pretty useless - it turns into a
verification that yes, the hardware does return zero from the pad register
when the pin is set as an output.

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
