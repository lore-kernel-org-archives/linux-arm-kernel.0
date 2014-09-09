From: jcm@redhat.com (Jon Masters)
Date: Tue, 09 Sep 2014 13:00:51 -0400
Subject: [PATCH v3 09/17] ARM64 / ACPI: Parse MADT for SMP initialization
In-Reply-To: <20140909165226.GD4948@e102568-lin.cambridge.arm.com>
References: <1409583475-6978-1-git-send-email-hanjun.guo@linaro.org>
 <1409583475-6978-10-git-send-email-hanjun.guo@linaro.org>
 <20140903172138.GG1824@e102568-lin.cambridge.arm.com>
 <5408854B.9010703@linaro.org>
 <20140909165226.GD4948@e102568-lin.cambridge.arm.com>
Message-ID: <540F3243.2010302@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/09/2014 12:52 PM, Lorenzo Pieralisi wrote:
> On Thu, Sep 04, 2014 at 04:29:15PM +0100, Hanjun Guo wrote:
>> Hi Lorenzo,

>>>> +	if (!enabled)
>>>> +		return -EINVAL;
>>>> +
>>>> +	if (enabled_cpus >=  NR_CPUS) {
>>>> +		pr_warn("NR_CPUS limit of %d reached, Processor %d/0x%llx ignored.\n",
>>>> +			NR_CPUS, total_cpus, mpidr);
>>>> +		return -EINVAL;
>>>> +	}
>>>> +
>>>> +	/* No need to check duplicate MPIDRs for the first CPU */
>>>> +	if (enabled_cpus) {
>>>> +		/*
>>>> +		 * Duplicate MPIDRs are a recipe for disaster. Scan
>>>> +		 * all initialized entries and check for
>>>> +		 * duplicates. If any is found just ignore the CPU.
>>>> +		 */
>>>> +		for_each_possible_cpu(cpu) {
>>>> +			if (cpu_logical_map(cpu) == mpidr) {
>>>> +				pr_err("Firmware bug, duplicate CPU MPIDR: 0x%llx in MADT\n",
>>>> +				mpidr);
>>>> +				return -EINVAL;
>>>> +			}
>>>> +		}
>>>> +	} else {
>>>> +		/* Fist GICC entry must be BSP as ACPI spec said */
>>> s/Fist/First/
>>>
>>>> +		if  (cpu_logical_map(0) != mpidr) {
>>>> +			pr_err("First GICC entry is not BSP for MPIDR 0x%llx\n",
>>>> +			       mpidr);
>>>> +			return -EINVAL;
>>>> +		}
>>> Interesting, this means that if I want to change the boot CPU I have to
>>> recompile the ACPI tables. Is that really true ?
>>
>> No, you needn't. there is a logic problem here, we just need to print
>> some message here and continue, OS will still ok with that.
> 
> I need to look at the specs here. I do not like fixed dependencies on
> the boot CPU, which risk being translated in dependencies on first/last
> CPU going-to/getting-out-of idle and that is a major concern, among
> others.

See page 149 of the ACPI5.1 specification document (5.2.12.14 GICC
Structure):

"Note: GICC descriptor structures are listed immediately after the Flags
field in the MADT, one descriptor for each GICC, followed by one for
each GICC Distributor. The Local GICC corresponding to the boot
processor must be the first entry in the Interrupt Controller Structure
list."

Jon.
