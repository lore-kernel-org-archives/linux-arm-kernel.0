From: mikpe@it.uu.se (Mikael Pettersson)
Date: Sun, 5 Dec 2010 13:32:37 +0100
Subject: [BUG] 2.6.37-rc3 massive interactivity regression on ARM
In-Reply-To: <19697.8378.717761.236202@pilspetsen.it.uu.se>
References: <19697.8378.717761.236202@pilspetsen.it.uu.se>
Message-ID: <19707.34405.791777.298955@pilspetsen.it.uu.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mikael Pettersson writes:
 > The scenario is that I do a remote login to an ARM build server,
 > use screen to start a sub-shell, in that shell start a largish
 > compile job, detach from that screen, and from the original login
 > shell I occasionally monitor the compile job with top or ps or
 > by attaching to the screen.
 > 
 > With kernels 2.6.37-rc2 and -rc3 this causes the machine to become
 > very sluggish: top takes forever to start, once started it shows no
 > activity from the compile job (it's as if it's sleeping on a lock),
 > and ps also takes forever and shows no activity from the compile job.
 > 
 > Rebooting into 2.6.36 eliminates these issues.
 > 
 > I do pretty much the same thing (remote login -> screen -> compile job)
 > on other archs, but so far I've only seen the 2.6.37-rc misbehaviour
 > on ARM EABI, specifically on an IOP n2100. (I have access to other ARM
 > sub-archs, but haven't had time to test 2.6.37-rc on them yet.)
 > 
 > Has anyone else seen this? Any ideas about the cause?

(Re-followup since I just realised my previous followups were to Rafael's
regressions mailbot rather than the original thread.)

> The bug is still present in 2.6.37-rc4.  I'm currently trying to bisect it.

git bisect identified

[305e6835e05513406fa12820e40e4a8ecb63743c] sched: Do not account irq time to current task

as the cause of this regression.  Reverting it from 2.6.37-rc4 (requires some
hackery due to subsequent changes in the same area) restores sane behaviour.

The original patch submission talks about irq-heavy scenarios.  My case is the
exact opposite: UP, !PREEMPT, NO_HZ, very low irq rate, essentially 100% CPU
bound in userspace but expected to schedule quickly when needed (e.g. running
top or ps or just hitting CR in one shell while another runs a compile job).

I've reproduced the misbehaviour with 2.6.37-rc4 on ARM/mach-iop32x and
ARM/mach-ixp4xx, but ARM/mach-kirkwood does not misbehave, and other archs
(x86 SMP, SPARC64 UP and SMP, PowerPC32 UP, Alpha UP) also do not misbehave.

So it looks like an ARM-only issue, possibly depending on platform specifics.

One difference I noticed between my Kirkwood machine and my ixp4xx and iop32x
machines is that even though all have CONFIG_NO_HZ=y, the timer irq rate is
much higher on Kirkwood, even when the machine is idle.

/Mikael
