From: hvaibhav@ti.com (Hiremath, Vaibhav)
Date: Fri, 12 Mar 2010 10:18:40 +0530
Subject: [PATCH 17/19] omap: Add DSI regulator supply to OMAP3EVM board
	file
In-Reply-To: <20100311234847.4500.24584.stgit@baageli.muru.com>
References: <20100311234404.4500.82861.stgit@baageli.muru.com>
	<20100311234847.4500.24584.stgit@baageli.muru.com>
Message-ID: <19F8576C6E063C45BE387C64729E7394044DD32D7B@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Tony Lindgren [mailto:tony at atomide.com]
> Sent: Friday, March 12, 2010 5:19 AM
> To: linux-arm-kernel at lists.infradead.org
> Cc: Tomi Valkeinen; linux-omap at vger.kernel.org; Hiremath, Vaibhav
> Subject: [PATCH 17/19] omap: Add DSI regulator supply to OMAP3EVM board file
> 
> From: Vaibhav Hiremath <hvaibhav@ti.com>
> 
> With recent changes happened in OMAP2/3 DSS library for regulator interface,
> it
> is required to define DSI regulator supply, without this DSS (in turn Fbdev)
> fails to get regulator.
> 
> Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> Acked-by: Tomi Valkeinen <tomi.valkeinen@nokia.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  arch/arm/mach-omap2/board-omap3evm.c |   16 +++++++++++-----
>  1 files changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-
> omap2/board-omap3evm.c
> index 017bb2f..a05de10 100644
> --- a/arch/arm/mach-omap2/board-omap3evm.c
> +++ b/arch/arm/mach-omap2/board-omap3evm.c
> @@ -514,9 +514,15 @@ static struct regulator_init_data omap3_evm_vdac = {
>  };
> 
>  /* VPLL2 for digital video outputs */
> -static struct regulator_consumer_supply omap3_evm_vpll2_supply = {
> -	.supply		= "vdvi",
> -	.dev		= &omap3_evm_lcd_device.dev,
> +static struct regulator_consumer_supply omap3_evm_vpll2_supplies[] = {
> +	{
> +		.supply		= "vdvi",
> +		.dev		= &omap3_evm_lcd_device.dev,
> +	},
> +	{
> +		.supply		= "vdds_dsi",
> +		.dev		= &omap3_evm_dss_device.dev,
> +	},
>  };
> 
>  static struct regulator_init_data omap3_evm_vpll2 = {
> @@ -530,8 +536,8 @@ static struct regulator_init_data omap3_evm_vpll2 = {
>  		.valid_ops_mask		= REGULATOR_CHANGE_MODE
>  					| REGULATOR_CHANGE_STATUS,
>  	},
> -	.num_consumer_supplies	= 1,
> -	.consumer_supplies	= &omap3_evm_vpll2_supply,
> +	.num_consumer_supplies	= ARRAY_SIZE(omap3_evm_vpll2_supplies),
> +	.consumer_supplies	= omap3_evm_vpll2_supplies,
>  };
> 
>  static struct twl4030_platform_data omap3evm_twldata = {
[Hiremath, Vaibhav] Tony,
Please use the patch below, I have fixed Mark's comments to use devname instead of dev.

diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index ea1014b..f5c815a 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -514,10 +514,8 @@ static struct regulator_init_data omap3_evm_vdac = {
 };

 /* VPLL2 for digital video outputs */
-static struct regulator_consumer_supply omap3_evm_vpll2_supply = {
-       .supply         = "vdds_dsi",
-       .dev            = &omap3_evm_dss_device.dev,
-};
+static struct regulator_consumer_supply omap3_evm_vpll2_supply =
+       REGULATOR_SUPPLY("vdds_dsi", "omapdss");

 static struct regulator_init_data omap3_evm_vpll2 = {
        .constraints = {


[Hiremath, Vaibhav] Since you have already merged the patch , I have created patch on top of linux-omap/master below.



diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index a05de10..f5c815a 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -514,16 +514,8 @@ static struct regulator_init_data omap3_evm_vdac = {
 };

 /* VPLL2 for digital video outputs */
-static struct regulator_consumer_supply omap3_evm_vpll2_supplies[] = {
-       {
-               .supply         = "vdvi",
-               .dev            = &omap3_evm_lcd_device.dev,
-       },
-       {
-               .supply         = "vdds_dsi",
-               .dev            = &omap3_evm_dss_device.dev,
-       },
-};
+static struct regulator_consumer_supply omap3_evm_vpll2_supply =
+       REGULATOR_SUPPLY("vdds_dsi", "omapdss");

 static struct regulator_init_data omap3_evm_vpll2 = {
        .constraints = {
@@ -536,8 +528,8 @@ static struct regulator_init_data omap3_evm_vpll2 = {
                .valid_ops_mask         = REGULATOR_CHANGE_MODE
                                        | REGULATOR_CHANGE_STATUS,
        },
-       .num_consumer_supplies  = ARRAY_SIZE(omap3_evm_vpll2_supplies),
-       .consumer_supplies      = omap3_evm_vpll2_supplies,
+       .num_consumer_supplies  = 1,
+       .consumer_supplies      = &omap3_evm_vpll2_supply,
 };

 static struct twl4030_platform_data omap3evm_twldata = {
diff --git a/drivers/mtd/maps/omap_nor.c b/drivers/mtd/maps/omap_nor.c
deleted file mode 100644
index e69de29..0000000

Thanks,
Vaibhav
