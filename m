From: Sudeep.KarkadaNagesha@arm.com (Sudeep KarkadaNagesha)
Date: Fri, 16 Aug 2013 09:48:19 +0100
Subject: [RFC PATCH 3/4] powerpc: refactor of_get_cpu_node to support
 other architectures
In-Reply-To: <1376628563.4255.137.camel@pasglop>
References: <1374492747-13879-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <1376586580-5409-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <1376586580-5409-4-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <1376628563.4255.137.camel@pasglop>
Message-ID: <520DE753.8090601@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16/08/13 05:49, Benjamin Herrenschmidt wrote:
> On Thu, 2013-08-15 at 18:09 +0100, Sudeep KarkadaNagesha wrote:
>> From: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
>>
>> Currently different drivers requiring to access cpu device node are
>> parsing the device tree themselves. Since the ordering in the DT need
>> not match the logical cpu ordering, the parsing logic needs to consider
>> that. However, this has resulted in lots of code duplication and in some
>> cases even incorrect logic.
> 
>  .../...
> 
>>  
>> +bool arch_match_cpu_phys_id(int cpu, u64 phys_id)
>> +{
>> +	return (int)phys_id == get_hard_smp_processor_id(cpu);
>> +}
> 
> Naming is a bit gross. You might want to make it clearer that
> we are talking about CPU IDs in the device-tree here.
> 
Any particular preference to the name or just a note is sufficient.
Also unlike PPC, in ARM we don't set hard processor id value based
values read from device tree. DT must contain the values matching to the
hardware ID registers.

>> +static bool __of_find_n_match_cpu_property(struct device_node *cpun,
>> +			const char *prop_name, int cpu, unsigned int *thread)
>> +{
>> +	const __be32 *cell;
>> +	int ac, prop_len, tid;
>> +	u64 hwid;
>> +
>> +	ac = of_n_addr_cells(cpun);
>> +	cell = of_get_property(cpun, prop_name, &prop_len);
>> +	if (!cell)
>> +		return false;
>> +	prop_len /= sizeof(*cell);
>> +	for (tid = 0; tid < prop_len; tid++) {
>> +		hwid = of_read_number(cell, ac);
>> +		if (arch_match_cpu_phys_id(cpu, hwid)) {
>> +			if (thread)
>> +				*thread = tid;
>> +			return true;
>> +		}
> 
> Missing:          cell += ac;
Ah, missed it while refactoring, will fix it. Thanks

Regards,
Sudeep
