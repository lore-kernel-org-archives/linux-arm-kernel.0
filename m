From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 26 Jul 2013 13:58:21 -0600
Subject: [PATCH 7/9] ASoC: tegra: move to generic DMA DT binding
In-Reply-To: <1374639002-16753-8-git-send-email-rizhao@nvidia.com>
References: <1374639002-16753-1-git-send-email-rizhao@nvidia.com>
 <1374639002-16753-8-git-send-email-rizhao@nvidia.com>
Message-ID: <51F2D4DD.9060308@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/23/2013 10:10 PM, Richard Zhao wrote:
> - add tegra_dma_filter_data to specify dma info
>   DMA DT binding needs the device that raise dma request and dma name
>   to request a dma channel. tegra30_i2s is a special case. It should be ahub
>   device and it also has dma name that cannot handled by ASoC dmaengine code.
>   So we pass the info using filter data in snd_dmaengine_dai_dma_data.
> - change i2s/ac97 drivers to use generic DT binding
> - tegra30_i2s: alloc ahub tx/rx fifo at driver probe time

> diff --git a/sound/soc/tegra/tegra30_i2s.c b/sound/soc/tegra/tegra30_i2s.c

I don't understand why the FIFO alloc/free had to move from
startup()/shutdown() to probe()/remove(). This will prevent later
changes from making the connectivity between the AHUB FIFOs and I2S
modules more dynamic, which is kind of the whole point of the AHUB HW
module.

> diff --git a/sound/soc/tegra/tegra_pcm.h b/sound/soc/tegra/tegra_pcm.h

> +#define TEGRA_DMA_NAME_MAX_LEN	10
> +
> +/*
> + * Generic DMA DT binding needs the device that raise dma request and dma name
> + * to request a dma channel. tegra30_i2s is a special case. It should be ahub
> + * device and it also has dma name that cannot handled by ASoC dmaengine code.
> + * So we pass the info using filter data in snd_dmaengine_dai_dma_data.
> + */
> +struct tegra_dma_filter_data {
> +	struct device *dma_dev;
> +	char dma_name[TEGRA_DMA_NAME_MAX_LEN];
> +};

I agree with Lars-Peter's comment that it'd be better to enhance the
ASoC dmaengine support to allow the channel name to be specified so we
don't need to much custom code. And that should use "char *" not a
fixed-length array.
