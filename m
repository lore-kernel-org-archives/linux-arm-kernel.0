From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 8 Jul 2011 18:19:18 +0200
Subject: [PATCH 02/10] ASoc: mxs: add mxs-saif driver
In-Reply-To: <1310140790-2132-3-git-send-email-b29396@freescale.com>
References: <1310140790-2132-1-git-send-email-b29396@freescale.com>
	<1310140790-2132-3-git-send-email-b29396@freescale.com>
Message-ID: <20110708161918.GJ6069@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 08, 2011 at 11:59:42PM +0800, Dong Aisheng wrote:
> Signed-off-by: Dong Aisheng <b29396@freescale.com>
> ---
>  sound/soc/mxs/mxs-saif.c |  524 ++++++++++++++++++++++++++++++++++++++++++++++
>  sound/soc/mxs/mxs-saif.h |  124 +++++++++++
>  2 files changed, 648 insertions(+), 0 deletions(-)
> 
> diff --git a/sound/soc/mxs/mxs-saif.c b/sound/soc/mxs/mxs-saif.c
> new file mode 100644
> index 0000000..afc6e57
> --- /dev/null
> +++ b/sound/soc/mxs/mxs-saif.c
> @@ -0,0 +1,524 @@
> +/*
> + * Copyright 2011 Freescale Semiconductor, Inc.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License along
> + * with this program; if not, write to the Free Software Foundation, Inc.,
> + * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <sound/core.h>
> +#include <sound/pcm.h>
> +#include <sound/pcm_params.h>
> +#include <sound/soc.h>
> +#include <mach/dma.h>
> +#include <asm/mach-types.h>
> +#include <mach/hardware.h>
> +#include <mach/mx28.h>

Is this include really needed?

> +
> +#include "mxs-saif.h"
> +
> +/*
> +* SAIF system clock configuration.
> +* Should only be called when port is inactive.
> +*/
> +static int mxs_saif_set_dai_sysclk(struct snd_soc_dai *cpu_dai,
> +			int clk_id, unsigned int freq, int dir)
> +{
> +	struct mxs_saif *saif = snd_soc_dai_get_drvdata(cpu_dai);
> +
> +	switch (clk_id) {
> +	case MXS_SAIF_SYS_CLK:
> +		clk_set_rate(saif->clk, freq);
> +		clk_enable(saif->clk);

This clk_enable is unbalanced. You enabled the clock in probe() already.

> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +	return 0;
> +}
> +
> +/*
> + * SAIF Clock dividers
> + * Should only be called when port is inactive.
> + */
> +static int mxs_saif_set_dai_clkdiv(struct snd_soc_dai *cpu_dai,
> +				  int div_id, int div)
> +{
> +	u32 scr;
> +	struct mxs_saif *saif = snd_soc_dai_get_drvdata(cpu_dai);
> +
> +	scr = __raw_readl(saif->base + SAIF_CTRL);
> +	scr &= ~BM_SAIF_CTRL_BITCLK_MULT_RATE;
> +	scr &= ~BM_SAIF_CTRL_BITCLK_BASE_RATE;
> +
> +	switch (div_id) {
> +	case MXS_SAIF_MCLK:
> +		switch (div) {
> +		case 32:
> +			scr |= BF_SAIF_CTRL_BITCLK_MULT_RATE(4);
> +			scr &= ~BM_SAIF_CTRL_BITCLK_BASE_RATE;
> +			break;
> +		case 64:
> +			scr |= BF_SAIF_CTRL_BITCLK_MULT_RATE(3);
> +			scr &= ~BM_SAIF_CTRL_BITCLK_BASE_RATE;
> +			break;
> +		case 128:
> +			scr |= BF_SAIF_CTRL_BITCLK_MULT_RATE(2);
> +			scr &= ~BM_SAIF_CTRL_BITCLK_BASE_RATE;
> +			break;
> +		case 256:
> +			scr |= BF_SAIF_CTRL_BITCLK_MULT_RATE(1);
> +			scr &= ~BM_SAIF_CTRL_BITCLK_BASE_RATE;
> +			break;
> +		case 512:
> +			scr |= BF_SAIF_CTRL_BITCLK_MULT_RATE(0);
> +			scr &= ~BM_SAIF_CTRL_BITCLK_BASE_RATE;
> +			break;
> +		case 48:
> +			scr |= BF_SAIF_CTRL_BITCLK_MULT_RATE(3);
> +			scr |= BM_SAIF_CTRL_BITCLK_BASE_RATE;
> +			break;
> +		case 96:
> +			scr |= BF_SAIF_CTRL_BITCLK_MULT_RATE(2);
> +			scr |= BM_SAIF_CTRL_BITCLK_BASE_RATE;
> +			break;
> +		case 192:
> +			scr |= BF_SAIF_CTRL_BITCLK_MULT_RATE(1);
> +			scr |= BM_SAIF_CTRL_BITCLK_BASE_RATE;
> +			break;
> +		case 384:
> +			scr |= BF_SAIF_CTRL_BITCLK_MULT_RATE(0);
> +			scr |= BM_SAIF_CTRL_BITCLK_BASE_RATE;
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	__raw_writel(scr, saif->base + SAIF_CTRL);
> +
> +	return 0;
> +}
> +
> +/*
> + * SAIF DAI format configuration.
> + * Should only be called when port is inactive.
> + * Note: We don't use the I2S modes but instead manually configure the
> + * SAIF for I2S.
> + */
> +static int mxs_saif_set_dai_fmt(struct snd_soc_dai *cpu_dai, unsigned int fmt)
> +{
> +	u32 scr, stat;
> +	u32 scr0;
> +	struct mxs_saif *saif = snd_soc_dai_get_drvdata(cpu_dai);
> +
> +	stat = __raw_readl(saif->base + SAIF_STAT);
> +	if (stat & BM_SAIF_STAT_BUSY)
> +		return 0;

Returning succesfully doesn't seem right here.

> +
> +	scr0 = __raw_readl(saif->base + SAIF_CTRL);
> +	scr0 = scr0 & ~BM_SAIF_CTRL_BITCLK_EDGE & ~BM_SAIF_CTRL_LRCLK_POLARITY \
> +		& ~BM_SAIF_CTRL_JUSTIFY & ~BM_SAIF_CTRL_DELAY;
> +	scr = 0;
> +
> +	/* DAI mode */
> +	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
> +	case SND_SOC_DAIFMT_I2S:
> +		/* data frame low 1clk before data */
> +		scr |= BM_SAIF_CTRL_DELAY;
> +		scr &= ~BM_SAIF_CTRL_LRCLK_POLARITY;
> +		break;
> +	case SND_SOC_DAIFMT_LEFT_J:
> +		/* data frame high with data */
> +		scr &= ~BM_SAIF_CTRL_DELAY;
> +		scr &= ~BM_SAIF_CTRL_LRCLK_POLARITY;
> +		scr &= ~BM_SAIF_CTRL_JUSTIFY;
> +		break;

	default:
		return -EINVAL;

> +	}
> +
> +	/* DAI clock inversion */
> +	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
> +	case SND_SOC_DAIFMT_IB_IF:
> +		scr |= BM_SAIF_CTRL_BITCLK_EDGE;
> +		scr |= BM_SAIF_CTRL_LRCLK_POLARITY;
> +		break;
> +	case SND_SOC_DAIFMT_IB_NF:
> +		scr |= BM_SAIF_CTRL_BITCLK_EDGE;
> +		scr &= ~BM_SAIF_CTRL_LRCLK_POLARITY;
> +		break;
> +	case SND_SOC_DAIFMT_NB_IF:
> +		scr &= ~BM_SAIF_CTRL_BITCLK_EDGE;
> +		scr |= BM_SAIF_CTRL_LRCLK_POLARITY;
> +		break;
> +	case SND_SOC_DAIFMT_NB_NF:
> +		scr &= ~BM_SAIF_CTRL_BITCLK_EDGE;
> +		scr &= ~BM_SAIF_CTRL_LRCLK_POLARITY;
> +		break;
> +	}

A question more for Liam and Mark: Would it make sense to add individual
masks for the clock inversion and frame sync inversion? I code like the
above in every driver, and I think this could become simpler.


> +
> +	/*
> +	 * Note: We simply just support master mode since SAIF TX only supports
> +	 * master mode.
> +	 */

When this is true...

> +	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
> +	case SND_SOC_DAIFMT_CBS_CFS:
> +		scr &= ~BM_SAIF_CTRL_SLAVE_MODE;
> +		__raw_writel(scr | scr0, saif->base + SAIF_CTRL);
> +		break;
> +	case SND_SOC_DAIFMT_CBM_CFS:
> +		break;
> +	case SND_SOC_DAIFMT_CBS_CFM:
> +		break;

You should return an error here.

> +	case SND_SOC_DAIFMT_CBM_CFM:
> +		return -EINVAL;
> +		break;
> +	}
> +
> +	return 0;
> +}
> +
> +static int mxs_saif_startup(struct snd_pcm_substream *substream,
> +			   struct snd_soc_dai *cpu_dai)
> +{
> +	struct mxs_saif *saif = snd_soc_dai_get_drvdata(cpu_dai);
> +	snd_soc_dai_set_dma_data(cpu_dai, substream, &saif->dma_param);
> +
> +	return 0;
> +}
> +
> +/*
> + * Should only be called when port is inactive.
> + * although can be called multiple times by upper layers.
> + */
> +static int mxs_saif_hw_params(struct snd_pcm_substream *substream,
> +			     struct snd_pcm_hw_params *params,
> +			     struct snd_soc_dai *cpu_dai)
> +{
> +	struct mxs_saif *saif = snd_soc_dai_get_drvdata(cpu_dai);
> +	u32 scr;
> +
> +	scr = __raw_readl(saif->base + SAIF_CTRL);
> +
> +	/* cant change any parameters when SAIF is running */
> +	/* DAI data (word) size */
> +	scr &= ~BM_SAIF_CTRL_WORD_LENGTH;
> +	scr &= ~BM_SAIF_CTRL_BITCLK_48XFS_ENABLE;
> +	switch (params_format(params)) {
> +	case SNDRV_PCM_FORMAT_S16_LE:
> +		scr |= BF_SAIF_CTRL_WORD_LENGTH(0);
> +		break;
> +	case SNDRV_PCM_FORMAT_S20_3LE:
> +		scr |= BF_SAIF_CTRL_WORD_LENGTH(4);
> +		scr |= BM_SAIF_CTRL_BITCLK_48XFS_ENABLE;
> +		break;
> +	case SNDRV_PCM_FORMAT_S24_LE:
> +		scr |= BF_SAIF_CTRL_WORD_LENGTH(8);
> +		scr |= BM_SAIF_CTRL_BITCLK_48XFS_ENABLE;
> +		break;

	default:
		return -EINVAL;

> +	}
> +
> +	/* Tx/Rx config */
> +	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
> +		/* enable TX mode */
> +		scr &= ~BM_SAIF_CTRL_READ_MODE;
> +	} else {
> +		/* enable RX mode */
> +		scr |= BM_SAIF_CTRL_READ_MODE;
> +	}
> +
> +	__raw_writel(scr, saif->base + SAIF_CTRL);
> +	return 0;
> +}
> +
> +static int mxs_saif_prepare(struct snd_pcm_substream *substream,
> +			   struct snd_soc_dai *cpu_dai)
> +{
> +	struct mxs_saif *saif = snd_soc_dai_get_drvdata(cpu_dai);
> +	__raw_writel(BM_SAIF_CTRL_CLKGATE,
> +		saif->base + SAIF_CTRL + MXS_CLR_ADDR);
> +
> +	return 0;
> +}
> +
> +static int mxs_saif_trigger(struct snd_pcm_substream *substream, int cmd,
> +				struct snd_soc_dai *cpu_dai)
> +{
> +	struct mxs_saif *saif = snd_soc_dai_get_drvdata(cpu_dai);
> +
> +	switch (cmd) {
> +	case SNDRV_PCM_TRIGGER_START:
> +	case SNDRV_PCM_TRIGGER_RESUME:
> +	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
> +		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
> +			/*write a data to saif data register to trigger
> +				the transfer*/

/* multiline comments
 * like this please
 */

> +			__raw_writel(0, saif->base + SAIF_DATA);
> +		else
> +			/*read a data from saif data register to trigger
> +				the receive*/
> +			__raw_readl(saif->base + SAIF_DATA);
> +		break;
> +	case SNDRV_PCM_TRIGGER_SUSPEND:
> +	case SNDRV_PCM_TRIGGER_STOP:
> +	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +#define MXS_SAIF_RATES		SNDRV_PCM_RATE_8000_192000
> +#define MXS_SAIF_FORMATS \
> +	(SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S20_3LE | \
> +	SNDRV_PCM_FMTBIT_S24_LE)
> +
> +static struct snd_soc_dai_ops mxs_saif_dai_ops = {
> +	.startup = mxs_saif_startup,
> +	.trigger = mxs_saif_trigger,
> +	.prepare = mxs_saif_prepare,
> +	.hw_params = mxs_saif_hw_params,
> +	.set_sysclk = mxs_saif_set_dai_sysclk,
> +	.set_clkdiv = mxs_saif_set_dai_clkdiv,
> +	.set_fmt = mxs_saif_set_dai_fmt,
> +};
> +
> +static int mxs_saif_dai_probe(struct snd_soc_dai *dai)
> +{
> +	struct mxs_saif *saif = dev_get_drvdata(dai->dev);
> +
> +	snd_soc_dai_set_drvdata(dai, saif);
> +
> +	/* Reset */
> +	__raw_writel(BM_SAIF_CTRL_SFTRST,
> +		saif->base + SAIF_CTRL + MXS_CLR_ADDR);
> +
> +	/* enable MCLK output early since codec may need it */
> +	__raw_writel(BM_SAIF_CTRL_CLKGATE,
> +		saif->base + SAIF_CTRL + MXS_CLR_ADDR);
> +	__raw_writel(BM_SAIF_CTRL_RUN,
> +		saif->base + SAIF_CTRL + MXS_SET_ADDR);
> +
> +	return 0;
> +}
> +
> +static struct snd_soc_dai_driver mxs_saif_dai = {
> +	.name = "mxs-saif",
> +	.probe = mxs_saif_dai_probe,
> +	.playback = {
> +		.channels_min = 2,
> +		.channels_max = 2,
> +		.rates = MXS_SAIF_RATES,
> +		.formats = MXS_SAIF_FORMATS,
> +	},
> +	.capture = {
> +		.channels_min = 2,
> +		.channels_max = 2,
> +		.rates = MXS_SAIF_RATES,
> +		.formats = MXS_SAIF_FORMATS,
> +	},
> +	.ops = &mxs_saif_dai_ops,
> +};
> +
> +static irqreturn_t mxs_saif_irq(int irq, void *dev_id)
> +{
> +	struct mxs_saif *saif = dev_id;
> +
> +	if (saif->fifo_err_counter++ % 100 == 0)
> +		printk(KERN_ERR "saif_irq SAIF_STAT %x SAIF_CTRL %x \
> +			fifo_errs=%d \n",
> +		       __raw_readl(saif->base + SAIF_STAT),
> +		       __raw_readl(saif->base + SAIF_CTRL),
> +		       saif->fifo_err_counter);
> +	__raw_writel(BM_SAIF_STAT_FIFO_UNDERFLOW_IRQ |
> +			BM_SAIF_STAT_FIFO_OVERFLOW_IRQ,
> +			saif->base + SAIF_STAT + MXS_CLR_ADDR);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int mxs_saif_probe(struct platform_device *pdev)
> +{
> +	struct resource *res;
> +	struct mxs_saif *saif;
> +	int ret = 0;
> +
> +	saif = kzalloc(sizeof(*saif), GFP_KERNEL);
> +	if (!saif)
> +		return -ENOMEM;

Consider using devm_kzalloc and friends, it makes the error path less
error prone.

> +
> +	saif->irq = platform_get_irq(pdev, 0);
> +	if (saif->irq < 0) {
> +		ret = saif->irq;
> +		dev_err(&pdev->dev, "failed to get irq resource: %d\n",
> +			ret);
> +		goto failed_get_irq1;
> +	}
> +
> +	saif->fifo_err_counter = 0;
> +	ret = request_irq(saif->irq, mxs_saif_irq, 0, "mxs-saif", saif);
> +	if (ret) {
> +		dev_err(&pdev->dev, "failed to request irq\n");
> +		goto failed_req_irq;
> +	}
> +
> +	saif->dma_param.chan_irq = platform_get_irq(pdev, 1);
> +	if (saif->dma_param.chan_irq < 0) {
> +		ret = saif->dma_param.chan_irq;
> +		dev_err(&pdev->dev, "failed to get dma irq resource: %d\n",
> +			ret);
> +		goto failed_get_irq2;
> +	}
> +
> +	saif->clk = clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(saif->clk)) {
> +		ret = PTR_ERR(saif->clk);
> +		dev_err(&pdev->dev, "Cannot get the clock: %d\n",
> +			ret);
> +		goto failed_clk;
> +	}
> +	clk_set_rate(saif->clk, 12000000);
> +	clk_enable(saif->clk);
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res) {
> +		ret = -ENODEV;
> +		dev_err(&pdev->dev, "failed to get io resource: %d\n",
> +			ret);
> +		goto failed_get_resource;
> +	}
> +
> +	if (!request_mem_region(res->start, resource_size(res), "mxs-saif")) {
> +		dev_err(&pdev->dev, "request_mem_region failed\n");
> +		ret = -EBUSY;
> +		goto failed_get_resource;
> +	}
> +
> +	saif->base = ioremap(res->start, resource_size(res));
> +	if (!saif->base) {
> +		dev_err(&pdev->dev, "ioremap failed\n");
> +		ret = -ENODEV;
> +		goto failed_ioremap;
> +	}
> +
> +	res = platform_get_resource(pdev, IORESOURCE_DMA, 0);
> +	if (!res) {
> +		ret = -ENODEV;
> +		dev_err(&pdev->dev, "failed to get dma resource: %d\n",
> +			ret);
> +		goto failed_get_resource;
> +	}
> +	saif->dma_param.chan_num = res->start;
> +
> +	platform_set_drvdata(pdev, saif);
> +
> +	ret = snd_soc_register_dai(&pdev->dev, &mxs_saif_dai);
> +	if (ret) {
> +		dev_err(&pdev->dev, "register DAI failed\n");
> +		goto failed_register;
> +	}
> +
> +	saif->soc_platform_pdev = platform_device_alloc(
> +					"mxs-pcm-audio", pdev->id);
> +	if (!saif->soc_platform_pdev) {
> +		ret = -ENOMEM;
> +		goto failed_pdev_alloc;
> +	}
> +
> +	platform_set_drvdata(saif->soc_platform_pdev, saif);
> +	ret = platform_device_add(saif->soc_platform_pdev);
> +	if (ret) {
> +		dev_err(&pdev->dev, "failed to add soc platform device\n");
> +		goto failed_pdev_add;
> +	}
> +
> +	return 0;
> +
> +failed_pdev_add:
> +	platform_device_put(saif->soc_platform_pdev);
> +failed_pdev_alloc:
> +	snd_soc_unregister_dai(&pdev->dev);
> +failed_register:
> +	iounmap(saif->base);
> +failed_ioremap:
> +	release_mem_region(res->start, resource_size(res));
> +failed_get_resource:
> +	clk_disable(saif->clk);
> +	clk_put(saif->clk);
> +failed_clk:
> +failed_get_irq2:
> +	free_irq(saif->irq, saif);
> +failed_req_irq:
> +failed_get_irq1:
> +	kfree(saif);
> +
> +	return ret;
> +}
> +
> +static int __devexit mxs_saif_remove(struct platform_device *pdev)
> +{
> +	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	struct mxs_saif *saif = platform_get_drvdata(pdev);
> +
> +	platform_device_unregister(saif->soc_platform_pdev);
> +
> +	snd_soc_unregister_dai(&pdev->dev);
> +
> +	iounmap(saif->base);
> +	release_mem_region(res->start, resource_size(res));
> +	free_irq(saif->irq, saif);
> +
> +	clk_disable(saif->clk);
> +	clk_put(saif->clk);
> +
> +	kfree(saif);
> +
> +	return 0;
> +}
> +
> +static struct platform_driver mxs_saif_driver = {
> +	.probe = mxs_saif_probe,
> +	.remove = __devexit_p(mxs_saif_remove),
> +
> +	.driver = {
> +		.name = "mxs-saif",
> +		.owner = THIS_MODULE,
> +	},
> +};
> +
> +static int __init mxs_saif_init(void)
> +{
> +	return platform_driver_register(&mxs_saif_driver);
> +}
> +
> +static void __exit mxs_saif_exit(void)
> +{
> +	platform_driver_unregister(&mxs_saif_driver);
> +}
> +
> +module_init(mxs_saif_init);
> +module_exit(mxs_saif_exit);
> +MODULE_AUTHOR("Freescale Semiconductor, Inc.");
> +MODULE_DESCRIPTION("MXS ASoC SAIF driver");
> +MODULE_LICENSE("GPL");
> diff --git a/sound/soc/mxs/mxs-saif.h b/sound/soc/mxs/mxs-saif.h
> new file mode 100644
> index 0000000..dd26b37
> --- /dev/null
> +++ b/sound/soc/mxs/mxs-saif.h
> @@ -0,0 +1,124 @@
> +/*
> + * Copyright (C) 2011 Freescale Semiconductor, Inc. All Rights Reserved.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License along
> + * with this program; if not, write to the Free Software Foundation, Inc.,
> + * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> + */
> +
> +
> +#ifndef _MXS_SAIF_H
> +#define _MXS_SAIF_H
> +
> +#define SAIF_CTRL	0x0
> +#define SAIF_STAT	0x10
> +#define SAIF_DATA	0x20
> +#define SAIF_VERSION	0X30
> +
> +/* SAIF_CTRL */
> +#define BM_SAIF_CTRL_SFTRST		0x80000000
> +#define BM_SAIF_CTRL_CLKGATE		0x40000000
> +#define BP_SAIF_CTRL_BITCLK_MULT_RATE	27
> +#define BM_SAIF_CTRL_BITCLK_MULT_RATE	0x38000000
> +#define BF_SAIF_CTRL_BITCLK_MULT_RATE(v) \
> +		(((v) << 27) & BM_SAIF_CTRL_BITCLK_MULT_RATE)
> +#define BM_SAIF_CTRL_BITCLK_BASE_RATE	0x04000000
> +#define BM_SAIF_CTRL_FIFO_ERROR_IRQ_EN	0x02000000
> +#define BM_SAIF_CTRL_FIFO_SERVICE_IRQ_EN	0x01000000
> +#define BP_SAIF_CTRL_RSRVD2		21
> +#define BM_SAIF_CTRL_RSRVD2		0x00E00000
> +
> +#define BP_SAIF_CTRL_DMAWAIT_COUNT	16
> +#define BM_SAIF_CTRL_DMAWAIT_COUNT	0x001F0000
> +#define BF_SAIF_CTRL_DMAWAIT_COUNT(v) \
> +		(((v) << 16) & BM_SAIF_CTRL_DMAWAIT_COUNT)
> +#define BP_SAIF_CTRL_CHANNEL_NUM_SELECT 14
> +#define BM_SAIF_CTRL_CHANNEL_NUM_SELECT 0x0000C000
> +#define BF_SAIF_CTRL_CHANNEL_NUM_SELECT(v) \
> +		(((v) << 14) & BM_SAIF_CTRL_CHANNEL_NUM_SELECT)
> +#define BM_SAIF_CTRL_LRCLK_PULSE	0x00002000
> +#define BM_SAIF_CTRL_BIT_ORDER		0x00001000
> +#define BM_SAIF_CTRL_DELAY		0x00000800
> +#define BM_SAIF_CTRL_JUSTIFY		0x00000400
> +#define BM_SAIF_CTRL_LRCLK_POLARITY	0x00000200
> +#define BM_SAIF_CTRL_BITCLK_EDGE	0x00000100
> +#define BP_SAIF_CTRL_WORD_LENGTH	4
> +#define BM_SAIF_CTRL_WORD_LENGTH	0x000000F0
> +#define BF_SAIF_CTRL_WORD_LENGTH(v) \
> +		(((v) << 4) & BM_SAIF_CTRL_WORD_LENGTH)
> +#define BM_SAIF_CTRL_BITCLK_48XFS_ENABLE	0x00000008
> +#define BM_SAIF_CTRL_SLAVE_MODE		0x00000004
> +#define BM_SAIF_CTRL_READ_MODE		0x00000002
> +#define BM_SAIF_CTRL_RUN		0x00000001
> +
> +/* SAIF_STAT */
> +#define BM_SAIF_STAT_PRESENT		0x80000000
> +#define BP_SAIF_STAT_RSRVD2		17
> +#define BM_SAIF_STAT_RSRVD2		0x7FFE0000
> +#define BF_SAIF_STAT_RSRVD2(v) \
> +		(((v) << 17) & BM_SAIF_STAT_RSRVD2)
> +#define BM_SAIF_STAT_DMA_PREQ		0x00010000
> +#define BP_SAIF_STAT_RSRVD1		7
> +#define BM_SAIF_STAT_RSRVD1		0x0000FF80
> +#define BF_SAIF_STAT_RSRVD1(v) \
> +		(((v) << 7) & BM_SAIF_STAT_RSRVD1)
> +
> +#define BM_SAIF_STAT_FIFO_UNDERFLOW_IRQ 0x00000040
> +#define BM_SAIF_STAT_FIFO_OVERFLOW_IRQ	0x00000020
> +#define BM_SAIF_STAT_FIFO_SERVICE_IRQ	0x00000010
> +#define BP_SAIF_STAT_RSRVD0		1
> +#define BM_SAIF_STAT_RSRVD0		0x0000000E
> +#define BF_SAIF_STAT_RSRVD0(v) \
> +		(((v) << 1) & BM_SAIF_STAT_RSRVD0)
> +#define BM_SAIF_STAT_BUSY		0x00000001
> +
> +/* SAFI_DATA */
> +#define BP_SAIF_DATA_PCM_RIGHT		16
> +#define BM_SAIF_DATA_PCM_RIGHT		0xFFFF0000
> +#define BF_SAIF_DATA_PCM_RIGHT(v) \
> +		(((v) << 16) & BM_SAIF_DATA_PCM_RIGHT)
> +#define BP_SAIF_DATA_PCM_LEFT		0
> +#define BM_SAIF_DATA_PCM_LEFT		0x0000FFFF
> +#define BF_SAIF_DATA_PCM_LEFT(v)	\
> +		(((v) << 0) & BM_SAIF_DATA_PCM_LEFT)
> +
> +/* SAIF_VERSION */
> +#define BP_SAIF_VERSION_MAJOR		24
> +#define BM_SAIF_VERSION_MAJOR		0xFF000000
> +#define BF_SAIF_VERSION_MAJOR(v) \
> +		(((v) << 24) & BM_SAIF_VERSION_MAJOR)
> +#define BP_SAIF_VERSION_MINOR		16
> +#define BM_SAIF_VERSION_MINOR		0x00FF0000
> +#define BF_SAIF_VERSION_MINOR(v) \
> +		(((v) << 16) & BM_SAIF_VERSION_MINOR)
> +#define BP_SAIF_VERSION_STEP		0
> +#define BM_SAIF_VERSION_STEP		0x0000FFFF
> +#define BF_SAIF_VERSION_STEP(v) \
> +		(((v) << 0) & BM_SAIF_VERSION_STEP)
> +
> +#define MXS_SAIF_SYS_CLK	0
> +#define MXS_SAIF_MCLK		1
> +
> +#include "mxs-pcm.h"
> +
> +struct mxs_saif {
> +	struct clk *clk;
> +	void __iomem *base;
> +	int irq;
> +	struct mxs_pcm_dma_params dma_param;
> +
> +	struct platform_device *soc_platform_pdev;
> +	u32 fifo_err_counter;
> +};
> +
> +#endif
> -- 
> 1.7.0.4
> 
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
