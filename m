From: jonathanh@nvidia.com (Jon Hunter)
Date: Wed, 11 Apr 2018 10:07:47 +0100
Subject: [PATCH v2 4/5] soc/tegra: pmc: Use of_clk_get_parent_count()
 instead of open coding
In-Reply-To: <1523364701-15383-5-git-send-email-geert+renesas@glider.be>
References: <1523364701-15383-1-git-send-email-geert+renesas@glider.be>
 <1523364701-15383-5-git-send-email-geert+renesas@glider.be>
Message-ID: <a96706de-f680-7ef2-53fd-d2cf07b6061b@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 10/04/18 13:51, Geert Uytterhoeven wrote:
> As of_clk_get_parent_count() returns zero on failure, while
> of_count_phandle_with_args() might return a negative error code, this
> also fixes the issue of possibly using a very big number in the
> allocation below.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> This depends on "[PATCH v2 1/5] clk: Extract OF clock helpers in
> <linux/of_clk.h>".
> 
> v2:
>   - of_clk_get_parent_count() was moved to <linux/of_clk.h>.
> ---
>  drivers/soc/tegra/pmc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
> index d9fcdb592b3966a5..d8cb48a4b8eb1b78 100644
> --- a/drivers/soc/tegra/pmc.c
> +++ b/drivers/soc/tegra/pmc.c
> @@ -31,6 +31,7 @@
>  #include <linux/iopoll.h>
>  #include <linux/of.h>
>  #include <linux/of_address.h>
> +#include <linux/of_clk.h>
>  #include <linux/of_platform.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_domain.h>
> @@ -725,7 +726,7 @@ static int tegra_powergate_of_get_clks(struct tegra_powergate *pg,
>  	unsigned int i, count;
>  	int err;
>  
> -	count = of_count_phandle_with_args(np, "clocks", "#clock-cells");
> +	count = of_clk_get_parent_count(np);
>  	if (count == 0)
>  		return -ENODEV;
>  
> 

Acked-by: Jon Hunter <jonathanh@nvidia.com>

Cheers
Jon
