From: heinold@inf.fu-berlin.de (Henning Heinold)
Date: Fri, 23 Dec 2011 11:47:51 +0100
Subject: [PATCH 4/9] arm/tegra: fuse: add functions to access chip revision
In-Reply-To: <1324599468-12845-5-git-send-email-olof@lixom.net>
References: <1324599468-12845-1-git-send-email-olof@lixom.net>
 <1324599468-12845-5-git-send-email-olof@lixom.net>
Message-ID: <20111223104751.GA22157@rhein.zuhause.netz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 22, 2011 at 04:17:43PM -0800, Olof Johansson wrote:
> Add function to get chip revision, and print it out at boot time.
> 
> Restructure the fuse access to just use cached variables instead
> of always reading the fuses, and export those variables directly
> instead of using accessor functions.
> 
> Add a SKU ID table of currently known values.
> 
> Based on code originally by Colin Cross <ccross@android.com>.
> 
> Signed-off-by: Olof Johansson <olof@lixom.net>
> ---
>  arch/arm/mach-tegra/fuse.c          |   80 +++++++++++++++++++++++------------
>  arch/arm/mach-tegra/fuse.h          |   31 +++++++++++--
>  arch/arm/mach-tegra/tegra2_clocks.c |    2 +-
>  3 files changed, 80 insertions(+), 33 deletions(-)
> 
> diff --git a/arch/arm/mach-tegra/fuse.c b/arch/arm/mach-tegra/fuse.c
> index daf3f57..2ddede9 100644
> --- a/arch/arm/mach-tegra/fuse.c
> +++ b/arch/arm/mach-tegra/fuse.c
> @@ -30,20 +30,70 @@
>  #define FUSE_SKU_INFO		0x110
>  #define FUSE_SPARE_BIT		0x200
>  
> +int tegra_sku_id;
> +int tegra_cpu_process_id;
> +int tegra_core_process_id;
> +enum tegra_revision tegra_revision;
> +
> +static const char *tegra_revision_name[TEGRA_REVISION_MAX] = {
> +	[TEGRA_REVISION_UNKNOWN] = "unknown",
> +	[TEGRA_REVISION_A02]     = "A02",
> +	[TEGRA_REVISION_A03]     = "A03",
> +	[TEGRA_REVISION_A03p]    = "A03 prime",
> +	[TEGRA_REVISION_A04]     = "A04",
> +};
> +

Hi Olof,

can you please add here [TEGRA_REVISION_A01] = "A01", too. It is used in the nvidia git tree and affects the new beta xorg
driver.

Bye Henning
