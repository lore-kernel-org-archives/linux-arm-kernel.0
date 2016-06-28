From: will.deacon@arm.com (Will Deacon)
Date: Tue, 28 Jun 2016 12:06:22 +0100
Subject: [PATCH v6] arm64: cpuinfo: Expose MIDR_EL1 and REVIDR_EL1 to sysfs
In-Reply-To: <1466507556-9027-1-git-send-email-suzuki.poulose@arm.com>
References: <1466507556-9027-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <20160628110621.GC5425@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 21, 2016 at 12:12:36PM +0100, Suzuki K Poulose wrote:
> From: Steve Capper <steve.capper@linaro.org>
> 
> It can be useful for JIT software to be aware of MIDR_EL1 and
> REVIDR_EL1 to ascertain the presence of any core errata that could
> affect code generation.
> 
> This patch exposes these registers through sysfs:
> 
> /sys/devices/system/cpu/cpu$ID/identification/midr
> /sys/devices/system/cpu/cpu$ID/identification/revidr
> 
> where $ID is the cpu number. For big.LITTLE systems, one can have a
> mixture of cores (e.g. Cortex A53 and Cortex A57), thus all CPUs need
> to be enumerated.
> 
> If the kernel does not have valid information to populate these entries
> with, an empty string is returned to userspace.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Steve Capper <steve.capper@linaro.org>
> [ ABI documentation updates, hotplug notifiers ]
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>

Looks good to me, but one minor comment below.

> +static struct attribute_group cpuregs_attr_group = {
> +	.attrs = cpuregs_attrs,
> +	.name = "identification"
> +};

This makes sense because MIDR/REVIDR belong to the "Identification"
functional group of registers, however I wonder if we should put this
under a directory called "regs" or similar, so that we don't have a
confusing top-level directory where "identification" lives alongside
things like "hotplug" and "cpuidle".

Either way:

Reviewed-by: Will Deacon <will.deacon@arm.com>

Will
