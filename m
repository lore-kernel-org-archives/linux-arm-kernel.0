From: B29396@freescale.com (Dong Aisheng-B29396)
Date: Wed, 13 Jul 2011 08:17:07 +0000
Subject: [PATCH V2 01/10] ASoc: mxs: add mxs-pcm driver
In-Reply-To: <20110713074437.GF23270@n2100.arm.linux.org.uk>
References: <1310483085-31442-1-git-send-email-b29396@freescale.com>
	<1310483085-31442-2-git-send-email-b29396@freescale.com>
	<20110713074437.GF23270@n2100.arm.linux.org.uk>
Message-ID: <65EE16ACC360FA4D99C96DC085B3F7721CD91F@039-SN1MPN1-002.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Russell King - ARM Linux [mailto:linux at arm.linux.org.uk]
> Sent: Wednesday, July 13, 2011 3:45 PM
> To: Dong Aisheng-B29396
> Cc: alsa-devel at alsa-project.org; s.hauer at pengutronix.de;
> broonie at opensource.wolfsonmicro.com; lrg at ti.com; linux-arm-
> kernel at lists.infradead.org; u.kleine-koenig at pengutronix.de
> Subject: Re: [PATCH V2 01/10] ASoc: mxs: add mxs-pcm driver
> 
> On Tue, Jul 12, 2011 at 11:04:36PM +0800, Dong Aisheng wrote:
> > +static int mxs_pcm_preallocate_dma_buffer(struct snd_pcm *pcm, int
> > +stream) {
> > +	struct snd_pcm_substream *substream = pcm-
> >streams[stream].substream;
> > +	struct snd_dma_buffer *buf = &substream->dma_buffer;
> > +	size_t size = 64 * 1024;
> > +
> > +	buf->dev.type = SNDRV_DMA_TYPE_DEV;
> > +	buf->dev.dev = pcm->card->dev;
> > +	buf->private_data = NULL;
> > +	buf->area = dma_alloc_writecombine(pcm->card->dev, size,
> > +					   &buf->addr, GFP_KERNEL);
> ...
> > +static int snd_mxs_pcm_mmap(struct snd_pcm_substream *substream,
> > +		struct vm_area_struct *vma)
> > +{
> > +	struct snd_pcm_runtime *runtime = substream->runtime;
> > +	int ret;
> > +
> > +	ret = dma_mmap_coherent(NULL, vma, runtime->dma_area,
> > +			runtime->dma_addr, runtime->dma_bytes);
> 
> This is wrong.  Hint 1:
> 
> int dma_mmap_writecombine(struct device *dev, struct vm_area_struct *vma,
>                           void *cpu_addr, dma_addr_t dma_addr, size_t
> size)
> 
> Hint 2: struct device *dev - you have one above.
Got it.
Thanks for the reminder.

Regards
Dong Aisheng
