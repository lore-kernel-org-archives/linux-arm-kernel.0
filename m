From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Sun, 1 Apr 2012 16:29:46 +0100
Subject: [PATCH] ARM: amba: adapt to regulator probe deferral change
In-Reply-To: <CACRpkdZUDs5pCk-zUns_0V5WDYwtJd+eOhk7129z_jbyV+pPAw@mail.gmail.com>
References: <1333115737-1654-1-git-send-email-shawn.guo@linaro.org>
 <20120330180134.GJ22981@n2100.arm.linux.org.uk>
 <20120331134215.GA5012@opensource.wolfsonmicro.com>
 <20120331143539.GB26661@n2100.arm.linux.org.uk>
 <20120331165301.GC5012@opensource.wolfsonmicro.com>
 <CACRpkdZUDs5pCk-zUns_0V5WDYwtJd+eOhk7129z_jbyV+pPAw@mail.gmail.com>
Message-ID: <20120401152945.GB8971@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 01, 2012 at 02:19:32PM +0200, Linus Walleij wrote:

> Modeling the actual switches for the power domains as regulators
> is a good idea IMO. If using the thing in drivers/base/power/domain.c
> this still results in some code that has to flip the actual switch
> somewhere, and that very switch may well be modeled as a
> regulator. Example drivers/regulator/db8500-prcmu.c

I have to say that this is a really unusual implementation of power
domains, and it's not currently deployed in mainline in this way (in
that nothing I can find has a vcore hooked up) .  The only other on-SoC
regulators are the anatop regulators in newer i.MX processors but those
are clearly a use case for the regulator API since they do voltage
changes.

> So the AMBA bus would instead of using regulators directly have
> to use the power domains directly to achieve the same effect.
> Then the power domain implementation would need to do the
> handling of deferred probing, if it happens to be using regulators
> to turn the voltage domain switches.

Absolutely, yes.  But we'd also get the benefit that platforms which
don't implement things in this specific way wouldn't have to stub things
out or anything and platforms that have more detailed requirements for
power domain management that go over multiple APIs wouldn't have to
work out if they try to dance around the standard support or ignore it.

One nice thing here is that power domains don't require per-bus
handling, the driver model takes care of everything transparently to the
bus using runtime PM.  This is similar to the move to dev_pm_ops in that
it greatly reduces the amount of open coding that is required in buses
to support power management features.

> That could (on some) platforms be handled in a centralized manner
> such as done by drivers/base/power/clock_ops.c
> say a regulator_ops.c thing instead.

If you were to read my original reply to Russell you'll see I did mutter
about this idea...  it should have a few more bells and whistles than
what the clock ops do but it's about there.

> What I think is the central question is whether it was a mistake
> after all to model power domain switches as regulators, since the
> subsystem may be developing in a way more suited for off-chip
> regulator things with complex dependency chains and isn't
> suitable for the type of "just flip a bit in a memory
> mapped register" type of voltage domain regulator.

This isn't something that's changed - the code that's there in mainline
has never been good practice for regulator usage, it's never been a good
idea to silenty ignore a failure to acquire power for the device.  For
most hardware power is fairly important to correct operation.  I'd have
said exactly the same things if I'd noticed the code prior to the change
for deferred probe, it's just that I was unaware of it until Shawn sent
his patch.

For example, if we get an init ordering problem or something with the
current approach you might end up with the regulator API deciding to
power off power domains it thinks aren't in use (because the
regulator_get() failed) and no errors reported until the driver notices
that the hardware underneath it doesn't have power any more.

> Maybe a power domain regulator shall be something simpler
> than an ordinary regulator? I think the abstraction we get
> through having it as a regulator is essentially good but implying
> a relationship to off-chip I2C-based regulators with complex
> deferred probing may not be desireable.

You've still got the same problems on chip as off chip - all this stuff
can be triggered just as easily by init order changes, making things
modular or new inter-subsystem dependencies appearing.  Off chip gives
boards more flexibility to do fun stuff which triggers issues but
fundamentally the issues are always there.

> Should we think of something like a simpler, atomic ops
> type "SoC regulator" or something like that, and then
> require power domains to use such an abstraction instead
> of the ordinary regulator?

Honestly I'd just use power domains, it's a large part of what they're
there for and it plays more nicely.  If all you're looking for from the
framework is reference counting it delivers that very nicely with no
work on the part of the bus and no impact on systems that don't use the
feature.  

You also don't have to deal with the regulator machine interface to
match the power domains with their devices which is the problem Shawn's
run into and is going to be a general annoyance.

With gen_pd it's really simple to implement this stuff, and indeed it
should be fairly simple to make a generic gen_pd domain which takes a
regulator and turns it on and off as needed that people can pick up off
the shelf.  That should be a good way to have platforms that want to use
this model positively select for it while allowing platforms with
different needs the flexibilty to do other things.

Power domains have also got features like being able to defer the
suspend for latency reasons and make it much easier to integrate more
complex constraints on when and how to enter states since the system can
insert random code which talks to any API.  From the SoCs I've looked at
you're usually going to want to do something more than what the
regulator API supports directly.  Even if you're going directly to an
off chip regulator with the control if you want to do something like
voltage scaling you're going to need something SoC specific in the way
to make the decisions.

As a regulator API maintainer when I've been working on power domains
for S3C64xx I went straight to the generic power domain code, it's
really nice and to me it seems like it's a much better fit for the
problem.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120401/0df5c55c/attachment.sig>
