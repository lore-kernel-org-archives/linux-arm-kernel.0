From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 24 Oct 2012 11:54:54 -0600
Subject: [PATCHv2] ARM: Push selects for TWD/SCU into machine entries
In-Reply-To: <1351099475-29349-1-git-send-email-sboyd@codeaurora.org>
References: <1351099475-29349-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <50882B6E.5020103@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/24/2012 11:24 AM, Stephen Boyd wrote:
> The TWD and SCU configs are selected by default as long as
> MSM_SCORPIONMP is false and/or MCT is false. Implementing the
> logic this way certainly saves lines in the Kconfig but it
> precludes those machines which select MSM_SCORPIONMP or MCT from
> participating in the single zImage effort because when those
> machines are combined with other SMP capable machines the TWD and
> SCU are no longer selected by default.
> 
> Push the select out to the machine entries so that we can compile
> these machines together and still select the appropriate configs.

Acked-by: Stephen Warren <swarren@nvidia.com>

> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig

> @@ -633,6 +633,8 @@ config ARCH_TEGRA
>  	select GENERIC_GPIO
>  	select HAVE_CLK
>  	select HAVE_SMP
> +	select HAVE_ARM_SCU if SMP
> +	select HAVE_ARM_TWD if LOCAL_TIMERS
>  	select MIGHT_HAVE_CACHE_L2X0
>  	select SPARSE_IRQ
>  	select USE_OF

Where will this patch be merged?

It probably won't happen for 3.8, but that config fragment will move to
arch/arm/mach-tegra/Kconfig when Tegra enables single zImage support, I
believe. So, it'd be good to make sure this patch gets merged somewhere
that could be used as a baseline for other arm-soc branches if needed,
to avoid merge conflicts.
