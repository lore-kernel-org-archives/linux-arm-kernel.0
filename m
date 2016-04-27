From: kernel@martin.sperl.org (Martin Sperl)
Date: Wed, 27 Apr 2016 16:33:14 +0200
Subject: [PATCH 2/2] ASoC: bcm2835: Add S16_LE support via packed DMA
 transfers
In-Reply-To: <1461763613-28714-2-git-send-email-hias@horus.com>
References: <1461763613-28714-1-git-send-email-hias@horus.com>
 <1461763613-28714-2-git-send-email-hias@horus.com>
Message-ID: <46CBACB0-97C6-4C41-A8A2-85176794FC91@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> On 27.04.2016, at 15:26, Matthias Reichl <hias@horus.com> wrote:
> 
> The bcm2835-i2s driver already has support for the S16_LE format but
> that format hasn't been made available because dmaengine_pcm didn't
> support packed data transfers.
> 
> bcm2835-i2s needs 16-bit left+right channel data to be packed into
> a 32-bit word, the FIFO register is 32-bit only and doesn't support
> 16-bit access.
> 
> Now that dmaengine_pcm supports packed transfers the format can
> be made available by setting the SND_DMAENGINE_PCM_DAI_FLAG_PACK flag.
> 
> No further configuration is necessary:
> - snd_dmaengine_dai_dma_data.addr_width is already set to
>  DMA_SLAVE_BUSWIDTH_4_BYTES to force 32-bit DMA transfers
> - dmaengine_pcm will pick up the S16_LE format from the DAI
>  configuration and make it available since it's no longer
>  masked out due to the PACK flag.
> - there are no further corner cases to catch in hw_params,
>  since the channel count is fixed at 2 we always have two
>  16-bit stereo samples that can be transferred via 32-bit DMA
> 
> Signed-off-by: Matthias Reichl <hias@horus.com>

Tested-by: Martin Sperl <kernel@martin.sperl.org>
