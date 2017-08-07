From: nleeder@codeaurora.org (Leeder, Neil)
Date: Mon, 7 Aug 2017 17:18:35 -0400
Subject: [PATCH 2/2] perf: add arm64 smmuv3 pmu driver
In-Reply-To: <1de250db-87d1-ed85-d0a7-43319139412b@arm.com>
References: <1501876754-1064-1-git-send-email-nleeder@codeaurora.org>
 <1501876754-1064-3-git-send-email-nleeder@codeaurora.org>
 <1de250db-87d1-ed85-d0a7-43319139412b@arm.com>
Message-ID: <4fc734dc-fde2-3f33-2f53-54affe7a14a9@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Robin,
Thank you for your comments.

On 8/7/2017 10:31 AM, Robin Murphy wrote:
> On 04/08/17 20:59, Neil Leeder wrote:
>> PMUs are named smmu_0_<phys_addr_page> where <phys_addr_page>
>> is the physical page address of the SMMU PMCG.
>> For example, the SMMU PMCG at 0xff88840000 is named smmu_0_ff88840
> 
> This seems a bit rough - is it at feasible to at least chase the node
> reference and namespace them by the associated component, e.g. something
> like "arm-smmu-v3.x:pmcg.y"? The user can always dig the associated
> physical address out of /proc/iomem if necessary.
> 
That looks like it may be better - I'll look into it. 

>> Filtering by stream id is done by specifying filtering parameters
>> with the event. Options are:
>>   filter_enable    - 0 = no filtering, 1 = filtering enabled
>>   filter_span      - 0 = exact match, 1 = pattern match
>>   filter_sec       - applies to non-secure (0) or secure (1) namespace
> 
> I'm a little dubious as to how useful it is to expose this, since we
> can't see the true value of SCR.SO so have no way of knowing what we'll
> actually end up counting.

I can remove the sec filter.

>> +config ARM_SMMUV3_PMU
>> +	 bool "ARM SMMUv3 PMU"
>> +	 depends on PERF_EVENTS && ARM64 && ACPI
> 
> PERF_EVENTS is already a top-level dependency now.
> 
OK

>> +#include <linux/msi.h>
> 
> Is MSI support planned?
> 
Not in this patchset. I'll remove the include.

