From: punit.agrawal@arm.com (Punit Agrawal)
Date: Tue, 30 Aug 2016 10:43:53 +0100
Subject: [PATCH v7 8/9] arm64: pmu: Detect and enable multiple PMUs in an
 ACPI system
In-Reply-To: <b4d5397f-2ab0-8c19-d36e-ea23edb71bfb@arm.com> (Jeremy Linton's
 message of "Fri, 26 Aug 2016 17:44:59 -0500")
References: <1471985280-2243-1-git-send-email-jeremy.linton@arm.com>
 <1471985280-2243-9-git-send-email-jeremy.linton@arm.com>
 <8737lro9lq.fsf@e105922-lin.cambridge.arm.com>
 <b4d5397f-2ab0-8c19-d36e-ea23edb71bfb@arm.com>
Message-ID: <87vayimw12.fsf@e105922-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jeremy,

Jeremy Linton <jeremy.linton@arm.com> writes:

> Hi,
>
> On 08/26/2016 10:04 AM, Punit Agrawal wrote:
> (trimming)
>>> +			pmu = kzalloc(sizeof(struct pmu_types), GFP_KERNEL);
>>> +			if (!pmu) {
>>> +				pr_warn("Unable to allocate pmu_types\n");
>>> +				/*
>>> +				 * continue to count cpus for any pmu_types
>>> +				 * already allocated, but don't allocate any
>>> +				 * more pmu_types. This avoids undercounting.
>>> +				 */
>>> +				alloc_failure = true;
>>
>> Why not just fail probe and return an error? What is the benefit of
>> having some of the PMUs available?
>
> AFAIC, there isn't a good reason for penalizing PMU's which we can get
> working if a subset of the system PMUs can't be created. But this is
> per PMU type, so with current systems the kzalloc will be called a max
> of 2 times (there is the potential of a 3rd time, due to some other
> error handling, but that doesn't change the argument much). AKA, this
> doesn't result in "partial registration" of a PMU.

If it wasn't clear, by partial registration I was referring to a strict
subset of core PMUs being registered.

>
> So, really the only question in my mind is does it work if one of the
> allocations fails and the other succeeds, and the answer is yes, the
> remaining interrupts/etc get associated with the correct PMU, and it
> gets created and should work as well as perf currently works in
> systems with heterogeneous PMUs (cue discussion about CPU process
> migration).
>
> So, since this is early boot, and we are taking a tiny allocation, if
> this fails i suspect that the machine will probably die anyway, not
> due to the choice of whether the PMU is counted properly or not. I
> would guess the platform allocation or similar will die..

As you have pointed out earlier, if the allocation fails something is
seriously wrong with the system.

In such a situation, I don't see the justification of additional code
complexity (as evidenced in the patch) - when having a subset of PMUs
available isn't even going to be high on the users' priority.

>
> (trimming)
>
>>> +/*
>>> + * For the given cpu/pmu type, walk all known GSIs, register them, and add
>>> + * them to the resource structure. Return the number of GSI's contained
>>> + * in the res structure, and the id of the last CPU/PMU we added.
>>> + */
>>> +static int __init arm_pmu_acpi_gsi_res(struct pmu_types *pmus,
>>> +				       struct resource *res, int *last_cpu_id)
>>> +{
>>> +	int i, count;
>>> +	int irq;
>>> +
>>> +	/* lets group all the PMU's from similar CPU's together */
>>> +	count = 0;
>>> +	for_each_possible_cpu(i) {
>>> +		struct cpuinfo_arm64 *cinfo = per_cpu_ptr(&cpu_data, i);
>>> +
>>> +		if (pmus->cpu_type == MIDR_PARTNUM(cinfo->reg_midr)) {
>>> +			if (pmu_irqs[i].gsi == 0)
>>> +				continue;
>>
>> Please don't silently continue if the irq is missing. It deserves a user
>> visible message. We don't want users complaining about kernel issues
>> when the firmware fails to provide the required information.
>
> See below.
>
>>
>>> +
>>> +			irq = acpi_register_gsi(NULL, pmu_irqs[i].gsi,
>>> +						pmu_irqs[i].trigger,
>>> +						ACPI_ACTIVE_HIGH);
>>
>> Check for the return value of acpi_register_gsi as it can return an
>> error.
>
> Ok, so this is probably a little subtle, but IIRC from a few months
> back when I was testing this/reworking it, duplicate GSI registrations
> for exclusive PPI's result in errors (see any random discussion about
> PPI's not being ACPI GSI's).

Is this - improper handling of PPIs in ACPI - something we should be
looking at improving? The current behaviour seems like a bodge we are
working around. I don't think this work should be part of this series.

> As the code to handle SPI vs PPI exists
> in the platform code, I decided to ignore registration errors until
> such a determination can be made. AKA, i'm potentially tossing invalid
> irq's into the irq list for PPIs, but it doesn't matter because they
> are temporary ignored. The core ARM PMU code, has a much better handle
> on what is a correct interrupt binding, so the decision about whether
> these failures need to be worried about are delayed until then. This
> results in a large simplification because we handle the irq
> deregistration necessarily for any further errors together, AKA you
> will notice a complete lack of differing code paths for PPI vs SPI in
> this module.
>
> As far as gsi=0, in cases where there are placeholder GICC entries in
> the MADT (think disabled CPU) then i've seen gsi=0. I'm not sure that
> is incorrect, so again it gets skipped, the pmu mask doesn't have it
> listed, and everything "works". So if i'm going to add a message here
> i'm, going to wrap it in a reg_midr!=0 check.
>
>>
>>> +
>>> +			res[count].start = res[count].end = irq;
>>> +			res[count].flags = IORESOURCE_IRQ;
>>> +
>>> +			if (pmu_irqs[i].trigger == ACPI_EDGE_SENSITIVE)
>>> +				res[count].flags |= IORESOURCE_IRQ_HIGHEDGE;
>>> +			else
>>> +				res[count].flags |= IORESOURCE_IRQ_HIGHLEVEL;
>>> +
>>> +			pmu_irqs[i].registered = true;
>>> +			count++;
>>> +			(*last_cpu_id) = cinfo->reg_midr;
>>
>> What is the benefit of using the entire MIDR for cpu_id when the
>> grouping is done on the basis of a subset, i.e., part number.
>
> Because the platform code isn't partnum specific, unless the the
> ARMV8_PMU_PART_PROBE() macro is utilized. Delaying any decisions about
> what part of the MIDR happens to be used (if any) to the part probe
> table is probably a good idea. Especially if someone happens to think
> that they want a ARMV8_PMU_PART_REVISION_PROBE() or similar macro..
>
>
> If anything It might be worth removing the partnum checks in this
> module as well. That way should someone ship a machine with the same
> CPU only differing by revision (or pick your favorite !partnum field)
> they get different PMUs definitions. Why anyone would do that I cannot
> guess, but I do see that apparently the xscale version was important
> at one point.

It is generally a hard problem to guess what implementations might do in
the future. ;)

Punit

>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
