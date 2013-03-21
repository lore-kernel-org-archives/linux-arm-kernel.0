From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 21 Mar 2013 22:53:00 +0800
Subject: [PATCH 2/2] ASoC: dmaengine_pcm: add
 snd_dmaengine_generic_pcm_open()
In-Reply-To: <20130321095718.GO10326@intel.com>
References: <1363318601-31505-1-git-send-email-shawn.guo@linaro.org>
 <1363318601-31505-3-git-send-email-shawn.guo@linaro.org>
 <20130321095718.GO10326@intel.com>
Message-ID: <20130321145258.GC23109@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 21, 2013 at 03:27:18PM +0530, Vinod Koul wrote:
> On Fri, Mar 15, 2013 at 11:36:41AM +0800, Shawn Guo wrote:
> > With generic DMA device tree binding and helper function
> > dma_request_slave_channel() in place, dmaengine_pcm should support
> > that in requesting DMA channel for users that support generic DMA
> > device tree binding.
> > 
> > Add a new API snd_dmaengine_generic_pcm_open() as the variant of
> > snd_dmaengine_pcm_open().  It takes DMA client struct device pointer
> > and slave channel name as arguments and calls generic DMA helper
> > dma_request_slave_channel() to request DMA channel from dmaengine.
> NAK
> 
> This is why we have dma_request_slave_channel_compat() API. You dont need to
> write two open handlers here, just pass all the arguments and if DT is set it
> will allocate a channel using dma_request_slave_channel() otherwise will do
> dma_request_channel which is what you need.

I do not quite follow your comment.  Let me try to understand it.  Are
you suggesting that instead of the current call path:

	snd_dmaengine_pcm_open()
		dmaengine_pcm_request_channel()
			dma_request_channel()

we should change it as below?

	snd_dmaengine_pcm_open()
		dmaengine_pcm_request_channel()
			dma_request_slave_channel_compat()

If that's the case, you are fundamentally requesting to change the
fingerprint of API snd_dmaengine_pcm_open() from the existing:

int snd_dmaengine_pcm_open(struct snd_pcm_substream *substream,
			   dma_filter_fn filter_fn, void *filter_data)

to something like:

int snd_dmaengine_pcm_open(struct snd_pcm_substream *substream,
			   dma_filter_fn filter_fn, void *filter_data,
			   struct device *dev, const char *name)

So every single user of snd_dmaengine_pcm_open() needs to adapt to the
interface change.

Is my understanding correct?  Or have I misunderstood your comment?

Shawn
