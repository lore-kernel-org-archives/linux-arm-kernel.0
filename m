From: jamie@jamieiles.com (Jamie Iles)
Date: Thu, 28 Jan 2010 11:26:06 +0000
Subject: [PATCH 5/5] arm/perfevents: implement perf event support for ARMv6
In-Reply-To: <000801ca9f7a$338d5f90$9aa81eb0$@deacon@arm.com>
References: <1263471256-3739-1-git-send-email-jamie.iles@picochip.com>
	<201001261847.44774.jpihet@mvista.com>
	<201001271840.47714.jpihet@mvista.com>
	<000801ca9f7a$338d5f90$9aa81eb0$@deacon@arm.com>
Message-ID: <20100128112606.GC4175@wear.picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 27, 2010 at 05:57:32PM -0000, Will Deacon wrote:
> Hi Jean,
> 
> Jean Pihet wrote:
> 
> > > However, if the IRQs are
> > > defined, but for some reason we fail to request them, then the
> > > armpmu_reserve_hardware function will fail.
> > That is the expected behaviour, isn't it?
> > Why is the PMU request failing? That is worth investigating. I never had that
> > problem on the Cortex-A8. Is it caused because of the multicore?
> 
> Don't worry, requesting the IRQs did not fail. I was simply speculating about
> the behaviour if it *does* fail. Then armpmu_reserve_hardware will return an
> error, which will prevent the event being added. Instead, we could print a
> warning, but continue without IRQs in the same manner as though they had not
> been defined in pmu.c.
This was my mistake and I don't think we should continue - we'd _probably_ be
ok for sampling counters, but for the counting counters we could hit problems
if the counters weren't being scheduled in and out. For example if someone did
'perf stat -a -e cycles -- sleep 1m' then the cycle counter would not need to
be scheduled out, the counter could wrap a few times and we wouldn't know
because we didn't get an interrupt.

I'd suggest the following patch to fix it.

diff --git a/arch/arm/kernel/perf_event.c b/arch/arm/kernel/perf_event.c
index 36a23cc..7b1022b 100644
--- a/arch/arm/kernel/perf_event.c
+++ b/arch/arm/kernel/perf_event.c
@@ -320,6 +320,7 @@ armpmu_reserve_hardware(void)
 
 	if (pmu_irqs->num_irqs < 1) {
 		pr_err("no irqs for PMUs defined\n");
+		return -ENODEV;
 	}
 
 	for (i = 0; i < pmu_irqs->num_irqs; ++i) {

> > > Actually, the return
> > > value appears to be uninitialised if you don't have any IRQs defined.
> > If the PMU request fails the IRQ should not be requested, so I think it is ok.
> > Is that correct?
> 
> What I mean is, if pmu_irqs->num_irqs < 1, then we return err without ever
> setting it. In fact, we might even end up freeing IRQs which we haven't
> requested which could cause all sorts of problems.
Good spot! I'm suprised gcc didn't pick this one up. The patch above should
prvent this.

Russell, shall I supersede the old patch in the patch system and roll in the
patch above?

Jamie
