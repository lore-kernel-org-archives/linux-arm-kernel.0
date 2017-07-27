From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Thu, 27 Jul 2017 17:27:19 +0100
Subject: [PATCH v3 2/6] of: Add helper for mapping device node to logical
 CPU number
In-Reply-To: <CAL_JsqKTdysnhHMRKyqODm7VN4k=tkddozmUYXWv9nOmYGtzdQ@mail.gmail.com>
References: <1501168218-26741-1-git-send-email-suzuki.poulose@arm.com>
 <1501168218-26741-3-git-send-email-suzuki.poulose@arm.com>
 <CAL_JsqKTdysnhHMRKyqODm7VN4k=tkddozmUYXWv9nOmYGtzdQ@mail.gmail.com>
Message-ID: <d93a64ad-2fc1-99bc-388e-09ded391f62a@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27/07/17 16:48, Rob Herring wrote:
> Please use get_maintainers and cc the right people/lists.
>

Sorry about that, will fix it.

> +Frank, DT list
>
> On Thu, Jul 27, 2017 at 10:10 AM, Suzuki K Poulose
> <suzuki.poulose@arm.com> wrote:
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
>> Cc: Sudeep Holla <sudeep.holla@arm.com>
>> Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>> ---
>>  drivers/of/base.c         | 26 ++++++++++++++++++++++++++
>>  include/linux/of_device.h |  7 +++++++
>>  2 files changed, 33 insertions(+)
>>
>> diff --git a/drivers/of/base.c b/drivers/of/base.c
>> index 686628d..0b01515 100644
>> --- a/drivers/of/base.c
>> +++ b/drivers/of/base.c
>> @@ -420,6 +420,32 @@ struct device_node *of_get_cpu_node(int cpu, unsigned int *thread)
>>  EXPORT_SYMBOL(of_get_cpu_node);
>>
>>  /**
>> + * of_device_node_get_cpu: Get the logical CPU number for a given device_node
>> + *
>> + * @cpu_node: Pointer to the device_node for CPU.
>> + *
>> + * Returns the logical CPU number of the given CPU device_node.
>> + * Returns >= nr_cpu_ids if CPU is not found.
>
> Wouldn't negative be easier to test for? Then the caller doesn't need
> to know nr_cpu_ids.

I followed the conventions used by cpu_mask upon error here. But, we
could return -ENODEV upon failure here.
>
>> + */
>> +int of_device_node_get_cpu(struct device_node *cpu_node)
>
> of_device_* is for functions operating on struct device. So find
> another name. of_cpu_node_to_id perhaps.
>
> _get functions generally imply incrementing ref counts which you are
> not doing here.
>

OK, I can switch to of_cpu_node_to_id().

>> +{
>> +       int cpu;
>> +       bool found = false;
>> +       struct device_node *np;
>> +
>> +       for_each_possible_cpu(cpu) {
>> +               np = of_get_cpu_node(cpu, NULL);
>> +               found = (cpu_node == np);
>> +               of_node_put(np);
>> +               if (found)
>> +                       break;
>> +       }
>> +
>> +       return cpu;
>> +}
>> +EXPORT_SYMBOL(of_device_node_get_cpu);
>> +
>> +/**
>>   * __of_device_is_compatible() - Check if the node matches given constraints
>>   * @device: pointer to node
>>   * @compat: required compatible string, NULL or "" for any match
>> diff --git a/include/linux/of_device.h b/include/linux/of_device.h
>> index b4ad8b4..00a4ba9 100644
>> --- a/include/linux/of_device.h
>> +++ b/include/linux/of_device.h
>> @@ -40,6 +40,8 @@ extern int of_device_request_module(struct device *dev);
>>  extern void of_device_uevent(struct device *dev, struct kobj_uevent_env *env);
>>  extern int of_device_uevent_modalias(struct device *dev, struct kobj_uevent_env *env);
>>
>> +extern int of_device_node_get_cpu(struct device_node *np);
>> +
>
> Wrong place for this.
>

How about include/linux/of.h ?

Suzuki
