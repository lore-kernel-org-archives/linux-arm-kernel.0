From: sudeep.holla@arm.com (Sudeep Holla)
Date: Mon, 17 Oct 2016 18:31:58 +0100
Subject: [PATCH 1/2] ARM: vexpress: refine MCPM smp operations override
 criteria
In-Reply-To: <20160923140303.GA26672@red-moon>
References: <20160923130907.4187-1-lorenzo.pieralisi@arm.com>
 <20160923140303.GA26672@red-moon>
Message-ID: <3d228f5f-8fb8-91f4-4572-4aeda679d36e@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 23/09/16 15:03, Lorenzo Pieralisi wrote:
> On Fri, Sep 23, 2016 at 02:09:06PM +0100, Lorenzo Pieralisi wrote:
>> Current vexpress smp init code detects whether to override the
>> default smp ops with MCPM smp ops by matching the "cci-400"
>> compatible string, in that MCPM requires control over CCI ports
>> to manage low-power states entry/exit.
>>
>> The "cci-400" compatible string check is a necessary but not
>> sufficient condition for MCPM to work, because the cci-400
>> can be made visible to the kernel, but firmware can nonetheless
>> disable non-secure CCI ports control, while still allowing PMU
>> access; if booted in non-secure world, the kernel would still
>> blindly override smp operations with MCPM operations, resulting
>> in kernel faults when the CCI ports programming interface is
>> accessed from non-secure world.
>>
>> This means that the "cci-400" compatible string check would
>> result in a false positive in systems that eg boot in HYP mode,
>> where CCI ports non-secure access is explicitly not allowed,
>> and it is reported in the respective device tree nodes with
>> CCI ports marked as disabled.
>>
>> Refactor the smp operations initialization to make sure that
>> the kernel is actually allowed to take control over CCI ports
>> (by enabling MCPM smp operations) before overriding default
>> vexpress smp operations.
>>
>> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>> Cc: Liviu Dudau <liviu.dudau@arm.com>
>> Cc: Sudeep Holla <sudeep.holla@arm.com>
>> Cc: Nicolas Pitre <nicolas.pitre@linaro.org>
>> Cc: Marc Zyngier <marc.zyngier@arm.com>
>> ---
>>  arch/arm/mach-vexpress/platsmp.c | 31 ++++++++++++++++++++++++-------
>>  1 file changed, 24 insertions(+), 7 deletions(-)
>>
>> diff --git a/arch/arm/mach-vexpress/platsmp.c b/arch/arm/mach-vexpress/platsmp.c
>> index 8b8d072..6cfd782 100644
>> --- a/arch/arm/mach-vexpress/platsmp.c
>> +++ b/arch/arm/mach-vexpress/platsmp.c
>> @@ -26,17 +26,34 @@
>>  bool __init vexpress_smp_init_ops(void)
>>  {
>>  #ifdef CONFIG_MCPM
>> +	int cpu;
>> +	struct device_node *cpu_node, *cci_node;
>> +
>>  	/*
>> -	 * The best way to detect a multi-cluster configuration at the moment
>> -	 * is to look for the presence of a CCI in the system.
>> +	 * The best way to detect a multi-cluster configuration
>> +	 * is to detect if the kernel can take over CCI ports
>> +	 * control. Loop over possible CPUs and check if CCI
>> +	 * port control is available.
>>  	 * Override the default vexpress_smp_ops if so.
>>  	 */
>> -	struct device_node *node;
>> -	node = of_find_compatible_node(NULL, NULL, "arm,cci-400");
>> -	if (node && of_device_is_available(node)) {
>> -		mcpm_smp_set_ops();
>> -		return true;
>> +	for_each_possible_cpu(cpu) {
>> +		bool available;
>> +
>> +		cpu_node = of_get_cpu_node(cpu, NULL);
>> +		if (WARN(!cpu_node, "Missing cpu device node!"))
>> +			return false;
>> +
>> +		cci_node = of_parse_phandle(cpu_node, "cci-control-port", 0);
>> +		available = cci_node && of_device_is_available(cci_node);
>> +		of_node_put(cci_node);
>> +		of_node_put(cpu_node);
>> +
>> +		if (!available)
>> +			return false;
>>  	}
>> +
>> +	mcpm_smp_set_ops();
>> +	return true;
>>  #endif
>>  	return false;
>
> For the records, while moving the code around I missed I was ending
> up with this idiotic double return, I have already reworked the patch
> and will squash changes in the final version if we agree on the bulk of
> the code.
>

I applied both patches to [1] with the fix for the above issue. Let me
know if that's fine. I have tested both hyp mode boot and SVC mode +
MCPM boot with latest u-boot by just fliping a bit in the firmware
(board.txt) without recompiling the kernel.

-- 
Regards,
Sudeep

[1] git.kernel.org/sudeep.holla/linux/h/vexpress/for-next
