From: tiwai@suse.de (Takashi Iwai)
Date: Mon, 11 Jan 2016 10:02:21 +0100
Subject: [PATCH] ASoC: mediatek: Enable 33bit memory address to support
 4GB DRAM
In-Reply-To: <1452499250-5202-1-git-send-email-pc.liao@mediatek.com>
References: <1452499250-5202-1-git-send-email-pc.liao@mediatek.com>
Message-ID: <s5hwprgcwv6.wl-tiwai@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 11 Jan 2016 09:00:50 +0100,
PC Liao wrote:
> 
> @@ -603,7 +606,10 @@ static int mtk_afe_dais_hw_params(struct snd_pcm_substream *substream,
>  	if (ret < 0)
>  		return ret;
>  
> -	memif->phys_buf_addr = substream->runtime->dma_addr;
> +	if (sizeof(dma_addr_t) > 4)
> +		msb_at_bit33 = (substream->runtime->dma_addr & 0x100000000) ? 1 : 0;

Better to put a proper suffix for the constant over 32bit.

Or use upper_32_bits().  Then sizeof() check can be omitted, as the
compiler should be smart enough to know it beforehand.


Takashi
