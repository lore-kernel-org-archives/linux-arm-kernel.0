From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 23 Jun 2011 09:45:35 +0200
Subject: [PATCH v2 6/6] dmaengine: imx-sdma: pass sdma firmware name via
	platform data
In-Reply-To: <1308753691-14442-7-git-send-email-shawn.guo@linaro.org>
References: <1308753691-14442-1-git-send-email-shawn.guo@linaro.org>
	<1308753691-14442-7-git-send-email-shawn.guo@linaro.org>
Message-ID: <20110623074534.GN6069@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Vinod,

Can I have your ack for this? It depends on the other patches in this
series and should go via the i.MX tree rather than the DMA tree.

Sascha

On Wed, Jun 22, 2011 at 10:41:31PM +0800, Shawn Guo wrote:
> It is not good to have cpu_name and to_version encoded into sdma
> firmware name as variables.  For example, there are three TOs of
> imx51 soc, the sdma script never changes since TO1, which means
> all three TOs of imx51 uses TO1 version of sdma script.  But we
> have to prepare three identical firmwares, sdma-imx51-to1.bin
> sdma-imx51-to2.bin and sdma-imx51-to3.bin, to have the kernel
> capable of running on all three TOs.
> 
> The patch removes cpu_name and to_version from sdma platform data,
> and instead uses fw_name to pass the firmware name, so that we can
> pass the TO version where it's relevant and skip it where only one
> firmware exists.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Vinod Koul <vinod.koul@intel.com>
> ---
>  arch/arm/mach-imx/mm-imx25.c          |    3 +--
>  arch/arm/mach-imx/mm-imx31.c          |    9 ++++++---
>  arch/arm/mach-imx/mm-imx35.c          |    9 ++++++---
>  arch/arm/mach-mx5/mm.c                |    9 ++-------
>  arch/arm/plat-mxc/include/mach/sdma.h |    6 ++----
>  drivers/dma/imx-sdma.c                |    6 +++---
>  6 files changed, 20 insertions(+), 22 deletions(-)
> 
> diff --git a/arch/arm/mach-imx/mm-imx25.c b/arch/arm/mach-imx/mm-imx25.c
> index 0c54520..1e0c956 100644
> --- a/arch/arm/mach-imx/mm-imx25.c
> +++ b/arch/arm/mach-imx/mm-imx25.c
> @@ -80,8 +80,7 @@ static struct sdma_script_start_addrs imx25_sdma_script __initdata = {
>  
>  static struct sdma_platform_data imx25_sdma_pdata __initdata = {
>  	.sdma_version = 2,
> -	.cpu_name = "imx25",
> -	.to_version = 1,
> +	.fw_name = "sdma-imx25.bin",
>  	.script_addrs = &imx25_sdma_script,
>  };
>  
> diff --git a/arch/arm/mach-imx/mm-imx31.c b/arch/arm/mach-imx/mm-imx31.c
> index 6af8519..a1ff96f 100644
> --- a/arch/arm/mach-imx/mm-imx31.c
> +++ b/arch/arm/mach-imx/mm-imx31.c
> @@ -70,7 +70,7 @@ static struct sdma_script_start_addrs imx31_to2_sdma_script __initdata = {
>  
>  static struct sdma_platform_data imx31_sdma_pdata __initdata = {
>  	.sdma_version = 1,
> -	.cpu_name = "imx31",
> +	.fw_name = "sdma-imx31-to2.bin",
>  	.script_addrs = &imx31_to2_sdma_script,
>  };
>  
> @@ -82,8 +82,11 @@ void __init imx31_soc_init(void)
>  	mxc_register_gpio(1, MX31_GPIO2_BASE_ADDR, SZ_16K, MX31_INT_GPIO2, 0);
>  	mxc_register_gpio(2, MX31_GPIO3_BASE_ADDR, SZ_16K, MX31_INT_GPIO3, 0);
>  
> -	imx31_sdma_pdata.to_version = to_version;
> -	if (to_version == 1)
> +	if (to_version == 1) {
> +		strncpy(imx31_sdma_pdata.fw_name, "sdma-imx31-to1.bin",
> +			strlen(imx31_sdma_pdata.fw_name));
>  		imx31_sdma_pdata.script_addrs = &imx31_to1_sdma_script;
> +	}
> +
>  	imx_add_imx_sdma(MX31_SDMA_BASE_ADDR, MX31_INT_SDMA, &imx31_sdma_pdata);
>  }
> diff --git a/arch/arm/mach-imx/mm-imx35.c b/arch/arm/mach-imx/mm-imx35.c
> index 9891adb..da530ca 100644
> --- a/arch/arm/mach-imx/mm-imx35.c
> +++ b/arch/arm/mach-imx/mm-imx35.c
> @@ -87,7 +87,7 @@ static struct sdma_script_start_addrs imx35_to2_sdma_script __initdata = {
>  
>  static struct sdma_platform_data imx35_sdma_pdata __initdata = {
>  	.sdma_version = 2,
> -	.cpu_name = "imx35",
> +	.fw_name = "sdma-imx35-to2.bin",
>  	.script_addrs = &imx35_to2_sdma_script,
>  };
>  
> @@ -99,8 +99,11 @@ void __init imx35_soc_init(void)
>  	mxc_register_gpio(1, MX35_GPIO2_BASE_ADDR, SZ_16K, MX35_INT_GPIO2, 0);
>  	mxc_register_gpio(2, MX35_GPIO3_BASE_ADDR, SZ_16K, MX35_INT_GPIO3, 0);
>  
> -	imx35_sdma_pdata.to_version = to_version;
> -	if (to_version == 1)
> +	if (to_version == 1) {
> +		strncpy(imx35_sdma_pdata.fw_name, "sdma-imx35-to1.bin",
> +			strlen(imx35_sdma_pdata.fw_name));
>  		imx35_sdma_pdata.script_addrs = &imx35_to1_sdma_script;
> +	}
> +
>  	imx_add_imx_sdma(MX35_SDMA_BASE_ADDR, MX35_INT_SDMA, &imx35_sdma_pdata);
>  }
> diff --git a/arch/arm/mach-mx5/mm.c b/arch/arm/mach-mx5/mm.c
> index aa848ea..1b7059f 100644
> --- a/arch/arm/mach-mx5/mm.c
> +++ b/arch/arm/mach-mx5/mm.c
> @@ -116,8 +116,7 @@ static struct sdma_script_start_addrs imx51_sdma_script __initdata = {
>  
>  static struct sdma_platform_data imx51_sdma_pdata __initdata = {
>  	.sdma_version = 2,
> -	.cpu_name = "imx51",
> -	.to_version = 1,
> +	.fw_name = "sdma-imx51.bin",
>  	.script_addrs = &imx51_sdma_script,
>  };
>  
> @@ -137,21 +136,17 @@ static struct sdma_script_start_addrs imx53_sdma_script __initdata = {
>  
>  static struct sdma_platform_data imx53_sdma_pdata __initdata = {
>  	.sdma_version = 2,
> -	.cpu_name = "imx53",
> -	.to_version = 1,
> +	.fw_name = "sdma-imx53.bin",
>  	.script_addrs = &imx53_sdma_script,
>  };
>  
>  void __init imx51_soc_init(void)
>  {
> -	int to_version = mx51_revision() >> 4;
> -
>  	mxc_register_gpio(0, MX51_GPIO1_BASE_ADDR, SZ_16K, MX51_MXC_INT_GPIO1_LOW, MX51_MXC_INT_GPIO1_HIGH);
>  	mxc_register_gpio(1, MX51_GPIO2_BASE_ADDR, SZ_16K, MX51_MXC_INT_GPIO2_LOW, MX51_MXC_INT_GPIO2_HIGH);
>  	mxc_register_gpio(2, MX51_GPIO3_BASE_ADDR, SZ_16K, MX51_MXC_INT_GPIO3_LOW, MX51_MXC_INT_GPIO3_HIGH);
>  	mxc_register_gpio(3, MX51_GPIO4_BASE_ADDR, SZ_16K, MX51_MXC_INT_GPIO4_LOW, MX51_MXC_INT_GPIO4_HIGH);
>  
> -	imx51_sdma_pdata.to_version = to_version;
>  	imx_add_imx_sdma(MX51_SDMA_BASE_ADDR, MX51_INT_SDMA, &imx51_sdma_pdata);
>  }
>  
> diff --git a/arch/arm/plat-mxc/include/mach/sdma.h b/arch/arm/plat-mxc/include/mach/sdma.h
> index 913e043..f495c87 100644
> --- a/arch/arm/plat-mxc/include/mach/sdma.h
> +++ b/arch/arm/plat-mxc/include/mach/sdma.h
> @@ -49,14 +49,12 @@ struct sdma_script_start_addrs {
>   * struct sdma_platform_data - platform specific data for SDMA engine
>   *
>   * @sdma_version	The version of this SDMA engine
> - * @cpu_name		used to generate the firmware name
> - * @to_version		CPU Tape out version
> + * @fw_name		The firmware name
>   * @script_addrs	SDMA scripts addresses in SDMA ROM
>   */
>  struct sdma_platform_data {
>  	int sdma_version;
> -	char *cpu_name;
> -	int to_version;
> +	char *fw_name;
>  	struct sdma_script_start_addrs *script_addrs;
>  };
>  
> diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
> index b6d1455..1ea47db 100644
> --- a/drivers/dma/imx-sdma.c
> +++ b/drivers/dma/imx-sdma.c
> @@ -1105,7 +1105,7 @@ static void sdma_add_scripts(struct sdma_engine *sdma,
>  }
>  
>  static int __init sdma_get_firmware(struct sdma_engine *sdma,
> -		const char *cpu_name, int to_version)
> +		const char *fw_name)
>  {
>  	const struct firmware *fw;
>  	char *fwname;
> @@ -1114,7 +1114,7 @@ static int __init sdma_get_firmware(struct sdma_engine *sdma,
>  	const struct sdma_script_start_addrs *addr;
>  	unsigned short *ram_code;
>  
> -	fwname = kasprintf(GFP_KERNEL, "sdma-%s-to%d.bin", cpu_name, to_version);
> +	fwname = kasprintf(GFP_KERNEL, "%s", fw_name);
>  	if (!fwname)
>  		return -ENOMEM;
>  
> @@ -1317,7 +1317,7 @@ static int __init sdma_probe(struct platform_device *pdev)
>  	if (pdata->script_addrs)
>  		sdma_add_scripts(sdma, pdata->script_addrs);
>  
> -	sdma_get_firmware(sdma, pdata->cpu_name, pdata->to_version);
> +	sdma_get_firmware(sdma, pdata->fw_name);
>  
>  	sdma->dma_device.dev = &pdev->dev;
>  
> -- 
> 1.7.4.1
> 
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
