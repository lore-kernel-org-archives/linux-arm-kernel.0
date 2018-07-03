From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Tue, 3 Jul 2018 14:13:44 +0100
Subject: [PATCH v4 4/7] arm_pmu: Tidy up clear_event_idx call backs
In-Reply-To: <20180703124905.75uttsh7xrrzh55q@lakrids.cambridge.arm.com>
References: <1530568788-26458-1-git-send-email-suzuki.poulose@arm.com>
 <1530568788-26458-5-git-send-email-suzuki.poulose@arm.com>
 <20180703124905.75uttsh7xrrzh55q@lakrids.cambridge.arm.com>
Message-ID: <6592be36-3b16-f566-96ff-15f97964d4c4@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/07/18 13:49, Mark Rutland wrote:
> On Mon, Jul 02, 2018 at 10:59:45PM +0100, Suzuki K Poulose wrote:
>> The armpmu uses get_event_idx callback to allocate an event
>> counter for a given event, which marks the selected counter
>> as "used". Now, when we delete the counter, the arm_pmu goes
>> ahead and clears the "used" bit and then invokes the "clear_event_idx"
>> call back, which kind of splits the job between the core code
>> and the backend. To keep things tidy, mandate the implementation
>> of clear_event_idx() and add it for exisiting backends.
>> This will be useful for adding the chained event support, where
>> we leave the event idx maintenance to the backend.
>>
>> Also, when an event is removed from the PMU, reset the hw.idx
>> to indicate that a counter is not allocated for this event,
>> to help the backends do better checks. This will be also used
>> for the chain counter support.
>>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: Will Deacon <will.deacon@arm.com>
>> Reviewed-by: Julien Thierry <julien.thierry@arm.com>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>> ---
>> Changes since v3:
>>   - Add clear_event_idx call back for backends.
>> ---
>>   arch/arm/kernel/perf_event_v6.c | 8 ++++++++
>>   arch/arm/kernel/perf_event_v7.c | 9 +++++++++
>>   arch/arm64/kernel/perf_event.c  | 7 +++++++
>>   drivers/perf/arm_pmu.c          | 7 +++----
>>   4 files changed, 27 insertions(+), 4 deletions(-)
> 
> I beleive this is missing the xscale PMU code.

Ah! Thanks for spotting. I will fix that.
> 
> Otherwiwse, this looks good to me.

Thanks
Suzuki
