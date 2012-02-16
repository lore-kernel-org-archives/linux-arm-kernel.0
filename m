From: ming.lei@canonical.com (Ming Lei)
Date: Thu, 16 Feb 2012 18:25:05 +0800
Subject: oprofile and ARM A9 hardware counter
In-Reply-To: <1329323900.2293.150.camel@twins>
References: <1328578047.1724.17.camel@dave-Dell-System-XPS-L502X>
 <CAMQu2gwfo5JXAqQaLUNs7C7J3TUhEO2zOcyD0Rk-D_O61Yrfag@mail.gmail.com>
 <CAMsRxfLNBbQO5XF+EHJqNsnW+s=ay3mjSV5dh=sxdwzktUu03g@mail.gmail.com>
 <CAMQu2gzfNAwtf1c6jrTZpfGMSqBgBrQKmFTeCFzbvMh9ESBDUg@mail.gmail.com>
 <CAMsRxfKR1ODH56BtcUT5Dv6qOVEYGVheEcW9ugXsZmLKok==bg@mail.gmail.com>
 <CAMQu2gwWt6oQPjxc1YHgOoxVkHdck_q78Xf==7ncwRj0_uS-JQ@mail.gmail.com>
 <CAMQu2gyCPtbNfBa5V8ve2JORN+sDeAY+hvR0g0_9U354JgcuiA@mail.gmail.com>
 <CAMsRxfJVEgVJoHcaPQbMg5mwz=tZUce4oibDUxtnevSF8bGY9g@mail.gmail.com>
 <CAMQu2gxVUqDF2HkPD=QeX0N_tUd=9FTd+T+1LHCR0tsCgQxC8Q@mail.gmail.com>
 <CAMsRxfJH+9MS=Svmh0BvDSb8xqsPe2HPobkeKcn8JO35npjhwQ@mail.gmail.com>
 <CACVXFVMx9Zx3ZQr6Q-17x5NVL8iuBJjOjtw39FJiWX=fGkZNZA@mail.gmail.com>
 <1329323900.2293.150.camel@twins>
Message-ID: <CACVXFVPce0A3LfL=mFo3UbN-Om7xLOo_d-LfKXDjdN5dFQdhiA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Feb 16, 2012 at 12:38 AM, Peter Zijlstra <a.p.zijlstra@chello.nl> wrote:
>
> So what this patch seems to do is put that filter on period in
> perf_ctx_adjust_freq(). Not making sense.. nor can I see a HZ
> dependency, perf_ctx_adjust_freq() uses TICK_NSEC as time base.

Yes, you are right, I remembered it was observed it on -rc1, and
Stephane's unthrottling
patch was not merged at that time. Today I investigated the problem
further on -rc3 and found that seems the problem is caused by arm pmu code.

The patch below may fix the problem, now about 40000 sample events
can be generated on the command:

	'perf record -e cycles -F 4000  ./noploop 10&& perf report -D | tail -20'

armpmu_event_update may be called in tick path, so the running counter
will be overflowed and produce a great value of 'delta', then a mistaken
count is stored into event->count and event->hw.freq_count_stamp. Finally
the two variables are not synchronous, then a invalid and large period is
computed and written to pmu, and sample events are decreased much.

Will, this patch simplifies the 'delta' computation and doesn't use the
overflow flag, even though which can be read directly from PMOVSR, could you
comment on the patch?

diff --git a/arch/arm/kernel/perf_event.c b/arch/arm/kernel/perf_event.c
index 5bb91bf..789700a 100644
--- a/arch/arm/kernel/perf_event.c
+++ b/arch/arm/kernel/perf_event.c
@@ -193,13 +193,8 @@ again:
 			     new_raw_count) != prev_raw_count)
 		goto again;

-	new_raw_count &= armpmu->max_period;
-	prev_raw_count &= armpmu->max_period;
-
-	if (overflow)
-		delta = armpmu->max_period - prev_raw_count + new_raw_count + 1;
-	else
-		delta = new_raw_count - prev_raw_count;
+	delta = (armpmu->max_period - prev_raw_count + new_raw_count
+				+ 1) & armpmu->max_period;

 	local64_add(delta, &event->count);
 	local64_sub(delta, &hwc->period_left);


thanks,
--
Ming Lei
