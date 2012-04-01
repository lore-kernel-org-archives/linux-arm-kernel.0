From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 1 Apr 2012 14:19:32 +0200
Subject: [PATCH] ARM: amba: adapt to regulator probe deferral change
In-Reply-To: <20120331165301.GC5012@opensource.wolfsonmicro.com>
References: <1333115737-1654-1-git-send-email-shawn.guo@linaro.org>
 <20120330180134.GJ22981@n2100.arm.linux.org.uk>
 <20120331134215.GA5012@opensource.wolfsonmicro.com>
 <20120331143539.GB26661@n2100.arm.linux.org.uk>
 <20120331165301.GC5012@opensource.wolfsonmicro.com>
Message-ID: <CACRpkdZUDs5pCk-zUns_0V5WDYwtJd+eOhk7129z_jbyV+pPAw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 31, 2012 at 6:53 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Sat, Mar 31, 2012 at 03:35:39PM +0100, Russell King - ARM Linux wrote:
>> On Sat, Mar 31, 2012 at 02:42:15PM +0100, Mark Brown wrote:
>
>> > We need to change the AMBA bus so it does something better than what it
>> > does now and work out a good way to roll this out. ?The more I think
>> > about this the less convinced I am that AMBA should have regualtor
>> > support in the bus itself at all.
>
>> How else does it power up the peripheral to read out the IDs? ?You can't
>> bind a driver until you've read the ID, which implies that the bus layer
>> needs to have regulator support to turn the power on.
>
> Like I said further down my mail it seems like any systems which do have
> individual regulators for the AMBA devices probably ought to be managing
> this via power domain code rather than by going direct to the regulator
> API. ?If actual regulators are required the power domain code for the
> platform would be responsible for doing that rather than AMBA itself but
> for most SoCs it's likely to not go through the regulator API if there's
> any sort of gating support at all.

Modeling the actual switches for the power domains as regulators
is a good idea IMO. If using the thing in drivers/base/power/domain.c
this still results in some code that has to flip the actual switch
somewhere, and that very switch may well be modeled as a
regulator. Example drivers/regulator/db8500-prcmu.c

So this would turn to the question of inserting a layer of power
domain abstraction inbetween the device/bus and the regulator.

So the AMBA bus would instead of using regulators directly have
to use the power domains directly to achieve the same effect.
Then the power domain implementation would need to do the
handling of deferred probing, if it happens to be using regulators
to turn the voltage domain switches.

That could (on some) platforms be handled in a centralized manner
such as done by drivers/base/power/clock_ops.c
say a regulator_ops.c thing instead.

What I think is the central question is whether it was a mistake
after all to model power domain switches as regulators, since the
subsystem may be developing in a way more suited for off-chip
regulator things with complex dependency chains and isn't
suitable for the type of "just flip a bit in a memory
mapped register" type of voltage domain regulator.

Maybe a power domain regulator shall be something simpler
than an ordinary regulator? I think the abstraction we get
through having it as a regulator is essentially good but implying
a relationship to off-chip I2C-based regulators with complex
deferred probing may not be desireable.

Should we think of something like a simpler, atomic ops
type "SoC regulator" or something like that, and then
require power domains to use such an abstraction instead
of the ordinary regulator?

Yours,
Linus Walleij
