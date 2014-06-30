From: t.figa@samsung.com (Tomasz Figa)
Date: Mon, 30 Jun 2014 18:11:50 +0200
Subject: [PATCH v5 1/5] ARM: EXYNOS: Add support for mapping PMU base
 address via DT
In-Reply-To: <1403705032-14835-2-git-send-email-pankaj.dubey@samsung.com>
References: <1403705032-14835-1-git-send-email-pankaj.dubey@samsung.com>
 <1403705032-14835-2-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <53B18C46.9010405@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pankaj,

In general the patch seems quite nice, but please see few comments inline.

On 25.06.2014 16:03, Pankaj Dubey wrote:
> Add support for mapping Samsung Power Management Unit (PMU)
> base address from device tree.
> 
> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> ---
>  arch/arm/mach-exynos/common.h |    1 +
>  arch/arm/mach-exynos/exynos.c |   45 +++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 46 insertions(+)

[snip]

> +static void exynos_map_pmu(void)
> +{
> +	struct device_node *np = NULL;

nit: Unnecessary variable initialization.

> +
> +	np = of_find_matching_node(NULL, exynos_dt_pmu_match);
> +

nit: Unnecessary blank line.

> +	if (!np) {
> +		pr_err("Failed to find PMU node\n");
> +		return;

Returning here probably doesn't make too much sense, especially when you
just panic if the mapping fails and you remove the static mapping in
patch 2/5, so backwards compatibility isn't provided anyway.

So something like this might be a better idea:

	np = of_find_matching_node(NULL, exynos_dt_pmu_match);
	if (np)
		pmu_base_addr = of_iomap(np, 0);

	if (!pmu_base_addr)
		panic("failed to find exynos pmu register\n");

> +	}
> +
> +	pmu_base_addr = of_iomap(np, 0);
> +
> +	if (!pmu_base_addr)
> +		panic("failed to find exynos pmu register\n");
> +}
> +
> +static void __init exynos_init_time(void)
> +{
> +	/* Nothing to do timer specific.
> +	 * Since platsmp.c needs pmu base address by the time
> +	 * DT is not unflatten so we can't use DT APIs before
> +	 * init_time
> +	 */
> +	exynos_map_pmu();

Would moving this to .init_irq() callback work too? There are more
things happening in .init_time() so it seems more fragile and some
platforms (e.g. mach-tegra) do such platform-specific initialization in
.init_irq() instead.

Best regards,
Tomasz
