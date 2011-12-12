From: olof@lixom.net (Olof Johansson)
Date: Sun, 11 Dec 2011 16:17:03 -0800
Subject: [PATCH v6 04/10] arm/tegra: prepare early init for multiple
 tegra variants
In-Reply-To: <1323348254-29072-5-git-send-email-pdeschrijver@nvidia.com>
References: <1323348254-29072-1-git-send-email-pdeschrijver@nvidia.com>
 <1323348254-29072-5-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <20111212001703.GA26598@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 08, 2011 at 02:43:47PM +0200, Peter De Schrijver wrote:
> This patch splits the early init code in a common and a tegra20 specific part.
> L2 cache initialization is generalized and discovers the cache associativity
> at runtime. Also use arm_pm_restart instead of arm_arch_reset and reset the
> the system using the PMC reset feature rather then the CAR system reset.
> 
> Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
> ---
>  arch/arm/mach-tegra/board-dt.c        |   10 +++++---
>  arch/arm/mach-tegra/board-harmony.c   |    2 +-
>  arch/arm/mach-tegra/board-paz00.c     |    2 +-
>  arch/arm/mach-tegra/board-seaboard.c  |    6 ++--
>  arch/arm/mach-tegra/board-trimslice.c |    2 +-
>  arch/arm/mach-tegra/board.h           |    2 +-
>  arch/arm/mach-tegra/clock.c           |    5 ----
>  arch/arm/mach-tegra/common.c          |   34 ++++++++++++++++++++------------
>  8 files changed, 34 insertions(+), 29 deletions(-)
> 
> diff --git a/arch/arm/mach-tegra/board-dt.c b/arch/arm/mach-tegra/board-dt.c
> index 6a460a2..ef9843c 100644
> --- a/arch/arm/mach-tegra/board-dt.c
> +++ b/arch/arm/mach-tegra/board-dt.c
> @@ -133,7 +133,8 @@ static void __init tegra_dt_init(void)
>  		"Unknown platform! Pinmuxing not initialized\n");
>  }
>  
> -static const char * tegra_dt_board_compat[] = {
> +#ifdef CONFIG_ARCH_TEGRA_2x_SOC
> +static const char *tegra20_dt_board_compat[] = {
>  	"compulab,trimslice",
>  	"nvidia,harmony",
>  	"compal,paz00",
> @@ -142,13 +143,14 @@ static const char * tegra_dt_board_compat[] = {
>  	NULL
>  };
>  
> -DT_MACHINE_START(TEGRA_DT, "nVidia Tegra (Flattened Device Tree)")
> +DT_MACHINE_START(TEGRA_DT, "nVidia Tegra20 (Flattened Device Tree)")
>  	.map_io		= tegra_map_common_io,
> -	.init_early	= tegra_init_early,
> +	.init_early	= tegra20_init_early,
>  	.init_irq	= tegra_dt_init_irq,
>  	.handle_irq	= gic_handle_irq,
>  	.timer		= &tegra_timer,
>  	.init_machine	= tegra_dt_init,
>  	.restart	= tegra_assert_system_reset,
> -	.dt_compat	= tegra_dt_board_compat,
> +	.dt_compat	= tegra20_dt_board_compat,
>  MACHINE_END
> +#endif

As previously mentioned by Stephen, please split up in separate
patches.

But also, I would prefer to see one board-dt for tegra20 and one for
tegra30 (board-dt-t20 and board-dt-t30, or whatnot). They wouldn't be
sharing much code anyway, I would rather see a limited amount of code
duplication than excessive ifdefs in one file.


-Olof
