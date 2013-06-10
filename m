From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 10 Jun 2013 14:23:02 -0700
Subject: [PATCH] arm: versatile: don't mark pen as __INIT
In-Reply-To: <20130610203901.GA3775@e102568-lin.cambridge.arm.com>
References: <1370876844-6599-1-git-send-email-mark.rutland@arm.com>
 <51B61D5F.1090906@codeaurora.org>
 <20130610185240.GC2513@e106331-lin.cambridge.arm.com>
 <51B62454.204@codeaurora.org> <51B6277C.9020003@codeaurora.org>
 <20130610203901.GA3775@e102568-lin.cambridge.arm.com>
Message-ID: <20130610212302.GA10823@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/10, Lorenzo Pieralisi wrote:
> On Mon, Jun 10, 2013 at 08:22:36PM +0100, Stephen Boyd wrote:
> > On 06/10/13 12:09, Stephen Boyd wrote:
> > > On 06/10/13 11:52, Mark Rutland wrote:
> > >> On Mon, Jun 10, 2013 at 07:39:27PM +0100, Stephen Boyd wrote:
> > >>> On 06/10/13 08:07, Mark Rutland wrote:
> > >>>> When booting fewer cores than are physically present on a versatile
> > >>>> platform (e.g. when passing maxcpus=N on the command line), some
> > >>>> secondary cores may remain in the holding pen, which is marked __INIT.
> > >>>> Late in the boot process, the memory comprising the holding pen will be
> > >>>> released to the kernel for more general use, and may be overwritten with
> > >>>> arbitrary data, which can cause the held secondaries to start behaving
> > >>>> unpredictably. This can lead to all manner of odd behaviour from the
> > >>>> kernel.
> > >>>>
> > >>>> Instead don't mark the section as __INIT. This means we can't reuse the
> > >>>> pen memory, but we won't get secondaries corrupting the rest of the
> > >>>> kernel.
> > >>>>
> > >>>> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> > >>>> Acked-by: Pawel Moll <pawel.moll@arm.com>
> > >>>> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > >>>> ---
> > >>>>  arch/arm/plat-versatile/headsmp.S | 2 --
> > >>>>  1 file changed, 2 deletions(-)
> > >>>>
> > >>>> diff --git a/arch/arm/plat-versatile/headsmp.S b/arch/arm/plat-versatile/headsmp.S
> > >>>> index b178d44..2677bc3 100644
> > >>>> --- a/arch/arm/plat-versatile/headsmp.S
> > >>>> +++ b/arch/arm/plat-versatile/headsmp.S
> > >>>> @@ -11,8 +11,6 @@
> > >>>>  #include <linux/linkage.h>
> > >>>>  #include <linux/init.h>
> > >>>>  
> > >>>> -	__INIT
> > >>>> -
> > >>>>  /*
> > >>>>   * Realview/Versatile Express specific entry point for secondary CPUs.
> > >>>>   * This provides a "holding pen" into which all secondary cores are held
> > >>> Why doesn't __CPUINIT work?
> > >> Won't we then encounter the same problem on builds without CPU_HOTPLUG? I
> > >> thought we'd throw away the .cpuinit.* section(s) in that case?
> > >>
> > > The generic linker macros look to set it up so that all __CPUINIT
> > > sections become __INIT in that scenario. Since we don't support hotplug
> > > booting with maxcpus < nr_present_cpus can't lead to any corruption
> > > because we can't bring online any of the offline and present CPUs.
> > >
> > 
> > Sorry I should clarify further. We can't bring online any offline and
> > present CPUs after the init sections are freed.
> 
> Problem is, since now GIC broadcasts IPIs at boot to all CPUs connected
> to the GIC so that they are woken up for GIC CPU IF id discovery, on
> some platforms (ie versatile express, where CPUs are in wfi waiting for
> an IPI, with a common jump address), they are all thrown at the kernel
> waiting for the pen release value to be set to their MPIDR. Since we
> want to boot fewer CPUs than the number of present ones, if we free the pen
> assembly stub after boot, well, those CPUs end up executing undefined
> bytes. There is no way to put those CPUs back to sleep on old versatile
> platforms and probably no way to prevent them from entering the kernel upon
> wfi since the jump address is set using a single register common to all
> CPUs (if there was a register per-CPU, the bootloader could check its
> value and put the CPU back in wfi if jump address was, say, NULL; if
> there were per-CPU resets that would even be simpler).
> 

Ah ok. I didn't think any of those CPUs were going to come out of
the boot monitor into the pen.

At the least please add a comment to this effect in the headsmp.S
file and/or in the commit text. It seems that if the GIC code
wasn't written that way this could be marked __CPUINIT.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
