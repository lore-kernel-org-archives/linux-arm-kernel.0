From: b-cousson@ti.com (Cousson, Benoit)
Date: Tue, 29 Nov 2011 14:00:58 +0100
Subject: [PATCH V2] arm/tegra: convert tegra20 to GIC devicetree binding
In-Reply-To: <1322528052-6516-1-git-send-email-swarren@nvidia.com>
References: <1322528052-6516-1-git-send-email-swarren@nvidia.com>
Message-ID: <4ED4D78A.6000400@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen & Peter,

On 11/29/2011 1:54 AM, Stephen Warren wrote:
> From: pdeschrijver at nvidia.com<pdeschrijver@nvidia.com>

[...]

> @@ -125,6 +131,14 @@ void __init tegra_init_irq(void)
>   	gic_arch_extn.irq_unmask = tegra_unmask;
>   	gic_arch_extn.irq_retrigger = tegra_retrigger;
>
> -	gic_init(0, 29, IO_ADDRESS(TEGRA_ARM_INT_DIST_BASE),
> -		 IO_ADDRESS(TEGRA_ARM_PERIF_BASE + 0x100));
> +#ifdef CONFIG_OF
> +	/* Check if there is a devicetree present as of_irq_init doesn't
> +	 * indicate if an interrupt controller node was found.
> +	 */
> +	if (of_find_node_by_path("/"))
> +		of_irq_init(tegra_irq_match);
> +	else
> +#endif

For the same kind of need, I found the following API:

of_have_populated_dt()

Moreover, it returns false if !CONFIG_OF, so it will avoid the #ifdef.

Regards,
Benoit
