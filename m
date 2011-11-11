From: jamie@jamieiles.com (Jamie Iles)
Date: Fri, 11 Nov 2011 11:45:21 +0000
Subject: [PATCH v4 04/10] arm/tegra: prepare early init for multiple
 tegra variants
In-Reply-To: <1321010541-31337-5-git-send-email-pdeschrijver@nvidia.com>
References: <1321010541-31337-1-git-send-email-pdeschrijver@nvidia.com>
 <1321010541-31337-5-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <20111111114521.GB5114@totoro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peter,

On Fri, Nov 11, 2011 at 01:22:10PM +0200, Peter De Schrijver wrote:
> This patch splits the early init code in a common and a tegra20 specific part.
> L2 cache initialization is generalized and discovers the cache associativity
> at runtime. Also use arm_pm_restart instead of arm_arch_reset and reset the
> the system using the PMC reset feature rather then the CAR system reset.
> 
> Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
> ---
>  arch/arm/mach-tegra/board-dt.c        |   21 ++++++++++++++
>  arch/arm/mach-tegra/board-harmony.c   |    2 +-
>  arch/arm/mach-tegra/board-paz00.c     |    2 +-
>  arch/arm/mach-tegra/board-seaboard.c  |    6 ++--
>  arch/arm/mach-tegra/board-trimslice.c |    2 +-
>  arch/arm/mach-tegra/board.h           |    6 ++--
>  arch/arm/mach-tegra/clock.c           |    5 ---
>  arch/arm/mach-tegra/common.c          |   47 ++++++++++++++++++++++----------
>  8 files changed, 62 insertions(+), 29 deletions(-)
> 
> diff --git a/arch/arm/mach-tegra/board-dt.c b/arch/arm/mach-tegra/board-dt.c
> index d368f8d..15ee974 100644
> --- a/arch/arm/mach-tegra/board-dt.c
> +++ b/arch/arm/mach-tegra/board-dt.c
> @@ -118,6 +118,27 @@ static void __init tegra_dt_init(void)
>  	of_platform_populate(NULL, tegra_dt_match_table, tegra20_auxdata_lookup, NULL);
>  }
>  
> +static struct {
> +	const char *machine;
> +	void (*init)(void);
> +} early_init[] __initdata = {
> +#ifdef CONFIG_ARCH_TEGRA_2x_SOC
> +	{ "nvidia,tegra20", tegra20_init_early },
> +#endif
> +};
> +
> +static void __init tegra_init_early(void)
> +{
> +
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(early_init); i++)
> +		if (of_machine_is_compatible(early_init[i].machine))
> +			return early_init[i].init();
> +
> +	pr_warn("Unknown platform detected\n");
> +}

Wouldn't it be better just to have separate machine descs for tegra20 
and tegra30 and have a different .init_early for each?  I'm not sure 
that this extra indirection buys us much, especially if we had to repeat 
it for any of the other entries.

Jamie
