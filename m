From: pierre-yves.mordret@st.com (Pierre Yves MORDRET)
Date: Wed, 26 Apr 2017 09:17:37 +0000
Subject: [PATCH 2/5] dmaengine: Add STM32 DMAMUX driver
In-Reply-To: <20170406064046.GF4094@localhost>
References: <1489414561-28912-1-git-send-email-cedric.madianga@gmail.com>
 <1489414561-28912-3-git-send-email-cedric.madianga@gmail.com>
 <20170406064046.GF4094@localhost>
Message-ID: <d18cb12d-1fd1-39d2-501a-18c000b9982e@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/06/2017 08:40 AM, Vinod Koul wrote:
> On Mon, Mar 13, 2017 at 03:15:58PM +0100, M'boumba Cedric Madianga wrote:
>> This patch implements the STM32 DMAMUX driver
>
> Can you describe the controller here pls

OK. Will be done in V2

>
>>
>> Signed-off-by: M'boumba Cedric Madianga <cedric.madianga@gmail.com>
>> ---
>>  drivers/dma/Kconfig        |   9 ++
>>  drivers/dma/Makefile       |   1 +
>>  drivers/dma/stm32-dmamux.c | 231 +++++++++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 241 insertions(+)
>>  create mode 100644 drivers/dma/stm32-dmamux.c
>>
>> diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
>> index fc3435c..6ab80c9 100644
>> --- a/drivers/dma/Kconfig
>> +++ b/drivers/dma/Kconfig
>> @@ -461,6 +461,15 @@ config STM32_DMA
>>  	  If you have a board based on such a MCU and wish to use DMA say Y
>>  	  here.
>>
>> +config STM32_DMAMUX
>> +	bool "STMicroelectronics STM32 dma multiplexer support"
>> +	depends on STM32_DMA
>
> can you add compile test here so that we can get better compile coverage

OK. Will be done in V2

