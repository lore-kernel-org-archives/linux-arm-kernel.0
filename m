From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Tue, 26 Sep 2017 11:03:08 +0300
Subject: [RESEND PATCH v5 2/4] dmaengine: Add STM32 DMAMUX driver
In-Reply-To: <1506065492-31478-3-git-send-email-pierre-yves.mordret@st.com>
References: <1506065492-31478-1-git-send-email-pierre-yves.mordret@st.com>
 <1506065492-31478-3-git-send-email-pierre-yves.mordret@st.com>
Message-ID: <32e4d8e5-e95c-9048-26b0-4ffe2c36ff02@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

?


Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

On 2017-09-22 10:31, Pierre-Yves MORDRET wrote:
> This patch implements the STM32 DMAMUX driver.
> 
> The DMAMUX request multiplexer allows routing a DMA request line between
> the peripherals and the DMA controllers of the product. The routing
> function is ensured by a programmable multi-channel DMA request line
> multiplexer. Each channel selects a unique DMA request line,
> unconditionally or synchronously with events from its DMAMUX
> synchronization inputs. The DMAMUX may also be used as a DMA request
> generator from programmable events on its input trigger signals
> 
> Signed-off-by: M'boumba Cedric Madianga <cedric.madianga@gmail.com>
> Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>

Reviewed-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

