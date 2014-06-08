From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Sun, 8 Jun 2014 13:45:30 +0100
Subject: Problems booting exynos5420 with >1 CPU
In-Reply-To: <CAOesGMj+itYr-daqxfX=J3Ss+7YdWhUUzBWTW3FqVEH8tXqt-A@mail.gmail.com>
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
Message-ID: <20140608124530.GA31921@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 08, 2014 at 12:53:34AM +0100, Olof Johansson wrote:
> Lorenzo,
> 
> Since you're emailing from @arm.com, some of this is to the wider
> recipient and maybe not directly to you:

I am glad to reply and take blame since this is a debate definitely worth
having.

[...]

> > Right, CCI snoops and DVMs for a cluster must be enabled by the first man
> > running in that cluster upon cluster power up with caches off, where the
> > first man must be arbitrated if multiple CPUs are racing for enabling CCI.
> > This is not an issue on cold boot, it is on resuming from CPUidle.
> 
> That's already handled by the MCPM backend on exynos:
> 
> /*
>  * Enable cluster-level coherency, in preparation for turning on the MMU.
>  */
> static void __naked exynos_pm_power_up_setup(unsigned int affinity_level)
> {
>         asm volatile ("\n"
>         "cmp    r0, #1\n"
>         "bxne   lr\n"
>         "b      cci_enable_port_for_self");
> }
> 
> >> > True, TC2 on warm-boot reenables CCI, and that's because it runs the
> >> > kernel in secure world, and again that's _wrong_.
> >>
> >> Let me respectfully disagree.
> >
> > You are welcome =)
> >
> >> > It must be done in firmware, and I am totally against any attempt at
> >> > papering over what looks like a messed up firmware implementation with
> >> > a bunch of hacks in the kernel, because that's what the patch below is
> >> > (soft restarting a CPU to enable CCI ? and adding generic code for that ?
> >> > what's next ?)
> >>
> >> Are you promoting for the removal of drivers/bus/arm-cci.c ?
> >
> > I really do not want to go there, but I might (apart from CCI PMUs).
> >
> >> You do realize that the fundamental raison d'?tre for MCPM is actually
> >> to manage the race free enabling of the cache and CCI ?
> >
> > Yes I do and I was willing to help implement it for TC2 to provide people
> > with an example on how to do it _properly_ (in secure world though, and that
> > was a mistake IMHO). If what we get is a workaround for every platform
> > going upstream, we are in a bind, seriously.
> 
> Real life is messy. Bugs happen. Having a stance that the kernel has
> to be a puritan implementation that can be done in a vacuum where bugs
> in hardware and firmware don't exist (and are fixable in the right
> place every single case) is not realistic. Linux is a useless piece of
> software to us if that is the case.
> 
> I've seen this from several other ARM developers in the past. It's
> almost like they were a couple of degrees removed from actually
> working on shipping real products and dealing with real users.

Guys, do not get me wrong here. There are fixes that can be deemed
acceptable in an OS, there are fixes that can't. I just can't help thinking
that Nicolas' patch is a nasty hack (and I am far, really really far from
blaming him for that, because that's the only patch that can fix that
issue in the kernel), and he perfectly knows that.

> > Whatever the outcome of this thread, a booting protocol update for CCI
> > is in order, even if we have to debate it for 6 months or more to get
> > an agreement.
> 
> Ding ding ding. Current documentation is in some very complex C
> frameworks (MCPM), and some device tree bindings that obviously don't
> cover this. Real documentation is obviously needed, but more than that
> (see below).
> 
> I'd actually argue that you don't have a leg to stand on in your
> complaints at all because:
> 
> 1) There's no documentation of the requirements
> 2) The only existing golden platform (TC2) manages CCI similar to how
> exynos does.

1) Blame taken, nothing to say. That's why I mentioned that CCI enablement
   must be part of a boot protocol document to prevent this from happening
   again.

2) Apart from the boot cluster, but that's related to (1).

