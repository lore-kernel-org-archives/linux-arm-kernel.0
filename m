From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Thu, 14 Jan 2016 11:48:02 +0800
Subject: [PATCH v2 3/4] arm64, acpi, numa: NUMA support based on SRAT and
 SLIT
In-Reply-To: <20160113230400.GB31343@rric.localdomain>
References: <1447784733-10419-1-git-send-email-gkulkarni@caviumnetworks.com>
 <1447784733-10419-4-git-send-email-gkulkarni@caviumnetworks.com>
 <56580C4F.4050903@huawei.com> <20160113230400.GB31343@rric.localdomain>
Message-ID: <56971A72.3070409@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016/1/14 7:04, Robert Richter wrote:
> On 27.11.15 15:54:55, Shannon Zhao wrote:
>> Hi,
>>
>> On 2015/11/18 2:25, Ganapatrao Kulkarni wrote:
>>> +/* Callback for Proximity Domain -> ACPI processor UID mapping */
>>> +void __init acpi_numa_gicc_affinity_init(struct acpi_srat_gicc_affinity *pa)
>>> +{
>>> +	int pxm, node;
>>> +	u64 mpidr;
>>> +	static int cpus_in_srat;
>>> +
>>> +	if (srat_disabled())
>>> +		return;
>>> +
>>> +	if (pa->header.length < sizeof(struct acpi_srat_gicc_affinity)) {
>>> +		bad_srat();
>>> +		return;
>>> +	}
>>> +
>>> +	if (!(pa->flags & ACPI_SRAT_GICC_ENABLED))
>>> +		return;
>>> +
>>> +	if (cpus_in_srat >= NR_CPUS) {
>>> +		pr_warn_once("SRAT: cpu_to_node_map[%ld] is too small, may not be able to use all cpus\n",
>>> +			     NR_CPUS);
>>> +		return;
>>> +	}
>>
>> arch/arm64/kernel/acpi_numa.c: In function 'acpi_numa_gicc_affinity_init':
>> arch/arm64/kernel/acpi_numa.c:137:3: warning: format '%ld' expects
>> argument of type 'long int', but argument 2 has type 'int' [-Wformat=]
>>     pr_warn_once("SRAT: cpu_to_node_map[%ld] is too small, may not be
>> able to use all cpus\n",
>
> Right, should be changed to:
>
>   pr_warn_once("SRAT: cpu_to_node_map[%d] ...

Thanks, I will update it in next version.

Hanjun
