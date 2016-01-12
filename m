From: tiwai@suse.de (Takashi Iwai)
Date: Tue, 12 Jan 2016 06:42:42 +0100
Subject: [PATCH] ASoC: mediatek: Enable 33bit memory address to support
 4GB DRAM
In-Reply-To: <1452567284.8331.12.camel@mtksdaap41>
References: <1452499250-5202-1-git-send-email-pc.liao@mediatek.com>
 <s5hwprgcwv6.wl-tiwai@suse.de>
 <1452567284.8331.12.camel@mtksdaap41>
Message-ID: <s5h37u3pd4d.wl-tiwai@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 12 Jan 2016 03:54:44 +0100,
PC Liao wrote:
> 
> On Mon, 2016-01-11 at 17:02 +0800, Takashi Iwai wrote:
> > On Mon, 11 Jan 2016 09:00:50 +0100,
> > PC Liao wrote:
> > > 
> > > @@ -603,7 +606,10 @@ static int mtk_afe_dais_hw_params(struct snd_pcm_substream *substream,
> > >  	if (ret < 0)
> > >  		return ret;
> > >  
> > > -	memif->phys_buf_addr = substream->runtime->dma_addr;
> > > +	if (sizeof(dma_addr_t) > 4)
> > > +		msb_at_bit33 = (substream->runtime->dma_addr & 0x100000000) ? 1 : 0;
> > 
> > Better to put a proper suffix for the constant over 32bit.
> > 
> > Or use upper_32_bits().  Then sizeof() check can be omitted, as the
> > compiler should be smart enough to know it beforehand.
> > 
> > 
> > Takashi
> 
> 
> Hi Takashi,
> 
> Thanks for your comment.
> I change as below:
> @@ -606,10 +606,8 @@ static int mtk_afe_dais_hw_params(struct
> snd_pcm_substream
>         if (ret < 0)
>                 return ret;
> 
> -       if (sizeof(dma_addr_t) > 4)
> -               msb_at_bit33 = (substream->runtime->dma_addr &
> 0x100000000) ? 1
> -
> -       memif->phys_buf_addr = substream->runtime->dma_addr &
> 0xffffffff;
> +       msb_at_bit33 = upper_32_bits(substream->runtime->dma_addr) ? 1 :
> 0;
> +       memif->phys_buf_addr =
> lower_32_bits(substream->runtime->dma_addr);
> 
> 
> Dose this change follow your idea?

Yes.


Takashi