>
>> +	help
>> +	  Enable support for the on-chip DMA multiplexer on STMicroelectronics
>> +	  STM32 MCUs.
>> +	  If you have a board based on such a MCU and wish to use DMAMUX say Y
>> +	  here.
>> +
>>  config S3C24XX_DMAC
>>  	bool "Samsung S3C24XX DMA support"
>>  	depends on ARCH_S3C24XX || COMPILE_TEST
>> diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
>> index 0b723e9..449c7a3 100644
>> --- a/drivers/dma/Makefile
>> +++ b/drivers/dma/Makefile
>> @@ -57,6 +57,7 @@ obj-$(CONFIG_RENESAS_DMA) += sh/
>>  obj-$(CONFIG_SIRF_DMA) += sirf-dma.o
>>  obj-$(CONFIG_STE_DMA40) += ste_dma40.o ste_dma40_ll.o
>>  obj-$(CONFIG_STM32_DMA) += stm32-dma.o
>> +obj-$(CONFIG_STM32_DMAMUX) += stm32-dmamux.o
>>  obj-$(CONFIG_S3C24XX_DMAC) += s3c24xx-dma.o
>>  obj-$(CONFIG_TXX9_DMAC) += txx9dmac.o
>>  obj-$(CONFIG_TEGRA20_APB_DMA) += tegra20-apb-dma.o
>> diff --git a/drivers/dma/stm32-dmamux.c b/drivers/dma/stm32-dmamux.c
>> new file mode 100644
>> index 0000000..3003546
>> --- /dev/null
>> +++ b/drivers/dma/stm32-dmamux.c
>> @@ -0,0 +1,231 @@
>> +/*
>> + * DMA Router driver for STM32 DMA MUX
>> + *
>> + * Copyright (C) 2015 M'Boumba Cedric Madianga <cedric.madianga@gmail.com>
>
> we are in '17 now :)

OK. Will be done in V2

>
>> + *
>> + * Based on LPC18xx/43xx DMA MUX and TI DMA XBAR
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + *
>> + */
>> +
>> +#include <linux/clk.h>
>> +#include <linux/delay.h>
>> +#include <linux/err.h>
>> +#include <linux/init.h>
>> +#include <linux/of_device.h>
>> +#include <linux/of_dma.h>
>> +#include <linux/reset.h>
>> +#include <linux/slab.h>
>> +
>> +#define STM32_DMAMUX_CCR(x)		(0x4 * (x))
>> +#define STM32_DMAMUX_MAX_CHANNELS	32
>> +#define STM32_DMAMUX_MAX_REQUESTS	255
>> +
>> +struct stm32_dmamux {
>> +	u32 chan_id;
>> +	u32 request;
>> +	bool busy;
>> +};
>> +
>> +struct stm32_dmamux_data {
>> +	struct dma_router dmarouter;
>> +	struct stm32_dmamux *muxes;
>> +	struct clk *clk;
>> +	void __iomem *iomem;
>> +	u32 dmamux_requests; /* number of DMA requests connected to DMAMUX */
>> +	u32 dmamux_channels; /* Number of DMA channels supported */
>> +};
>> +
>> +static inline u32 stm32_dmamux_read(void __iomem *iomem, u32 reg)
>> +{
>> +	return readl_relaxed(iomem + reg);
>> +}
>> +
>> +static inline void stm32_dmamux_write(void __iomem *iomem, u32 reg, u32 val)
>> +{
>> +	writel_relaxed(val, iomem + reg);
>> +}
>> +
>> +static void stm32_dmamux_free(struct device *dev, void *route_data)
>> +{
>> +	struct stm32_dmamux_data *dmamux = dev_get_drvdata(dev);
>> +	struct stm32_dmamux *mux = route_data;
>> +
>> +	/* Clear dma request for the right channel */
>> +	stm32_dmamux_write(dmamux->iomem, STM32_DMAMUX_CCR(mux->chan_id), 0);
>> +	clk_disable(dmamux->clk);
>> +	mux->busy = false;
>> +
>> +	dev_dbg(dev, "Unmapping dma-router%dchan%d (was routed to request%d)\n",
>> +		dev->id, mux->chan_id, mux->request);
>> +}
>> +
>> +static void *stm32_dmamux_route_allocate(struct of_phandle_args *dma_spec,
>> +					 struct of_dma *ofdma)
>> +{
>> +	struct platform_device *pdev = of_find_device_by_node(ofdma->of_node);
>> +	struct stm32_dmamux_data *dmamux = platform_get_drvdata(pdev);
>> +	struct stm32_dmamux *mux;
>> +	u32 chan_id;
>> +	int ret;
>> +
>> +	if (dma_spec->args_count != 4) {
>> +		dev_err(&pdev->dev, "invalid number of dma mux args\n");
>> +		return ERR_PTR(-EINVAL);
>> +	}
>> +
>> +	if (dma_spec->args[0] >= dmamux->dmamux_channels) {
>> +		dev_err(&pdev->dev, "invalid channel id: %d\n",
>> +			dma_spec->args[0]);
>> +		return ERR_PTR(-EINVAL);
>> +	}
>> +
>> +	if (dma_spec->args[1] > dmamux->dmamux_requests) {
>> +		dev_err(&pdev->dev, "invalid mux request number: %d\n",
>> +			dma_spec->args[1]);
>> +		return ERR_PTR(-EINVAL);
>> +	}
>> +
>> +	/* The of_node_put() will be done in of_dma_router_xlate function */
>> +	dma_spec->np = of_parse_phandle(ofdma->of_node, "dma-masters", 0);
>> +	if (!dma_spec->np) {
>> +		dev_err(&pdev->dev, "can't get dma master\n");
>> +		return ERR_PTR(-EINVAL);
>> +	}
>> +
>> +	chan_id = dma_spec->args[0];
>> +	mux = &dmamux->muxes[chan_id];
>> +	mux->chan_id = chan_id;
>> +	mux->request = dma_spec->args[1];
>> +
>> +	if (mux->busy) {
>> +		dev_err(&pdev->dev, "dma channel %d busy with request %d\n",
>> +			chan_id, mux->request);
>> +		return ERR_PTR(-EBUSY);
>> +	}
>> +
>> +	ret = clk_enable(dmamux->clk);
>> +	if (ret < 0) {
>> +		dev_err(&pdev->dev, "clk_enable failed: %d\n", ret);
>> +		return ERR_PTR(ret);
>> +	}
>> +
>> +	stm32_dmamux_write(dmamux->iomem, STM32_DMAMUX_CCR(mux->chan_id),
>> +			   mux->request);
>> +	mux->busy = true;
>> +
>> +	dev_dbg(&pdev->dev, "Mapping dma-router%dchan%d to request%d\n",
>> +		pdev->dev.id, mux->chan_id, mux->request);
>> +
>> +	return mux;
>> +}
>> +
>> +static int stm32_dmamux_probe(struct platform_device *pdev)
>> +{
>> +	struct device_node *dma_node, *node = pdev->dev.of_node;
>> +	struct stm32_dmamux_data *dmamux;
>> +	struct reset_control *rst;
>> +	struct resource *res;
>> +	int ret;
>> +
>> +	if (!node)
>> +		return -ENODEV;
>> +
>> +	dmamux = devm_kzalloc(&pdev->dev, sizeof(struct stm32_dmamux_data),
>> +			      GFP_KERNEL);
>> +	if (!dmamux)
>> +		return -ENOMEM;
>> +
>> +	dma_node = of_parse_phandle(node, "dma-masters", 0);
>> +	if (!dma_node) {
>> +		dev_err(&pdev->dev, "Can't get DMA master node\n");
>> +		return -ENODEV;
>> +	}
>> +	of_node_put(dma_node);
>> +
>> +	ret = of_property_read_u32(node, "dma-channels",
>> +				   &dmamux->dmamux_channels);
>
> can we have property_xxx calls alone, that way driver is not strictly
> dependent on of

Can you please explain what you are asking for ? Not sure to understand 
correctly.

>
>> +	if (ret)
>> +		dmamux->dmamux_channels = STM32_DMAMUX_MAX_CHANNELS;
>> +
>> +	ret = of_property_read_u32(node, "dma-requests",
>> +				   &dmamux->dmamux_requests);
>> +	if (ret)
>> +		dmamux->dmamux_requests = STM32_DMAMUX_MAX_REQUESTS;
>> +
>> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +	if (!res)
>> +		return -ENODEV;
>> +
>> +	dmamux->iomem = devm_ioremap_resource(&pdev->dev, res);
>> +	if (!dmamux->iomem)
>> +		return -ENOMEM;
>> +
>> +	dmamux->clk = devm_clk_get(&pdev->dev, NULL);
>> +	if (IS_ERR(dmamux->clk)) {
>> +		dev_err(&pdev->dev, "Missing controller clock\n");
>> +		return PTR_ERR(dmamux->clk);
>> +	}
>> +	ret = clk_prepare(dmamux->clk);
>> +	if (ret < 0) {
>> +		dev_err(&pdev->dev, "clk_prep failed: %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	dmamux->muxes = devm_kcalloc(&pdev->dev, dmamux->dmamux_channels,
>> +				     sizeof(struct stm32_dmamux),
>> +				     GFP_KERNEL);
>> +	if (!dmamux->muxes)
>> +		return -ENOMEM;
>> +
>> +	rst = devm_reset_control_get(&pdev->dev, NULL);
>> +	if (!IS_ERR(rst)) {
>> +		ret = clk_enable(dmamux->clk);
>> +		if (ret < 0) {
>> +			dev_err(&pdev->dev, "clk_enable failed: %d\n", ret);
>> +			return ret;
>> +		}
>> +		reset_control_assert(rst);
>> +		udelay(2);
>> +		reset_control_deassert(rst);
>> +		clk_disable(dmamux->clk);
>> +	}
>> +
>> +	dmamux->dmarouter.dev = &pdev->dev;
>> +	dmamux->dmarouter.route_free = stm32_dmamux_free;
>> +	platform_set_drvdata(pdev, dmamux);
>> +
>> +	ret = of_dma_router_register(node, stm32_dmamux_route_allocate,
>> +				     &dmamux->dmarouter);
>> +	if (ret < 0) {
>> +		dev_err(&pdev->dev,
>> +			"STM32 DMAMUX DMA OF registration failed %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	dev_info(&pdev->dev, "STM32 DMAMUX driver registered\n");
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct of_device_id stm32_dmamux_match[] = {
>> +	{ .compatible = "st,stm32-dmamux" },
>> +	{},
>> +};
>> +
>> +static struct platform_driver stm32_dmamux_driver = {
>> +	.probe	= stm32_dmamux_probe,
>> +	.driver = {
>> +		.name = "stm32-dmamux",
>> +		.of_match_table = stm32_dmamux_match,
>> +	},
>> +};
>> +
>> +static int __init stm32_dmamux_init(void)
>> +{
>> +	return platform_driver_register(&stm32_dmamux_driver);
>> +}
>> +arch_initcall(stm32_dmamux_init);
>
> why not module init, wouldnt defer probe solve the dependencies
>

The reason behind many devices (device_initcall level) rely on DMAs. If 
init is deferred DMAMUX driver will be probed twice if dependents rely 
on it. This sounds not a good call. This explains arch_initcall level.
