From: ashwinc@codeaurora.org (Ashwin Chaugule)
Date: Mon, 22 Aug 2011 14:36:18 -0400
Subject: [RFC PATCH 08/15] ARM: perf: remove unnecessary armpmu->stop
In-Reply-To: <4B9A4BAF850C914D8DED94776A2C477E0B853A03@nasanexd01b.na.qualcomm.com>
References: <4B9A4BAF850C914D8DED94776A2C477E0B853A03@nasanexd01b.na.qualcomm.com>
Message-ID: <4E52A1A2.5020700@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

>> From: Mark Rutland 
>>
>> As armpmu_disable will call armpmu->stop when the last event has been
>> removed, this is pointless and simply adds to the noise when debugging.
>> Additionally, due to this call occurring in a preemptible context, this
>> is problematic for per-cpu locking of PMU registers (where we will
>> attempt to access per-cpu spinlock for use with raw_spin_lock_irqsave).
>>
>> This patch removes the call to armpmu->stop.
>>
>> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
>> Reviewed-by: Will Deacon <will.deacon@arm.com>
>> ---
>> arch/arm/kernel/perf_event.c |    1 -
>> 1 files changed, 0 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/arm/kernel/perf_event.c b/arch/arm/kernel/perf_event.c
>> index 9d6ac99..5ce6c33 100644
>> --- a/arch/arm/kernel/perf_event.c
>> +++ b/arch/arm/kernel/perf_event.c
>> @@ -396,7 +396,6 @@ armpmu_release_hardware(void)
>> 			free_irq(irq, NULL);
>> 	}
>>
>> -	armpmu->stop();
>> 	release_pmu(ARM_PMU_DEVICE_CPU);


Makes sense. On a similar note, I've been wondering why we need to loop
through all events in armpmu_enable() ?

Wouldn't the event->add call have taken care of armpmu->enable prior to
calling armpmu_enable() ?

I think we just need an armpmu->start(). What are your thoughts ?

Cheers,
Ashwin

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
