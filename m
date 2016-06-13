From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Mon, 13 Jun 2016 13:02:36 +0100
Subject: [PATCH] arm64: cpuinfo: Expose MIDR_EL1 and REVIDR_EL1 to sysfs
In-Reply-To: <20160610170220.GC23223@arm.com>
References: <1465571984-18776-1-git-send-email-suzuki.poulose@arm.com>
 <20160610170220.GC23223@arm.com>
Message-ID: <575EA0DC.2080801@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/06/16 18:02, Will Deacon wrote:
> On Fri, Jun 10, 2016 at 04:19:44PM +0100, Suzuki K Poulose wrote:
>> From: Steve Capper <steve.capper@linaro.org>
>>
>> It can be useful for JIT software to be aware of MIDR_EL1 and
>> REVIDR_EL1 to ascertain the presence of any core errata that could
>> affect codegen.
>>
>> This patch exposes these registers through sysfs:
>>
>> /sys/devices/system/cpu/cpu$ID/identification/midr
>> /sys/devices/system/cpu/cpu$ID/identification/revidr


>> +
>> +#define CPUINFO_ATTR_RO(_name)							\
>> +	static ssize_t show_##_name (struct device *dev,			\
>> +			struct device_attribute *attr, char *buf)		\
>> +	{									\
>> +		struct cpuinfo_arm64 *info = &per_cpu(cpu_data, dev->id);	\
>> +		if (!cpu_present(dev->id))					\
>> +			return -ENODEV;						\
>> +										\
>> +		if (info->reg_midr)						\
>> +			return sprintf(buf, "0x%016x\n", info->reg_##_name);	\
>
> Should this be 0x%08x, as these are 32-bit registers?

Yes. Will change it. As per Mark's comments, I can change them to 64bit in a separate
patch.



>> +
>> +static int __init cpuinfo_regs_init(void)
>> +{
>> +	int cpu, finalcpu, ret;
>> +	struct device *dev;
>> +
>> +	for_each_present_cpu(cpu) {
>> +		dev = get_cpu_device(cpu);
>> +
>> +		if (!dev) {
>> +			ret = -ENODEV;
>> +			break;
>> +		}
>> +
>> +		ret = sysfs_create_group(&dev->kobj, &cpuregs_attr_group);
>> +		if (ret)
>> +			break;
>> +	}
>> +
>> +	if (!ret)
>> +		return 0;
>> +	/*
>> +	 * We were unable to put down sysfs groups for all the CPUs, revert
>> +	 * all the groups we have placed down s.t. none are visible.
>> +	 * Otherwise we could give a misleading picture of what's present.
>> +	 */
>> +	finalcpu = cpu;
>> +	for_each_present_cpu(cpu) {
>> +		if (cpu == finalcpu)
>> +			break;
>> +		dev = get_cpu_device(cpu);
>> +		if (dev)
>> +			sysfs_remove_group(&dev->kobj, &cpuregs_attr_group);
>> +	}
>
> Can CPUs be removed from underneath us using unregister_cpu? If so, I

Yes. Good point. Though this is done at early boot, nobody prevents
an unregister_cpu(). The safer way would be to wrap the code in
cpu_hotplug_disable()...enable().

I will respin it.



> don't think we should assume that get_cpu_device will succeed in the
> same places for both the loops.


Thanks
Suzuki
