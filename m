From: will.deacon@arm.com (Will Deacon)
Date: Fri, 9 Sep 2016 18:26:09 +0100
Subject: [PATCH v8 8/9] arm64: pmu: Detect and enable multiple PMUs in an
 ACPI system
In-Reply-To: <1472507300-9844-9-git-send-email-jeremy.linton@arm.com>
References: <1472507300-9844-1-git-send-email-jeremy.linton@arm.com>
 <1472507300-9844-9-git-send-email-jeremy.linton@arm.com>
Message-ID: <20160909172609.GD11418@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 29, 2016 at 04:48:19PM -0500, Jeremy Linton wrote:
> +/* Count number and type of CPU cores in the system. */
> +static void __init arm_pmu_acpi_determine_cpu_types(struct list_head *pmus)
> +{
> +	int i;
> +	bool alloc_failure = false;
> +
> +	for_each_possible_cpu(i) {
> +		struct cpuinfo_arm64 *cinfo = per_cpu_ptr(&cpu_data, i);
> +		u32 partnum = MIDR_PARTNUM(cinfo->reg_midr);
> +		struct pmu_types *pmu;
> +
> +		list_for_each_entry(pmu, pmus, list) {
> +			if (pmu->cpu_type == partnum) {
> +				pmu->cpu_count++;
> +				break;
> +			}
> +		}
> +
> +		/* we didn't find the CPU type, add an entry to identify it */
> +		if ((&pmu->list == pmus) && (!alloc_failure)) {
> +			pmu = kzalloc(sizeof(struct pmu_types), GFP_KERNEL);
> +			if (!pmu) {
> +				pr_warn("Unable to allocate pmu_types\n");
> +				/*
> +				 * continue to count cpus for any pmu_types
> +				 * already allocated, but don't allocate any
> +				 * more pmu_types. This avoids undercounting.
> +				 */
> +				alloc_failure = true;

I thought we were ripping this out?

Will
