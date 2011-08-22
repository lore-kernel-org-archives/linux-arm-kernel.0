From: will.deacon@arm.com (Will Deacon)
Date: Mon, 22 Aug 2011 21:12:48 +0100
Subject: [RFC PATCH 08/15] ARM: perf: remove unnecessary armpmu->stop
In-Reply-To: <4E52A1A2.5020700@codeaurora.org>
References: <4B9A4BAF850C914D8DED94776A2C477E0B853A03@nasanexd01b.na.qualcomm.com>
	<4E52A1A2.5020700@codeaurora.org>
Message-ID: <20110822201248.GC22755@e102144-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 22, 2011 at 07:36:18PM +0100, Ashwin Chaugule wrote:
> Hello,

Hi Ashwin,

> >> From: Mark Rutland 
> >>
> >> As armpmu_disable will call armpmu->stop when the last event has been
> >> removed, this is pointless and simply adds to the noise when debugging.
> >> Additionally, due to this call occurring in a preemptible context, this
> >> is problematic for per-cpu locking of PMU registers (where we will
> >> attempt to access per-cpu spinlock for use with raw_spin_lock_irqsave).
> >>
> >> This patch removes the call to armpmu->stop.
> >>
> >> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> >> Reviewed-by: Will Deacon <will.deacon@arm.com>
> >> ---
> >> arch/arm/kernel/perf_event.c |    1 -
> >> 1 files changed, 0 insertions(+), 1 deletions(-)
> >>
> >> diff --git a/arch/arm/kernel/perf_event.c b/arch/arm/kernel/perf_event.c
> >> index 9d6ac99..5ce6c33 100644
> >> --- a/arch/arm/kernel/perf_event.c
> >> +++ b/arch/arm/kernel/perf_event.c
> >> @@ -396,7 +396,6 @@ armpmu_release_hardware(void)
> >> 			free_irq(irq, NULL);
> >> 	}
> >>
> >> -	armpmu->stop();
> >> 	release_pmu(ARM_PMU_DEVICE_CPU);
> 
> 
> Makes sense. On a similar note, I've been wondering why we need to loop
> through all events in armpmu_enable() ?
> 
> Wouldn't the event->add call have taken care of armpmu->enable prior to
> calling armpmu_enable() ?

Hmm, I think you might be right. armpmu->enable is called from armpmu_start,
which is called from armpmu->add whenever a new event is added. The current
redundancy is likely a hangover from before we had the PERF_EF_*/PERF_HES_*
flags.

> I think we just need an armpmu->start(). What are your thoughts ?

Yes, conditional on armpmu->num_events > 0. I'll give it a spin and add it to
my perf-updates branch if I don't see any regressions.

Cheers,

Will
