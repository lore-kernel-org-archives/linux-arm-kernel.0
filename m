From: nleeder@codeaurora.org (Leeder, Neil)
Date: Mon, 6 Feb 2017 14:11:36 -0500
Subject: [PATCH v9] perf: add qcom l2 cache perf events driver
In-Reply-To: <20170206154814.GA4190@leverpostej>
References: <1486161081-28409-1-git-send-email-nleeder@codeaurora.org>
 <20170206154814.GA4190@leverpostej>
Message-ID: <8d61d7fb-71d0-190e-26e3-a72e98cfb10d@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,
Thanks for those comments - I'll add the fixes.

On 2/6/2017 10:48 AM, Mark Rutland wrote:
> I'm still concerned by this use of the filter_match callback, because it
> depends on the set of other active events, and can change as other
> events are scheduled in and out.
>
> When we schedule in two conflicting events A and B in order, B will fail
> its filter match. When we scheduled out A and B in order, B will succeed
> its filter match.
>
> The perf core does not expect this inconsistency, and this appears to
> break the timing update logic in event_sched_out(), when unconditionally
> called from ctx_sched_out() as part of perf_rotate_context().
>
> I would feel much happier if we dropped l2_cache_filter_match(), at
> least for the timebeing, and handled this as we do for other cases of
> intra-pmu resource contention.
>
> We can then consider the filter_match addition on its own at a later
> point.

So could this be detected in get_event_idx, the same way we handle 
counter resource contention? That would eliminate filter_match, and it's 
the same way its done in armv7 
(arch/arm/kernel/perf_event_v7.c:krait_pmu_get_event_idx()).

It's less obvious to the user, but seeing 2 events being rotated so they 
each have ~50% coverage should provide a hint that the user did 
something wrong, so I think that would work.

Thanks,

Neil
-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm 
Technologies Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
