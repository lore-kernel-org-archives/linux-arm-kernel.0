From: ming.lei@canonical.com (Ming Lei)
Date: Fri, 17 Feb 2012 13:24:02 +0800
Subject: oprofile and ARM A9 hardware counter
In-Reply-To: <20120216180841.GC31977@mudshark.cambridge.arm.com>
References: <CAMsRxfJVEgVJoHcaPQbMg5mwz=tZUce4oibDUxtnevSF8bGY9g@mail.gmail.com>
 <CAMQu2gxVUqDF2HkPD=QeX0N_tUd=9FTd+T+1LHCR0tsCgQxC8Q@mail.gmail.com>
 <CAMsRxfJH+9MS=Svmh0BvDSb8xqsPe2HPobkeKcn8JO35npjhwQ@mail.gmail.com>
 <CACVXFVMx9Zx3ZQr6Q-17x5NVL8iuBJjOjtw39FJiWX=fGkZNZA@mail.gmail.com>
 <1329323900.2293.150.camel@twins>
 <CACVXFVPce0A3LfL=mFo3UbN-Om7xLOo_d-LfKXDjdN5dFQdhiA@mail.gmail.com>
 <20120216150004.GE2641@mudshark.cambridge.arm.com>
 <CACVXFVM472hz+na7o2wJr1CPq-W=YB7i0UwtrsUf62+ryzWp8A@mail.gmail.com>
 <1329409183.2293.245.camel@twins>
 <CACVXFVOygObWqPMLjg6uOB6inBkvvUjsQncNW0fbmpa4Xspw0Q@mail.gmail.com>
 <20120216180841.GC31977@mudshark.cambridge.arm.com>
Message-ID: <CACVXFVO4eexVK-S5TdRk2T6pyKRzpW1HxBQxo0Yfk_ziaO_U4Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 17, 2012 at 2:08 AM, Will Deacon <will.deacon@arm.com> wrote:

>
> The more I think about this, the more I think that the overflow parameter to
> armpmu_event_update needs to go. It was introduced to prevent massive event
> loss in non-sampling mode, but I think we can get around that by changing
> the default sample_period to be half of the max_period, therefore giving
> ourselves a much better chance of handling the interrupt before new wraps
> around past prev.
>
> Ming Lei - can you try the following please? If it works for you, then I'll
> do it properly and kill the overflow parameter altogether.

Of course, it does work for the problem reported by Stephane since
it changes the delta computation basically as I did, but I am afraid that
it may be not good enough for the issue fixed in a737823d ("ARM: 6835/1:
perf: ensure overflows aren't missed due to IRQ latency").

>
> Thanks,
>
> Will
>
> git a/arch/arm/kernel/perf_event.c b/arch/arm/kernel/perf_event.c
> index 5bb91bf..ef597a3 100644
> --- a/arch/arm/kernel/perf_event.c
> +++ b/arch/arm/kernel/perf_event.c
> @@ -193,13 +193,7 @@ again:
> ? ? ? ? ? ? ? ? ? ? ? ? ? ? new_raw_count) != prev_raw_count)
> ? ? ? ? ? ? ? ?goto again;
>
> - ? ? ? new_raw_count &= armpmu->max_period;
> - ? ? ? prev_raw_count &= armpmu->max_period;
> -
> - ? ? ? if (overflow)
> - ? ? ? ? ? ? ? delta = armpmu->max_period - prev_raw_count + new_raw_count + 1;
> - ? ? ? else
> - ? ? ? ? ? ? ? delta = new_raw_count - prev_raw_count;
> + ? ? ? delta = (new_raw_count - prev_raw_count) & armpmu->max_period;
>
> ? ? ? ?local64_add(delta, &event->count);
> ? ? ? ?local64_sub(delta, &hwc->period_left);
> @@ -518,7 +512,7 @@ __hw_perf_event_init(struct perf_event *event)
> ? ? ? ?hwc->config_base ? ? ? ? ? ?|= (unsigned long)mapping;
>
> ? ? ? ?if (!hwc->sample_period) {
> - ? ? ? ? ? ? ? hwc->sample_period ?= armpmu->max_period;
> + ? ? ? ? ? ? ? hwc->sample_period ?= armpmu->max_period >> 1;

If you assume that the issue addressed by a737823d can only happen in
non-sample situation, Peter's idea of u32 cast is OK and maybe simpler.

But I am afraid that the issue still can be triggered in sample-based situation,
especially in very high frequency case: suppose the sample freq is 10000,
100us IRQ delay may trigger the issue.

So we may use the overflow information to make perf more robust, IMO.

thanks
--
Ming Lei
