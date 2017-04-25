From: f.fainelli@gmail.com (Florian Fainelli)
Date: Tue, 25 Apr 2017 10:13:51 -0700
Subject: [PATCH 2/2] arm64: pmu: Wire-up L2 cache events for ARMv8 PMUv3
In-Reply-To: <20170425124427.GI24484@arm.com>
References: <20170420190546.7453-1-f.fainelli@gmail.com>
 <20170420190546.7453-4-f.fainelli@gmail.com> <20170425124427.GI24484@arm.com>
Message-ID: <28edde78-b965-8136-1c95-11b9182de405@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/25/2017 05:44 AM, Will Deacon wrote:
> Hi Florian,
> 
> On Thu, Apr 20, 2017 at 12:05:46PM -0700, Florian Fainelli wrote:
>> The ARMv8 PMUv3 cache map did not include the L2 cache events, add
>> them.
>>
>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
>> ---
>>  arch/arm64/kernel/perf_event.c | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
>> index 4f011cdd756d..a664c575f3fd 100644
>> --- a/arch/arm64/kernel/perf_event.c
>> +++ b/arch/arm64/kernel/perf_event.c
>> @@ -264,6 +264,11 @@ static const unsigned armv8_pmuv3_perf_cache_map[PERF_COUNT_HW_CACHE_MAX]
>>  	[C(L1I)][C(OP_READ)][C(RESULT_ACCESS)]	= ARMV8_PMUV3_PERFCTR_L1I_CACHE,
>>  	[C(L1I)][C(OP_READ)][C(RESULT_MISS)]	= ARMV8_PMUV3_PERFCTR_L1I_CACHE_REFILL,
>>  
>> +	[C(LL)][C(OP_READ)][C(RESULT_ACCESS)]	= ARMV8_PMUV3_PERFCTR_L2D_CACHE,
>> +	[C(LL)][C(OP_READ)][C(RESULT_MISS)]	= ARMV8_PMUV3_PERFCTR_L2D_CACHE_REFILL,
>> +	[C(LL)][C(OP_WRITE)][C(RESULT_ACCESS)]	= ARMV8_PMUV3_PERFCTR_L2D_CACHE,
>> +	[C(LL)][C(OP_WRITE)][C(RESULT_MISS)]	= ARMV8_PMUV3_PERFCTR_L2D_CACHE_REFILL,
> 
> I don't think this is correct in general. 'LL' stands for "last-level",
> which may be L3 or even a system cache in the interconnect. Tying that to L2
> is the wrong thing to do from perf's generic event perspective.
> 
> I'm ok with what you're proposing for A53 (where the PMU can only count
> events out to the L2), but I'm reluctant to make this change for the generic
> PMUv3 events.

That makes sense, shall I resubmit the first patch by itself or can you
or Catalin take it as-is?

Thanks!
-- 
Florian
