From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 20 Mar 2017 15:14:34 +0100
Subject: [PATCH 3/5] soc/tegra: Move Tegra flowctrl driver
In-Reply-To: <1489584715-23138-4-git-send-email-jonathanh@nvidia.com>
References: <1489584715-23138-1-git-send-email-jonathanh@nvidia.com>
 <1489584715-23138-4-git-send-email-jonathanh@nvidia.com>
Message-ID: <20170320141434.GC28203@ulmo.ba.sec>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 15, 2017 at 01:31:53PM +0000, Jon Hunter wrote:
[...]
> +static int __init tegra_flowctrl_init(void)
> +{
> +	/* hardcoded fallback if device tree node is missing */
> +	unsigned long base = 0x60007000;
> +	unsigned long size = SZ_4K;
> +	struct device_node *np;
> +
> +	if (!soc_is_tegra())
> +		return 0;
> +
> +	np = of_find_matching_node(NULL, matches);
> +	if (np) {
> +		struct resource res;
> +
> +		if (of_address_to_resource(np, 0, &res) == 0) {
> +			size = resource_size(&res);
> +			base = res.start;
> +		}
> +
> +		of_node_put(np);
> +	}
> +
> +	tegra_flowctrl_base = ioremap_nocache(base, size);
> +
> +	if (!tegra_flowctrl_base)
> +		return -ENXIO;
> +
> +	return 0;
> +}
> +early_initcall(tegra_flowctrl_init);

Do we want to implement a hand-off to a proper driver at some point,
similar to what we have for PMC?

> diff --git a/include/soc/tegra/flowctrl.h b/include/soc/tegra/flowctrl.h
[...]
> +#ifndef __ASSEMBLY__
> +u32 flowctrl_read_cpu_csr(unsigned int cpuid);
> +void flowctrl_write_cpu_csr(unsigned int cpuid, u32 value);
> +void flowctrl_write_cpu_halt(unsigned int cpuid, u32 value);
> +
> +void flowctrl_cpu_suspend_enter(unsigned int cpuid);
> +void flowctrl_cpu_suspend_exit(unsigned int cpuid);
> +#endif

Perhaps we want the same type of dummy functions scheme here for
!SOC_TEGRA_FLOWCTRL that Arnd proposed for !SOC_TEGRA_PMC?


> +
> +#endif
> -- 
> 2.7.4
> 
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170320/dc5df8d7/attachment.sig>
