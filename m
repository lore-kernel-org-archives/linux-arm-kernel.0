From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Fri, 22 Feb 2013 15:00:51 +0200
Subject: [PATCH 2/4] ARM: tegra: pmc: add power on function for
 secondary CPUs
In-Reply-To: <1361515491-16199-3-git-send-email-josephl@nvidia.com>
References: <1361515491-16199-1-git-send-email-josephl@nvidia.com>
 <1361515491-16199-3-git-send-email-josephl@nvidia.com>
Message-ID: <20130222130051.GV23234@tbergstrom-lnx.Nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 22, 2013 at 07:44:49AM +0100, Joseph Lo wrote:
> Adding the power on function for secondary CPUs in PMC driver, this can
> help us to remove legacy powergate driver and add generic power domain
> support later.
> 
> Signed-off-by: Joseph Lo <josephl@nvidia.com>
> ---
>  arch/arm/mach-tegra/pmc.c | 105 +++++++++++++++++++++++++++++++++++++++++++++-
>  arch/arm/mach-tegra/pmc.h |   4 ++
>  2 files changed, 107 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-tegra/pmc.c b/arch/arm/mach-tegra/pmc.c
> index 2315e25..a2446c2 100644
> --- a/arch/arm/mach-tegra/pmc.c
> +++ b/arch/arm/mach-tegra/pmc.c
> @@ -21,8 +21,26 @@
>  #include <linux/of.h>
>  #include <linux/of_address.h>
>  
> -#define PMC_CTRL		0x0
> -#define PMC_CTRL_INTR_LOW	(1 << 17)
> +#define PMC_CTRL			0x0
> +#define PMC_CTRL_INTR_LOW		(1 << 17)
> +#define PMC_PWRGATE_TOGGLE		0x30
> +#define PMC_PWRGATE_TOGGLE_START	(1 << 8)
> +#define PMC_REMOVE_CLAMPING		0x34
> +#define PMC_PWRGATE_STATUS		0x38
> +
> +#define TEGRA_POWERGATE_PCIE	3
> +#define TEGRA_POWERGATE_VDEC	4
> +#define TEGRA_POWERGATE_CPU1	9
> +#define TEGRA_POWERGATE_CPU2	10
> +#define TEGRA_POWERGATE_CPU3	11
> +
> +static u8 tegra_cpu_domains[] = {
> +	0xFF,			/* not available for CPU0 */

On Tegra114 we can also powergate CPU0, so this needs to be defined then.

Cheers,

Peter.
