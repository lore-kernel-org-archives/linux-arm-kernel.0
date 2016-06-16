From: will.deacon@arm.com (Will Deacon)
Date: Thu, 16 Jun 2016 17:43:11 +0100
Subject: [PATCH v5] arm64: cpuinfo: Expose MIDR_EL1 and REVIDR_EL1 to sysfs
In-Reply-To: <1466083730-11786-1-git-send-email-suzuki.poulose@arm.com>
References: <1466083730-11786-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <20160616164311.GH5827@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 16, 2016 at 02:28:50PM +0100, Suzuki K Poulose wrote:
> +static int __init cpuinfo_regs_init(void)
> +{
> +	int cpu, finalcpu, ret;
> +	struct device *dev;
> +
> +	cpu_hotplug_disable();
> +
> +	for_each_present_cpu(cpu) {
> +		dev = get_cpu_device(cpu);
> +
> +		if (!dev) {
> +			ret = -ENODEV;
> +			break;
> +		}
> +
> +		ret = sysfs_create_group(&dev->kobj, &cpuregs_attr_group);
> +		if (ret)
> +			break;
> +	}
> +
> +	if (!ret)
> +		goto out;
> +	/*
> +	 * We were unable to put down sysfs groups for all the CPUs, revert
> +	 * all the groups we have placed down s.t. none are visible.
> +	 * Otherwise we could give a misleading picture of what's present.
> +	 */
> +	finalcpu = cpu;
> +	for_each_present_cpu(cpu) {
> +		if (cpu == finalcpu)
> +			break;
> +		dev = get_cpu_device(cpu);
> +		if (dev)
> +			sysfs_remove_group(&dev->kobj, &cpuregs_attr_group);
> +	}
> +
> +out:
> +	cpu_hotplug_enable();
> +	return ret;
> +}
> +
> +device_initcall(cpuinfo_regs_init);

Given that you're built the sysfs entries out of the present mask, don't
you need a hotplug notifier to keep things up to date?

Will
