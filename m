From: lars@metafoo.de (Lars-Peter Clausen)
Date: Thu, 21 Mar 2013 17:26:19 +0100
Subject: [alsa-devel] [PATCH 0/2] ASoC: dmaengine_pcm: support generic
 DMA binding users
In-Reply-To: <20130321152206.GA14768@opensource.wolfsonmicro.com>
References: <1363318601-31505-1-git-send-email-shawn.guo@linaro.org>
 <20130321023858.GD6281@S2101-09.ap.freescale.net> <514B21F3.90803@metafoo.de>
 <20130321152206.GA14768@opensource.wolfsonmicro.com>
Message-ID: <514B34AB.1080107@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/21/2013 04:22 PM, Mark Brown wrote:
> On Thu, Mar 21, 2013 at 04:06:27PM +0100, Lars-Peter Clausen wrote:
> 
>> Hm, I only saw this series today would have been good to be on Cc. I've been
>> working on something very similar. My series goes a bit further though, it
>> implements an (almost generic) dmaengine based PCM driver using the of
>> bindings. So you need almost no platform code. The only things that are
>> platform specific at the moment is the pcm_hardware struct, but I'd like to
>> replace that in the future with something that queries the pcm hardware
>> parameter like max_period from the DMA engine driver. And another bit that is
>> still driver specific is a callback that fills the dma_slave_config struct.
> 
> FWIW it might be worth looking at the one rmk wrote but has never wanted
> to submit for whatever reason.

Ideally I'd like to eventually move this 'fill in slave config' callback to the
DAI driver, since this is almost always DAI specific data, like for example the
FIFO address, the burst length, the bus width, etc. But I'd like to do that in
a second step. The first step should already help us to get rid of a large
portion of redundant code we see in PCM drivers today.

> 
>> In my series the channels are requested at probe time, so it is possible to
>> handle -EPROBE_DEFER properly and also we can allocate the audio buffers with
>> the dma device instead of the sound device, so stupid hacks like
> 
>>     card->dev->dma_mask = &dma_mask;
>>     card->dev->coherent_dma_mask = DMA_BIT_MASK(32);
> 
>> anymore. I'll try to post the series tomorrow.
> 
> This is the main thing his code has got that the library hasn't, it's
> certainly the only issue he keeps mentioning.

Yes, he definitely deserves credit for this, I probably wouldn't have
implemented it, if he hadn't point this out.

The problem with the current library is that we don't know yet which dmaengine
device is going to be used by the time we pre-allocate the audio buffers, since
the DMA filter parameters often are provided by the DAI driver. When using
devicetree on the other hand the handle to the dmaengine comes from the
devicetree itself and so it is available at the time we probe the PCM driver.

There are some other drivers which don't really depend on runtime filter
parameters, e.g. tegra, which doesn't use a filter function. So tegra can also
easily make use of this new generic dmaengine based PCM driver.

- Lars
