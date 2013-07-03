From: voice.shen@atmel.com (Bo Shen)
Date: Wed, 3 Jul 2013 09:33:59 +0800
Subject: [alsa-devel] [PATCH 2/2] ASoC: atmel-pcm: use generic dmaengine
 framework
In-Reply-To: <51D2F306.7040603@metafoo.de>
References: <1372755849-19546-1-git-send-email-voice.shen@atmel.com>
 <1372755849-19546-3-git-send-email-voice.shen@atmel.com>
 <51D2F306.7040603@metafoo.de>
Message-ID: <51D37F87.2010008@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lars-Peter,

On 7/2/2013 23:34, Lars-Peter Clausen wrote:
> On 07/02/2013 11:04 AM, Bo Shen wrote:
> [...]
>> -/*--------------------------------------------------------------------------*\
>> - * DMAENGINE operations
>> -\*--------------------------------------------------------------------------*/
>> -static bool filter(struct dma_chan *chan, void *slave)
>> -{
>> -	struct at_dma_slave *sl = slave;
>> -
>> -	if (sl->dma_dev == chan->device->dev) {
>> -		chan->private = sl;
>> -		return true;
>> -	} else {
>> -		return false;
>> -	}
>> -}
>
> I'm wondering why is filtering no longer required?

Now this is handled by at_dma_filter in at_hdmac driver. More 
information, you can reference: <driver/dma/at_hdmac.c> file

> [...]
>> +		slave_config->dst_addr = (dma_addr_t)ssc->phybase + SSC_THR;
> [...]
>> +		slave_config->src_addr = (dma_addr_t)ssc->phybase + SSC_RHR;
>
> Change the type of phybase to dma_addr_t

It should be:
slave_config->dst_addr = (dma_addr_t)(ssc->phybase + SSC_THR);
slave_config->src_addr = (dma_addr_t)(ssc->phybase + SSC_RHR);

> [...]
>>   }
>>
>> -static int atmel_pcm_dma_prepare(struct snd_pcm_substream *substream)
>> -{
>> -	struct snd_soc_pcm_runtime *rtd = substream->private_data;
>> -	struct atmel_pcm_dma_params *prtd;
>> -
>> -	prtd = snd_soc_dai_get_dma_data(rtd->cpu_dai, substream);
>> -
>> -	ssc_writex(prtd->ssc->regs, SSC_IER, prtd->mask->ssc_error);
>> -	ssc_writex(prtd->ssc->regs, SSC_CR, prtd->mask->ssc_enable);
>
> These writes are also completely lost

This will be moved to DAI driver startup callback function.

>> -
>> -	return 0;
>> -}
>
> I think it would also be good to get rid of any references to the ssc struct
> from the DMA driver and move them over to the DAI driver.

I will try to implement this in next version patch.

Thanks.

> - Lars
>

Best Regards,
Bo Shen
