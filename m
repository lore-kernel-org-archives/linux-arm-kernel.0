From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 10 Jun 2014 00:25:47 -0400 (EDT)
Subject: Problems booting exynos5420 with >1 CPU
In-Reply-To: <20140609222604.GA16889@e102568-lin.cambridge.arm.com>
References: <alpine.LFD.2.11.1406061740280.25775@knanqh.ubzr>
 <CAM4voam5KDicwLAt3EA1UC7M+EciGccrnMUKxoR-5c8xT8-zSQ@mail.gmail.com>
 <alpine.LFD.2.11.1406062340480.25775@knanqh.ubzr>
 <20140607175618.GA25068@e102568-lin.cambridge.arm.com>
 <alpine.LFD.2.11.1406071431490.25775@knanqh.ubzr>
 <20140607223614.GA26641@e102568-lin.cambridge.arm.com>
 <CAOesGMj+itYr-daqxfX=J3Ss+7YdWhUUzBWTW3FqVEH8tXqt-A@mail.gmail.com>
 <20140608124530.GA31921@e102568-lin.cambridge.arm.com>
 <alpine.LFD.2.11.1406081138070.25775@knanqh.ubzr>
 <7hsindq07l.fsf@paris.lan>
 <20140609222604.GA16889@e102568-lin.cambridge.arm.com>
Message-ID: <alpine.LFD.2.11.1406092254220.25775@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 9 Jun 2014, Lorenzo Pieralisi wrote:

> I commented on Nico's patch because I did not like how it was
> implemented (at least remove the CPU PM notifier calls please, because
> they are not needed).

OK no problem.  That's easy enough.  I added them to play it safe as a 
test patch in case some VFP content could be lost somehow by looping 
back through the CPU init code for example, and needed to be saved.

> I also said that's the only thing he could do, and I still think 
> that's not a nice way to use the cpu_suspend API for something it was 
> not designed for, that's what I wanted to say, period.

Well... Maybe it wasn't designed for that, but it certainly can be used 
for that. And with no modifications to the core code, making this 
solution fairly elegant.  This is not so different from, say, the BPF 
code being reused for seccomp_filters. BPF wasn't designed for system 
call filtering, but it happens to work well.

> If I am allowed to say something, here is a couple of thoughts.
> 
> 1) CCI snoops and DVM enablement are secure operations, to do them in
>    non-secure world this must be overriden in firmware. You can argue,
>    you can think whatever you want, that's a fact. So, to use this
>    code SMP bit in SCTLR and CCI enablement must become non-secure
>    operations. This is a boot requirement for MCPM, right or wrong
>    it is up to platform designers to judge. If CCI and SMP enablement
>    are secure operations, we should not start adding random SMC calls
>    in the kernel, since managing coherency in the kernel would become
>    problematic, with lots of platform quirks. We do not want that to
>    happen, and I think we all agree on this.

One could certainly question the need for so many controls handled in 
secure world.  But that is not the point.

Here we're talking about MCPM.  That implies the kernel has control over 
SCTLR.SMP and the CCI.  If those things aren't under the kernel's 
control, then MCPM is of no use to you.

Therefore, if you do want to use MCPM, then this implies the kernel has 
access to the CCI. And if it has access to it, then it should turn it on 
by itself in all cases to be consistent, not only in half of the cases.

> 2) (1) must be documented.

Absolutely.  But let's be coherent in the implementation so the 
documentation is as simple as it can be.

> 3) When I talked about consequences for CPUidle (implicit), I was referring
>    to all sort of hacks we had to come up to bring devices like SPC
>    (remember ? I remember very very well unfortunately for me), or whatever
>    power controller up in the kernel early, too early to fit in any
>    existing kernel device framework. There is still no solution to that, and
>    the only way that code can exist is in mach- code. Right or wrong,
>    that's a second fact and in my opinion that's not nice for the ARM
>    kernel.

I disagree.  This can perfectly be turned into driver code. If we need 
it too early for existing kernel device framework to handle this 
properly, then the solution is to extend the existing framework or 
create another one specially for that purpose.  This may not be obvious 
when TC2 is the first/only platform in that situation, but if more 
platforms have the same need then it'll be easier to abstract 
commonalities into a framework.

Saying that no framework exists today or/and upstream maintainers are 
being difficult is _not_ a reason for throwing your hands up and e.g. 
shoving all this code into firmware instead.

> 4) When I am talking about firmware I am talking about sequences that
>    are very close to HW (disabling C bit, cleaning caches, exiting
>    coherency). Erratas notwithstanding, they are being standardized at
>    ARM the best we can. They might even end up being implemented in HW
>    in the not so far future. I understand they are tricky, I understand
>    they take lots of time to implement them and to debug them, what I
>    want to say is that they are becoming standard and we _must_ reuse the
>    same code for all ARM platforms. You can implement them in MCPM (see
>    (1)) or in firmware (and please do not start painting me as firmware
>    hugger here, I am referring to standard power down sequences that
>    again, are very close to HW state machines 

That's where the disconnect lies.  On the one hand you say "I understand 
they are tricky, I understand they take lots of time to implement them 
and to debug them" and on the other hand you say "They might end up being 
implemented in HW in the not so far future."  That simply makes no 
economical sense at all!

When some operation is 1) tricky and takes time to debug, and 2) not 
performance critical (no one is trying to get in and out of idle or 
hibernation a billion times per second), then you should never ever put 
such a thing in firmware, and hardware should be completely out of the 
question!

>    and more importantly if they
>    HAVE to run in secure world that's the only solution we have unless you
>    want to split race conditions between kernel and secure world).

If they HAVE to run in secure world then your secure world architecture 
is simply misdesigned, period.  Someone must have ignored the economics 
of modern software development to have come up with this.

> 5) I agree that the CCI enablement in TC2 (bootmon for cold boot and
>    kernel for warm-boot is wrong, nothing to say and it was not the
>    reason I commented on Nico's patch - I think I explained to you
>    thoroughly why now).

OK. Let's start by agreeing on the spirit behind my patch then.  The 
actual patch implementation details are a secondary concern and open for 
discussion.


Nicolas