> >> > I understand there is an issue and lots at stake here, but I do not want the
> >> > patch below to be merged in the kernel, I am sorry, it is a tad too much.
> >>
> >> Lorenzo: Don't get me wrong.  The Chromebooks, and possibly to some
> >> extent some people at Samsung, were simply too confident in their
> >> ability to create absolutely bug-free firmware code to the point of not
> >> making its update easy in the field.  This is completely outrageous in
> >> my point of view.
> 
> I would like to clarify that firmware is updateable today. But
> Chromebooks are in many ways vertically integrated products, so if a
> problem is found, there's always going to be a trade-off between the
> places to fix it for our own product.
> 
> I have successfully argued for fixes in firmware (or EC) for some bugs
> in the past. For others we have to go with the cheaper fix. And at the
> end of the day, pushing out a new firmware is a massive undertaking
> compared to a kernel workaround, and doing so only because upstream
> maintainers aren't happy with the way we and Samsung solved something
> in our firmware+kernel combo is an argument that is hard to win -- it
> doesn't affect the product at all, only those wanting to run an
> upstream kernel on it.
> 
> I'm a very strong proponent of enabling upstream support for our
> platform (for several reasons -- most of these are actually business
> reasons for us, but also because it's the right thing to do). Finding
> the trade-off for what workarounds are still reasonable to do in the
> kernel for that situation is obviously hard and we're disagreeing. But
> the scope for these workarounds is not large.
> 
> Personally, I'm of the opinion that if we can add a few hooks to take
> care of something, or keep something contained in a piece of platform
> code, then it's not a given that we have to reject the workaround. If
> we have to modify core code (or substantially impact core ARM code)
> then it's time to consider fixing in firmware or wherever else.
> 
> In this case, the change we're looking at is enabling the CCI port for
> the boot cpu. It's perfectly containable in exynos-only code, and we
> can surround it by however many comments of never ever using it as an
> example for how to do it as you'll want.

I agree with what you are saying, but if for any reason someone will
copy that code to paper over yet another firmware quirk and think that's
the right thing to do, that would be grave IMHO.

So:

1) CCI requirements added to boot document
2) If Nico's patch get in we must stick a massive disclaimer summing up
   this thread in there
3) Next time the answer will be: NAK.

Do we agree ? I still have very strong feelings against (2) and I would
be very glad to avoid merging that patch.

> >> Yet one of the reactions was to call upstream kernel
> >> people as purists because the kernel is so much easier to modify in
> >> order to cover their mess and yet that might not be accepted.  Like I
> >> said I won't stop shaming them publicly for their own "incompetence"
> >> just yet (no pun intended), but being excessively purist does not
> >> benefit anyone either, and for that they have a point.
> >
> > I do not think they do. The kernel should not become a place where firmware
> > bugs are fixed, if you refuse to fix the bug and this code does not get
> > upstream I am pretty sure next time more attention will be paid.
> 
> You do realize that you have absolutely zero leverage over us on this,
> right? Our product is already shipped with kernel code that fixes
> this. The only parties you hurt by doing this is community developers
> that want to run an upstream kernel on the platform. Apparently
> several of them want to work on sorting out energy aware scheduling on
> a platform that is easily available -- mostly people at Linaro and
> ARM. I think it makes sense to do what we have to do to enable that
> without having people tear their machines open and voiding warranties.

I have zero leverage, but still the right to say what I think.
The patch fixing CCI enablement for the boot CPU is a nasty hack
and that's certainly not Nicolas' fault.

I understand your point, and I do not want to stop people from using
this platform with upstream code, actually I am the first who is happy
to see power management code getting in the mainline, but not at all costs,
because this has consequences for US.

> > Booting, powering up and down cores are standard procedures, why can't we
> > share the same code for all v7 platforms ? Why ?
> 
> That's something you should ask your colleagues. ARM has historically
> refused to require standards for these things, and it causes the mess
> we see now. Arbitrarily changing the requirements from your part of
> kernel isn't going to change the marketplace.

