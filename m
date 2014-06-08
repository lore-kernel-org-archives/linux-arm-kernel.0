From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Sun, 8 Jun 2014 13:53:43 -0400 (EDT)
Subject: Problems booting exynos5420 with >1 CPU
In-Reply-To: <20140608124530.GA31921@e102568-lin.cambridge.arm.com>
References: <539145B4.5000200@gmail.com>
 <CAD=FV=XqwEQNJmij-4Gh62OY+B66AjdQjZC0=f_6tbot3UfQaA@mail.gmail.com>
 <CAM4voaknx3+X4O8MUwaruUFPyquY8Opq61ucKX08xTrv8PqfLg@mail.gmail.com>
 <alpine.LFD.2.11.1406061740280.25775@knanqh.ubzr>
 <CAM4voam5KDicwLAt3EA1UC7M+EciGccrnMUKxoR-5c8xT8-zSQ@mail.gmail.com>
 <alpine.LFD.2.11.1406062340480.25775@knanqh.ubzr>
 <20140607175618.GA25068@e102568-lin.cambridge.arm.com>
 <alpine.LFD.2.11.1406071431490.25775@knanqh.ubzr>
 <20140607223614.GA26641@e102568-lin.cambridge.arm.com>
 <CAOesGMj+itYr-daqxfX=J3Ss+7YdWhUUzBWTW3FqVEH8tXqt-A@mail.gmail.com>
 <20140608124530.GA31921@e102568-lin.cambridge.arm.com>
Message-ID: <alpine.LFD.2.11.1406081138070.25775@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 8 Jun 2014, Lorenzo Pieralisi wrote:

> On Sun, Jun 08, 2014 at 12:53:34AM +0100, Olof Johansson wrote:
> > Lorenzo,
> > 
> > Since you're emailing from @arm.com, some of this is to the wider
> > recipient and maybe not directly to you:
> 
> I am glad to reply and take blame since this is a debate definitely worth
> having.

Great.  Because I would like to steer this debate a little towards the 
genuine cause rather than sticking to some particular consequences.

> Guys, do not get me wrong here. There are fixes that can be deemed
> acceptable in an OS, there are fixes that can't. I just can't help thinking
> that Nicolas' patch is a nasty hack (and I am far, really really far from
> blaming him for that, because that's the only patch that can fix that
> issue in the kernel), and he perfectly knows that.

You know what?  The more I think about my patch, the more I consider 
this should be the standard way of setting up things unconditionally on 
_all_ platforms using MCPM.  Why? Because that's the most coherent thing 
to do!

I really think the kernel should either be responsible for the CCI or it 
should not at all.  And conversely for the bootloader.  Right now we 
have an implicit requirement that the bootloader should turn on the CCI, 
but only for cold boot, and only for the boot cluster, and not for CPU 
resuming from idle, and what other case we haven't thought about yet.  
And as noticed this requirement is not documented.

> > > Whatever the outcome of this thread, a booting protocol update for CCI
> > > is in order, even if we have to debate it for 6 months or more to get
> > > an agreement.
> > 

And in the end I don't think the CCI should have to be documented as a 
boot requirement.  Instead of having firmware implementers understand 
when they should care about the CCI and when they shouldn't, I'd much 
prefer if they hadn't to care at all. I really prefer when 
responsibility for something is well encapsulated in one place and not 
shared across layers like the firmware or the kernel depending on some 
context. The complexity of a system (and therefore the probability for 
bugs) grows with the square of the number of interrelations between 
constituent parts. So we should always strive to make the boot protocol 
_simpler_ not more complex.

And if complete responsibility for the CCI in the kernel had been 
assumed from the beginning, we wouldn't be struggling in this power play 
to determine which side should give in.  Especially since the kernel has 
all the necessary infrastructure to do it all already, and I must say in 
a rather elegant manner.

