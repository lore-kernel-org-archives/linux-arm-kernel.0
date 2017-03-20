From: jonathanh@nvidia.com (Jon Hunter)
Date: Mon, 20 Mar 2017 16:37:58 +0000
Subject: [PATCH 3/5] soc/tegra: Move Tegra flowctrl driver
In-Reply-To: <20170320141434.GC28203@ulmo.ba.sec>
References: <1489584715-23138-1-git-send-email-jonathanh@nvidia.com>
 <1489584715-23138-4-git-send-email-jonathanh@nvidia.com>
 <20170320141434.GC28203@ulmo.ba.sec>
Message-ID: <c0b18931-1377-813d-c8a3-60aea4379aa6@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 20/03/17 14:14, Thierry Reding wrote:
> * PGP Signed by an unknown key
> 
> On Wed, Mar 15, 2017 at 01:31:53PM +0000, Jon Hunter wrote:
> [...]
>> +static int __init tegra_flowctrl_init(void)
>> +{
>> +	/* hardcoded fallback if device tree node is missing */
>> +	unsigned long base = 0x60007000;
>> +	unsigned long size = SZ_4K;
>> +	struct device_node *np;
>> +
>> +	if (!soc_is_tegra())
>> +		return 0;
>> +
>> +	np = of_find_matching_node(NULL, matches);
>> +	if (np) {
>> +		struct resource res;
>> +
>> +		if (of_address_to_resource(np, 0, &res) == 0) {
>> +			size = resource_size(&res);
>> +			base = res.start;
>> +		}
>> +
>> +		of_node_put(np);
>> +	}
>> +
>> +	tegra_flowctrl_base = ioremap_nocache(base, size);
>> +
>> +	if (!tegra_flowctrl_base)
>> +		return -ENXIO;
>> +
>> +	return 0;
>> +}
>> +early_initcall(tegra_flowctrl_init);
> 
> Do we want to implement a hand-off to a proper driver at some point,
> similar to what we have for PMC?

Yes I can add, it won't do much apart from remap the io-space, but at
least it is registered as a device then.

>> diff --git a/include/soc/tegra/flowctrl.h b/include/soc/tegra/flowctrl.h
> [...]
>> +#ifndef __ASSEMBLY__
>> +u32 flowctrl_read_cpu_csr(unsigned int cpuid);
>> +void flowctrl_write_cpu_csr(unsigned int cpuid, u32 value);
>> +void flowctrl_write_cpu_halt(unsigned int cpuid, u32 value);
>> +
>> +void flowctrl_cpu_suspend_enter(unsigned int cpuid);
>> +void flowctrl_cpu_suspend_exit(unsigned int cpuid);
>> +#endif
> 
> Perhaps we want the same type of dummy functions scheme here for
> !SOC_TEGRA_FLOWCTRL that Arnd proposed for !SOC_TEGRA_PMC?

Yes that is a better solution, so will do the same here.

Jon

-- 
nvpublic
