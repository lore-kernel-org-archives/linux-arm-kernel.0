From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 21 Apr 2016 13:24:06 +0200
Subject: [PATCH 03/18] dmaengine: st_fdma: Add STMicroelectronics FDMA
 engine driver support
In-Reply-To: <1461236675-10176-4-git-send-email-peter.griffin@linaro.org>
References: <1461236675-10176-1-git-send-email-peter.griffin@linaro.org>
 <1461236675-10176-4-git-send-email-peter.griffin@linaro.org>
Message-ID: <3845018.6KSEIV4jzU@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 21 April 2016 12:04:20 Peter Griffin wrote:
> This patch adds support for the Flexible Direct Memory Access (FDMA) core
> driver. The FDMA is a slim core CPU with a dedicated firmware.
> It is a general purpose DMA controller capable of supporting 16
> independent DMA channels. Data moves maybe from memory to memory
> or between memory and paced latency critical real time targets and it
> is found on al STi based chipsets.
> 
> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> ---
>  drivers/dma/Kconfig   |  12 +
>  drivers/dma/Makefile  |   1 +
>  drivers/dma/st_fdma.c | 967 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 980 insertions(+)
>  create mode 100644 drivers/dma/st_fdma.c
> 
> diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
> index d96d87c..5910c4f 100644
> --- a/drivers/dma/Kconfig
> +++ b/drivers/dma/Kconfig
> @@ -527,6 +527,18 @@ config ZX_DMA
>  	help
>  	  Support the DMA engine for ZTE ZX296702 platform devices.
>  
> +config ST_FDMA
> +	tristate "ST FDMA dmaengine support"
> +	depends on ARCH_STI

Try to ensure that the driver builds on x86 (possibly adding
further dependencies if needed), then make this

	depends on ARCH_STI || COMPILE_TEST

to get better build coverage.

> +static struct dma_chan *st_fdma_of_xlate(struct of_phandle_args *dma_spec,
> +					 struct of_dma *ofdma)
> +{
> +	struct st_fdma_dev *fdev = ofdma->of_dma_data;
> +	struct st_fdma_cfg cfg;
> +
> +	if (dma_spec->args_count < 1)
> +		return NULL;
> +
> +	cfg.of_node = dma_spec->np;
> +	cfg.req_line = dma_spec->args[0];
> +	cfg.req_ctrl = 0;
> +	cfg.type = ST_FDMA_TYPE_FREE_RUN;
> +
> +	if (dma_spec->args_count > 1)
> +		cfg.req_ctrl = dma_spec->args[1] & REQ_CTRL_CFG_MASK;
> +
> +	if (dma_spec->args_count > 2)
> +		cfg.type = dma_spec->args[2];
> +
> +	dev_dbg(fdev->dev, "xlate req_line:%d type:%d req_ctrl:%#lx\n",
> +		cfg.req_line, cfg.type, cfg.req_ctrl);
> +
> +	return dma_request_channel(fdev->dma_device.cap_mask,
> +			st_fdma_filter_fn, &cfg);
> +}

No need to look at all DMA channels in the system here with
dma_request_channel(). Just call dma_get_any_slave_channel()
to get the first available channel for this engine, then
set the configuration right in that channel data while parsing
the DT properties.

	Arnd
