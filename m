From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 3 Apr 2018 17:53:25 +0200
Subject: [PATCH 14/15] ARM: pxa: change SSP devices allocation
In-Reply-To: <87lge4485x.fsf@belgarion.home>
References: <20180402142656.26815-1-robert.jarzmik@free.fr>
 <20180402142656.26815-15-robert.jarzmik@free.fr>
 <CAK8P3a2hYWO2eweg3zpR7iJoqtH4uxJLAxJAno7L96G7nA2HxQ@mail.gmail.com>
 <87lge4485x.fsf@belgarion.home>
Message-ID: <CAK8P3a1ko=YEwR2VOahH0OWHfeOyWAzDYah4DSohBcvTNq_MKQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 3, 2018 at 5:32 PM, Robert Jarzmik <robert.jarzmik@free.fr> wrote:
> Arnd Bergmann <arnd@arndb.de> writes:
>
> chop chop ... removed several mail recipients to leave only the ASoC / PXA
> subset ...
>
>> On Mon, Apr 2, 2018 at 4:26 PM, Robert Jarzmik <robert.jarzmik@free.fr> wrote:
>>
>>>
>>> +static struct pxa_ssp_info pxa_ssp_infos[] = {
>>> +       { .dma_chan_rx_name = "ssp1_rx", .dma_chan_tx_name = "ssp1_tx", },
>>> +       { .dma_chan_rx_name = "ssp1_rx", .dma_chan_tx_name = "ssp1_tx", },
>>> +       { .dma_chan_rx_name = "ssp2_rx", .dma_chan_tx_name = "ssp2_tx", },
>>> +       { .dma_chan_rx_name = "ssp2_rx", .dma_chan_tx_name = "ssp2_tx", },
>>> +       { .dma_chan_rx_name = "ssp3_rx", .dma_chan_tx_name = "ssp3_tx", },
>>> +       { .dma_chan_rx_name = "ssp3_rx", .dma_chan_tx_name = "ssp3_tx", },
>>> +       { .dma_chan_rx_name = "ssp4_rx", .dma_chan_tx_name = "ssp4_tx", },
>>> +       { .dma_chan_rx_name = "ssp4_rx", .dma_chan_tx_name = "ssp4_tx", },
>>> +};
>>
>> This part looks odd to me, you're adding an extra level of indirection to
>> do two stages of lookups in some form of platform data.
> That's unfortunately right.
>
>> Why can't you just always use "rx" and "tx" as the names here?
> Well I couldn't. I'll explain you why, and maybe you'll find a better solution.
>
> That all is related to how ASoC and SSP interact.
> If I remember correctly, here is how it works :
>  - the DMA channel is requested in sound/arm/pxa2xx-pcm-lib.c:128
>         return snd_dmaengine_pcm_open(
>                 substream, dma_request_slave_channel(rtd->platform->dev,
>    The trick is that the device here is _not_ the SSP one, it's if memory serves
>    me well the pxa-pcm-audio one.
>
>    As a consequence, the device cannot be used to differenciate which SSP
>    exactly is providing the sound samples stream. This information is
>    nevertheless required to choose the correct requestor line, which is a 1-to-1
>    match to the SSP port.
>
>    The indirection in the channel name is used to choose the correct requestor
>    line for a given SSP port providing the samples.
>
>    It also must be underlined that this dma request serves both AC97 and SSP as
>    sample providers.

I'm still unable to follow through that code, but I understand now that
the device you pass to dma_request_slave_channel() is not the one
we'd like it to be here.

Where exactly does that call to dma_request_chan() happen? Is this
the one in dmaengine_pcm_new()? Could we perhaps put a
pointer to the SSP device into snd_dmaengine_dai_dma_data?

       Arnd
