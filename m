From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 4 Mar 2013 16:37:28 +0800
Subject: [PATCH 09/12] ASoC: dmaengine_pcm: support use of generic DMA
 helper
In-Reply-To: <201302272102.40811.arnd@arndb.de>
References: <1361978748-25281-1-git-send-email-shawn.guo@linaro.org>
 <1361978748-25281-10-git-send-email-shawn.guo@linaro.org>
 <201302272102.40811.arnd@arndb.de>
Message-ID: <20130304083726.GA30198@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 27, 2013 at 09:02:40PM +0000, Arnd Bergmann wrote:
> On Wednesday 27 February 2013, Shawn Guo wrote:
> > With generic DMA device tree binding and helper function
> > dma_request_slave_channel() in place, dmaengine_pcm should support
> > that in requesting DMA channel for users that support generic DMA
> > device tree binding.
> > 
> > Instead of inventing a new API, it defines the parameters needed by
> > dma_request_slave_channel() into struct snd_dma_channel_params,
> > interprets filter_data into snd_dma_channel_params, and calls the
> > helper in case that dmaengine_pcm users pass in a NULL filter_fn.
> > 
> > Then, dmaengine_pcm users can call snd_dmaengine_pcm_open() with NULL
> > filter_fn and snd_dma_channel_params being filter_data to direct the
> > API to request DMA channel using generic DMA helper.
> > 
> > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> > Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
> > Cc: alsa-devel at alsa-project.org
> 
> I would actually prefer having a new API in the soc-dmaengine-pcm
> module, like
> 
> static int dmaengine_pcm_request_slave_channel(struct dmaengine_pcm_runtime_data *prtd,
> 						struct device *dev, const char *id);
> 
> For sound drivers that are fully converted to using DT, it would be
> a more natural interface to use IMHO.

Just to be clear, if we choose to have a new API, it's not the above
one but something like 

int snd_dmaengine_generic_pcm_open(struct snd_pcm_substream *substream,
                                   struct device *dev, const char *id)

as snd_dmaengine_pcm_open() is the interface to soc-dmaengine-pcm
clients, not dmaengine_pcm_request_channel().

Shawn
