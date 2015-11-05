From: Suzuki.Poulose@arm.com (Suzuki K. Poulose)
Date: Thu, 5 Nov 2015 17:52:37 +0000
Subject: [PATCHv2 3/4] arm-cci: Add routines to enable/disable all counters
In-Reply-To: <20151105172756.GH32247@leverpostej>
References: <1445346326-30820-1-git-send-email-suzuki.poulose@arm.com>
 <1445346326-30820-4-git-send-email-suzuki.poulose@arm.com>
 <20151104182854.GH23860@leverpostej> <563B2C01.80701@arm.com>
 <20151105172756.GH32247@leverpostej>
Message-ID: <563B9765.9070708@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/11/15 17:27, Mark Rutland wrote:
>>> Can we not get rid of the mask entirely? The combination of used_mask
>>> and each event's hwc->state tells us which counters are actually in use.
>>
>> The problem is that neither hwc->state nor the cci_pmu->hw_events->events is
>> protected by pmu_lock, while enable/disable counter is. So we cannot really
>> rely on ((struct perf_event *)(cci_pmu->hw_events->events[counter]))->hw->state.
>
> They must be protected somehow, or we'd have races against cross-calls
> and/or the interrupt handler.

>
> Are we protected due to being cpu-affine with interrupts disabled when
> modifying these, is there some other mechanism that protects us, or do
> we have additional problems here?
>


Each perf_event is allocated a counter id atomically using the bit mask. So,
once the id is allocated nobody messes with that id from the PMU side. And,
the hw->state may have its own protection within the generic perf layer(which
I haven't checked).

Thanks
Suzuki
