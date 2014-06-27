From: will.deacon@arm.com (Will Deacon)
Date: Fri, 27 Jun 2014 16:34:44 +0100
Subject: [PATCHv3 2/5] arm64: cpuinfo: record cpu system register values
In-Reply-To: <1403795926-17139-3-git-send-email-mark.rutland@arm.com>
References: <1403795926-17139-1-git-send-email-mark.rutland@arm.com>
 <1403795926-17139-3-git-send-email-mark.rutland@arm.com>
Message-ID: <20140627153444.GB15775@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On Thu, Jun 26, 2014 at 04:18:43PM +0100, Mark Rutland wrote:
> Several kernel subsystems need to know details about CPU system register
> values, sometimes for CPUs other than that they are executing on. Rather
> than hard-coding system register accesses and cross-calls for these
> cases, this patch adds logic to record various system register values at
> boot-time. This may be used for feature reporting, firmware bug
> detection, etc.
> 
> Separate hooks are added for the boot and hotplug paths to enable
> one-time intialisation and cold/warm boot value mismatch detection in
> later patches.

[...]

> +void cpuinfo_store_cpu(void)
> +{
> +	unsigned int cpu = smp_processor_id();
> +	struct cpuinfo_arm64 *info = &per_cpu(cpu_data, cpu);

this_cpu_ptr?

> +	__cpuinfo_store_cpu(info);
> +}
> +
> +void __init cpuinfo_store_boot_cpu(void)
> +{
> +	unsigned int cpu = smp_processor_id();
> +	struct cpuinfo_arm64 *info = &per_cpu(cpu_data, cpu);
> +	__cpuinfo_store_cpu(info);

This looks familiar. Can you just call cpuinfo_store_cpu here, or even move
that code into __cpu_info_store_cpu, which will only work if it runs on the
CPU owning that data anyway.

Will