> > I'm a very strong proponent of enabling upstream support for our
> > platform (for several reasons -- most of these are actually business
> > reasons for us, but also because it's the right thing to do). Finding
> > the trade-off for what workarounds are still reasonable to do in the
> > kernel for that situation is obviously hard and we're disagreeing. But
> > the scope for these workarounds is not large.

Will people ever realize that, if the kernel was more in control of the 
hardware (isn't that the role of an OS kernel to serve as the hardware 
abstraction layer?) then we wouldn't be talking about "workarounds" but 
rather "standard fixes"?

> > In this case, the change we're looking at is enabling the CCI port for
> > the boot cpu. It's perfectly containable in exynos-only code, and we
> > can surround it by however many comments of never ever using it as an
> > example for how to do it as you'll want.

In this case, to state my opinion clearly, it is the general design that 
was flawed and the kernel should be fixed to enable the CCI for the boot 
CPU itself _when_ it knows it is going to need it.  To start with, the 
bootloader has no need what so ever for using more than one CPU, unless 
it wants to become an operating system, so it shouldn't have to care at 
all.  The kernel, if booted without the CCI information in the DTB, will 
run with only one CPU and won't rely on the CCI.  Logically the CCI 
could be left turned off in that case, possibly increasing bus 
performance and saving some power.

> I agree with what you are saying, but if for any reason someone will
> copy that code to paper over yet another firmware quirk and think that's
> the right thing to do, that would be grave IMHO.

Someone shouldn't have to copy that code because I'm getting more and 
more convinced it should be made generic and unconditional, and by doing 
so removing any possibility for firmware to get that part wrong again.  
According to my quick experiment on TC2, this took only 271 microseconds 
to perform so this is not like if that would make a significant 
difference in boot time.

> > > I do not think they do. The kernel should not become a place where firmware
> > > bugs are fixed, if you refuse to fix the bug and this code does not get
> > > upstream I am pretty sure next time more attention will be paid.

Again, this is coming about because firmware is a MAGNITUDE harder to 
fix and IMPOSSIBLE to be bug free, just like any other software. So if I 
may get back to the genuine cause for this debate: this came about 
because of TOO MUCH firmware code and encouraging people to create more 
of it is *BAD*.

Sure, in the server world you are likely to want firmware and standards 
because that helps bringing maintenance costs down.  But server 
equipment has much longer life cycles than mobile devices and somewhat 
less aggressive and complex power management to perform. Firmware for 
servers may take *time* to be developed, tested, certified, etc.  To 
illustrate this, we've been working on UEFI and ACPI for a period tat 
can be measured in years at this point.  So, hopefully by the time 
server oriented firmware is available, it would be well tested and 
relied upon for a long time.

none of the above applies to consumer products with fast development and 
short life cycles.

> I understand your point, and I do not want to stop people from using
> this platform with upstream code, actually I am the first who is happy
> to see power management code getting in the mainline, but not at all costs,
> because this has consequences for US.

And those consequences are?

> ARM are pushing for open trusted firmware, ARM TRMs are available to
> partners with those sequences described, and I have always been willing
> to support developers.

Ahhhh...  Here we are. "ARM are pushing for open trusted firmware ..."

> We should do more, but that does not justify these bugs, really.

Bugs are never justifiable, but they happen _all_ the time.

Firmware is a MAGNITUDE harder to fix, and IMPOSSIBLE to be bug free
just like any other software.

> > > Where do we draw the line, that's my point.
> > 
> > You draw the line by giving vendors a place to do the nasty stuff that
> > needs to be done in a place that doesn't impact others, and where
> > others don't have to look. Quirk tables, fixup functions, or function
> > pointers that can be replaced on a specific platform if needed. When
> > it affects core code, you sort it out in a different way if you have
> > to.

Again this is missing the point.  No line would need to be drawn if the 
core code was responsible in the first place.  DMC parameters are 
conceptually so trivial that no one should normally mess that up, and 
the firmware must do it just so that memory is usable.  So there is no 
choice but to do that in firmware.  It is a completely different story 
with complex operations which should never ever be relegated to 
firmware.

> > Maybe it's just me, but I didn't use to see this disconnected puritan
> > world view from people until DT came along. I don't think it's DTs
> > fault, but I think the requirements of DT-as-ABI has tainted the
> > mindset of many developers in a way that they treat everything as
> > needing to be polished to a perfect shine in all aspects, all the
> > time.
> 
> Olof, it is not puritanism, it is all about upstreaming code. If we
> keep accepting these hacks and we end up with mach code full of them
> we have a problem, do you agree ?

Absolutely!

So once again, let's take a step back, open our eyes and look at the 
fundamental reason why hacks are there, and how they could fundamentally 
be avoided.  And no, hoping for fewer bugs in firmware is not realistic 
if people are encouraged to create more of it.

> > Expecting things to be perfect from day one is not realistic.
> 
> I do not buy this I am sorry. Fair enough, CCI is a new concept, but
> SMP power management has been implemented in older platforms with
> the same requirements, nothing new and still people are getting this
> wrong.

Lorenzo: what you say is not exact.  People screwed SMP power management 
in the past for sure.  And they still will because requirement are 
changing all the time they're not the same.  Maybe requirements are 
somewhat stable in the server space, but in the mobile space they're 
not. So this must be implemented where it is cheapest to fix.

> > > Nicolas: it is not a matter of PSCI vs. MCPM, firmware vs. the kernel,
> > > that's a debate worth having, not now.

Why not?  I'm saying that too much firmware is a fundamental design 
mistake for consumer products.  All the rest falls off from that.  Why 
not addressing the source of the problem rather than constantly 
suffering and debating its consequences?

Again I want to clearly state that I have nothing against PSCI the 
interface spec despite the appearances.  I've reviewed its draft and 
provided comments, etc.  My point is, when taking a step back, we may 
only conclude that more firmware does not create a better system overall 
because of real life costs and constraints associated to it. So PSCI is 
not the problem, the problem is at another conceptual level.

> > > Adding these hacks has serious maintainance consequences (eg CPUidle
> > > code) and that's the main reason I jumped into this discussion.

Sorry, I don't see the connection.

> > > Let me reiterate my point: it is not a kernel vs firmware debate,

But of *course* it is, unless you're too invested in your firmware 
strategy to be able to see all the downsides.

> > > it is about clean and maintainable code vs hackish and 
> > > unmaintainable code in the kernel.

No argument there.  Unfortunately, hackish code comes about because of 
broken firmware in most cases.  Kernel code can be cleaned at any moment 
but in practice firmware code cannot.

> > No, it's about having code that runs in the real world, versus some
> > random framework that doesn't actually fill a useful purpose since
> > nobody can make use of it without a bunch of out-of-tree code.
> 
> PSCI is not a random framework, it is a standard and it runs in real
> world platforms and would hide all these HW quirks where they belong.

Which real world platforms?  I'm curious.

> > Wow, you're going to be really, really frustrated over how the world
> > will start to look with all the "standardized" closed firmware
> > platforms and their quirks and bug workarounds we'll have to add in
> > the kernel.
> 
> Yes, and I will shout even louder when that will happen =)

That _will_ happen. Such is life. And you'll have only yourself to blame 
because you pushed for bigger firmware to be created in the first place.


Nicolas