> ---
>  Version history:
>     v5:
>         * Set selected channel ID within a lock to avoid race condition.
>           Release if any error occurs
>     v4:
>         * Get rid of st,dmamux property and custom API between STM32
>           DMAMUX and DMA.
>           DMAMUX will read DMA masters from Device Tree from now on.
>           Merely one DMAMUX node is needed now.
>         * Only STM32 DMA are allowed to be connected onto DMAMUX
>         * channelID is computed locally within the driver and crafted in
>           dma_psec to be passed toward DMA master.
>           DMAMUX router sorts out which DMA master will serve the
>           request automatically.
>         * This version forbids the use of DMA in standalone and DMAMUX at
>           the same time : all clients need to be connected either on DMA
>           or DMAMUX ; no mix up
>     v3:
>         * change compatible to st,stm32h7-dmamux to be mode SoC specific
>     v2:
>         * Dynamic channelID allocation.
>         * Change of_property_... by device_property.
>         * New clock management.
>         * DMAMUX Configuration API.
> ---
> ---
>  drivers/dma/Kconfig        |   9 ++
>  drivers/dma/Makefile       |   1 +
>  drivers/dma/stm32-dmamux.c | 327 +++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 337 insertions(+)
>  create mode 100644 drivers/dma/stm32-dmamux.c
> 
> diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
> index fadc4d8..04e381b 100644
> --- a/drivers/dma/Kconfig
> +++ b/drivers/dma/Kconfig
> @@ -483,6 +483,15 @@ config STM32_DMA
>  	  If you have a board based on such a MCU and wish to use DMA say Y
>  	  here.
>  
> +config STM32_DMAMUX
> +	bool "STMicroelectronics STM32 dma multiplexer support"
> +	depends on STM32_DMA || COMPILE_TEST
> +	help
> +	  Enable support for the on-chip DMA multiplexer on STMicroelectronics
> +	  STM32 MCUs.
> +	  If you have a board based on such a MCU and wish to use DMAMUX say Y
> +	  here.
> +
>  config S3C24XX_DMAC
>  	bool "Samsung S3C24XX DMA support"
>  	depends on ARCH_S3C24XX || COMPILE_TEST
> diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
> index f08f8de..a145ad1 100644
> --- a/drivers/dma/Makefile
> +++ b/drivers/dma/Makefile
> @@ -59,6 +59,7 @@ obj-$(CONFIG_RENESAS_DMA) += sh/
>  obj-$(CONFIG_SIRF_DMA) += sirf-dma.o
>  obj-$(CONFIG_STE_DMA40) += ste_dma40.o ste_dma40_ll.o
>  obj-$(CONFIG_STM32_DMA) += stm32-dma.o
> +obj-$(CONFIG_STM32_DMAMUX) += stm32-dmamux.o
>  obj-$(CONFIG_S3C24XX_DMAC) += s3c24xx-dma.o
>  obj-$(CONFIG_TXX9_DMAC) += txx9dmac.o
>  obj-$(CONFIG_TEGRA20_APB_DMA) += tegra20-apb-dma.o
> diff --git a/drivers/dma/stm32-dmamux.c b/drivers/dma/stm32-dmamux.c
> new file mode 100644
> index 0000000..22812e7
> --- /dev/null
> +++ b/drivers/dma/stm32-dmamux.c
> @@ -0,0 +1,327 @@
> +/*
> + *
> + * Copyright (C) STMicroelectronics SA 2017
> + * Author(s): M'boumba Cedric Madianga <cedric.madianga@gmail.com>
> + *            Pierre-Yves Mordret <pierre-yves.mordret@st.com>
> + *
> + * License terms: GPL V2.0.
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License version 2 as published by
> + * the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more
> + * details.
> + *
> + * DMA Router driver for STM32 DMA MUX
> + *
> + * Based on TI DMA Crossbar driver
> + *
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/err.h>
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/of_dma.h>
> +#include <linux/reset.h>
> +#include <linux/slab.h>
> +#include <linux/spinlock.h>
> +
> +#define STM32_DMAMUX_CCR(x)		(0x4 * (x))
> +#define STM32_DMAMUX_MAX_DMA_REQUESTS	32
> +#define STM32_DMAMUX_MAX_REQUESTS	255
> +
> +struct stm32_dmamux {
> +	u32 master;
> +	u32 request;
> +	u32 chan_id;
> +};
> +
> +struct stm32_dmamux_data {
> +	struct dma_router dmarouter;
> +	struct clk *clk;
> +	struct reset_control *rst;
> +	void __iomem *iomem;
> +	u32 dma_requests; /* Number of DMA requests connected to DMAMUX */
> +	u32 dmamux_requests; /* Number of DMA requests routed toward DMAs */
> +	spinlock_t lock; /* Protects register access */
> +	unsigned long *dma_inuse; /* Used DMA channel */
> +	u32 dma_reqs[]; /* Number of DMA Request per DMA masters.
> +			 *  [0] holds number of DMA Masters.
> +			 *  To be kept at very end end of this structure
> +			 */
> +};
> +
> +static inline u32 stm32_dmamux_read(void __iomem *iomem, u32 reg)
> +{
> +	return readl_relaxed(iomem + reg);
> +}
> +
> +static inline void stm32_dmamux_write(void __iomem *iomem, u32 reg, u32 val)
> +{
> +	writel_relaxed(val, iomem + reg);
> +}
> +
> +static void stm32_dmamux_free(struct device *dev, void *route_data)
> +{
> +	struct stm32_dmamux_data *dmamux = dev_get_drvdata(dev);
> +	struct stm32_dmamux *mux = route_data;
> +	unsigned long flags;
> +
> +	/* Clear dma request */
> +	spin_lock_irqsave(&dmamux->lock, flags);
> +
> +	stm32_dmamux_write(dmamux->iomem, STM32_DMAMUX_CCR(mux->chan_id), 0);
> +	clear_bit(mux->chan_id, dmamux->dma_inuse);
> +
> +	if (!IS_ERR(dmamux->clk))
> +		clk_disable(dmamux->clk);
> +
> +	spin_unlock_irqrestore(&dmamux->lock, flags);
> +
> +	dev_dbg(dev, "Unmapping DMAMUX(%u) to DMA%u(%u)\n",
> +		mux->request, mux->master, mux->chan_id);
> +
> +	kfree(mux);
> +}
> +
> +static void *stm32_dmamux_route_allocate(struct of_phandle_args *dma_spec,
> +					 struct of_dma *ofdma)
> +{
> +	struct platform_device *pdev = of_find_device_by_node(ofdma->of_node);
> +	struct stm32_dmamux_data *dmamux = platform_get_drvdata(pdev);
> +	struct stm32_dmamux *mux;
> +	u32 i, min, max;
> +	int ret;
> +	unsigned long flags;
> +
> +	if (dma_spec->args_count != 3) {
> +		dev_err(&pdev->dev, "invalid number of dma mux args\n");
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	if (dma_spec->args[0] > dmamux->dmamux_requests) {
> +		dev_err(&pdev->dev, "invalid mux request number: %d\n",
> +			dma_spec->args[0]);
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	mux = kzalloc(sizeof(*mux), GFP_KERNEL);
> +	if (!mux)
> +		return ERR_PTR(-ENOMEM);
> +
> +	spin_lock_irqsave(&dmamux->lock, flags);
> +	mux->chan_id = find_first_zero_bit(dmamux->dma_inuse,
> +					   dmamux->dma_requests);
> +	set_bit(mux->chan_id, dmamux->dma_inuse);
> +	spin_unlock_irqrestore(&dmamux->lock, flags);
> +
> +	if (mux->chan_id == dmamux->dma_requests) {
> +		dev_err(&pdev->dev, "Run out of free DMA requests\n");
> +		ret = -ENOMEM;
> +		goto error;
> +	}
> +
> +	/* Look for DMA Master */
> +	for (i = 1, min = 0, max = dmamux->dma_reqs[i];
> +	     i <= dmamux->dma_reqs[0];
> +	     min += dmamux->dma_reqs[i], max += dmamux->dma_reqs[++i])
> +		if (mux->chan_id < max)
> +			break;
> +	mux->master = i - 1;
> +
> +	/* The of_node_put() will be done in of_dma_router_xlate function */
> +	dma_spec->np = of_parse_phandle(ofdma->of_node, "dma-masters", i - 1);
> +	if (!dma_spec->np) {
> +		dev_err(&pdev->dev, "can't get dma master\n");
> +		ret = -EINVAL;
> +		goto error;
> +	}
> +
> +	/* Set dma request */
> +	spin_lock_irqsave(&dmamux->lock, flags);
> +	if (!IS_ERR(dmamux->clk)) {
> +		ret = clk_enable(dmamux->clk);
> +		if (ret < 0) {
> +			spin_unlock_irqrestore(&dmamux->lock, flags);
> +			dev_err(&pdev->dev, "clk_prep_enable issue: %d\n", ret);
> +			goto error;
> +		}
> +	}
> +	spin_unlock_irqrestore(&dmamux->lock, flags);
> +
> +	mux->request = dma_spec->args[0];
> +
> +	/*  craft DMA spec */
> +	dma_spec->args[3] = dma_spec->args[2];
> +	dma_spec->args[2] = dma_spec->args[1];
> +	dma_spec->args[1] = 0;
> +	dma_spec->args[0] = mux->chan_id - min;
> +	dma_spec->args_count = 4;
> +
> +	stm32_dmamux_write(dmamux->iomem, STM32_DMAMUX_CCR(mux->chan_id),
> +			   mux->request);
> +	dev_dbg(&pdev->dev, "Mapping DMAMUX(%u) to DMA%u(%u)\n",
> +		mux->request, mux->master, mux->chan_id);
> +
> +	return mux;
> +
> +error:
> +	clear_bit(mux->chan_id, dmamux->dma_inuse);
> +	kfree(mux);
> +	return ERR_PTR(ret);
> +}
> +
> +static const struct of_device_id stm32_stm32dma_master_match[] = {
> +	{ .compatible = "st,stm32-dma", },
> +	{},
> +};
> +
> +static int stm32_dmamux_probe(struct platform_device *pdev)
> +{
> +	struct device_node *node = pdev->dev.of_node;
> +	const struct of_device_id *match;
> +	struct device_node *dma_node;
> +	struct stm32_dmamux_data *stm32_dmamux;
> +	struct resource *res;
> +	void __iomem *iomem;
> +	int i, count, ret;
> +	u32 dma_req;
> +
> +	if (!node)
> +		return -ENODEV;
> +
> +	count = device_property_read_u32_array(&pdev->dev, "dma-masters",
> +					       NULL, 0);
> +	if (count < 0) {
> +		dev_err(&pdev->dev, "Can't get DMA master(s) node\n");
> +		return -ENODEV;
> +	}
> +
> +	stm32_dmamux = devm_kzalloc(&pdev->dev, sizeof(*stm32_dmamux) +
> +				    sizeof(u32) * (count + 1), GFP_KERNEL);
> +	if (!stm32_dmamux)
> +		return -ENOMEM;
> +
> +	dma_req = 0;
> +	for (i = 1; i <= count; i++) {
> +		dma_node = of_parse_phandle(node, "dma-masters", i - 1);
> +
> +		match = of_match_node(stm32_stm32dma_master_match, dma_node);
> +		if (!match) {
> +			dev_err(&pdev->dev, "DMA master is not supported\n");
> +			of_node_put(dma_node);
> +			return -EINVAL;
> +		}
> +
> +		if (of_property_read_u32(dma_node, "dma-requests",
> +					 &stm32_dmamux->dma_reqs[i])) {
> +			dev_info(&pdev->dev,
> +				 "Missing MUX output information, using %u.\n",
> +				 STM32_DMAMUX_MAX_DMA_REQUESTS);
> +			stm32_dmamux->dma_reqs[i] =
> +				STM32_DMAMUX_MAX_DMA_REQUESTS;
> +		}
> +		dma_req += stm32_dmamux->dma_reqs[i];
> +		of_node_put(dma_node);
> +	}
> +
> +	if (dma_req > STM32_DMAMUX_MAX_DMA_REQUESTS) {
> +		dev_err(&pdev->dev, "Too many DMA Master Requests to manage\n");
> +		return -ENODEV;
> +	}
> +
> +	stm32_dmamux->dma_requests = dma_req;
> +	stm32_dmamux->dma_reqs[0] = count;
> +	stm32_dmamux->dma_inuse = devm_kcalloc(&pdev->dev,
> +					       BITS_TO_LONGS(dma_req),
> +					       sizeof(unsigned long),
> +					       GFP_KERNEL);
> +	if (!stm32_dmamux->dma_inuse)
> +		return -ENOMEM;
> +
> +	if (device_property_read_u32(&pdev->dev, "dma-requests",
> +				     &stm32_dmamux->dmamux_requests)) {
> +		stm32_dmamux->dmamux_requests = STM32_DMAMUX_MAX_REQUESTS;
> +		dev_warn(&pdev->dev, "DMAMUX defaulting on %u requests\n",
> +			 stm32_dmamux->dmamux_requests);
> +	}
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res)
> +		return -ENODEV;
> +
> +	iomem = devm_ioremap_resource(&pdev->dev, res);
> +	if (!iomem)
> +		return -ENOMEM;
> +
> +	spin_lock_init(&stm32_dmamux->lock);
> +
> +	stm32_dmamux->clk = devm_clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(stm32_dmamux->clk)) {
> +		ret = PTR_ERR(stm32_dmamux->clk);
> +		if (ret == -EPROBE_DEFER)
> +			dev_info(&pdev->dev, "Missing controller clock\n");
> +		return ret;
> +	}
> +
> +	stm32_dmamux->rst = devm_reset_control_get(&pdev->dev, NULL);
> +	if (!IS_ERR(stm32_dmamux->rst)) {
> +		reset_control_assert(stm32_dmamux->rst);
> +		udelay(2);
> +		reset_control_deassert(stm32_dmamux->rst);
> +	}
> +
> +	stm32_dmamux->iomem = iomem;
> +	stm32_dmamux->dmarouter.dev = &pdev->dev;
> +	stm32_dmamux->dmarouter.route_free = stm32_dmamux_free;
> +
> +	platform_set_drvdata(pdev, stm32_dmamux);
> +
> +	if (!IS_ERR(stm32_dmamux->clk)) {
> +		ret = clk_prepare_enable(stm32_dmamux->clk);
> +		if (ret < 0) {
> +			dev_err(&pdev->dev, "clk_prep_enable error: %d\n", ret);
> +			return ret;
> +		}
> +	}
> +
> +	/* Reset the dmamux */
> +	for (i = 0; i < stm32_dmamux->dma_requests; i++)
> +		stm32_dmamux_write(stm32_dmamux->iomem, STM32_DMAMUX_CCR(i), 0);
> +
> +	if (!IS_ERR(stm32_dmamux->clk))
> +		clk_disable(stm32_dmamux->clk);
> +
> +	return of_dma_router_register(node, stm32_dmamux_route_allocate,
> +				     &stm32_dmamux->dmarouter);
> +}
> +
> +static const struct of_device_id stm32_dmamux_match[] = {
> +	{ .compatible = "st,stm32h7-dmamux" },
> +	{},
> +};
> +
> +static struct platform_driver stm32_dmamux_driver = {
> +	.probe	= stm32_dmamux_probe,
> +	.driver = {
> +		.name = "stm32-dmamux",
> +		.of_match_table = stm32_dmamux_match,
> +	},
> +};
> +
> +static int __init stm32_dmamux_init(void)
> +{
> +	return platform_driver_register(&stm32_dmamux_driver);
> +}
> +arch_initcall(stm32_dmamux_init);
> +
> +MODULE_DESCRIPTION("DMA Router driver for STM32 DMA MUX");
> +MODULE_AUTHOR("M'boumba Cedric Madianga <cedric.madianga@gmail.com>");
> +MODULE_AUTHOR("Pierre-Yves Mordret <pierre-yves.mordret@st.com>");
> +MODULE_LICENSE("GPL v2");
