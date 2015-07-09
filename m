From: pebolle@tiscali.nl (Paul Bolle)
Date: Thu, 09 Jul 2015 10:27:48 +0200
Subject: [PATCH 4/7] dmaengine: st_fdma: Add xbar support
In-Reply-To: <1436371888-27863-5-git-send-email-peter.griffin@linaro.org>
References: <1436371888-27863-1-git-send-email-peter.griffin@linaro.org>
 <1436371888-27863-5-git-send-email-peter.griffin@linaro.org>
Message-ID: <1436430468.20619.86.camel@tiscali.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On wo, 2015-07-08 at 17:11 +0100, Peter Griffin wrote:
> --- a/drivers/dma/Kconfig
> +++ b/drivers/dma/Kconfig
 
> +config ST_FDMA_XBAR
> +	bool "ST FDMA crossbar"
> +	depends on ST_FDMA
> +	default y
> +	help
> +	  Enable support for ST FDMA crossbar.
> +	  xbar add flexibility and increase the number of peripheral request
> +	  can be used by fdma xbar can multiplex until 96 peripheral requests
> +	  to one of 3 fdma controller

> diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
> index f68e6d8..19f18b1 100644
> --- a/drivers/dma/Makefile
> +++ b/drivers/dma/Makefile

> +obj-$(CONFIG_ST_FDMA_XBAR) += st_fdma_xbar.o

ST_FDMA_XBAR is a bool symbol, so st_fdma_xbar.o can only be built-in.

> --- /dev/null
> +++ b/drivers/dma/st_fdma_xbar.c

> +#include <linux/module.h>

Needed?

> +void st_fdma_xbar_free(struct st_fdma_xbar_dev *device)
> +{
> +	platform_device_put(device->pdev);
> +	kfree(device);
> +}

Unused.

> +static const struct of_device_id st_fdma_xbar_match[] = {
> +	{ .compatible = "st,fdma-xbar-1.0", .data = (void *)XBAR_1_0_MAX_REQ },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, st_fdma_xbar_match);

See my remark on 3/7: MODULE_DEVICE_TABLE() will be preprocessed away.

> +static struct platform_driver st_fdma_xbar_driver = {
> +	.driver	= {
> +		.name = "st-fdma-xbar",
> +		.of_match_table = st_fdma_xbar_match,
> +	},
> +	.probe = st_fdma_xbar_probe,
> +	.remove = st_fdma_xbar_remove,
> +};
> +module_platform_driver(st_fdma_xbar_driver);

See my remark on 3/7: builtin_platform_driver(). 

> +MODULE_LICENSE("GPL v2");
> +MODULE_DESCRIPTION("STMicroelectronics FDMA cross bar");
> +MODULE_AUTHOR("Ludovic.barre <Ludovic.barre@st.com>");

See my remark on 3/7: will be preprocessed away.

Thanks,


Paul Bolle
