From: jonsmirl@gmail.com (jonsmirl at gmail.com)
Date: Tue, 8 Jul 2014 15:09:14 -0400
Subject: [PATCH v2 1/8] dma: sun4i: Add support for the DMA engine on
 sun[457]i SoCs
In-Reply-To: <1404619518-7592-2-git-send-email-emilio@elopez.com.ar>
References: <1404619518-7592-1-git-send-email-emilio@elopez.com.ar>
 <1404619518-7592-2-git-send-email-emilio@elopez.com.ar>
Message-ID: <CAKON4Ow4qNrOoHAiT3E62D4Tw3kKe7FNmXEP=OO+qfxdU8mFmQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 6, 2014 at 12:05 AM, Emilio L?pez <emilio@elopez.com.ar> wrote:
> This patch adds support for the DMA engine present on Allwinner A10,

ALSA only programs in the destination bus width and burst. So the
source buswidth is DMA_SLAVE_BUSWIDTH_UNDEFINED = 0.

In this driver that results in the source buswidth being set to 8 and
burst set to 1 for the source which disagree with what the Allwinner
code does. To agree with the Allwinner code
DMA_SLAVE_BUSWIDTH_UNDEFINED should cause the dest width/burst to get
copied to the src width/burst.

void snd_dmaengine_pcm_set_config_from_dai_data(
const struct snd_pcm_substream *substream,
const struct snd_dmaengine_dai_dma_data *dma_data,
struct dma_slave_config *slave_config)
{
if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
slave_config->dst_addr = dma_data->addr;
slave_config->dst_maxburst = dma_data->maxburst;
if (dma_data->addr_width != DMA_SLAVE_BUSWIDTH_UNDEFINED)
slave_config->dst_addr_width = dma_data->addr_width;
} else {
slave_config->src_addr = dma_data->addr;
slave_config->src_maxburst = dma_data->maxburst;
if (dma_data->addr_width != DMA_SLAVE_BUSWIDTH_UNDEFINED)
slave_config->src_addr_width = dma_data->addr_width;
}

slave_config->slave_id = dma_data->slave_id;
}
EXPORT_SYMBOL_GPL(snd_dmaengine_pcm_set_config_from_dai_data);
