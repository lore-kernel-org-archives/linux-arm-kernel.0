From: acourbot@nvidia.com (Alexandre Courbot)
Date: Tue, 11 Nov 2014 15:21:15 +0900
Subject: [PATCH v4 REPOST 5/5] ARM: tegra: Add thermal reset (thermtrip)
 support to PMC
In-Reply-To: <1415625137-4791-6-git-send-email-mikko.perttunen@kapsi.fi>
References: <1415625137-4791-1-git-send-email-mikko.perttunen@kapsi.fi>
 <1415625137-4791-6-git-send-email-mikko.perttunen@kapsi.fi>
Message-ID: <5461AADB.2060207@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/10/2014 10:12 PM, Mikko Perttunen wrote:
> @@ -606,6 +623,234 @@ void tegra_pmc_enter_suspend_mode(enum tegra_suspend_mode mode)
>   }
>   #endif
>
> +static const char * const tegra20_powergates[] = {
> +	[TEGRA_POWERGATE_CPU] = "cpu",
> +	[TEGRA_POWERGATE_3D] = "3d",
> +	[TEGRA_POWERGATE_VENC] = "venc",
> +	[TEGRA_POWERGATE_VDEC] = "vdec",
> +	[TEGRA_POWERGATE_PCIE] = "pcie",
> +	[TEGRA_POWERGATE_L2] = "l2",
> +	[TEGRA_POWERGATE_MPE] = "mpe",
> +};
> +
> +static const struct tegra_pmc_soc tegra20_pmc_soc = {
> +	.num_powergates = ARRAY_SIZE(tegra20_powergates),
> +	.powergates = tegra20_powergates,
> +	.num_cpu_powergates = 0,
> +	.cpu_powergates = NULL,
> +};
> +
> +static const char * const tegra30_powergates[] = {
> +	[TEGRA_POWERGATE_CPU] = "cpu0",
> +	[TEGRA_POWERGATE_3D] = "3d0",
> +	[TEGRA_POWERGATE_VENC] = "venc",
> +	[TEGRA_POWERGATE_VDEC] = "vdec",
> +	[TEGRA_POWERGATE_PCIE] = "pcie",
> +	[TEGRA_POWERGATE_L2] = "l2",
> +	[TEGRA_POWERGATE_MPE] = "mpe",
> +	[TEGRA_POWERGATE_HEG] = "heg",
> +	[TEGRA_POWERGATE_SATA] = "sata",
> +	[TEGRA_POWERGATE_CPU1] = "cpu1",
> +	[TEGRA_POWERGATE_CPU2] = "cpu2",
> +	[TEGRA_POWERGATE_CPU3] = "cpu3",
> +	[TEGRA_POWERGATE_CELP] = "celp",
> +	[TEGRA_POWERGATE_3D1] = "3d1",
> +};
> +
> +static const u8 tegra30_cpu_powergates[] = {
> +	TEGRA_POWERGATE_CPU,
> +	TEGRA_POWERGATE_CPU1,
> +	TEGRA_POWERGATE_CPU2,
> +	TEGRA_POWERGATE_CPU3,
> +};
> +
> +static const struct tegra_pmc_soc tegra30_pmc_soc = {
> +	.num_powergates = ARRAY_SIZE(tegra30_powergates),
> +	.powergates = tegra30_powergates,
> +	.num_cpu_powergates = ARRAY_SIZE(tegra30_cpu_powergates),
> +	.cpu_powergates = tegra30_cpu_powergates,
> +	.has_tsense_reset = true,
> +};
> +
> +static const char * const tegra114_powergates[] = {
> +	[TEGRA_POWERGATE_CPU] = "crail",
> +	[TEGRA_POWERGATE_3D] = "3d",
> +	[TEGRA_POWERGATE_VENC] = "venc",
> +	[TEGRA_POWERGATE_VDEC] = "vdec",
> +	[TEGRA_POWERGATE_MPE] = "mpe",
> +	[TEGRA_POWERGATE_HEG] = "heg",
> +	[TEGRA_POWERGATE_CPU1] = "cpu1",
> +	[TEGRA_POWERGATE_CPU2] = "cpu2",
> +	[TEGRA_POWERGATE_CPU3] = "cpu3",
> +	[TEGRA_POWERGATE_CELP] = "celp",
> +	[TEGRA_POWERGATE_CPU0] = "cpu0",
> +	[TEGRA_POWERGATE_C0NC] = "c0nc",
> +	[TEGRA_POWERGATE_C1NC] = "c1nc",
> +	[TEGRA_POWERGATE_DIS] = "dis",
> +	[TEGRA_POWERGATE_DISB] = "disb",
> +	[TEGRA_POWERGATE_XUSBA] = "xusba",
> +	[TEGRA_POWERGATE_XUSBB] = "xusbb",
> +	[TEGRA_POWERGATE_XUSBC] = "xusbc",
> +};
> +
> +static const u8 tegra114_cpu_powergates[] = {
> +	TEGRA_POWERGATE_CPU0,
> +	TEGRA_POWERGATE_CPU1,
> +	TEGRA_POWERGATE_CPU2,
> +	TEGRA_POWERGATE_CPU3,
> +};
> +
> +static const struct tegra_pmc_soc tegra114_pmc_soc = {
> +	.num_powergates = ARRAY_SIZE(tegra114_powergates),
> +	.powergates = tegra114_powergates,
> +	.num_cpu_powergates = ARRAY_SIZE(tegra114_cpu_powergates),
> +	.cpu_powergates = tegra114_cpu_powergates,
> +	.has_tsense_reset = true,
> +};
> +
> +static const char * const tegra124_powergates[] = {
> +	[TEGRA_POWERGATE_CPU] = "crail",
> +	[TEGRA_POWERGATE_3D] = "3d",
> +	[TEGRA_POWERGATE_VENC] = "venc",
> +	[TEGRA_POWERGATE_PCIE] = "pcie",
> +	[TEGRA_POWERGATE_VDEC] = "vdec",
> +	[TEGRA_POWERGATE_L2] = "l2",
> +	[TEGRA_POWERGATE_MPE] = "mpe",
> +	[TEGRA_POWERGATE_HEG] = "heg",
> +	[TEGRA_POWERGATE_SATA] = "sata",
> +	[TEGRA_POWERGATE_CPU1] = "cpu1",
> +	[TEGRA_POWERGATE_CPU2] = "cpu2",
> +	[TEGRA_POWERGATE_CPU3] = "cpu3",
> +	[TEGRA_POWERGATE_CELP] = "celp",
> +	[TEGRA_POWERGATE_CPU0] = "cpu0",
> +	[TEGRA_POWERGATE_C0NC] = "c0nc",
> +	[TEGRA_POWERGATE_C1NC] = "c1nc",
> +	[TEGRA_POWERGATE_SOR] = "sor",
> +	[TEGRA_POWERGATE_DIS] = "dis",
> +	[TEGRA_POWERGATE_DISB] = "disb",
> +	[TEGRA_POWERGATE_XUSBA] = "xusba",
> +	[TEGRA_POWERGATE_XUSBB] = "xusbb",
> +	[TEGRA_POWERGATE_XUSBC] = "xusbc",
> +	[TEGRA_POWERGATE_VIC] = "vic",
> +	[TEGRA_POWERGATE_IRAM] = "iram",
> +};
> +
> +static const u8 tegra124_cpu_powergates[] = {
> +	TEGRA_POWERGATE_CPU0,
> +	TEGRA_POWERGATE_CPU1,
> +	TEGRA_POWERGATE_CPU2,
> +	TEGRA_POWERGATE_CPU3,
> +};
> +
> +static const struct tegra_pmc_soc tegra124_pmc_soc = {
> +	.num_powergates = ARRAY_SIZE(tegra124_powergates),
> +	.powergates = tegra124_powergates,
> +	.num_cpu_powergates = ARRAY_SIZE(tegra124_cpu_powergates),
> +	.cpu_powergates = tegra124_cpu_powergates,
> +	.has_tsense_reset = true,
> +};
> +
> +static const struct of_device_id tegra_pmc_match[] = {
> +	{ .compatible = "nvidia,tegra124-pmc", .data = &tegra124_pmc_soc },
> +	{ .compatible = "nvidia,tegra114-pmc", .data = &tegra114_pmc_soc },
> +	{ .compatible = "nvidia,tegra30-pmc", .data = &tegra30_pmc_soc },
> +	{ .compatible = "nvidia,tegra20-pmc", .data = &tegra20_pmc_soc },
> +	{ }
> +};

Is there a need for moving this huge block of declarations? AFAICT you 
are only using tegra_pmc_match in your function, maybe you can just do a 
forward declaration so does not get longer and more complex than it 
needs to be?

This detail aside, patch looks ok to me.