ARM are pushing for open trusted firmware, ARM TRMs are available to
partners with those sequences described, and I have always been willing
to support developers.

We should do more, but that does not justify these bugs, really.

> > And we are not talking about a race condition hit every 10 gazillions
> > cycles here.
> >
> >> *HOWEVER* I have no choice but to say that many people at ARM, including
> >> a couple individuals for whom I nevertheless have a lot of admiration,
> >> also have an incredible faith in their ability to convince themselves,
> >> and then turn around to preach to the world, that *more firmware* is
> >> going to be so much purer and solve so many more problems than it
> >> creates and become such a magical success that we should immediately
> >> dedicate our soul to the cause with no hint of a doubt.
> >>
> >> I'm sorry to rain on your parade, but I don't believe in this one iota.
> >>
> >> Let me repeat the MCPM story again: it took 3 people, including 2 from
> >> ARM, over *six* months to get everything right and stable on TC2. I
> >> think you also contributed to that effort as well. Subsequent MCPM
> >> backend contributions (yes, just the backend and not the core code) took
> >> at least *five* rounds of reviews in one case, and after *seven* rounds
> >> in another case it is still not right, despite the publicly available
> >> TC2 implementation to serve as a reference.
> >>
> >> I'm sure each time a new patch set was posted, their authors honestly
> >> believed their code was correct.  Otherwise why would they post buggy
> >> code?
> >>
> >> Now you are telling me that they should have put that code into firmware
> >> instead?  Can you realize what a catastrophe this would have been? Are
> >> you _seriously_ believing that they would be up to their 5th firmware
> >> revision by now?  And that updating their firmware six months after
> >> product launch would be as easy as updating the kernel?
> >
> > If firmware messes up the DMC controller configuration, would you fix
> > it in the Linux kernel ? It is an unrealistic (well..) example but you should
> > catch my drift.
> 
> It's actually perfectly realistic, and we did exactly this in the
> first ARM Chromebook. We never upstreamed the code because it only
> affected a smaller number of models (it's something we did update the
> RO firmware for in production).
> 
> > Where do we draw the line, that's my point.
> 
> You draw the line by giving vendors a place to do the nasty stuff that
> needs to be done in a place that doesn't impact others, and where
> others don't have to look. Quirk tables, fixup functions, or function
> pointers that can be replaced on a specific platform if needed. When
> it affects core code, you sort it out in a different way if you have
> to.
> 
> There'll always be some ugly code that needs to go somewhere. This
> isn't rocket science. It's something we've done in the kernel since
> pretty much forever. In some cases, we can even share the quirks if
> several vendors have made the same mistakes.
> 
> Maybe it's just me, but I didn't use to see this disconnected puritan
> world view from people until DT came along. I don't think it's DTs
> fault, but I think the requirements of DT-as-ABI has tainted the
> mindset of many developers in a way that they treat everything as
> needing to be polished to a perfect shine in all aspects, all the
> time.

Olof, it is not puritanism, it is all about upstreaming code. If we
keep accepting these hacks and we end up with mach code full of them
we have a problem, do you agree ?

You, Russell and Nico know what to do, I wanted to get my opinion
across and I think you got my point.

