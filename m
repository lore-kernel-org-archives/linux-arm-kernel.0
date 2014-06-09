From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Mon, 9 Jun 2014 23:26:05 +0100
Subject: Problems booting exynos5420 with >1 CPU
In-Reply-To: <7hsindq07l.fsf@paris.lan>
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
Message-ID: <20140609222604.GA16889@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 09, 2014 at 09:47:42PM +0100, Kevin Hilman wrote:
> Nicolas Pitre <nicolas.pitre@linaro.org> writes:
> 
> > On Sun, 8 Jun 2014, Lorenzo Pieralisi wrote:
> >
> >> On Sun, Jun 08, 2014 at 12:53:34AM +0100, Olof Johansson wrote:
> >> > Lorenzo,
> >> > 
> >> > Since you're emailing from @arm.com, some of this is to the wider
> >> > recipient and maybe not directly to you:
> >> 
> >> I am glad to reply and take blame since this is a debate definitely worth
> >> having.
> >
> > Great.  Because I would like to steer this debate a little towards the 
> > genuine cause rather than sticking to some particular consequences.

I commented on Nico's patch because I did not like how it was
implemented (at least remove the CPU PM notifier calls please, because
they are not needed). I also said that's the only thing he could do,
and I still think that's not a nice way to use the cpu_suspend API
for something it was not designed for, that's what I wanted to say,
period.

> >> Guys, do not get me wrong here. There are fixes that can be deemed
> >> acceptable in an OS, there are fixes that can't. I just can't help thinking
> >> that Nicolas' patch is a nasty hack (and I am far, really really far from
> >> blaming him for that, because that's the only patch that can fix that
> >> issue in the kernel), and he perfectly knows that.
> >
> > You know what?  The more I think about my patch, the more I consider 
> > this should be the standard way of setting up things unconditionally on 
> > _all_ platforms using MCPM.  Why? Because that's the most coherent thing 
> > to do!
> 
> I agree.
> 
> > I really think the kernel should either be responsible for the CCI or it 
> > should not at all.  And conversely for the bootloader.  Right now we 
> > have an implicit requirement that the bootloader should turn on the CCI, 
> > but only for cold boot, and only for the boot cluster, and not for CPU 
> > resuming from idle, and what other case we haven't thought about yet.  
> > And as noticed this requirement is not documented.
> 
> In addition to being a firmware minimalist like Nico, what I find most
> objectional to the bootloader approach is that even with CCI enabled by
> the firmware, since it's a runtime requirement (for low-power idle or
> suspend), the kernel has to handle it anyways.  So you end up with a
> partial solution in the firwmare (for boot cluster only) *and* a full
> solution in the kernel.  This doesn't make any sense, expecially because
> the kernel might then have to do things differently on cold boot
> vs. low-power idle/suspend or differently on the boot cluster vs. other
> clusters.  From a maintenance PoV, this is a mess and could easily lead
> to just as many SoC specific hacks that are different across platforms.
> 
> Stated more simply: If the kernel has to manage the resource at runtime
> due to low-power idle/suspend.  I don't see any reason why it shouldn't
> manage it at cold boot time also.

If I am allowed to say something, here is a couple of thoughts.

1) CCI snoops and DVM enablement are secure operations, to do them in
   non-secure world this must be overriden in firmware. You can argue,
   you can think whatever you want, that's a fact. So, to use this
   code SMP bit in SCTLR and CCI enablement must become non-secure
   operations. This is a boot requirement for MCPM, right or wrong
   it is up to platform designers to judge. If CCI and SMP enablement
   are secure operations, we should not start adding random SMC calls
   in the kernel, since managing coherency in the kernel would become
   problematic, with lots of platform quirks. We do not want that to
   happen, and I think we all agree on this.
2) (1) must be documented.
3) When I talked about consequences for CPUidle (implicit), I was referring
   to all sort of hacks we had to come up to bring devices like SPC
   (remember ? I remember very very well unfortunately for me), or whatever
   power controller up in the kernel early, too early to fit in any
   existing kernel device framework. There is still no solution to that, and
   the only way that code can exist is in mach- code. Right or wrong,
   that's a second fact and in my opinion that's not nice for the ARM
   kernel.
4) When I am talking about firmware I am talking about sequences that
   are very close to HW (disabling C bit, cleaning caches, exiting
   coherency). Erratas notwithstanding, they are being standardized at
   ARM the best we can. They might even end up being implemented in HW
   in the not so far future. I understand they are tricky, I understand
   they take lots of time to implement them and to debug them, what I
   want to say is that they are becoming standard and we _must_ reuse the
   same code for all ARM platforms. You can implement them in MCPM (see
   (1)) or in firmware (and please do not start painting me as firmware
   hugger here, I am referring to standard power down sequences that
   again, are very close to HW state machines and more importantly if they
   HAVE to run in secure world that's the only solution we have unless you
   want to split race conditions between kernel and secure world).
5) I agree that the CCI enablement in TC2 (bootmon for cold boot and
   kernel for warm-boot is wrong, nothing to say and it was not the
   reason I commented on Nico's patch - I think I explained to you
   thoroughly why now).

That's what I had to say, I hope it helps.

Thanks,
Lorenzo
