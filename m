From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 13 Mar 2013 12:03:06 -0600
Subject: [PATCH V3 4/9] ARM: tegra: pm: add platform suspend support
In-Reply-To: <1363161683-20825-5-git-send-email-josephl@nvidia.com>
References: <1363161683-20825-1-git-send-email-josephl@nvidia.com>
 <1363161683-20825-5-git-send-email-josephl@nvidia.com>
Message-ID: <5140BF5A.3040108@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/13/2013 02:01 AM, Joseph Lo wrote:
> Adding suspend to RAM support for Tegra platform. There are three suspend
> mode for Tegra. The difference were below.
> 
> * LP2: CPU voltage off
> * LP1: CPU voltage off, DRAM in self-refresh
> * LP0: CPU + Core voltage off, DRAM in self-refresh
> 
> After this patch, the LP2 suspend mode will be supported.

> diff --git a/arch/arm/mach-tegra/pm.c b/arch/arm/mach-tegra/pm.c

> +void __init tegra_init_suspend(void)
...
> +	/* We only support LP2 suspend mode right now. */
> +	if (mode > TEGRA_SUSPEND_LP2)
> +		tegra_pmc_set_suspend_mode(TEGRA_SUSPEND_LP2);

I see that in patch 3/9, tegra_pmc_parse_dt() simply assigns directly to
pmc_pm_data.suspend_mode rather than calling a function. If it's useful
to call a function here, isn't doing so also useful in tegra_pmc_parse_dt()?

I guess you did this because pmc_pm_data is static so you can't just
assign it here.

Instead, I would suggest that tegra_pmc_parse_dt() does this validation
itself, either by:

a) Enhancing tegra_pmc_parse_dt() to know which modes are supported itself.

or:

b) Have tegra_pmc_parse_dt() call a function in pm.c to determine
whether the user-selected suspend mode is valid or not. Something like:

pmc_pm_data.suspend_mode = tegra_pm_validate_suspend_mode(suspend_mode);

That way, tegra_pm_validate_suspend_mode() can encapsulate all details
of which suspend modes are supported, any SoC-specific differences (e.g.
not Tegra114 in any mode, but any earlier chip in LP2 mode for example).

(a) is slightly simpler. (b) is probably more flexible. I guess I'd
prefer (b).
