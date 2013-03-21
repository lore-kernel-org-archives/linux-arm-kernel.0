From: lars@metafoo.de (Lars-Peter Clausen)
Date: Thu, 21 Mar 2013 16:06:27 +0100
Subject: [alsa-devel] [PATCH 0/2] ASoC: dmaengine_pcm: support generic
 DMA binding users
In-Reply-To: <20130321023858.GD6281@S2101-09.ap.freescale.net>
References: <1363318601-31505-1-git-send-email-shawn.guo@linaro.org>
 <20130321023858.GD6281@S2101-09.ap.freescale.net>
Message-ID: <514B21F3.90803@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/21/2013 03:39 AM, Shawn Guo wrote:
> On Fri, Mar 15, 2013 at 11:36:39AM +0800, Shawn Guo wrote:
>> The series adds a snd_dmaengine_generic_pcm_open() for users that
>> adopt generic DMA binding and helplers.
>>
>> Vinod,
>>
> Ping?
> 

Hm, I only saw this series today would have been good to be on Cc. I've been
working on something very similar. My series goes a bit further though, it
implements an (almost generic) dmaengine based PCM driver using the of
bindings. So you need almost no platform code. The only things that are
platform specific at the moment is the pcm_hardware struct, but I'd like to
replace that in the future with something that queries the pcm hardware
parameter like max_period from the DMA engine driver. And another bit that is
still driver specific is a callback that fills the dma_slave_config struct.

In my series the channels are requested at probe time, so it is possible to
handle -EPROBE_DEFER properly and also we can allocate the audio buffers with
the dma device instead of the sound device, so stupid hacks like

    card->dev->dma_mask = &dma_mask;
    card->dev->coherent_dma_mask = DMA_BIT_MASK(32);

anymore. I'll try to post the series tomorrow.

- Lars


> Shawn
> 
>> AS per the request from Mark, I add the first patch to mark name
>> parameter of dmaengine helpers as const, so that clients can mark
>> const on their side.
>>
>> We need to have these two patches on a topic branch, as I've heard
>> a few people converting their ASoC driver needing the patches.  Can
>> you ack the first patch, so that Mark can maintain them in a branch
>> for anyone who needs it to pull?
>>
>> Shawn Guo (2):
>>   dmaengine: add const for name parameter
>>   ASoC: dmaengine_pcm: add snd_dmaengine_generic_pcm_open()
>>
>>  drivers/dma/dmaengine.c       |    2 +-
>>  drivers/dma/of-dma.c          |    6 +++---
>>  include/linux/dmaengine.h     |    7 ++++---
>>  include/linux/of_dma.h        |    2 +-
>>  include/sound/dmaengine_pcm.h |    2 ++
>>  sound/soc/soc-dmaengine-pcm.c |   39 +++++++++++++++++++++++++++++++++++++++
>>  6 files changed, 50 insertions(+), 8 deletions(-)
>>
>> -- 
>> 1.7.9.5
>>
>>
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel at alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
