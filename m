From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 03 Jun 2013 14:31:26 -0600
Subject: [PATCH 2/4] ARM: tegra: hook tegra_tear_down_cpu function in
 the PM suspend init function
In-Reply-To: <1370258267-30184-3-git-send-email-josephl@nvidia.com>
References: <1370258267-30184-1-git-send-email-josephl@nvidia.com>
 <1370258267-30184-3-git-send-email-josephl@nvidia.com>
Message-ID: <51ACFD1E.4070102@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/03/2013 05:17 AM, Joseph Lo wrote:
> The tegra_tear_down_cpu was used to cut off the CPU rail for various Tegra
> SoCs. Hooking it in the PM suspend init function and making the CPUidle
> driver more generic.

> diff --git a/arch/arm/mach-tegra/pm.c b/arch/arm/mach-tegra/pm.c

> +static void tegra_tear_down_cpu_init(void)
> +{
> +	if (IS_ENABLED(CONFIG_ARCH_TEGRA_2x_SOC) && tegra_chip_id == TEGRA20)
> +		tegra_tear_down_cpu = tegra20_tear_down_cpu;
> +	if (IS_ENABLED(CONFIG_ARCH_TEGRA_3x_SOC) && tegra_chip_id == TEGRA30)
> +		tegra_tear_down_cpu = tegra30_tear_down_cpu;
> +}

I think you should use a switch statement there instead:

switch (tegra_chip_id) {
case TEGRA20:
	if (IS_ENABLED(CONFIG_ARCH_TEGRA_2x_SOC))
		tegra_tear_down_cpu = tegra20_tear_down_cpu;
	break;
...

Similar for patch 3/4. This makes it a lot more obvious that it's
selecting an option based on the runtime SoC, rather than just a bunch
of if conditions that each may or may-not be doing similar things.
