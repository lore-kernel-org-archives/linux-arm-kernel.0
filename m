From: vinod.koul@intel.com (Vinod Koul)
Date: Tue, 30 Apr 2013 16:21:05 +0530
Subject: [PATCH v2 2/2] dma: imx-sdma: move to generic device tree bindings
In-Reply-To: <1366901008-7593-3-git-send-email-shawn.guo@linaro.org>
References: <1366901008-7593-1-git-send-email-shawn.guo@linaro.org>
 <1366901008-7593-3-git-send-email-shawn.guo@linaro.org>
Message-ID: <20130430105105.GG1960@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 25, 2013 at 10:43:28PM +0800, Shawn Guo wrote:
> Update imx-sdma driver to adopt generic DMA device tree bindings.  It
> calls of_dma_controller_register() with imx-sdma specific of_dma_xlate
> to get the generic DMA device tree helper support.  The #dma-cells for
> imx-sdma must be 3, which includes request ID, peripheral type and
> priority.
> 
> The definitions of peripheral type and priority get moved into
> include/dt-bindings/dma/imx.h, so that the macros can also be used in
> dts files.
> 
> The existing way of requesting channel, clients directly call
> dma_request_channel(), still work there, and will be removed after
> all imx-sdma clients get converted to generic DMA device tree helper.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
Looks fine to me, Arnd?