> >> Software ALWAYS has bugs, whether it is user apps, the kernel, firmware
> >> or boot ROM. The bigger one of those parts is, the more bugs it will
> >> have. And the cost to vendors for fixing those bugs grow exponentially
> >> down each level. For proof, we're now considering possible workarounds
> >> in the kernel to sidestep the difficulty with updating the firmware on a
> >> Chromebook.
> >>
> >> Yet you're saying that firmware should grow code with the same
> >> complexity as the MCPM core, plus a machine specific backend that
> >> experience has proven multiple times is evidently hard to get right,
> >> into firmware because running Linux in secure mode is wrong?  If so we
> >> don't live in the same world indeed.
> >>
> >> The day I see a firmware architecture that allows for 1) the same level
> >> of peer review as what we enjoy with the Linux kernel code and 2) the
> >> same ability to perform updates in the field as the kernel, then maybe I
> >> could be sold on the many advantages having generic firmware might have.
> >> In the meantime I consider complex firmware as a very suboptimal
> >> architecture with no bearing on the reality of actual short-cycled
> >> products, and if they prevail we'd better be ready to pile more of those
> >> ugly hacks in the kernel.
> 
> I couldn't agree more. MCPM and the b.L stuff is also a brand new
> concept, that the reference code was kept secret for longer than it
> should have been, and few people have been through a full product
> cycle of it and learned lessons. We're obviously learning several
> right now on our first one.
> 
> Expecting things to be perfect from day one is not realistic.

I do not buy this I am sorry. Fair enough, CCI is a new concept, but
SMP power management has been implemented in older platforms with
the same requirements, nothing new and still people are getting this
wrong.

> > Nicolas: it is not a matter of PSCI vs. MCPM, firmware vs. the kernel,
> > that's a debate worth having, not now.
> >
> > There is a bug to solve, and you did. What I am telling you is that
> > I am fed up to my back teeth of having code in the kernel solving
> > issues that should not be solved in the kernel, if we keep doing that
> > hacks will become the rule not the exception. Time to draw a line,
> > firmware is broken, so is the platform. (BTW, if anyone can explain to
> > me how CPUidle works in this platform, and that's the main reason of
> > having MCPM in there, I am all ears).
> 
> Punting all this to software means that there will be bugs to fix in
> software. Period. In the real world, fixing those bugs will not be
> practical to do in the best possible place. Life sucks.
> 
> You do know that we're arguing over a one-time setup of the boot cpu
> port on the CCI and coming in and out of system suspend/resume here,
> right? Everything else should already be covered by the runtime
> MCPM/CCI code from Nico (together with the exynos backend). So this is
> just the first CCI setup on boot as well as after S3 suspend/resume.
> One-time code paths, not critical path and definitely containable
> within the platform code.

See above. And let's hope MCPM is useful at all on this platform, which
means CPUidle can be enabled and working.

> > Adding these hacks has serious maintainance consequences (eg CPUidle
> > code) and that's the main reason I jumped into this discussion.
> 
> > Let me reiterate my point: it is not a kernel vs firmware debate, it
> > is about clean and maintainable code vs hackish and unmaintainable
> > code in the kernel.
> 
> No, it's about having code that runs in the real world, versus some
> random framework that doesn't actually fill a useful purpose since
> nobody can make use of it without a bunch of out-of-tree code.

PSCI is not a random framework, it is a standard and it runs in real
world platforms and would hide all these HW quirks where they belong.

It won't be perfect, but hey, neither is this code.

> > And of top of that, people must test their code, we are not talking
> > about a rare race condition here, this is a blatant bug.
> 
> Where's the test suite that would have caught this?
> 
> Or hell, I'll be happy to see a document that declares the requirement
> of firmware to enable the CCI port on the boot cluster. You admit
> above that there is none.

See above, blame taken but FW/HW engineers should know that a multicluster
coherent system should have coherent caches to be properly booted.

> Samsung chose to do that in the kernel instead of firmware, nobody
> involved knew better at the time and we now have to deal with it. It's
> unlikely to go uncaught on the next product iteration, but things like
> this happen.

Fair enough, provided it is the last time this happens.

> > I have lots to add concerning the firmware implementations of power
> > down procedures, but let's take it offline.
> >
> > I am not happy with merging your patch, I am sorry, for the reasons I've
> > just explained.
> 
> Wow, you're going to be really, really frustrated over how the world
> will start to look with all the "standardized" closed firmware
> platforms and their quirks and bug workarounds we'll have to add in
> the kernel.

Yes, and I will shout even louder when that will happen =)

Thanks !
Lorenzo
