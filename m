From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 17 Jan 2014 20:53:46 +0000
Subject: More GPIO madness on iMX6 - and the crappy ARM port of Linux
In-Reply-To: <52D995C4.80104@wwwdotorg.org>
References: <20140117184731.GE15937@n2100.arm.linux.org.uk>
 <52D98712.3070103@wwwdotorg.org>
 <20140117202405.GF15937@n2100.arm.linux.org.uk>
 <52D995C4.80104@wwwdotorg.org>
Message-ID: <20140117205346.GH15937@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 17, 2014 at 01:42:44PM -0700, Stephen Warren wrote:
> On 01/17/2014 01:24 PM, Russell King - ARM Linux wrote:
> > On Fri, Jan 17, 2014 at 12:40:02PM -0700, Stephen Warren wrote:
> >> On 01/17/2014 11:47 AM, Russell King - ARM Linux wrote:
> >>> So, we have this wonderful GPIO layer which abstracts GPIO stuff and
> >>> hides stuff.  It's really wonderful, because you don't have to care
> >>> about how the GPIOs are actually accessed in drivers anymore.
> >> ...
> >>> 1. What should gpio_get_value() return for an output?
> >>
> >> Some HW can't ever read back the value of an output pin, so isn't
> >> calling gpio_get_value() undefined for output pins?
> > 
> > As has been pointed out, that's not how gpio_get_valie() is documented.
> > It's documented to return the value of the pin where possible.  In my
> > case, it _is_ possible to read back the value of the pin - it just
> > needs the appropriate chip configuration to make it happen.
> > 
> > Now to the crunch point of my email: where subsystems differ completely
> > _unnecessarily_ from what is expected from them - such as returning the
> > current state of the output where it's possible to do so - then this
> > kind of difference *reduces* the portability of that subsystem, and
> > makes being able to move from one SoC to another _unnecessarily_ more
> > difficult.
> 
> If the gpio_get_value() was guaranteed never to be valid for an output
> pin, that would actually be *more* portable, not less; it would work the
> same way everywhere.
> 
> I believe you want gpio_get_value() to return either the driven or
> actual pin value where it can on the current HW, but just e.g. hard-code
> 0 on other HW. That would introduce a core feature that works some
> places but not others, and hence make drivers that relied on the feature
> less portable between HW with different actual features.

I can buy that argument, but there's an issue which stands squarely in
its way, and that is open-drain GPIOs.

These are modelled just as any other GPIO, mainly so that both
gpio_set_value(gpio, 1) and gpio_direction_input(gpio) both result in
the signal being high.  The only combination which results in the
signal being driven low is outputting zero - and the state of the signal
can aways be read back.

The problem here is that such gpios are implemented in things like the
I2C driver such that they're _always_ outputs, and gpio_set_value() is
used to pull the signal down.  gpio_get_value() is used to read its
current state.

So, if we say that gpio_get_value() is undefined, we force such
subsystems to always jump through the non-open-drain paths (using
gpio_direction_input() to set the line high and
gpio_direction_output(gpio, 0) to drive it low.)

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
