From: olof@lixom.net (Olof Johansson)
Date: Sun, 4 Aug 2013 21:22:42 -0700
Subject: [GIT PULL] MCPM backends update
In-Reply-To: <alpine.LFD.2.03.1308042058280.14472@syhkavp.arg>
References: <alpine.LFD.2.03.1307221521200.15022@syhkavp.arg>
 <20130804200201.GH10876@quad.lixom.net>
 <alpine.LFD.2.03.1308042058280.14472@syhkavp.arg>
Message-ID: <CAOesGMjB+=auLRTAEfjuW5udJzuj4YS0G4nS7gHmyurZMVdt3Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 4, 2013 at 6:19 PM, Nicolas Pitre <nico@fluxnic.net> wrote:
> On Sun, 4 Aug 2013, Olof Johansson wrote:
>
>> On Mon, Jul 22, 2013 at 04:02:45PM -0400, Nicolas Pitre wrote:
>> > Hello gents,
>>
>> Hi, sorry for the delayed reply to this.
>>
>> > Would you please pull the following into ARM-SOC:
>> >
>> >     git://git.linaro.org/people/nico/linux mcpm+tc2
>> >
>> > This contains
>> >
>> > - Fixes to the existing Vexpress DCSCB backend.
>> >
>> > - Lorenzo's minimal SPC driver required by the TC2 MCPM backend.
>> >   As discussed on the list, this is not considered to be a MFD driver.
>> >   This hardly qualify as a bus driver either.  Conceptually, this is
>> >   a very platform specific register multiplex driver allowing subsystem
>> >   drivers to hook into.  I therefore moved it to
>> >   drivers/platform/vexpress/ which seems to please everyone.
>> >
>> > - The MCPM backend enabling SMP secondary boot and CPU hotplug
>> >   on the VExpress TC2 big.LITTLE platform.
>> >
>> > - MCPM suspend method to the TC2 backend allowing basic CPU
>> >   idle/suspend.  The cpuidle driver that hooks into this will be
>> >   submitted separately.
>> >
>> > This is based on v3.11-rc2.  The diffstat follows:
>> >
>> >  .../devicetree/bindings/arm/vexpress-spc.txt       |  36 +++
>> >  arch/arm/mach-vexpress/Kconfig                     |   9 +
>> >  arch/arm/mach-vexpress/Makefile                    |   1 +
>> >  arch/arm/mach-vexpress/dcscb.c                     |  58 ++--
>> >  arch/arm/mach-vexpress/tc2_pm.c                    | 304 +++++++++++++++++++++
>> >  drivers/platform/Kconfig                           |   4 +-
>> >  drivers/platform/Makefile                          |   1 +
>> >  drivers/platform/vexpress/Kconfig                  |   9 +
>> >  drivers/platform/vexpress/Makefile                 |   1 +
>> >  drivers/platform/vexpress/spc.c                    | 253 +++++++++++++++++
>> >  include/linux/vexpress.h                           |  17 ++
>> >  11 files changed, 671 insertions(+), 22 deletions(-)
>>
>>
>> The vexpress code continues to be uncooperative in fitting into any of
>> the existing conventions of how drivers and platform code is organized
>> in the kernel, which makes it hard to find a good home for it.
>
> No kidding.
>
>> I sort of see the appeal of having a generic driver for this, but the code is
>> already TC2-specific.
>
> I'm expecting the next b.L platform from ARM to be Cortex A57+A53 based
> which is 64 bits.
>
>> Also, most drivers under drivers/platform are more or less glue code
>> that sets up other drivers.
>
> But that's exactly what's happening here.
>
>> I don't think we want to have a calling
>> dependency from mach-vexpress into drivers/platform like this.
>
> The cpufreq driver (currently used by TC2 but I'd expect more vexpress
> flavors in the future) is also calling into this.  And that one doesn't
> live under mach-vexpress.
>
>> If it wasn't for that tight coupling then I think drivers/platform/arm
>> could be a good location for it.
>
> This is actually more "Versatile Express" related than "ARM" which IMHO
> is a bit too generic.  Hence "platform: vexpress".

I'd rather collect all arm{,64} platform drivers under one
drivers/platform/arm directory than have each SoC or platform vendor
add their own toplevel directory. Anyway, see below -- that's
tangential to this discussion now.

> And aren't we simply starting to bikeshed here?
>
>> I'm sure there'll come a time when a similar driver is needed for
>> something arm64-based on vexpress. Until then I think we're best off
>> just moving the code under mach-vexpress.
>
> That time is going to be sooner than you think.

I bet it'll be private for linaro for 6 months or so first, so don't
mind me if I choose to _not_ hold my breath. :)

>> Nico, would you mind moving it once again and this time to
>> mach-vexpress? I know you already brought it out of drivers/mfd.
>
> You know what?  This code did start in mach-vexpress originally.  But
> that was considered unsuitable a location.

Well, the code has been been cleaned up and restructured a few times
since then. I found these drivers to be pretty hairy when first
posted, so so I'm not going to feel guilty about looking at it
differently once the onion has been peeled a few layers.

> So could we stop fooling around please?
>
> I'd strongly plea for you to just pull this stuff as it is now.  We've
> wasted way too much time on the issue of a proper location for this code
> and other drivers are being gated on this. I think that
> drivers/platform/vexpress is Innocent enough to cause no harm.  So
> _please_ let's just use that and move it _if_ we find a more optimal
> location in the future.
>
> Please ?

How about this:

I'll pick this up in an unstable branch for now with three commits on
top of, which I will send out in a minute. Those three commits move
the code back next to tc2_pm, and has two tiny cleanups (quicker to do
that than go back and loop with code review). If you and Pawel and
Lorenzo are happy with those commits, I'll move the whole branch over
into next/soc and we'll lock it in for 3.12.

Before 3.12 merge window, I would really like to sort out the one
remaining question in the 3-patch thread, which is the binding (see
those emails).

We'll deal with sharing/abstraction that fits vexpress arm64 platforms
when we know more what will truly be shared, etc.

Btw, there's no corresponding dts/dtsi update for vexpress yet to
activate this code. That'll be needed too.

Deal?


-Olof
