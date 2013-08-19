From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 19 Aug 2013 22:41:38 +0800
Subject: [PATCH 2/3] dma: imx-sdma: Add ROM script addresses to driver
In-Reply-To: <1376914563-10912-3-git-send-email-s.hauer@pengutronix.de>
References: <1376914563-10912-1-git-send-email-s.hauer@pengutronix.de>
 <1376914563-10912-3-git-send-email-s.hauer@pengutronix.de>
Message-ID: <20130819144136.GC28297@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Copy devicetree mailing list.

On Mon, Aug 19, 2013 at 02:16:02PM +0200, Sascha Hauer wrote:
> This adds the ROM script addresses to the SDMA driver needed for the
> driver to work without additional firmware.
> 
> The ROM script addresses are SoC specific and in some cases even tapeout
> specific. This makes it necessary to introduce SoC specific and tapeout
> specific bindings for the driver. While extending the binding also make
> the <chip_type> explicit in the binding documentation.
> 
> The non tapeout specific variants of the i.MX31/35 bindings are kept
> for compatibility.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  .../devicetree/bindings/dma/fsl-imx-sdma.txt       |   7 +-
>  drivers/dma/imx-sdma.c                             | 180 ++++++++++++++++++++-
>  2 files changed, 185 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt b/Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt
> index 68cee4f5..4fa814d 100644
> --- a/Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt
> +++ b/Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt
> @@ -1,7 +1,12 @@
>  * Freescale Smart Direct Memory Access (SDMA) Controller for i.MX
>  
>  Required properties:
> -- compatible : Should be "fsl,<chip>-sdma"
> +- compatible : Should be "fsl,imx31-sdma", "fsl,imx31-to1-sdma",
> +  "fsl,imx31-to2-sdma", "fsl,imx35-sdma", "fsl,imx35-to1-sdma",
> +  "fsl,imx35-to2-sdma", "fsl,imx51-sdma", "fsl,imx53-sdma" or
> +  "fsl,imx6q-sdma". The -to variants should be preferred since they
> +  allow to determnine the correct ROM script addresses needed for
> +  the driver to work without additional firmware.
>  - reg : Should contain SDMA registers location and length
>  - interrupts : Should contain SDMA interrupt
>  - #dma-cells : Must be <3>.
> diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
> index e3e7e3f..42142b7 100644
> --- a/drivers/dma/imx-sdma.c
> +++ b/drivers/dma/imx-sdma.c
> @@ -310,6 +310,7 @@ struct sdma_firmware_header {
>  struct sdma_driver_data {
>  	int chnenbl0;
>  	int num_events;
> +	struct sdma_script_start_addrs	*script_addrs;
>  };
>  
>  struct sdma_engine {
> @@ -328,23 +329,191 @@ struct sdma_engine {
>  	const struct sdma_driver_data	*drvdata;
>  };
>  
> +static struct sdma_script_start_addrs sdma_script_imx31_to1 = {
> +	.per_2_per_addr = 1677,
> +};
> +
> +static struct sdma_script_start_addrs sdma_script_imx31_to2 = {
> +	.ap_2_ap_addr = 423,
> +	.ap_2_bp_addr = 829,
> +	.bp_2_ap_addr = 1029,
> +};
> +
>  struct sdma_driver_data sdma_imx31 = {
>  	.chnenbl0 = SDMA_CHNENBL0_IMX31,
>  	.num_events = 32,
>  };
>  
> +struct sdma_driver_data sdma_imx31_to1 = {
> +	.chnenbl0 = SDMA_CHNENBL0_IMX31,
> +	.num_events = 32,
> +	.script_addrs = &sdma_script_imx31_to1,
> +};
> +
> +struct sdma_driver_data sdma_imx31_to2 = {
> +	.chnenbl0 = SDMA_CHNENBL0_IMX31,
> +	.num_events = 32,
> +	.script_addrs = &sdma_script_imx31_to2,
> +};
> +
> +static struct sdma_script_start_addrs sdma_script_imx25 = {
> +	.ap_2_ap_addr = 729,
> +	.uart_2_mcu_addr = 904,
> +	.per_2_app_addr = 1255,
> +	.mcu_2_app_addr = 834,
> +	.uartsh_2_mcu_addr = 1120,
> +	.per_2_shp_addr = 1329,
> +	.mcu_2_shp_addr = 1048,
> +	.ata_2_mcu_addr = 1560,
> +	.mcu_2_ata_addr = 1479,
> +	.app_2_per_addr = 1189,
> +	.app_2_mcu_addr = 770,
> +	.shp_2_per_addr = 1407,
> +	.shp_2_mcu_addr = 979,
> +};
> +
> +struct sdma_driver_data sdma_imx25 = {
> +	.chnenbl0 = SDMA_CHNENBL0_IMX35,
> +	.num_events = 48,
> +	.script_addrs = &sdma_script_imx25,
> +};
> +
> +static struct sdma_script_start_addrs sdma_script_imx35_to1 = {
> +	.ap_2_ap_addr = 642,
> +	.uart_2_mcu_addr = 817,
> +	.mcu_2_app_addr = 747,
> +	.uartsh_2_mcu_addr = 1183,
> +	.per_2_shp_addr = 1033,
> +	.mcu_2_shp_addr = 961,
> +	.ata_2_mcu_addr = 1333,
> +	.mcu_2_ata_addr = 1252,
> +	.app_2_mcu_addr = 683,
> +	.shp_2_per_addr = 1111,
> +	.shp_2_mcu_addr = 892,
> +};
> +
> +static struct sdma_script_start_addrs sdma_script_imx35_to2 = {
> +	.ap_2_ap_addr = 729,
> +	.uart_2_mcu_addr = 904,
> +	.per_2_app_addr = 1597,
> +	.mcu_2_app_addr = 834,
> +	.uartsh_2_mcu_addr = 1270,
> +	.per_2_shp_addr = 1120,
> +	.mcu_2_shp_addr = 1048,
> +	.ata_2_mcu_addr = 1429,
> +	.mcu_2_ata_addr = 1339,
> +	.app_2_per_addr = 1531,
> +	.app_2_mcu_addr = 770,
> +	.shp_2_per_addr = 1198,
> +	.shp_2_mcu_addr = 979,
> +};
> +
>  struct sdma_driver_data sdma_imx35 = {
>  	.chnenbl0 = SDMA_CHNENBL0_IMX35,
>  	.num_events = 48,
>  };
>  
> +struct sdma_driver_data sdma_imx35_to1 = {
> +	.chnenbl0 = SDMA_CHNENBL0_IMX35,
> +	.num_events = 48,
> +	.script_addrs = &sdma_script_imx35_to1,
> +};
> +
> +struct sdma_driver_data sdma_imx35_to2 = {
> +	.chnenbl0 = SDMA_CHNENBL0_IMX35,
> +	.num_events = 48,
> +	.script_addrs = &sdma_script_imx35_to2,
> +};
> +
> +static struct sdma_script_start_addrs sdma_script_imx51 = {
> +	.ap_2_ap_addr = 642,
> +	.uart_2_mcu_addr = 817,
> +	.mcu_2_app_addr = 747,
> +	.mcu_2_shp_addr = 961,
> +	.ata_2_mcu_addr = 1473,
> +	.mcu_2_ata_addr = 1392,
> +	.app_2_per_addr = 1033,
> +	.app_2_mcu_addr = 683,
> +	.shp_2_per_addr = 1251,
> +	.shp_2_mcu_addr = 892,
> +};
> +
> +struct sdma_driver_data sdma_imx51 = {
> +	.chnenbl0 = SDMA_CHNENBL0_IMX35,
> +	.num_events = 48,
> +	.script_addrs = &sdma_script_imx51,
> +};
> +
> +static struct sdma_script_start_addrs sdma_script_imx53 = {
> +	.ap_2_ap_addr = 642,
> +	.app_2_mcu_addr = 683,
> +	.mcu_2_app_addr = 747,
> +	.uart_2_mcu_addr = 817,
> +	.shp_2_mcu_addr = 891,
> +	.mcu_2_shp_addr = 960,
> +	.uartsh_2_mcu_addr = 1032,
> +	.spdif_2_mcu_addr = 1100,
> +	.mcu_2_spdif_addr = 1134,
> +	.firi_2_mcu_addr = 1193,
> +	.mcu_2_firi_addr = 1290,
> +};
> +
> +struct sdma_driver_data sdma_imx53 = {
> +	.chnenbl0 = SDMA_CHNENBL0_IMX35,
> +	.num_events = 48,
> +	.script_addrs = &sdma_script_imx53,
> +};
> +
> +static struct sdma_script_start_addrs sdma_script_imx6q = {
> +	.ap_2_ap_addr = 642,
> +	.uart_2_mcu_addr = 817,
> +	.mcu_2_app_addr = 747,
> +	.per_2_per_addr = 6331,
> +	.uartsh_2_mcu_addr = 1032,
> +	.mcu_2_shp_addr = 960,
> +	.app_2_mcu_addr = 683,
> +	.shp_2_mcu_addr = 891,
> +	.spdif_2_mcu_addr = 1100,
> +	.mcu_2_spdif_addr = 1134,
> +};
> +
> +struct sdma_driver_data sdma_imx6q = {
> +	.chnenbl0 = SDMA_CHNENBL0_IMX35,
> +	.num_events = 48,
> +	.script_addrs = &sdma_script_imx6q,
> +};
> +
>  static struct platform_device_id sdma_devtypes[] = {
>  	{
> +		.name = "imx25-sdma",
> +		.driver_data = (unsigned long)&sdma_imx25,
> +	}, {
>  		.name = "imx31-sdma",
>  		.driver_data = (unsigned long)&sdma_imx31,
> +	},  {
> +		.name = "imx31-to1-sdma",
> +		.driver_data = (unsigned long)&sdma_imx31_to1,
> +	},  {
> +		.name = "imx31-to2-sdma",
> +		.driver_data = (unsigned long)&sdma_imx31_to2,
>  	}, {
>  		.name = "imx35-sdma",
>  		.driver_data = (unsigned long)&sdma_imx35,
> +	},  {
> +		.name = "imx35-to1-sdma",
> +		.driver_data = (unsigned long)&sdma_imx35_to1,
> +	},  {
> +		.name = "imx35-to2-sdma",
> +		.driver_data = (unsigned long)&sdma_imx35_to2,
> +	}, {
> +		.name = "imx51-sdma",
> +		.driver_data = (unsigned long)&sdma_imx51,
> +	}, {
> +		.name = "imx53-sdma",
> +		.driver_data = (unsigned long)&sdma_imx53,
> +	}, {
> +		.name = "imx6q-sdma",
> +		.driver_data = (unsigned long)&sdma_imx6q,
>  	}, {
>  		/* sentinel */
>  	}
> @@ -352,8 +521,15 @@ static struct platform_device_id sdma_devtypes[] = {
>  MODULE_DEVICE_TABLE(platform, sdma_devtypes);
>  
>  static const struct of_device_id sdma_dt_ids[] = {
> -	{ .compatible = "fsl,imx31-sdma", .data = &sdma_imx31, },
> +	{ .compatible = "fsl,imx6q-sdma", .data = &sdma_imx6q, },
> +	{ .compatible = "fsl,imx53-sdma", .data = &sdma_imx53, },
> +	{ .compatible = "fsl,imx51-sdma", .data = &sdma_imx51, },
> +	{ .compatible = "fsl,imx35-to2-sdma", .data = &sdma_imx35_to2, },
> +	{ .compatible = "fsl,imx35-to1-sdma", .data = &sdma_imx35_to1, },
>  	{ .compatible = "fsl,imx35-sdma", .data = &sdma_imx35, },

Do we need to bind the compatible with sdma_imx35_to2 like below?

  	{ .compatible = "fsl,imx35-sdma", .data = &sdma_imx35_to2, },

Otherwise, we will need to patch sdma_imx35 with proper .script_addrs
assignment?

Also, I do not know how we will play these tapeout specific compatible
in device tree.  As you know, we currently do not have tapeout but only
chip specific DTS, since we expect kernel will figure out the
tapeout/revision and handle the differences accordingly.

Shawn

> +	{ .compatible = "fsl,imx31-to2-sdma", .data = &sdma_imx31_to2, },
> +	{ .compatible = "fsl,imx31-to1-sdma", .data = &sdma_imx31_to1, },
> +	{ .compatible = "fsl,imx31-sdma", .data = &sdma_imx31, },
>  	{ /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(of, sdma_dt_ids);
> @@ -1434,6 +1610,8 @@ static int __init sdma_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto err_init;
>  
> +	if (sdma->drvdata->script_addrs)
> +		sdma_add_scripts(sdma, sdma->drvdata->script_addrs);
>  	if (pdata && pdata->script_addrs)
>  		sdma_add_scripts(sdma, pdata->script_addrs);
>  
> -- 
> 1.8.4.rc3
> 
