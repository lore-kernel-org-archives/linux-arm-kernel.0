From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 29 Jul 2013 17:53:35 -0600
Subject: [PATCH 7/8] ARM: tegra114: add LP1 suspend support
In-Reply-To: <1374830110-30685-8-git-send-email-josephl@nvidia.com>
References: <1374830110-30685-1-git-send-email-josephl@nvidia.com>
 <1374830110-30685-8-git-send-email-josephl@nvidia.com>
Message-ID: <51F7007F.6090200@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/26/2013 03:15 AM, Joseph Lo wrote:
> The LP1 suspend mode will power off the CPU, clock gated the PLLs and put
> SDRAM to self-refresh mode. Any interrupt can wake up device from LP1. The
> sequence when LP1 suspending:

> diff --git a/arch/arm/mach-tegra/pm.c b/arch/arm/mach-tegra/pm.c
> index 5ae7ee5..36cadaa 100644
> --- a/arch/arm/mach-tegra/pm.c
> +++ b/arch/arm/mach-tegra/pm.c
> @@ -214,6 +214,7 @@ static bool tegra_lp1_iram_hook(void)
>  		tegra20_lp1_iram_hook();
>  		break;
>  	case TEGRA30:
> +	case TEGRA114:
>  		tegra30_lp1_iram_hook();

That's in pm-tegra30.c, which is only compiled in if
CONFIG_ARCH_TEGRA_3x_SOC is enabled. Similarly, this patch adds a lot of
code to sleep-tegra30.S, which also isn't built/linked if
!CONFIG_ARCH_TEGRA_3x_SOC.

Does this series built with all 7 combinations of Tegra20/30/114 support
enabled?

> diff --git a/arch/arm/mach-tegra/sleep-tegra30.S b/arch/arm/mach-tegra/sleep-tegra30.S

> @@ -96,9 +100,15 @@
>  	orreq	\rd, \rd, #(1 << 30)
>  	streq	\rd, [\r_car_base, #\pll_base]
>  	/* Enable lock detector */
> +	.if	\pll_misc
> +	ldr	\rd, [\r_car_base, #\pll_misc]
> +	bic	\rd, \rd, #(1 << 18)
> +	str	\rd, [\r_car_base, #\pll_misc]
> +	ldr	\rd, [\r_car_base, #\pll_misc]
>  	ldr	\rd, [\r_car_base, #\pll_misc]
>  	orr	\rd, \rd, #(1 << 18)
>  	str	\rd, [\r_car_base, #\pll_misc]
> +	.endif

Hmm. Those last 3 lines that aren't touched by this patch already
touched the pll_misc register even if !pll_misc. Was that a bug in a
previous patch?

Is git bisect maintained for both compile and run-time across this whole
patch series?
