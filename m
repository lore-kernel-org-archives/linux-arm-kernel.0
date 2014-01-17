From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 17 Jan 2014 20:24:05 +0000
Subject: More GPIO madness on iMX6 - and the crappy ARM port of Linux
In-Reply-To: <52D98712.3070103@wwwdotorg.org>
References: <20140117184731.GE15937@n2100.arm.linux.org.uk>
 <52D98712.3070103@wwwdotorg.org>
Message-ID: <20140117202405.GF15937@n2100.arm.linux.org.uk>
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

As has been pointed out, that's not how gpio_get_valie() is documented.
It's documented to return the value of the pin where possible.  In my
case, it _is_ possible to read back the value of the pin - it just
needs the appropriate chip configuration to make it happen.

Now to the crunch point of my email: where subsystems differ completely
_unnecessarily_ from what is expected from them - such as returning the
current state of the output where it's possible to do so - then this
kind of difference *reduces* the portability of that subsystem, and
makes being able to move from one SoC to another _unnecessarily_ more
difficult.

This is the issue: if everyone has to re-learn how subsystem X behaves
on hardware Y because it has unnecessarily different hardware, then
we're just making stuff much harder for no reason what so ever, and I'd
say there's no point to having that subsystem in the first place.  It's
nothing more than a waste of space.

Let's put it a different way - what if every hard disk you bought had
a completely different connector on it just because the manufacturer
could put a different connector on it, and you had to also buy their
special cable... oh, and the motherboard end also had a motherboard
specific connector, so you had to get the right connector at both ends
of the cable.  Electrically, the thing is the same, it's just that the
manufacturer is being perverse and changing the connector for the shere
hell of it.  Would that annoy you?

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
