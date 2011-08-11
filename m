From: boojin.kim@samsung.com (Boojin Kim)
Date: Thu, 11 Aug 2011 19:04:36 +0900
Subject: [PATCH 14/15] ASoC: Samsung: Update DMA interface
In-Reply-To: <CABb+yY0E9_asUdMQ3ayDuRDa_SVhEZGiTRmPspD+YsQ-y40m4g@mail.gmail.com>
References: <1311744697-10264-1-git-send-email-boojin.kim@samsung.com>
	<1311744697-10264-15-git-send-email-boojin.kim@samsung.com>
	<CABb+yY0E9_asUdMQ3ayDuRDa_SVhEZGiTRmPspD+YsQ-y40m4g@mail.gmail.com>
Message-ID: <001301cc580e$13cab560$3b602020$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jassi Brar Wrote:
> Sent: Tuesday, August 09, 2011 4:28 AM
> To: Boojin Kim
> Cc: linux-arm-kernel at lists.infradead.org; linux-samsung-
> soc at vger.kernel.org; Vinod Koul; Dan Williams; Kukjin Kim; Mark Brown;
> Grant Likely; Russell King; Liam Girdwood
> Subject: Re: [PATCH 14/15] ASoC: Samsung: Update DMA interface
>
> On Wed, Jul 27, 2011 at 11:01 AM, Boojin Kim <boojin.kim@samsung.com>
> wrote:
>
> >  static void dma_enqueue(struct snd_pcm_substream *substream)
> >  {
> >        struct runtime_data *prtd = substream->runtime->private_data;
> >        dma_addr_t pos = prtd->dma_pos;
> >        unsigned int limit;
> > -       int ret;
> > +       struct samsung_dma_prep_info dma_info;
> >
> >        pr_debug("Entered %s\n", __func__);
> >
> > -       if (s3c_dma_has_circular())
> > -               limit = (prtd->dma_end - prtd->dma_start) / prtd-
> >dma_period;
> > -       else
> > -               limit = prtd->dma_limit;
> > +       limit = (prtd->dma_end - prtd->dma_start) / prtd->dma_period;
>
> 'dma_limit' is rendered useless, so you might want to remove it from
> 'struct runtime_data'
> as well.
You're right. I will remove it in next cleanup patch

>
> >        pr_debug("%s: loaded %d, limit %d\n",
> >                                __func__, prtd->dma_loaded, limit);
> >
> > -       while (prtd->dma_loaded < limit) {
> > -               unsigned long len = prtd->dma_period;
> > +       dma_info.cap = (samsung_dma_has_circular() ? DMA_CYCLIC :
> DMA_SLAVE);
> > +       dma_info.direction =
> > +               (substream->stream == SNDRV_PCM_STREAM_PLAYBACK
> > +               ? DMA_TO_DEVICE : DMA_FROM_DEVICE);
> > +       dma_info.fp = audio_buffdone;
> > +       dma_info.fp_param = substream;
> > +       dma_info.period = prtd->dma_period;
> > +       dma_info.len = prtd->dma_period*limit;
> >
> > +       while (prtd->dma_loaded < limit) {
> >                pr_debug("dma_loaded: %d\n", prtd->dma_loaded);
> >
> > -               if ((pos + len) > prtd->dma_end) {
> > -                       len  = prtd->dma_end - pos;
> > -                       pr_debug("%s: corrected dma len %ld\n",
> __func__, len);
> > +               if ((pos + dma_info.period) > prtd->dma_end) {
> > +                       dma_info.period  = prtd->dma_end - pos;
> > +                       pr_debug("%s: corrected dma len %ld\n",
> > +                                       __func__, dma_info.period);
> >                }
> >
> > -               ret = s3c2410_dma_enqueue(prtd->params->channel,
> > -                       substream, pos, len);
> > +               dma_info.buf = pos;
> > +               prtd->params->ops->prepare(prtd->params->ch,
> &dma_info);
> >
> > -               if (ret == 0) {
> > -                       prtd->dma_loaded++;
> > -                       pos += prtd->dma_period;
> > -                       if (pos >= prtd->dma_end)
> > -                               pos = prtd->dma_start;
> > -               } else
> > -                       break;
> > +               prtd->dma_loaded++;
> > +               pos += prtd->dma_period;
> > +               if (pos >= prtd->dma_end)
> > +                       pos = prtd->dma_start;
> >        }
> >
> >        prtd->dma_pos = pos;
> >  }
> >
> > -static void audio_buffdone(struct s3c2410_dma_chan *channel,
> > -                               void *dev_id, int size,
> > -                               enum s3c2410_dma_buffresult result)
> > +static void audio_buffdone(void *data)
> >  {
> > -       struct snd_pcm_substream *substream = dev_id;
> > -       struct runtime_data *prtd;
> > +       struct snd_pcm_substream *substream = data;
> > +       struct runtime_data *prtd = substream->runtime->private_data;
> >
> >        pr_debug("Entered %s\n", __func__);
> >
> > -       if (result == S3C2410_RES_ABORT || result == S3C2410_RES_ERR)
> > -               return;
> > -
> > -       prtd = substream->runtime->private_data;
> > +       if (prtd->state & ST_RUNNING) {
> > +               prtd->dma_pos += prtd->dma_period;
> > +               if (prtd->dma_pos >= prtd->dma_end)
> > +                       prtd->dma_pos = prtd->dma_start;
> >
> > -       if (substream)
> > -               snd_pcm_period_elapsed(substream);
> > +               if (substream)
> > +                       snd_pcm_period_elapsed(substream);
> >
> > -       spin_lock(&prtd->lock);
> > -       if (prtd->state & ST_RUNNING && !s3c_dma_has_circular()) {
> > -               prtd->dma_loaded--;
> > -               dma_enqueue(substream);
> > +               spin_lock(&prtd->lock);
> > +               if (!samsung_dma_has_circular()) {
> > +                       prtd->dma_loaded--;
> > +                       dma_enqueue(substream);
> > +               }
> > +               spin_unlock(&prtd->lock);
> >        }
> > -
> > -       spin_unlock(&prtd->lock);
> >  }
>
> Since we set integer-constraint on number of periods, you could also
> discard bothering fractional boundaries. That would make things a lot
> simpler.
>
>
>
> > @@ -265,14 +250,14 @@ static int dma_trigger(struct
> snd_pcm_substream *substream, int cmd)
> >        case SNDRV_PCM_TRIGGER_RESUME:
> >        case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
> >                prtd->state |= ST_RUNNING;
> > -               s3c2410_dma_ctrl(prtd->params->channel,
> S3C2410_DMAOP_START);
> > +               prtd->params->ops->trigger(prtd->params->ch);
> >                break;
> >
> >        case SNDRV_PCM_TRIGGER_STOP:
> >        case SNDRV_PCM_TRIGGER_SUSPEND:
> >        case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
> >                prtd->state &= ~ST_RUNNING;
> > -               s3c2410_dma_ctrl(prtd->params->channel,
> S3C2410_DMAOP_STOP);
> > +               prtd->params->ops->stop(prtd->params->ch);
> >                break;
>
> I wish you agreed and used
>        prtd->params->ops->cmd(ch, enum some_cmd_options)
> rather than having 4 separate callbacks
>       prtd->params->ops->trigger(prtd->params->ch)
>       prtd->params->ops->stop(prtd->params->ch)
>      prtd->params->ops->flush(prtd->params->ch)
>      prtd->params->ops->started(prtd->params->ch)
>
>
> > @@ -291,21 +276,12 @@ dma_pointer(struct snd_pcm_substream
> *substream)
> >        struct snd_pcm_runtime *runtime = substream->runtime;
> >        struct runtime_data *prtd = runtime->private_data;
> >        unsigned long res;
> > -       dma_addr_t src, dst;
> >
> >        pr_debug("Entered %s\n", __func__);
> >
> > -       spin_lock(&prtd->lock);
> > -       s3c2410_dma_getposition(prtd->params->channel, &src, &dst);
> > -
> > -       if (substream->stream == SNDRV_PCM_STREAM_CAPTURE)
> > -               res = dst - prtd->dma_start;
> > -       else
> > -               res = src - prtd->dma_start;
> > -
> > -       spin_unlock(&prtd->lock);
> > +       res = prtd->dma_pos - prtd->dma_start;
> >
> > -       pr_debug("Pointer %x %x\n", src, dst);
> > +       pr_debug("Pointer offset: %lu\n", res);
> >
> >        /* we seem to be getting the odd error from the pcm library
> due
> >         * to out-of-bounds pointers. this is maybe due to the dma
> engine
>
> Isn't this a regression ?
> dma_pointer() doesn't really return actual location of DMA activity
> anymore.
> Now it simply tells the last period done.
> This would affect latencies in a bad way.
Yes, This code makes the DMA position less accurately. But, This position is 
enough for audio DMA activity. Other drivers also use similar method to get 
the position.
