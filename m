From: Bharat.Bhushan@freescale.com (Bharat Bhushan)
Date: Sun, 10 Nov 2013 06:57:08 +0000
Subject: [PATCH v4 1/4] dma: imx-sdma: Add sdma firmware version 2 support
In-Reply-To: <1524b725cecd208ad63741f0b7214d0039608ac0.1383907685.git.b42378@freescale.com>
References: <cover.1383907685.git.b42378@freescale.com>
 <1524b725cecd208ad63741f0b7214d0039608ac0.1383907685.git.b42378@freescale.com>
Message-ID: <6A3DF150A5B70D4F9B66A25E3F7C888D071EDFC5@039-SN2MPN1-013.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Linuxppc-dev [mailto:linuxppc-dev-
> bounces+bharat.bhushan=freescale.com at lists.ozlabs.org] On Behalf Of Nicolin Chen
> Sent: Friday, November 08, 2013 4:20 PM
> To: vinod.koul at intel.com; dan.j.williams at intel.com; s.hauer at pengutronix.de;
> timur at tabi.org; shawn.guo at linaro.org; broonie at kernel.org
> Cc: mark.rutland at arm.com; devicetree at vger.kernel.org; alsa-devel at alsa-
> project.org; pawel.moll at arm.com; linux-doc at vger.kernel.org;
> swarren at wwwdotorg.org; linux-kernel at vger.kernel.org; rob.herring at calxeda.com;
> dmaengine at vger.kernel.org; ijc+devicetree at hellion.org.uk; linuxppc-
> dev at lists.ozlabs.org; linux-arm-kernel at lists.infradead.org
> Subject: [PATCH v4 1/4] dma: imx-sdma: Add sdma firmware version 2 support
> 
> On i.MX5/6 series, SDMA is using new version firmware to support SSI dual FIFO
> feature and HDMI Audio (i.MX6Q/DL only). Thus add it.
> 
> Signed-off-by: Nicolin Chen <b42378@freescale.com>
> ---
>  drivers/dma/imx-sdma.c                     | 15 ++++++++++++++-
>  include/linux/platform_data/dma-imx-sdma.h |  5 +++++
>  2 files changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c index
> fc43603..c7ece8d 100644
> --- a/drivers/dma/imx-sdma.c
> +++ b/drivers/dma/imx-sdma.c
> @@ -323,6 +323,7 @@ struct sdma_engine {
>  	struct clk			*clk_ipg;
>  	struct clk			*clk_ahb;
>  	spinlock_t			channel_0_lock;
> +	u32				script_number;
>  	struct sdma_script_start_addrs	*script_addrs;
>  	const struct sdma_driver_data	*drvdata;
>  };
> @@ -1238,6 +1239,7 @@ static void sdma_issue_pending(struct dma_chan *chan)  }
> 
>  #define SDMA_SCRIPT_ADDRS_ARRAY_SIZE_V1	34
> +#define SDMA_SCRIPT_ADDRS_ARRAY_SIZE_V2	38
> 
>  static void sdma_add_scripts(struct sdma_engine *sdma,
>  		const struct sdma_script_start_addrs *addr) @@ -1246,7 +1248,7 @@
> static void sdma_add_scripts(struct sdma_engine *sdma,
>  	s32 *saddr_arr = (u32 *)sdma->script_addrs;
>  	int i;
> 
> -	for (i = 0; i < SDMA_SCRIPT_ADDRS_ARRAY_SIZE_V1; i++)
> +	for (i = 0; i < sdma->script_number; i++)
>  		if (addr_arr[i] > 0)
>  			saddr_arr[i] = addr_arr[i];
>  }
> @@ -1272,6 +1274,17 @@ static void sdma_load_firmware(const struct firmware *fw,
> void *context)
>  		goto err_firmware;
>  	if (header->ram_code_start + header->ram_code_size > fw->size)
>  		goto err_firmware;
> +	switch (header->version_major) {
> +		case 1:
> +			sdma->script_number = SDMA_SCRIPT_ADDRS_ARRAY_SIZE_V1;
> +			break;
> +		case 2:
> +			sdma->script_number = SDMA_SCRIPT_ADDRS_ARRAY_SIZE_V2;
> +			break;
> +		default:
> +			dev_err(sdma->dev, "unknown firmware version\n");
> +			return;

Why return and not "goto err_firmware" ?

-Bharat

> +	}
> 
>  	addr = (void *)header + header->script_addrs_start;
>  	ram_code = (void *)header + header->ram_code_start; diff --git
> a/include/linux/platform_data/dma-imx-sdma.h b/include/linux/platform_data/dma-
> imx-sdma.h
> index 3a39428..eabac4e 100644
> --- a/include/linux/platform_data/dma-imx-sdma.h
> +++ b/include/linux/platform_data/dma-imx-sdma.h
> @@ -43,6 +43,11 @@ struct sdma_script_start_addrs {
>  	s32 dptc_dvfs_addr;
>  	s32 utra_addr;
>  	s32 ram_code_start_addr;
> +	/* End of v1 array */
> +	s32 mcu_2_ssish_addr;
> +	s32 ssish_2_mcu_addr;
> +	s32 hdmi_dma_addr;
> +	/* End of v2 array */
>  };
> 
>  /**
> --
> 1.8.4
> 
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev at lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
