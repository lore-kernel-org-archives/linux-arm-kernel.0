From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 22 Feb 2013 11:37:06 -0700
Subject: [PATCH 2/4] ARM: tegra: pmc: add power on function for secondary
 CPUs
In-Reply-To: <1361515491-16199-3-git-send-email-josephl@nvidia.com>
References: <1361515491-16199-1-git-send-email-josephl@nvidia.com>
 <1361515491-16199-3-git-send-email-josephl@nvidia.com>
Message-ID: <5127BAD2.8030904@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/21/2013 11:44 PM, Joseph Lo wrote:
> Adding the power on function for secondary CPUs in PMC driver, this can
> help us to remove legacy powergate driver and add generic power domain
> support later.

> diff --git a/arch/arm/mach-tegra/pmc.c b/arch/arm/mach-tegra/pmc.c

> +static u8 tegra_cpu_domains[] = {
> +	0xFF,			/* not available for CPU0 */
> +	TEGRA_POWERGATE_CPU1,
> +	TEGRA_POWERGATE_CPU2,
> +	TEGRA_POWERGATE_CPU3,
> +};

Per Peter's comment, you probably need SoC-specific arrays here, to
support CPU0 having a valid value or not.

> +static int tegra_pmc_get_cpu_powerdomain_id(int cpuid)
> +{
> +	if (cpuid <= 0 || cpuid > num_possible_cpus())

cpuid >= num_possible_cpus()?

> +static int tegra_pmc_powergate_set(int id, bool new_state)
> +{
> +	bool status;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&tegra_powergate_lock, flags);
> +
> +	status = tegra_pmc_readl(PMC_PWRGATE_STATUS) & (1 << id);

I would perform the read and the logical operations separately. Same for
the write below.

Don't you want to and with ~BIT(id) not BIT(id)?

> +static int tegra_pmc_powergate_remove_clamping(int id)
> +{
> +	u32 mask;
> +
> +	/*
> +	 * Tegra has a bug where PCIE and VDE clamping masks are
> +	 * swapped relatively to the partition ids.
> +	 */
> +	if (id ==  TEGRA_POWERGATE_VDEC)
> +		mask = (1 << TEGRA_POWERGATE_PCIE);
> +	else if	(id == TEGRA_POWERGATE_PCIE)
> +		mask = (1 << TEGRA_POWERGATE_VDEC);
> +	else
> +		mask = (1 << id);

Is this just true for this one register, but not others? If it's true
everywhere, why not just fix the TEGRA_POWERGATE_* definitions?

I asked this downstream, but you didn't answer.

> +bool tegra_pmc_cpu_is_powered(int cpuid)
> +{
> +	int id;
> +
> +	id = tegra_pmc_get_cpu_powerdomain_id(cpuid);
> +	if (IS_ERR_VALUE(id))
> +		return false;

As I pointed out downstream, that should be if (id < 0); IS_ERR_VALUE is
intended for use on error-pointers, not on integer error codes.
