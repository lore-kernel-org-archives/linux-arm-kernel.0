From: nsekhar@ti.com (Sekhar Nori)
Date: Thu, 7 Dec 2017 11:27:17 +0530
Subject: [PATCH v2 1/3] ARM: davinci: Use platform_device_register_full()
 to create pdev for dm365's eDMA
In-Reply-To: <20171205123458.97837-2-amery@hanoverdisplays.com>
References: <2298378f-37d0-0c04-dfe3-4503c58e5456@ti.com>
 <20171204133359.45625-1-amery@hanoverdisplays.com>
 <20171205123458.97837-1-amery@hanoverdisplays.com>
 <20171205123458.97837-2-amery@hanoverdisplays.com>
Message-ID: <3a6e1896-89de-9871-eac0-24b75097190a@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alejandro,

On Tuesday 05 December 2017 06:04 PM, Alejandro Mery wrote:
> as it was done by 7ab388e85faa97a35d520720269e7c8e00ad54a0 for other davinci SoCs
> 
> changes since v1:
> * fix typo
> 
> Signed-off-by: Alejandro Mery <amery@hanoverdisplays.com>

The patch itself looks good (and apologies for not catching the missing 
DM365 conversion). But:

The way you refer to the commit in patch description will lead to 
checkpatch error. And, we need more explanation in the patch description 
than just referencing the commit which is being fixed. When fixing a 
previous commit, its best to use the Fixes: tag (see below). Thats an 
indication for stable tree maintainers to backport this patch all the 
way till the time the offending commit was introduced into the kernel. 
This way you don't have to do the backporting yourself.

Please keep the changelog below the tearline "---" so it will not get 
included in commit description. And, when submitting another version, 
please carry forward the Reviewed-by: and and Acked-by: tags you 
received for previous version (unless the patch has changed so 
significantly that it does not make sense to do so anymore).

For this time, I fixed all of these up locally. Here is the final commit 
text.

--8<--
ARM: davinci: Use platform_device_register_full() to create pdev for dm365's eDMA

Convert the DM365 EDMA platform device creation to use
struct platform_device_info XXXXXX __initconst and
platform_device_register_full()

This will allow us to specify the dma_mask for the device
in an upcoming patch. Without this, EDMA on DM365 refuses
to probe.

Fixes: 7ab388e85faa ("ARM: davinci: Use platform_device_register_full() to create pdev for eDMA")
Reviewed-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Alejandro Mery <amery@hanoverdisplays.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
--8<--

Thanks,
Sekhar


> ---
>  arch/arm/mach-davinci/dm365.c | 20 +++++++++++++-------
>  1 file changed, 13 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm/mach-davinci/dm365.c b/arch/arm/mach-davinci/dm365.c
> index 8be04ec95adf..9bd17bc77b5c 100644
> --- a/arch/arm/mach-davinci/dm365.c
> +++ b/arch/arm/mach-davinci/dm365.c
> @@ -925,12 +925,13 @@ static struct resource edma_resources[] = {
>  	/* not using TC*_ERR */
>  };
>  
> -static struct platform_device dm365_edma_device = {
> -	.name			= "edma",
> -	.id			= 0,
> -	.dev.platform_data	= &dm365_edma_pdata,
> -	.num_resources		= ARRAY_SIZE(edma_resources),
> -	.resource		= edma_resources,
> +static const struct platform_device_info dm365_edma_device __initconst = {
> +	.name		= "edma",
> +	.id		= 0,
> +	.res		= edma_resources,
> +	.num_res	= ARRAY_SIZE(edma_resources),
> +	.data		= &dm365_edma_pdata,
> +	.size_data	= sizeof(dm365_edma_pdata),
>  };
>  
>  static struct resource dm365_asp_resources[] = {
> @@ -1428,13 +1429,18 @@ int __init dm365_init_video(struct vpfe_config *vpfe_cfg,
>  
>  static int __init dm365_init_devices(void)
>  {
> +	struct platform_device *edma_pdev;
>  	int ret = 0;
>  
>  	if (!cpu_is_davinci_dm365())
>  		return 0;
>  
>  	davinci_cfg_reg(DM365_INT_EDMA_CC);
> -	platform_device_register(&dm365_edma_device);
> +	edma_pdev = platform_device_register_full(&dm365_edma_device);
> +	if (IS_ERR(edma_pdev)) {
> +		pr_warn("%s: Failed to register eDMA\n", __func__);
> +		return PTR_ERR(edma_pdev);
> +	}
>  
>  	platform_device_register(&dm365_mdio_device);
>  	platform_device_register(&dm365_emac_device);
> -- 
> 2.15.0
> 
