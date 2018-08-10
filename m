From: Dave.Martin@arm.com (Dave Martin)
Date: Fri, 10 Aug 2018 11:06:58 +0100
Subject: [PATCH v2] arm64: Trap WFI executed in userspace
In-Reply-To: <a71ad7e3-8584-36b2-3912-dac3c38db204@arm.com>
References: <20180810091939.2773-1-marc.zyngier@arm.com>
 <a71ad7e3-8584-36b2-3912-dac3c38db204@arm.com>
Message-ID: <20180810100656.GP9097@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 10, 2018 at 10:43:13AM +0100, Robin Murphy wrote:
> On 10/08/18 10:19, Marc Zyngier wrote:
> >It recently came to light that userspace can execute WFI, and that
> >the arm64 kernel doesn trap this event. This sounds rather benign,
> 
>                         't
> 
> >but the kernel should decide when it wants to wait for an interrupt,
> >and not userspace.
> >
> >Let's trap WFI and immediately return after having skipped the
> >instruction. This effectively makes WFI a rather expensive NOP.
> 
> ...which is still a perfectly valid behaviour, given that it's a hint.
> That's fine by me :)

The only plausible use of WFI that I can see is in a polling or idle
loop of some description.  So turning WFI into a NOP will likely create
a userspace busy-wait that never explicitly blocks or yields, which may
be considered pathological behaviour.

If there is junk is some app store that does this it may lead to
power wastage and thermal throttling, damaging performance of the whole
system the rogue app runs on.

That kind of consequence is partly why I suggested breaking rogue apps
cleanly (via SIGILL) rather than breaking the system hosting those apps
in messier ways.  I accept that SIGILL is a step to far.

So, I continue to favour the sched_yield() approach over all.

Should this be discussed with the security folks?  It feels like we're
speculating about whether sched_yield() is a security concern.

If it is, could we not NOP or SIGILL WFI if sched_yield() is disallowed
by seccomp, and treat it as a sched_yield() otherwise?

[...]

Cheers
---Dave
