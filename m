From: Sudeep.KarkadaNagesha@arm.com (Sudeep KarkadaNagesha)
Date: Mon, 22 Jul 2013 16:07:05 +0100
Subject: [PATCH v3 01/16] of: add support for retrieving cpu node for
 a given logical cpu index
In-Reply-To: <alpine.LFD.2.03.1307221007160.15022@syhkavp.arg>
References: <1374069984-20567-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <1374492747-13879-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <1374492747-13879-2-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <alpine.LFD.2.03.1307221007160.15022@syhkavp.arg>
Message-ID: <51ED4A99.3030403@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nico,

On 22/07/13 15:14, Nicolas Pitre wrote:
> On Mon, 22 Jul 2013, Sudeep KarkadaNagesha wrote:
> 
>> From: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
>>
>> Currently different drivers requiring to access cpu device node are
>> parsing the device tree themselves. Since the ordering in the DT need
>> not match the logical cpu ordering, the parsing logic needs to consider
>> that. However, this has resulted in lots of code duplication and in some
>> cases even incorrect logic.
>>
>> It's better to consolidate them by adding support for getting cpu
>> device node for a given logical cpu index in DT core library. However
>> logical to physical index mapping can be architecture specific.
>>
>> This patch adds of_get_cpu_node to retrieve a cpu device node for a
>> given logical cpu index. The default matching of the physical id to the
>> logical cpu index can be overridden by architecture specific code.
>>
>> It is recommended to use these helper function only in pre-SMP/early
>> initialisation stages to retrieve CPU device node pointers in logical
>> ordering. Once the cpu devices are registered, it can be retrieved easily
>> from cpu device of_node which avoids unnecessary parsing and matching.
>>
>> Acked-by: Rob Herring <rob.herring@calxeda.com>
>> Signed-off-by: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
> 
> Minor nits below.  Otherwise...
> 
> Acked-by: Nicolas Pitre <nico@linaro.org>
> 
Thanks for all the Acks.

>> ---
>>  drivers/of/base.c  | 72 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>  include/linux/of.h |  6 +++++
>>  2 files changed, 78 insertions(+)
>>
>> diff --git a/drivers/of/base.c b/drivers/of/base.c
>> index 5c54279..1e690bf 100644
>> --- a/drivers/of/base.c
>> +++ b/drivers/of/base.c
>> @@ -230,6 +230,78 @@ const void *of_get_property(const struct device_node *np, const char *name,
>>  }
>>  EXPORT_SYMBOL(of_get_property);
>>  
>> +/*
>> + * arch_match_cpu_phys_id - Match the given logical CPU and physical id
>> + *
>> + * @cpu: logical index of a cpu
>> + * @phys_id: physical identifier of a cpu
>> + *
>> + * CPU logical to physical index mapping is architecture specific.
>> + * However this __weak function provides a default match of physical
>> + * id to logical cpu index.
>> + *
>> + * Returns true if the physical identifier and the logical index correspond
>> + * to the same cpu, false otherwise.
>> + */
>> +bool __weak arch_match_cpu_phys_id(int cpu, u64 phys_id)
> 
> Maybe a prototype declaration for this function should be added to 
> include/linux/of.h to avoid mismatch with architecture provided 
> versions.
> 
Agreed, but include/linux/of.h doesn't seem to be right choice for me as
this function is not really related to OF/DT. I can't choose any better
place either. I don't have a strong opinion on that, just a thought.

Regards,
Sudeep
