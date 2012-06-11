From: jon-hunter@ti.com (Jon Hunter)
Date: Mon, 11 Jun 2012 14:56:29 -0500
Subject: [PATCH v5 02/14] ARM: OMAP2+: gpmc: Adapt to HWMOD
In-Reply-To: <fb739c3c5383806f78cee3666f7c74d61bed6427.1339419492.git.afzal@ti.com>
References: <cover.1339419492.git.afzal@ti.com>
 <fb739c3c5383806f78cee3666f7c74d61bed6427.1339419492.git.afzal@ti.com>
Message-ID: <4FD64D6D.3020401@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Afzal,

On 06/11/2012 09:26 AM, Afzal Mohammed wrote:
> Create API for platforms to adapt gpmc to HWMOD
> 
> Signed-off-by: Afzal Mohammed <afzal@ti.com>
> ---
>  arch/arm/mach-omap2/gpmc.c             |   31 +++++++++++++++++++++++++++++++
>  arch/arm/plat-omap/include/plat/gpmc.h |    2 ++
>  2 files changed, 33 insertions(+)
> 
> diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
> index 517953f..b471c2f 100644
> --- a/arch/arm/mach-omap2/gpmc.c
> +++ b/arch/arm/mach-omap2/gpmc.c
> @@ -27,6 +27,7 @@
>  
>  #include <asm/mach-types.h>
>  #include <plat/gpmc.h>
> +#include <plat/omap_device.h>
>  
>  #include <plat/sdrc.h>
>  
> @@ -898,6 +899,36 @@ static int __init gpmc_init(void)
>  }
>  postcore_initcall(gpmc_init);
>  
> +__init int omap_gpmc_init(struct gpmc_pdata *pdata)
> +{
> +	struct omap_hwmod *oh;
> +	struct platform_device *pdev;
> +	char *name = "omap-gpmc";
> +	char *oh_name = "gpmc";
> +
> +	oh = omap_hwmod_lookup(oh_name);
> +	if (!oh) {
> +		pr_err("Could not look up %s\n", oh_name);
> +		return -ENODEV;
> +	}
> +
> +	pdev = omap_device_build(name, -1, oh, pdata,
> +					sizeof(*pdata), NULL, 0, 0);
> +	if (IS_ERR(pdev)) {
> +		WARN(1, "Can't build omap_device for %s:%s.\n",
> +						name, oh->name);
> +		return PTR_ERR(pdev);
> +	}
> +
> +	gpmc_l3_clk = clk_get(NULL, oh->main_clk);
> +	if (IS_ERR(gpmc_l3_clk)) {
> +		pr_err("Could not get GPMC clock\n");
> +		return PTR_ERR(gpmc_l3_clk);
> +	}

My preference would be to store gpmc_l3_clk in the pdata and pass to
probe via the pdata. The aim would be to remove the global gpmc_l3_clk
altogether.

Also we should attempt to get the clk before calling omap_device_build
which is registering the driver.

Cheers
Jon
