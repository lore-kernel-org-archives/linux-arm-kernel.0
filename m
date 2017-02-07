From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 7 Feb 2017 10:43:15 +0000
Subject: [PATCH v9] perf: add qcom l2 cache perf events driver
In-Reply-To: <8d61d7fb-71d0-190e-26e3-a72e98cfb10d@codeaurora.org>
References: <1486161081-28409-1-git-send-email-nleeder@codeaurora.org>
 <20170206154814.GA4190@leverpostej>
 <8d61d7fb-71d0-190e-26e3-a72e98cfb10d@codeaurora.org>
Message-ID: <20170207104315.GA28790@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 06, 2017 at 02:11:36PM -0500, Leeder, Neil wrote:
> Hi Mark,
> Thanks for those comments - I'll add the fixes.

Cheers!

> On 2/6/2017 10:48 AM, Mark Rutland wrote:
> >I'm still concerned by this use of the filter_match callback, because it
> >depends on the set of other active events, and can change as other
> >events are scheduled in and out.
> >
> >When we schedule in two conflicting events A and B in order, B will fail
> >its filter match. When we scheduled out A and B in order, B will succeed
> >its filter match.
> >
> >The perf core does not expect this inconsistency, and this appears to
> >break the timing update logic in event_sched_out(), when unconditionally
> >called from ctx_sched_out() as part of perf_rotate_context().
> >
> >I would feel much happier if we dropped l2_cache_filter_match(), at
> >least for the timebeing, and handled this as we do for other cases of
> >intra-pmu resource contention.
> >
> >We can then consider the filter_match addition on its own at a later
> >point.
> 
> So could this be detected in get_event_idx, the same way we handle
> counter resource contention? That would eliminate filter_match, and
> it's the same way its done in armv7
> (arch/arm/kernel/perf_event_v7.c:krait_pmu_get_event_idx()).

Returning -EAGAIN from event_get_ixd() in that case sounds good to me.

Thanks,
Mark.
