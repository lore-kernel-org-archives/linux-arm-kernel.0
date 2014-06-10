From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 10 Jun 2014 15:15:53 -0400 (EDT)
Subject: Problems booting exynos5420 with >1 CPU
In-Reply-To: <20140610174212.GJ3523@arm.com>
References: <alpine.LFD.2.11.1406071431490.25775@knanqh.ubzr>
 <20140607223614.GA26641@e102568-lin.cambridge.arm.com>
 <CAOesGMj+itYr-daqxfX=J3Ss+7YdWhUUzBWTW3FqVEH8tXqt-A@mail.gmail.com>
 <20140608124530.GA31921@e102568-lin.cambridge.arm.com>
 <alpine.LFD.2.11.1406081138070.25775@knanqh.ubzr> <7hsindq07l.fsf@paris.lan>
 <20140609222604.GA16889@e102568-lin.cambridge.arm.com>
 <alpine.LFD.2.11.1406092254220.25775@knanqh.ubzr>
 <20140610141446.GA3519@arm.com>
 <alpine.LFD.2.11.1406101149520.25775@knanqh.ubzr>
 <20140610174212.GJ3523@arm.com>
Message-ID: <alpine.LFD.2.11.1406101443160.25775@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 10 Jun 2014, Catalin Marinas wrote:
> On Tue, Jun 10, 2014 at 05:49:01PM +0100, Nicolas Pitre wrote:
> > The M-class processor should be treated the same way as firmware.  It 
> > ought to be flexible (certainly more than hardwired hardware), but it 
> > shares all the same downsides as firmware and the same concerns apply.
> 
> Yes, we can treat it as firmware, but we don't have a better alternative
> to move the functionality into the kernel (well, we could at least allow
> the kernel to load a binary blob and restart the controller).

That would address the "easy to update in the field" side of the story.  
So far I've not seen this aspect been addressed with a serious plan 
anywhere.

> > The reaction from the hardware people often is "the software is crap and 
> > makes our hardware look bad, we know better, so let's make it easier on 
> > those poor software dudes by handling power management in hardware 
> > instead".  But ultimately the hardware just can't predict things like 
> > software can.  It might do a better job than the current software state 
> > of affairs, but most likely not be as efficient as a proper software 
> > architecture.  The hardware may only be reactive, whereas the software 
> > can be proactive (when properly done that is).
> 
> Indeed. But that's not the aim of the power controller on our boards.
> It's just a mechanism for safely changing sleep states, CPU frequencies
> but entirely under the OS decision.

Sure.  But then you might want to consider that some usage scenarios 
might benefit from the ability to abort a request, or monitor the 
progress of a request for software timing purposes, or accept parallel 
requests rather than serialize them, etc.  Given the flexibility to 
extend beyond a rigid interface, the system may become even more 
efficient overall, albeit with added complexity in the implementation. 
But for that to work it has to be cheaply achievable.

> > I sense from your paragraph above that ARM might be going the same 
> > direction as X86 and that would be very sad.  Maybe the best compromise 
> > would be for all knobs to be made available to software if software 
> > wants to turn off the hardware auto-pilot and take control.  This way 
> > the hardware guys would cover their arses while still allowing for the 
> > possibility that software might be able to out perform the hardware 
> > solution.
> 
> I'm definitely not suggesting ARM is going the same route. Just trying
> to show that ARM is slightly better here.
> 
> As a personal opinion, I like the simplicity of writing a register to
> change the P-state but I don't like the non-determinism of the x86
> hardware w.r.t. CPU performance. There are however some "policy" aspects
> which I find interesting (like detecting whether the workload is memory
> bound and automatically lowering the CPU frequency; the OS cannot react
> this fast).

This is not really a policy.  This is a straight-forward waterfall 
dependency.  There is simply nothing you can do with those CPU clock 
cycles when stalled most of the time waiting for memory queries to come 
back so the choice is obvious.  If however this has a significant impact 
on code execution speed then this becomes a tradeoff and the choice to 
use this feature or not (the policy) must be implemented in software.


Nicolas
