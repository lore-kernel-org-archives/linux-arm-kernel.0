From: pebolle@tiscali.nl (Paul Bolle)
Date: Thu, 09 Jul 2015 10:17:52 +0200
Subject: [PATCH 3/7] dmaengine: st_fdma: Add STMicroelectronics FDMA
 engine driver support
In-Reply-To: <1436371888-27863-4-git-send-email-peter.griffin@linaro.org>
References: <1436371888-27863-1-git-send-email-peter.griffin@linaro.org>
 <1436371888-27863-4-git-send-email-peter.griffin@linaro.org>
Message-ID: <1436429872.20619.77.camel@tiscali.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On wo, 2015-07-08 at 17:11 +0100, Peter Griffin wrote:
> --- a/drivers/dma/Kconfig
> +++ b/drivers/dma/Kconfig
 
> +config ST_FDMA
> +	bool "ST FDMA dmaengine support"
> +	depends on ARCH_STI
> +	select DMA_ENGINE
> +	select FW_LOADER
> +	select FW_LOADER_USER_HELPER_FALLBACK
> +	select LIBELF_32
> +	select DMA_VIRTUAL_CHANNELS
> +	help
> +	  Enable support for ST FDMA controller.
> +	  It supports 16 independent DMA channels, accepts up to 32 DMA requests
> +
> +	  Say Y here if you have such a chipset.
> +	  If unsure, say N.

> --- a/drivers/dma/Makefile
> +++ b/drivers/dma/Makefile
> 
> +obj-$(CONFIG_ST_FDMA) += st_fdma.o

ST_FDMA is a bool symbol, so st_fdma.o can only be built-in.

> --- /dev/null
> +++ b/drivers/dma/st_fdma.c

> +#include <linux/module.h>

Needed?

> +void *st_fdma_seg_to_mem(struct st_fdma_dev *fdev, u64 da, int len)

static?

> +{
> +	[...]
> +}

> +static int
> +st_fdma_elf_load_segments(struct st_fdma_dev *fdev, const struct 
> firmware *fw)
> +{
> +	[...]
> +		dst = st_fdma_seg_to_mem(fdev, da, memsz);
> +		[...]
> +}

> +static const struct of_device_id st_fdma_match[] = {
> +	{ .compatible = "st,fdma_mpe31", .data = &fdma_mpe31 },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, st_fdma_match);

MODULE_DEVICE_TABLE() is preprocessed away for built-in only code.

> +static int __exit st_fdma_remove(struct platform_device *pdev)
> +{
> +	struct st_fdma_dev *fdev = platform_get_drvdata(pdev);
> +
> +	wait_for_completion(&fdev->fw_ack);
> +
> +	st_fdma_clk_disable(fdev);
> +
> +	return 0;
> +}

Since this driver is built-in only this means st_fdma_remove() can never
be used, right?

> +static struct platform_driver st_fdma_platform_driver = {
> +	.driver = {
> +		.name = "st-fdma",
> +		.of_match_table = st_fdma_match,
> +		.pm = ST_FDMA_PM,
> +	},
> +	.probe = st_fdma_probe,
> +	.remove = st_fdma_remove,
> +};
> +module_platform_driver(st_fdma_platform_driver);

So can .remove be dropped?

Since v4.2-rc1 there's builtin_platform_driver() for built-in only code.

> +bool st_fdma_filter_fn(struct dma_chan *chan, void *param)
> +{
> +	[...]
> +}
> +EXPORT_SYMBOL(st_fdma_filter_fn);

This series adds no users of this export. I suppose they will be added
in another series. Is that correct?

> +MODULE_LICENSE("GPL v2");
> +MODULE_DESCRIPTION("STMicroelectronics FDMA engine driver");
> +MODULE_AUTHOR("Ludovic.barre <Ludovic.barre@st.com>");

These macros will, basically, be preprocessed away for built-in only
code.

Thanks,


Paul Bolle
