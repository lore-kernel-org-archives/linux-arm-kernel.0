From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 12 Feb 2015 10:53:17 -0800
Subject: [PATCH 2/2] ARM: perf: Add support for Scorpion PMUs
In-Reply-To: <20150212124949.GE1522@leverpostej>
References: <1423616724-20849-1-git-send-email-sboyd@codeaurora.org>
 <1423616724-20849-3-git-send-email-sboyd@codeaurora.org>
 <20150212124949.GE1522@leverpostej>
Message-ID: <54DCF69D.5090707@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/12/15 04:49, Mark Rutland wrote:
> Hi,
>
> I haven't given this a thorough review, but I spotted a couple of items
> below.
>
> On Wed, Feb 11, 2015 at 01:05:24AM +0000, Stephen Boyd wrote:
>> Scorpion supports a set of local performance monitor event
>> selection registers (LPM) sitting behind a cp15 based interface
>> that extend the architected PMU events to include Scorpion CPU
>> and Venum VFP specific events. To use these events the user is
>> expected to program the lpm register with the event code shifted
>> into the group they care about and then point the PMNx event at
>> that region+group combo by writing a LPMn_GROUPx event. Add
>> support for this hardware.
>>
>> Note: the raw event number is a pure software construct that
>> allows us to map the multi-dimensional number space of regions,
>> groups, and event codes into a flat event number space suitable
>> for use by the perf framework.
>>
>> This is based on code originally written by Ashwin Chaugule and
>> Neil Leeder [1] massed to become similar to the Krait PMU support
>> code.
>>
>> [1] https://www.codeaurora.org/cgit/quic/la/kernel/msm/tree/arch/arm/kernel/perf_event_msm.c?h=msm-3.4
>>
>> Cc: Neil Leeder <nleeder@codeaurora.org>
>> Cc: Ashwin Chaugule <ashwinc@codeaurora.org>
>> Cc: <devicetree@vger.kernel.org>
>> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
>> ---
>>  Documentation/devicetree/bindings/arm/pmu.txt |   2 +
>>  arch/arm/kernel/perf_event_cpu.c              |   2 +
>>  arch/arm/kernel/perf_event_v7.c               | 395 ++++++++++++++++++++++++++
>>  3 files changed, 399 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/pmu.txt b/Documentation/devicetree/bindings/arm/pmu.txt
>> index 75ef91d08f3b..6e54a9d88b7a 100644
>> --- a/Documentation/devicetree/bindings/arm/pmu.txt
>> +++ b/Documentation/devicetree/bindings/arm/pmu.txt
>> @@ -18,6 +18,8 @@ Required properties:
>>         "arm,arm11mpcore-pmu"
>>         "arm,arm1176-pmu"
>>         "arm,arm1136-pmu"
>> +       "qcom,scorpion-pmu"
>> +       "qcom,scorpion-mp-pmu"
> Is the PMU any different in the MP and !MP variants? The code doesn't
> seem to handle the two any differently and will pass either to userspace
> as "armv7_scorpion".
>
> If there is some difference that we don't handle right now, that's fine,
> it just looks a little odd.

It seems that on MP there are two event encodings on MP that aren't
there on !MP and vice versa[1]. So I made two compatibles to reflect
that. I'll make two names that go to userspace to clarify this.

>> +static const unsigned scorpion_perf_cache_map[PERF_COUNT_HW_CACHE_MAX]
>> +                                           [PERF_COUNT_HW_CACHE_OP_MAX]
>> +                                           [PERF_COUNT_HW_CACHE_RESULT_MAX] = {
>> +       PERF_CACHE_MAP_ALL_UNSUPPORTED,
>> +       /*
>> +        * The performance counters don't differentiate between read and write
>> +        * accesses/misses so this isn't strictly correct, but it's the best we
>> +        * can do. Writes and reads get combined.
>> +        */
>> +       [C(L1D)][C(OP_READ)][C(RESULT_ACCESS)] = ARMV7_PERFCTR_L1_DCACHE_ACCESS,
>> +       [C(L1D)][C(OP_READ)][C(RESULT_MISS)] = ARMV7_PERFCTR_L1_DCACHE_REFILL,
>> +       [C(L1D)][C(OP_WRITE)][C(RESULT_ACCESS)] = ARMV7_PERFCTR_L1_DCACHE_ACCESS,
>> +       [C(L1D)][C(OP_WRITE)][C(RESULT_MISS)] = ARMV7_PERFCTR_L1_DCACHE_REFILL,
>> +       [C(L1I)][C(OP_READ)][C(RESULT_ACCESS)] = SCORPION_ICACHE_ACCESS,
>> +       [C(L1I)][C(OP_READ)][C(RESULT_MISS)] = SCORPION_ICACHE_MISS,
>> +       [C(L1I)][C(OP_WRITE)][C(RESULT_ACCESS)] = SCORPION_ICACHE_ACCESS,
>> +       [C(L1I)][C(OP_WRITE)][C(RESULT_MISS)] = SCORPION_ICACHE_MISS,
> These last two entries go against the policy we set in commit
> 40c390c768f89849: "ARM: perf: don't pretend to support counting of L1I
> writes", so I think they should be dropped.

Fair enough. Thanks for the pointer.

>
>> +       /*
>> +        * Only ITLB misses and DTLB refills are supported.  If users want the
>> +        * DTLB refills misses a raw counter must be used.
>> +        */
>> +       [C(DTLB)][C(OP_READ)][C(RESULT_ACCESS)] = SCORPION_DTLB_ACCESS,
>> +       [C(DTLB)][C(OP_READ)][C(RESULT_MISS)] = SCORPION_DTLB_MISS,
>> +       [C(DTLB)][C(OP_WRITE)][C(RESULT_ACCESS)] = SCORPION_DTLB_ACCESS,
>> +       [C(DTLB)][C(OP_WRITE)][C(RESULT_MISS)] = SCORPION_DTLB_MISS,
>> +       [C(ITLB)][C(OP_READ)][C(RESULT_MISS)] = SCORPION_ITLB_MISS,
>> +       [C(ITLB)][C(OP_WRITE)][C(RESULT_MISS)] = SCORPION_ITLB_MISS,
>> +       [C(BPU)][C(OP_READ)][C(RESULT_ACCESS)] = ARMV7_PERFCTR_PC_BRANCH_PRED,
>> +       [C(BPU)][C(OP_READ)][C(RESULT_MISS)] = ARMV7_PERFCTR_PC_BRANCH_PRED,
>> +       [C(BPU)][C(OP_WRITE)][C(RESULT_ACCESS)] = ARMV7_PERFCTR_PC_BRANCH_PRED,
>> +       [C(BPU)][C(OP_WRITE)][C(RESULT_MISS)] = ARMV7_PERFCTR_PC_BRANCH_PRED,
>> +};
> Not ARMV7_PERFCTR_PC_BRANCH_MIS_PRED for the RESULT_MISS cases as with
> all other ARMv7 instances (Krait included)?

I was just copying the stuff from downstream. I think it's a bug that
nobody noticed because the same problem was there on Krait and I fixed
it before sending upstream. Thanks for catching it.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
