From: sudeep.holla@arm.com (Sudeep Holla)
Date: Thu, 9 Jun 2016 15:26:26 +0100
Subject: [PATCH v4 3/5] drivers: psci: refactor psci_cpu_init_idle in
 preparation for ACPI LPI support
In-Reply-To: <20160609132408.GA16831@red-moon>
References: <1461069013-13292-1-git-send-email-sudeep.holla@arm.com>
 <1461069013-13292-4-git-send-email-sudeep.holla@arm.com>
 <20160609132408.GA16831@red-moon>
Message-ID: <57597C92.3000609@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 09/06/16 14:24, Lorenzo Pieralisi wrote:
> On Tue, Apr 19, 2016 at 01:30:11PM +0100, Sudeep Holla wrote:
>> Inorder to accomodate bot DT and ACPI LPI support in psci_cpu_init_idle,
>> move the device tree specific into psci_dt_cpu_init_idle.
>>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>> Cc: linux-arm-kernel at lists.infradead.org
>> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
>> ---
>>   drivers/firmware/psci.c | 23 +++++++++--------------
>>   1 file changed, 9 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/firmware/psci.c b/drivers/firmware/psci.c
>> index 11bfee8b79a9..af6c5c839568 100644
>> --- a/drivers/firmware/psci.c
>> +++ b/drivers/firmware/psci.c
>> @@ -250,11 +250,11 @@ static int __init psci_features(u32 psci_func_id)
>>   #ifdef CONFIG_CPU_IDLE
>>   static DEFINE_PER_CPU_READ_MOSTLY(u32 *, psci_power_state);
>>
>> -static int psci_dt_cpu_init_idle(struct device_node *cpu_node, int cpu)
>> +static int psci_dt_cpu_init_idle(unsigned int cpu)
>
> Unfortunately you would break ARM 32-bit if you did that.
>

Ah right, I failed to catch this. Thanks for spotting this.

[...]

>>   int psci_cpu_init_idle(unsigned int cpu)
>>   {
>> -	struct device_node *cpu_node;
>> -	int ret;
>> -
>> -	cpu_node = of_get_cpu_node(cpu, NULL);
>> -	if (!cpu_node)
>> -		return -ENODEV;
>> -
>> -	ret = psci_dt_cpu_init_idle(cpu_node, cpu);
>> -
>> -	of_node_put(cpu_node);
>> -
>> -	return ret;
>> +	return psci_dt_cpu_init_idle(cpu);
>
> How about leaving code as is and you wrap the cpu_node retrieval:
>
> if (!acpi_disabled) {
> 	acpi_idle_init();
> } else {
> 	cpu_node = of_get_cpu_node(cpu, NULL);
> 	if (!cpu_node)
> 		return -ENODEV;
>
> 	ret = psci_dt_cpu_init_idle(cpu_node, cpu);
>
> 	of_node_put(cpu_node);
> }
>
> ?
>
> Alternatively, you could create an intermediate stub
> __psci_dt_cpu_init_idle(), that will be used for CONFIG_ARM
> cpuidle_ops.init and psci_dt_cpu_init_idle() after retrieving
> the cpu_node, which I think is slightly cleaner.
>

I like this approach more.

-- 
Regards,
Sudeep
