From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 29 Jul 2013 16:47:37 -0600
Subject: [PATCH 2/8] ARM: tegra: config the polarity of the request of
 sys clock
In-Reply-To: <1374830110-30685-3-git-send-email-josephl@nvidia.com>
References: <1374830110-30685-1-git-send-email-josephl@nvidia.com>
 <1374830110-30685-3-git-send-email-josephl@nvidia.com>
Message-ID: <51F6F109.8010102@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/26/2013 03:15 AM, Joseph Lo wrote:
> When suspending to LP1 mode, the SYSCLK will be clock gated. And different
> board may have different polarity of the request of SYSCLK, this patch
> configure the polarity from the DT for the board.

> diff --git a/arch/arm/mach-tegra/pmc.c b/arch/arm/mach-tegra/pmc.c

> @@ -238,6 +240,20 @@ void tegra_pmc_suspend_init(void)
>  	reg = tegra_pmc_readl(PMC_CTRL);
>  	reg |= TEGRA_POWER_CPU_PWRREQ_OE;
>  	tegra_pmc_writel(reg, PMC_CTRL);
> +
> +	reg = tegra_pmc_readl(PMC_CTRL);
> +
> +	if (!pmc_pm_data.sysclkreq_high)
> +		reg |= TEGRA_POWER_SYSCLK_POLARITY;
> +	else
> +		reg &= ~TEGRA_POWER_SYSCLK_POLARITY;
> +
> +	/* configure the output inverts while the request is tristated */
> +	tegra_pmc_writel(reg, PMC_CTRL);

I think s/inverts/polarity/ in that comment would make a lot more sense.

Must _OE be disabled for the code to work correctly? If so, should the
code explicitly clear _OE first, since who knows what state it was
originally in? Can't we just set the new polarity and enable _OE in a
single register write?

> +	/* now enable the request */
> +	reg |= TEGRA_POWER_SYSCLK_OE;
> +	tegra_pmc_writel(reg, PMC_CTRL);