--
~Vinod
> ---
>  .../devicetree/bindings/dma/fsl-imx-sdma.txt       |   22 +++++++++++
>  drivers/dma/imx-sdma.c                             |   40 ++++++++++++++++++++
>  include/dt-bindings/dma/imx.h                      |   29 ++++++++++++++
>  include/linux/platform_data/dma-imx.h              |   31 +--------------
>  4 files changed, 92 insertions(+), 30 deletions(-)
>  create mode 100644 include/dt-bindings/dma/imx.h
> 
> diff --git a/Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt b/Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt
> index d1e3f44..8bd8d35 100644
> --- a/Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt
> +++ b/Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt
> @@ -4,6 +4,11 @@ Required properties:
>  - compatible : Should be "fsl,<chip>-sdma"
>  - reg : Should contain SDMA registers location and length
>  - interrupts : Should contain SDMA interrupt
> +- #dma-cells : Must be <3>.
> +  The first cell specifies the DMA request/event ID.  The second and
> +  third cell specifies the peripheral type and priority of DMA transfer
> +  respectively.  Refer to include/dt-bindings/dma/imx.h for available
> +  peripheral types and priorities.
>  - fsl,sdma-ram-script-name : Should contain the full path of SDMA RAM
>    scripts firmware
>  
> @@ -13,5 +18,22 @@ sdma at 83fb0000 {
>  	compatible = "fsl,imx51-sdma", "fsl,imx35-sdma";
>  	reg = <0x83fb0000 0x4000>;
>  	interrupts = <6>;
> +	#dma-cells = <3>;
>  	fsl,sdma-ram-script-name = "sdma-imx51.bin";
>  };
> +
> +DMA clients connected to the i.MX SDMA controller must use the format
> +described in the dma.txt file.
> +
> +Examples:
> +
> +ssi2: ssi at 70014000 {
> +	compatible = "fsl,imx51-ssi", "fsl,imx21-ssi";
> +	reg = <0x70014000 0x4000>;
> +	interrupts = <30>;
> +	clocks = <&clks 49>;
> +	dmas = <&sdma 24 IMX_DMATYPE_SSI_SP DMA_PRIO_HIGH>,
> +	       <&sdma 25 IMX_DMATYPE_SSI_SP DMA_PRIO_HIGH>;
> +	dma-names = "rx", "tx";
> +	fsl,fifo-depth = <15>;
> +};
> diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
> index e57a0c6..f1324da 100644
> --- a/drivers/dma/imx-sdma.c
> +++ b/drivers/dma/imx-sdma.c
> @@ -36,6 +36,7 @@
>  #include <linux/dmaengine.h>
>  #include <linux/of.h>
>  #include <linux/of_device.h>
> +#include <linux/of_dma.h>
>  
>  #include <asm/irq.h>
>  #include <linux/platform_data/dma-imx-sdma.h>
> @@ -1296,6 +1297,35 @@ err_dma_alloc:
>  	return ret;
>  }
>  
> +static bool sdma_filter_fn(struct dma_chan *chan, void *fn_param)
> +{
> +	struct imx_dma_data *data = fn_param;
> +
> +	if (!imx_dma_is_general_purpose(chan))
> +		return false;
> +
> +	chan->private = data;
> +
> +	return true;
> +}
> +
> +struct dma_chan *sdma_xlate(struct of_phandle_args *dma_spec,
> +			    struct of_dma *ofdma)
> +{
> +	struct sdma_engine *sdma = ofdma->of_dma_data;
> +	dma_cap_mask_t mask = sdma->dma_device.cap_mask;
> +	struct imx_dma_data data;
> +
> +	if (dma_spec->args_count != 3)
> +		return NULL;
> +
> +	data.dma_request = dma_spec->args[0];
> +	data.peripheral_type = dma_spec->args[1];
> +	data.priority = dma_spec->args[2];
> +
> +	return dma_request_channel(mask, sdma_filter_fn, &data);
> +}
> +
>  static int __init sdma_probe(struct platform_device *pdev)
>  {
>  	const struct of_device_id *of_id =
> @@ -1443,10 +1473,20 @@ static int __init sdma_probe(struct platform_device *pdev)
>  		goto err_init;
>  	}
>  
> +	if (np) {
> +		ret = of_dma_controller_register(np, sdma_xlate, sdma);
> +		if (ret) {
> +			dev_err(&pdev->dev, "failed to register controller\n");
> +			goto err_register;
> +		}
> +	}
> +
>  	dev_info(sdma->dev, "initialized\n");
>  
>  	return 0;
>  
> +err_register:
> +	dma_async_device_unregister(&sdma->dma_device);
>  err_init:
>  	kfree(sdma->script_addrs);
>  err_alloc:
> diff --git a/include/dt-bindings/dma/imx.h b/include/dt-bindings/dma/imx.h
> new file mode 100644
> index 0000000..d5de68c
> --- /dev/null
> +++ b/include/dt-bindings/dma/imx.h
> @@ -0,0 +1,29 @@
> +/*
> + * This enumerates peripheral types. Used for SDMA.
> + */
> +#define IMX_DMATYPE_SSI		0  /* MCU domain SSI */
> +#define IMX_DMATYPE_SSI_SP	1  /* Shared SSI */
> +#define IMX_DMATYPE_MMC		2  /* MMC */
> +#define IMX_DMATYPE_SDHC	3  /* SDHC */
> +#define IMX_DMATYPE_UART	4  /* MCU domain UART */
> +#define IMX_DMATYPE_UART_SP	5  /* Shared UART */
> +#define IMX_DMATYPE_FIRI	6  /* FIRI */
> +#define IMX_DMATYPE_CSPI	7  /* MCU domain CSPI */
> +#define IMX_DMATYPE_CSPI_SP	8  /* Shared CSPI */
> +#define IMX_DMATYPE_SIM		9  /* SIM */
> +#define IMX_DMATYPE_ATA		10 /* ATA */
> +#define IMX_DMATYPE_CCM		11 /* CCM */
> +#define IMX_DMATYPE_EXT		12 /* External peripheral */
> +#define IMX_DMATYPE_MSHC	13 /* Memory Stick Host Controller */
> +#define IMX_DMATYPE_MSHC_SP	14 /* Shared Memory Stick Host Controller */
> +#define IMX_DMATYPE_DSP		15 /* DSP */
> +#define IMX_DMATYPE_MEMORY	16 /* Memory */
> +#define IMX_DMATYPE_FIFO_MEMORY	17 /* FIFO type Memory */
> +#define IMX_DMATYPE_SPDIF	18 /* SPDIF */
> +#define IMX_DMATYPE_IPU_MEMORY	19 /* IPU Memory */
> +#define IMX_DMATYPE_ASRC	20 /* ASRC */
> +#define IMX_DMATYPE_ESAI	21 /* ESAI */
> +
> +#define DMA_PRIO_HIGH		0
> +#define DMA_PRIO_MEDIUM		1
> +#define DMA_PRIO_LOW		2
> diff --git a/include/linux/platform_data/dma-imx.h b/include/linux/platform_data/dma-imx.h
> index 8a8a684..33f7eda 100644
> --- a/include/linux/platform_data/dma-imx.h
> +++ b/include/linux/platform_data/dma-imx.h
> @@ -12,36 +12,7 @@
>  #include <linux/scatterlist.h>
>  #include <linux/device.h>
>  #include <linux/dmaengine.h>
> -
> -/*
> - * This enumerates peripheral types. Used for SDMA.
> - */
> -#define IMX_DMATYPE_SSI		0  /* MCU domain SSI */
> -#define IMX_DMATYPE_SSI_SP	1  /* Shared SSI */
> -#define IMX_DMATYPE_MMC		2  /* MMC */
> -#define IMX_DMATYPE_SDHC	3  /* SDHC */
> -#define IMX_DMATYPE_UART	4  /* MCU domain UART */
> -#define IMX_DMATYPE_UART_SP	5  /* Shared UART */
> -#define IMX_DMATYPE_FIRI	6  /* FIRI */
> -#define IMX_DMATYPE_CSPI	7  /* MCU domain CSPI */
> -#define IMX_DMATYPE_CSPI_SP	8  /* Shared CSPI */
> -#define IMX_DMATYPE_SIM		9  /* SIM */
> -#define IMX_DMATYPE_ATA		10 /* ATA */
> -#define IMX_DMATYPE_CCM		11 /* CCM */
> -#define IMX_DMATYPE_EXT		12 /* External peripheral */
> -#define IMX_DMATYPE_MSHC	13 /* Memory Stick Host Controller */
> -#define IMX_DMATYPE_MSHC_SP	14 /* Shared Memory Stick Host Controller */
> -#define IMX_DMATYPE_DSP		15 /* DSP */
> -#define IMX_DMATYPE_MEMORY	16 /* Memory */
> -#define IMX_DMATYPE_FIFO_MEMORY	17 /* FIFO type Memory */
> -#define IMX_DMATYPE_SPDIF	18 /* SPDIF */
> -#define IMX_DMATYPE_IPU_MEMORY	19 /* IPU Memory */
> -#define IMX_DMATYPE_ASRC	20 /* ASRC */
> -#define IMX_DMATYPE_ESAI	21 /* ESAI */
> -
> -#define DMA_PRIO_HIGH		0
> -#define DMA_PRIO_MEDIUM		1
> -#define DMA_PRIO_LOW		2
> +#include <dt-bindings/dma/imx.h>
>  
>  struct imx_dma_data {
>  	int dma_request; /* DMA request line */
> -- 
> 1.7.9.5
> 
> 
