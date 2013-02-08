From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 08 Feb 2013 10:09:10 -0700
Subject: [PATCH 1/4] ARM: tegra: Unify tegra{20,30,114}_init_early()
In-Reply-To: <340098510.UosBEPkrGv@fb07-iapwap2>
References: <1360308574-19658-1-git-send-email-hdoyu@nvidia.com>
 <1360308574-19658-2-git-send-email-hdoyu@nvidia.com>
 <340098510.UosBEPkrGv@fb07-iapwap2>
Message-ID: <51153136.7010705@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/08/2013 05:29 AM, Marc Dietrich wrote:
> Hiroshi,
> 
> Am Freitag, 8. Februar 2013, 09:29:31 schrieb Hiroshi Doyu:
>> Refactored tegra{20,30,114}_init_early() so that we have the unified
>> tegra_init_early().

>> diff --git a/arch/arm/mach-tegra/hotplug.c b/arch/arm/mach-tegra/hotplug.c

>> +void __init tegra_hotplug_init(void)
>>  {
>> +	switch (tegra_chip_id) {
>> +#ifdef CONFIG_ARCH_TEGRA_2x_SOC
>> +	case TEGRA20:
>> +		tegra_hotplug_shutdown = tegra20_hotplug_shutdown;
>> +		break;
>>  #endif
>> +#if defined(CONFIG_ARCH_TEGRA_3x_SOC)
>> +	case TEGRA30:
>> +		tegra_hotplug_shutdown = tegra30_hotplug_shutdown;
>> +		break;
>>  #endif
>> +	default:
>> +		BUG_ON(IS_ENABLED(CONFIG_HOTPLUG_CPU));
>> +		break;
>> +	}
>> +}
> 
> are these ifdefs really needed? Multisoc kernels will enable them all anyway 
> and there is a case structure which protects the assignments. Also the hotplug 
> functions are very tiny, so there shouldn't be a big loss.

The files that contain/implement those functions are separate for each
SoC and only included in the build when the individual SoCs are enabled.

While multi-platform SoCs do make sense for distros, we also very
specifically want to support the case where only Tegra, and only a
single Tegra SoC, is enabled, hence this separation.

(and Tegra doesn't support multi-platform yet; maybe in another kernel
release or two)