>> +#define SMMU_PMCG_EVCNTR0               0x0
>> +#define SMMU_PMCG_EVCNTR(n, stride)     (SMMU_PMCG_EVCNTR0 + (n) * (stride))
>> +#define SMMU_PMCG_EVTYPER0              0x400
>> +#define SMMU_PMCG_EVTYPER(n)            (SMMU_PMCG_EVTYPER0 + (n) * 4)
>> +#define SMMU_PMCG_EVTYPER_SEC_SID_SHIFT       30
>> +#define SMMU_PMCG_EVTYPER_SID_SPAN_SHIFT      29
>> +#define SMMU_PMCG_EVTYPER_EVENT_MASK          GENMASK(15, 0)
>> +#define SMMU_PMCG_SVR0                  0x600
>> +#define SMMU_PMCG_SVR(n, stride)        (SMMU_PMCG_SVR0 + (n) * (stride))
>> +#define SMMU_PMCG_SMR0                  0xA00
>> +#define SMMU_PMCG_SMR(n)                (SMMU_PMCG_SMR0 + (n) * 4)
>> +#define SMMU_PMCG_CNTENSET0             0xC00
>> +#define SMMU_PMCG_CNTENCLR0             0xC20
>> +#define SMMU_PMCG_INTENSET0             0xC40
>> +#define SMMU_PMCG_INTENCLR0             0xC60
>> +#define SMMU_PMCG_OVSCLR0               0xC80
>> +#define SMMU_PMCG_OVSSET0               0xCC0
>> +#define SMMU_PMCG_CAPR                  0xD88
>> +#define SMMU_PMCG_SCR                   0xDF8
>> +#define SMMU_PMCG_CFGR                  0xE00
>> +#define SMMU_PMCG_CFGR_SID_FILTER_TYPE        BIT(23)
>> +#define SMMU_PMCG_CFGR_CAPTURE                BIT(22)
>> +#define SMMU_PMCG_CFGR_MSI                    BIT(21)
>> +#define SMMU_PMCG_CFGR_RELOC_CTRS             BIT(20)
>> +#define SMMU_PMCG_CFGR_SIZE_MASK              GENMASK(13, 8)
>> +#define SMMU_PMCG_CFGR_SIZE_SHIFT             8
>> +#define SMMU_PMCG_CFGR_COUNTER_SIZE_32        31
>> +#define SMMU_PMCG_CFGR_NCTR_MASK              GENMASK(5, 0)
>> +#define SMMU_PMCG_CFGR_NCTR_SHIFT             0
>> +#define SMMU_PMCG_CR                    0xE04
>> +#define SMMU_PMCG_CR_ENABLE                   BIT(0)
>> +#define SMMU_PMCG_CEID0                 0xE20
>> +#define SMMU_PMCG_CEID1                 0xE28
>> +#define SMMU_PMCG_IRQ_CTRL              0xE50
>> +#define SMMU_PMCG_IRQ_CTRL_IRQEN              BIT(0)
>> +#define SMMU_PMCG_IRQ_CTRLACK           0xE54
>> +#define SMMU_PMCG_IRQ_CTRLACK_IRQEN           BIT(0)
>> +#define SMMU_PMCG_IRQ_CFG0              0xE58
>> +#define SMMU_PMCG_IRQ_CFG0_ADDR_MASK          GENMASK(51, 2)
>> +#define SMMU_PMCG_IRQ_CFG1              0xE60
>> +#define SMMU_PMCG_IRQ_CFG2              0xE64
>> +#define SMMU_PMCG_IRQ_STATUS            0xE68
>> +#define SMMU_PMCG_IRQ_STATUS_IRQ_ABT          BIT(0)
>> +#define SMMU_PMCG_AIDR                  0xE70
> 
> Several of these are unused (although at least IRQ0_CFG1 probably should
> be, to zero it to a known state if we aren't supporting MSIs).
> 
I can remove the unused defines and clear IRQ_CFG1.

>> +	bool reg_size_32;
> 
> This guy is redundant...
> 
[...]
>> +	if (smmu_pmu->reg_size_32)
> 
> ...since it would be just as efficient to directly test
> smmu_pmu->counter_mask & BIT(32) here and below.
> 
OK

>> +
>> +	for (i = 0; i < smmu_pmu->num_counters; i++) {
>> +		smmu_pmu_counter_disable(smmu_pmu, i);
>> +		smmu_pmu_interrupt_disable(smmu_pmu, i);
>> +	}
> 
> Surely it would be far quicker and simpler to do this?
> 
> 	writeq(smmu_pmu->counter_present_mask,
> 		smmu_pmu->reg_base + SMMU_PMCG_CNTENCLR0);
> 	writeq(smmu_pmu->counter_present_mask,
> 		smmu_pmu->reg_base + SMMU_PMCG_INTENCLR0);
> 
OK

>> +static inline bool smmu_pmu_has_overflowed(struct smmu_pmu *smmu_pmu, u64 ovsr)
>> +{
>> +	return !!(ovsr & smmu_pmu->counter_present_mask);
>> +}
> 
> Personally, I find these helpers abstracting simple reads/writes
> actually make the code harder to follow, especially when they're each
> used a grand total of once. That may well just be me, though.
> 
At least this one will go away with the below change to the interrupt handler.

>> +	new = SMMU_COUNTER_RELOAD;
> 
> Given that we *are* following the "use the top counter bit as an
> implicit overflow bit" pattern of arm_pmu, it feels a bit weird to not
> use the actual half-maximum value here (especially since it's easily
> computable from counter_mask). I'm about 85% sure it probably still
> works, but as ever inconsistency breeds uncertainty.

I thought that if we're happy with BIT(31) working fine with 32-bit registers,
it should also work for larger registers, so there was no need to waste more of
their bits. But I can change it to be half-max for all of them.

>> +static irqreturn_t smmu_pmu_handle_irq(int irq_num, void *data)
>> +{
>> +	struct smmu_pmu *smmu_pmu = data;
>> +	u64 ovsr;
>> +	unsigned int idx;
>> +
>> +	ovsr = smmu_pmu_getreset_ovsr(smmu_pmu);
>> +	if (!smmu_pmu_has_overflowed(smmu_pmu, ovsr))
> 
> You have an architectural guarantee that unimplemented bits of OVSSET0
> are RES0, so checking !ovsr is sufficient.
> 
OK

>> +	/* Verify specified event is supported on this PMU */
>> +	event_id = get_event(event);
>> +	if ((event_id >= SMMU_MAX_EVENT_ID) ||
> 
> What about raw imp-def events?
> 
I can keep the check for common events, but also allow any raw event
in the imp-def range.

>> +	    (!test_bit(event_id, smmu_pmu->supported_events))) {
>> +		dev_dbg_ratelimited(&smmu_pmu->pdev->dev,
>> +				    "Invalid event %d for this PMU\n",
>> +				    event_id);
>> +		return -EINVAL;
>> +	}
[...]

>> +static int smmu_pmu_offline_cpu(unsigned int cpu, struct hlist_node *node)
>> +{
>> +	struct smmu_pmu *smmu_pmu;
>> +	unsigned int target;
>> +
>> +	smmu_pmu = hlist_entry_safe(node, struct smmu_pmu, node);
> 
> Is it ever valid for node to be NULL? If we can't trust it to be one of
> the PMUs we registered I think all bets are off anyway.
> 
I was following the logic in arm-ccn.c and arm-cci.c. If it works for them
I would hope it works here too.

>> +
>> +	ceid_64 = readq(smmu_pmu->reg_base + SMMU_PMCG_CEID0);
>> +	ceid[0] = ceid_64 & GENMASK(31, 0);
> 
> It took a second look to determine that that masking does nothing...
> 
>> +	ceid[1] = ceid_64 >> 32;
>> +	ceid_64 = readq(smmu_pmu->reg_base + SMMU_PMCG_CEID1);
>> +	ceid[2] = ceid_64 & GENMASK(31, 0);
>> +	ceid[3] = ceid_64 >> 32;
>> +	bitmap_from_u32array(smmu_pmu->supported_events, SMMU_MAX_EVENT_ID,
>> +			     ceid, SMMU_NUM_EVENTS_U32);
> 
> ...but then the whole lot might be cleaner and simpler with a u64[2]
> cast to u32* (or unioned to u32[4]) as necessary.
> 
I've rewritten this about 4 different ways and didn't love any of them,
including this one. I can re-do this as you suggest.

>> +static struct platform_driver smmu_pmu_driver = {
>> +	.driver = {
>> +		.name = "arm-smmu-pmu",
> 
> Nit: "arm-smmu-v3-pmu" please, for consistency with the IOMMU driver
> naming. There is a SMMUv2 PMU driver in the works, too ;)
> 
ok

Thanks,

Neil
-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
