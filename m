From: will.deacon@arm.com (Will Deacon)
Date: Mon, 20 Feb 2012 13:34:00 +0000
Subject: [PATCH] ARM: perf: limit sample_period to half max_period in
 non-sampling mode
In-Reply-To: <CACVXFVPHrenJO_vKJNXVaSjnKHstQ3_3NRJFqhp0dTiDAAm8tw@mail.gmail.com>
References: <1329739646-17058-1-git-send-email-will.deacon@arm.com>
 <CACVXFVPHrenJO_vKJNXVaSjnKHstQ3_3NRJFqhp0dTiDAAm8tw@mail.gmail.com>
Message-ID: <20120220133400.GF25462@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 20, 2012 at 12:39:11PM +0000, Ming Lei wrote:
> On Mon, Feb 20, 2012 at 8:07 PM, Will Deacon <will.deacon@arm.com> wrote:
> > diff --git a/arch/arm/kernel/perf_event.c b/arch/arm/kernel/perf_event.c
> > index 5bb91bf..56173ae 100644
> > --- a/arch/arm/kernel/perf_event.c
> > +++ b/arch/arm/kernel/perf_event.c
> > @@ -180,7 +180,7 @@ armpmu_event_set_period(struct perf_event *event,
> > ?u64
> > ?armpmu_event_update(struct perf_event *event,
> > ? ? ? ? ? ? ? ? ? ?struct hw_perf_event *hwc,
> > - ? ? ? ? ? ? ? ? ? int idx, int overflow)
> > + ? ? ? ? ? ? ? ? ? int idx)
> > ?{
> > ? ? ? ?struct arm_pmu *armpmu = to_arm_pmu(event->pmu);
> > ? ? ? ?u64 delta, prev_raw_count, new_raw_count;
> > @@ -193,13 +193,7 @@ again:
> > ? ? ? ? ? ? ? ? ? ? ? ? ? ? new_raw_count) != prev_raw_count)
> > ? ? ? ? ? ? ? ?goto again;
> >
> > - ? ? ? new_raw_count &= armpmu->max_period;
> > - ? ? ? prev_raw_count &= armpmu->max_period;
> > -
> > - ? ? ? if (overflow)
> > - ? ? ? ? ? ? ? delta = armpmu->max_period - prev_raw_count + new_raw_count + 1;
> > - ? ? ? else
> > - ? ? ? ? ? ? ? delta = new_raw_count - prev_raw_count;
> > + ? ? ? delta = (new_raw_count - prev_raw_count) & armpmu->max_period;
> 
> Please add
> 
>            Signed-off-by: Ming Lei <ming.lei@canonical.com>

Sure, didn't want to add anything more than a CC until I was sure you were
happy with it.

On the plus side, the warnings from Stephane's IRQ throttling code have been
fixed in -rc4 by f39d47ff ("perf: Fix double start/stop in
x86_pmu_start()").

So the ball should be back in the OMAP court now as far as enabling perf on
Panda.

Will
