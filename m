From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Thu, 13 Mar 2014 15:03:00 +0200
Subject: [alsa-devel] [PATCH 14/18] ASoC: davinci: Add edma dmaengine
 platform driver
In-Reply-To: <53218835.3080909@metafoo.de>
References: <1394702320-21743-1-git-send-email-peter.ujfalusi@ti.com>
 <1394702320-21743-15-git-send-email-peter.ujfalusi@ti.com>
 <53218835.3080909@metafoo.de>
Message-ID: <5321AC84.7080004@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/13/2014 12:28 PM, Lars-Peter Clausen wrote:
>> +int edma_pcm_platform_register(struct device *dev)
>> +{
>> +    if (dev->of_node)
>> +        return snd_dmaengine_pcm_register(dev,
>> +                    &edma_dmaengine_pcm_config,
>> +                    SND_DMAENGINE_PCM_FLAG_NO_RESIDUE);
> 
> Since the edma dmaengine driver implements the slave cap API there is no need
> to manually specify SND_DMAENGINE_PCM_FLAG_NO_RESIDUE manually. But since the
> edma driver sets the granularity to DMA_RESIDUE_GRANULARITY_DESCRIPTOR in this
> case the generic dmaengine will not set SND_DMAENGINE_PCM_FLAG_NO_RESIDUE
> automatically since it assumes that the dmaengine driver is capable of
> properly reporting the DMA position.

Hrm, I see. For eDMA I think we can support DMA_RESIDUE_GRANULARITY_SEGMENT
granularity. Since according to the documentation the _SEGMENT means that the
DMA position will be updated per periods, which is basically the same thing
what we are doing at the moment when the granularity is
DMA_RESIDUE_GRANULARITY_DESCRIPTOR.
>From ALSA point of view at least they are the same: neither of them can report
exact position, the DMA pointer jumps from period to period.

IMHO in the generic dmaengine PCM we should set the SNDRV_PCM_INFO_BATCH for
both cases.

-- 
P?ter
