From: zhangfei.gao@gmail.com (zhangfei gao)
Date: Fri, 25 May 2012 16:47:20 +0800
Subject: [alsa-devel] [PATCH 2/4] ASoC: mmp: add audio dma support
In-Reply-To: <20120525080500.GB24149@n2100.arm.linux.org.uk>
References: <1337929863-31885-1-git-send-email-zhangfei.gao@marvell.com>
 <1337929863-31885-3-git-send-email-zhangfei.gao@marvell.com>
 <1337932416.1580.2.camel@vkoul-udesk3>
 <20120525080500.GB24149@n2100.arm.linux.org.uk>
Message-ID: <CAMj5Bkhc46zqY5AbJkc=-h02taP_esxrqpNu--aYtZZcVcPK6A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks Russell and Vinod.

On Fri, May 25, 2012 at 4:05 PM, Russell King - ARM Linux <
linux@arm.linux.org.uk> wrote:

> On Fri, May 25, 2012 at 01:23:36PM +0530, Vinod Koul wrote:
> > On Fri, 2012-05-25 at 15:11 +0800, Zhangfei Gao wrote:
> > > mmp-pcm handle audio dma based on dmaengine
> > > Support mmp and pxa910
> > Looks like this is *not* using soc-dmaengine library, why?
>
> Note also...
>
Will look into soc-dmaengine.


>
> > > +   prtd->dma_chan = dma_request_channel(mask, filter, prtd);
> > > +   if (!prtd->dma_chan)
> > > +           return -EINVAL;
>
> This should be done at probe time, so we know the struct device, so
> that...
>

Do you mean at open time, like snd_dmaengine_pcm_open.
The channel resource is limited and better get dynamically.
As a  result the pcm_new and preallocate already called before.


> > > +static int mmp_pcm_preallocate_dma_buffer(struct snd_pcm *pcm, int
> stream)
> > > +{
> > > +   struct snd_pcm_substream *substream =
> pcm->streams[stream].substream;
> > > +   struct snd_dma_buffer *buf = &substream->dma_buffer;
> > > +   size_t size = mmp_pcm_hardware[stream].buffer_bytes_max;
> > > +   struct gen_pool *gpool;
> > > +
> > > +   buf->dev.type = SNDRV_DMA_TYPE_DEV;
> > > +   buf->dev.dev = pcm->card->dev;
>
> ... this uses the right device, and...
>
> > > +static u64 mmp_pcm_dmamask = DMA_BIT_MASK(64);
> > > +
> > > +int mmp_pcm_new(struct snd_soc_pcm_runtime *rtd)
> > > +{
> > > +   struct snd_card *card = rtd->card->snd_card;
> > > +   struct snd_pcm *pcm = rtd->pcm;
> > > +   int ret = 0;
> > > +
> > > +   if (!card->dev->dma_mask)
> > > +           card->dev->dma_mask = &mmp_pcm_dmamask;
> > > +
> > > +   if (!card->dev->coherent_dma_mask)
> > > +           card->dev->coherent_dma_mask = DMA_BIT_MASK(64);
>
> ... we don't need crap like this.
>
> Because then we'll be allocating buffers against the _right_ struct device
> which is the DMA engine struct device.
> --
> To unsubscribe from this list: send the line "unsubscribe alsa-devel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel at alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120525/af4b4fa0/attachment-0001.html>
