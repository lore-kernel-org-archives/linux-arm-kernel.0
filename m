From: ashok.sekar@broadcom.com (Ashok Sekar)
Date: Tue, 22 Mar 2016 22:09:42 +0530
Subject: [PATCH 3/5] arm64/perf: Add Broadcom Vulcan PMU support
In-Reply-To: <20160322100110.GC31126@arm.com>
References: <1458133309-17045-1-git-send-email-ashoks@broadcom.com>
 <1458133309-17045-4-git-send-email-ashoks@broadcom.com>
 <20160322100110.GC31126@arm.com>
Message-ID: <CANK38rZQSOJPN76eP1LFcx8GduZRf8z-3w_kriAUg2=uON8Rcw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

On Tue, Mar 22, 2016 at 3:31 PM, Will Deacon <will.deacon@arm.com> wrote:
> Hi Ashok,
>
> On Wed, Mar 16, 2016 at 06:01:47AM -0700, Ashok Kumar wrote:
>> Broadcom Vulcan uses ARMv8 PMUv3 and supports most of
>> the ARMv8 recommended implementation defined events.
>>
>> Added Vulcan events mapping for perf and perf_cache.
>>
>> Created separate event_attrs structure for vulcan as
>> it supports more events and doesn't support few events
>> (like PC_WRITE, MEM_ERROR) from the generic armv8
>> event_attrs structure.
>>
>> Signed-off-by: Ashok Kumar <ashoks@broadcom.com>
>> ---
>>  arch/arm64/kernel/perf_event.c | 253 +++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 253 insertions(+)
>>
>> diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
>> index 3207b5f..1bb06d3 100644
>> --- a/arch/arm64/kernel/perf_event.c
>> +++ b/arch/arm64/kernel/perf_event.c
>> @@ -232,6 +232,20 @@ static const unsigned armv8_thunder_perf_map[PERF_COUNT_HW_MAX] = {
>>       [PERF_COUNT_HW_STALLED_CYCLES_BACKEND]  = ARMV8_PMUV3_PERFCTR_STALL_BACKEND,
>>  };
>>
>> +/* Broadcom Vulcan events mapping */
>> +static const unsigned armv8_vulcan_perf_map[PERF_COUNT_HW_MAX] = {
>> +     PERF_MAP_ALL_UNSUPPORTED,
>> +     [PERF_COUNT_HW_CPU_CYCLES]              = ARMV8_PMUV3_PERFCTR_CLOCK_CYCLES,
>> +     [PERF_COUNT_HW_INSTRUCTIONS]            = ARMV8_PMUV3_PERFCTR_INSTR_EXECUTED,
>> +     [PERF_COUNT_HW_CACHE_REFERENCES]        = ARMV8_PMUV3_PERFCTR_L1D_CACHE_ACCESS,
>> +     [PERF_COUNT_HW_CACHE_MISSES]            = ARMV8_PMUV3_PERFCTR_L1D_CACHE_REFILL,
>> +     [PERF_COUNT_HW_BRANCH_INSTRUCTIONS]     = ARMV8_PMUV3_PERFCTR_BR_RETIRED,
>> +     [PERF_COUNT_HW_BRANCH_MISSES]           = ARMV8_PMUV3_PERFCTR_PC_BRANCH_MIS_PRED,
>> +     [PERF_COUNT_HW_BUS_CYCLES]              = ARMV8_PMUV3_PERFCTR_BUS_CYCLES,
>> +     [PERF_COUNT_HW_STALLED_CYCLES_FRONTEND] = ARMV8_PMUV3_PERFCTR_STALL_FRONTEND,
>> +     [PERF_COUNT_HW_STALLED_CYCLES_BACKEND]  = ARMV8_PMUV3_PERFCTR_STALL_BACKEND,
>> +};
>> +
>>  static const unsigned armv8_pmuv3_perf_cache_map[PERF_COUNT_HW_CACHE_MAX]
>>                                               [PERF_COUNT_HW_CACHE_OP_MAX]
>>                                               [PERF_COUNT_HW_CACHE_RESULT_MAX] = {
>> @@ -324,6 +338,36 @@ static const unsigned armv8_thunder_perf_cache_map[PERF_COUNT_HW_CACHE_MAX]
>>       [C(BPU)][C(OP_WRITE)][C(RESULT_MISS)]   = ARMV8_PMUV3_PERFCTR_PC_BRANCH_MIS_PRED,
>>  };
>>
>> +static const unsigned armv8_vulcan_perf_cache_map[PERF_COUNT_HW_CACHE_MAX]
>> +                                           [PERF_COUNT_HW_CACHE_OP_MAX]
>> +                                           [PERF_COUNT_HW_CACHE_RESULT_MAX] = {
>> +     PERF_CACHE_MAP_ALL_UNSUPPORTED,
>> +
>> +     [C(L1D)][C(OP_READ)][C(RESULT_ACCESS)]  = ARMV8_IMPDEF_PERFCTR_L1D_CACHE_ACCESS_LD,
>> +     [C(L1D)][C(OP_READ)][C(RESULT_MISS)]    = ARMV8_IMPDEF_PERFCTR_L1D_CACHE_REFILL_LD,
>> +     [C(L1D)][C(OP_WRITE)][C(RESULT_ACCESS)] = ARMV8_IMPDEF_PERFCTR_L1D_CACHE_ACCESS_ST,
>> +     [C(L1D)][C(OP_WRITE)][C(RESULT_MISS)]   = ARMV8_IMPDEF_PERFCTR_L1D_CACHE_REFILL_ST,
>> +
>> +     [C(L1I)][C(OP_READ)][C(RESULT_ACCESS)]  = ARMV8_PMUV3_PERFCTR_L1I_CACHE_ACCESS,
>> +     [C(L1I)][C(OP_READ)][C(RESULT_MISS)]    = ARMV8_PMUV3_PERFCTR_L1I_CACHE_REFILL,
>> +
>> +     [C(ITLB)][C(OP_READ)][C(RESULT_MISS)]   = ARMV8_PMUV3_PERFCTR_L1I_TLB_REFILL,
>> +     [C(ITLB)][C(OP_READ)][C(RESULT_ACCESS)] = ARMV8_PMUV3_PERFCTR_L1I_TLB_ACCESS,
>> +
>> +     [C(DTLB)][C(OP_READ)][C(RESULT_ACCESS)] = ARMV8_IMPDEF_PERFCTR_L1D_TLB_ACCESS_LD,
>> +     [C(DTLB)][C(OP_WRITE)][C(RESULT_ACCESS)] = ARMV8_IMPDEF_PERFCTR_L1D_TLB_ACCESS_ST,
>> +     [C(DTLB)][C(OP_READ)][C(RESULT_MISS)]   = ARMV8_IMPDEF_PERFCTR_L1D_TLB_REFILL_LD,
>> +     [C(DTLB)][C(OP_WRITE)][C(RESULT_MISS)]  = ARMV8_IMPDEF_PERFCTR_L1D_TLB_REFILL_ST,
>> +
>> +     [C(BPU)][C(OP_READ)][C(RESULT_ACCESS)]  = ARMV8_PMUV3_PERFCTR_PC_BRANCH_PRED,
>> +     [C(BPU)][C(OP_READ)][C(RESULT_MISS)]    = ARMV8_PMUV3_PERFCTR_PC_BRANCH_MIS_PRED,
>> +     [C(BPU)][C(OP_WRITE)][C(RESULT_ACCESS)] = ARMV8_PMUV3_PERFCTR_PC_BRANCH_PRED,
>> +     [C(BPU)][C(OP_WRITE)][C(RESULT_MISS)]   = ARMV8_PMUV3_PERFCTR_PC_BRANCH_MIS_PRED,
>> +
>> +     [C(NODE)][C(OP_READ)][C(RESULT_ACCESS)] = ARMV8_IMPDEF_PERFCTR_BUS_ACCESS_LD,
>> +     [C(NODE)][C(OP_WRITE)][C(RESULT_ACCESS)] = ARMV8_IMPDEF_PERFCTR_BUS_ACCESS_ST,
>> +};
>
> I'm fine with this part of the patch...
>
>>  #define ARMV8_EVENT_ATTR_RESOLVE(m) #m
>>  #define ARMV8_EVENT_ATTR(name, config) \
>>       PMU_EVENT_ATTR_STRING(name, armv8_event_attr_##name, \
>> @@ -379,6 +423,74 @@ ARMV8_EVENT_ATTR(l2i_tlb_refill, ARMV8_PMUV3_PERFCTR_L2I_TLB_REFILL);
>>  ARMV8_EVENT_ATTR(l2d_tlb_access, ARMV8_PMUV3_PERFCTR_L2D_TLB_ACCESS);
>>  ARMV8_EVENT_ATTR(l2i_tlb_access, ARMV8_PMUV3_PERFCTR_L2I_TLB_ACCESS);
>>
>> +ARMV8_EVENT_ATTR(l1d_cache_access_ld, ARMV8_IMPDEF_PERFCTR_L1D_CACHE_ACCESS_LD);
>> +ARMV8_EVENT_ATTR(l1d_cache_refill_ld, ARMV8_IMPDEF_PERFCTR_L1D_CACHE_REFILL_LD);
>> +ARMV8_EVENT_ATTR(l1d_cache_access_st, ARMV8_IMPDEF_PERFCTR_L1D_CACHE_ACCESS_ST);
>> +ARMV8_EVENT_ATTR(l1d_cache_refill_st, ARMV8_IMPDEF_PERFCTR_L1D_CACHE_REFILL_ST);
>> +ARMV8_EVENT_ATTR(l1d_tlb_access_ld, ARMV8_IMPDEF_PERFCTR_L1D_TLB_ACCESS_LD);
>> +ARMV8_EVENT_ATTR(l1d_tlb_access_st, ARMV8_IMPDEF_PERFCTR_L1D_TLB_ACCESS_ST);
>> +ARMV8_EVENT_ATTR(l1d_tlb_refill_ld, ARMV8_IMPDEF_PERFCTR_L1D_TLB_REFILL_LD);
>> +ARMV8_EVENT_ATTR(l1d_tlb_refill_st, ARMV8_IMPDEF_PERFCTR_L1D_TLB_REFILL_ST);
>
> [...]
>
>> +static struct attribute *vulcan_pmuv3_event_attrs[] = {
>> +     &armv8_event_attr_sw_incr.attr.attr,
>> +     &armv8_event_attr_l1i_cache_refill.attr.attr,
>> +     &armv8_event_attr_l1i_tlb_refill.attr.attr,
>> +     &armv8_event_attr_l1d_cache_refill.attr.attr,
>> +     &armv8_event_attr_l1d_cache_access.attr.attr,
>> +     &armv8_event_attr_l1d_tlb_refill.attr.attr,
>> +     &armv8_event_attr_ld_retired.attr.attr,
>> +     &armv8_event_attr_st_retired.attr.attr,
>> +     &armv8_event_attr_inst_retired.attr.attr,
>> +     &armv8_event_attr_exc_taken.attr.attr,
>> +     &armv8_event_attr_exc_return.attr.attr,
>
> ... but I'm not keen on having these tables in the kernel for each CPU
> PMU we support. Where I'd like to get to is:
>
>   * We expose the architected events (0x0-0x3f) in /sys using the existing
>     PMUv3 tables in conjunction with PMCEIDn_EL0 (Jan mentioned this before)
I will use armv8_pmuv3_event_attrs itself for the time being for Vulcan.
Once the events identification mechanism is done using PMCEIDn_EL0, it
should take care
of removing the unsupported events from the table for Vulcan too.
Jan is working on this currently? or else I could look into it.
>
>   * Userspace knows about the micro-architecture-specific events for a
>     given PMU
>
> If there really is a need to have this in the kernel, then I think we
> should construct the tables at runtime using a bitmap, much like I'd
> like to do with PMCEIDn_EL0. That would mean having a bitmap for each
> compatible string, as opposed to a table of pointers in the kernel image.
>
> I still need to be convinced that this doesn't belong in userspace,
> though.
Agreed. I will look into adding them in userspace, libpfm4, I believe.

Thanks,
Ashok
>
> Will
