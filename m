From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Thu, 16 Jun 2016 17:51:25 +0100
Subject: [PATCH v5] arm64: cpuinfo: Expose MIDR_EL1 and REVIDR_EL1 to sysfs
In-Reply-To: <20160616164311.GH5827@arm.com>
References: <1466083730-11786-1-git-send-email-suzuki.poulose@arm.com>
 <20160616164311.GH5827@arm.com>
Message-ID: <5762D90D.8090303@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16/06/16 17:43, Will Deacon wrote:
> On Thu, Jun 16, 2016 at 02:28:50PM +0100, Suzuki K Poulose wrote:
>> +static int __init cpuinfo_regs_init(void)
>> +{
>> +	int cpu, finalcpu, ret;
>> +	struct device *dev;
>> +
>> +	cpu_hotplug_disable();
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
>> +		goto out;
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
>> +
>> +out:
>> +	cpu_hotplug_enable();
>> +	return ret;
>> +}
>> +
>> +device_initcall(cpuinfo_regs_init);
>
> Given that you're built the sysfs entries out of the present mask, don't
> you need a hotplug notifier to keep things up to date?

We already check if the CPU is present at runtime before we give out the data.

+#define CPUINFO_ATTR_RO(_name)							\
+	static ssize_t show_##_name (struct device *dev,			\
+			struct device_attribute *attr, char *buf)		\
+	{									\
+		struct cpuinfo_arm64 *info = &per_cpu(cpu_data, dev->id);	\
+		if (!cpu_present(dev->id))					\
+			return -ENODEV;						\
+										\

Did you mean to check online/offline ?

Cheers
Suzuki
