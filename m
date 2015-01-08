From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 8 Jan 2015 22:34:35 +0000 (UTC)
Subject: [PATCH] soc/tegra: pmc: Add Tegra132 support
In-Reply-To: <1420701657-32543-1-git-send-email-thierry.reding@gmail.com>
References: <1420701657-32543-1-git-send-email-thierry.reding@gmail.com>
Message-ID: <alpine.DEB.2.02.1501082232280.28771@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 8 Jan 2015, Thierry Reding wrote:

> From: Thierry Reding <treding@nvidia.com>
> 
> Tegra132 uses the same GPU as Tegra124 and the same special-case is
> needed to remove clamps. However Tegra132 has a separate chip ID, so in
> order to avoid having to extend the list of chip IDs for the special
> case, add a feature flag to the SoC data.
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>

Reviewed-by: Paul Walmsley <pwalmsley@nvidia.com>

Nit: not sure I would call it a special-case; to me it's more of an 
evolutionary change due to the radically different GPU in T124 & T132.


- Paul

> ---
>  drivers/soc/tegra/pmc.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
> index 4bdc654bd747..0f096e76574a 100644
> --- a/drivers/soc/tegra/pmc.c
> +++ b/drivers/soc/tegra/pmc.c
> @@ -88,6 +88,8 @@ struct tegra_pmc_soc {
>  	const char *const *powergates;
>  	unsigned int num_cpu_powergates;
>  	const u8 *cpu_powergates;
> +
> +	bool has_gpu_clamps;
>  };
>  
>  /**
> @@ -225,11 +227,11 @@ int tegra_powergate_remove_clamping(int id)
>  		return -EINVAL;
>  
>  	/*
> -	 * The Tegra124 GPU has a separate register (with different semantics)
> -	 * to remove clamps.
> +	 * On Tegra124 and later, the clamps for the GPU are controlled by a
> +	 * separate register (with different semantics).
>  	 */
> -	if (tegra_get_chip_id() == TEGRA124) {
> -		if (id == TEGRA_POWERGATE_3D) {
> +	if (id == TEGRA_POWERGATE_3D) {
> +		if (pmc->soc->has_gpu_clamps) {
>  			tegra_pmc_writel(0, GPU_RG_CNTRL);
>  			return 0;
>  		}
> @@ -773,6 +775,7 @@ static const struct tegra_pmc_soc tegra20_pmc_soc = {
>  	.powergates = tegra20_powergates,
>  	.num_cpu_powergates = 0,
>  	.cpu_powergates = NULL,
> +	.has_gpu_clamps = false,
>  };
>  
>  static const char * const tegra30_powergates[] = {
> @@ -804,6 +807,7 @@ static const struct tegra_pmc_soc tegra30_pmc_soc = {
>  	.powergates = tegra30_powergates,
>  	.num_cpu_powergates = ARRAY_SIZE(tegra30_cpu_powergates),
>  	.cpu_powergates = tegra30_cpu_powergates,
> +	.has_gpu_clamps = false,
>  };
>  
>  static const char * const tegra114_powergates[] = {
> @@ -839,6 +843,7 @@ static const struct tegra_pmc_soc tegra114_pmc_soc = {
>  	.powergates = tegra114_powergates,
>  	.num_cpu_powergates = ARRAY_SIZE(tegra114_cpu_powergates),
>  	.cpu_powergates = tegra114_cpu_powergates,
> +	.has_gpu_clamps = false,
>  };
>  
>  static const char * const tegra124_powergates[] = {
> @@ -880,6 +885,7 @@ static const struct tegra_pmc_soc tegra124_pmc_soc = {
>  	.powergates = tegra124_powergates,
>  	.num_cpu_powergates = ARRAY_SIZE(tegra124_cpu_powergates),
>  	.cpu_powergates = tegra124_cpu_powergates,
> +	.has_gpu_clamps = true,
>  };
>  
>  static const struct of_device_id tegra_pmc_match[] = {
> -- 
> 2.1.3
> 


- Paul
