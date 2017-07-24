From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Mon, 24 Jul 2017 16:15:01 +0100
Subject: [PATCH v2 2/6] of: Add helper for mapping device node to logical
 CPU number
In-Reply-To: <ff7f1757-0beb-b87c-8965-d9fb29e6de47@arm.com>
References: <1500892161-17634-1-git-send-email-suzuki.poulose@arm.com>
 <1500892161-17634-3-git-send-email-suzuki.poulose@arm.com>
 <ff7f1757-0beb-b87c-8965-d9fb29e6de47@arm.com>
Message-ID: <b0484d86-0c0c-7c7f-6196-7c68c717a219@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,


On 24/07/17 14:14, Marc Zyngier wrote:
> On 24/07/17 11:29, Suzuki K Poulose wrote:
>> Add a helper to map a device node to a logical CPU number to avoid
>> duplication. Currently this is open coded in different places (e.g
>> gic-v3, coresight). The helper tries to map device node to a "possible"
>> logical CPU id, which may not be online yet. It is the responsibility
>> of the user to make sure that the CPU is online. The helper uses
>> of_get_cpu_node() which uses arch specific backends to match the phyiscal
>> ids.
>>
>> Cc: Rob Herring <robh+dt@kernel.org>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>> ---
>>  drivers/of/base.c         | 26 ++++++++++++++++++++++++++
>>  include/linux/of_device.h |  7 +++++++
>>  2 files changed, 33 insertions(+)
>>
>> diff --git a/drivers/of/base.c b/drivers/of/base.c
>> index 686628d..639af23 100644
>> --- a/drivers/of/base.c
>> +++ b/drivers/of/base.c

>> +int of_device_node_get_cpu(struct device_node *cpu_node)
>> +{
>> +	int cpu, thread;
>> +	bool found = false;
>> +	struct device_node *np;
>> +
>> +	for_each_possible_cpu(cpu) {
>> +		np = of_get_cpu_node(cpu, &thread);
>
> nit: Since you don't need the thread here, you can pass NULL instead.
>

Sure, will do that in the next version.


>
> FWIW:
>
> Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>
>

Thanks for taking a look.

Suzuki
