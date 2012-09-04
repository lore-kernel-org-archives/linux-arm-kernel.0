From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Tue, 04 Sep 2012 16:26:28 +0300
Subject: [alsa-devel] [RFC 1/3] ASoC: dmaengine: Don't use runtime	private
 data for dmaengine data
In-Reply-To: <s5ha9x62an0.wl%tiwai@suse.de>
References: <20120903165832.GA31511@n2100.arm.linux.org.uk>
 <E1T8ZzV-0002vp-2j@rmk-PC.arm.linux.org.uk> <5045124D.3050604@metafoo.de>
 <20120903204325.GA728@n2100.arm.linux.org.uk> <50451A4A.9000108@metafoo.de>
 <s5ha9x62an0.wl%tiwai@suse.de>
Message-ID: <50460184.4000404@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Takashi,

On 09/04/2012 04:14 PM, Takashi Iwai wrote:
>> Ok, it might have been helpful in the conversion process, but for the final
>> patch it would be nice if you could replace
>>
>> struct snd_pcm_runtime *runtime = substream->runtime;
>> struct omap_runtime_data *prtd = runtime->private_data;
>> struct omap_pcm_dma_data *dma_data = prtd->dma_data;
>> with
>> struct omap_pcm_dma_data *dma_data = snd_dmaengine_pcm_get_data(substream);
>>
>> and in the hwparams callback use
>>
>> snd_dmaengine_pcm_set_data(substream, dma_data);
>>
>> and then drop patch 1 and 2 from the series.
> 
> We discussed with Liam about the addition of new field in ALSA core,
> and concluded that a bit different approach, at least, more generic
> name is preferred, even if a new field is inevitably needed.
> 
> So, eventually some change may happen in near future in ALSA core
> side, but still it'd be really helpful if the callers have been
> standardized beforehand with a helper function like above.

If the omap-pcm dmaengine conversion works on all OMAP versions (from OMAP1 to
OMAP5) it is possible to avoid the additional field.
My main concern at the moment is if we will need two sets of drivers to
support OMAP1 and OMAP2/3/4/5.
In all case we use the same omap-mcbsp driver which would need deal with two
different type of ASoC platform driver (dmaengine and non-dmaengine).
I hope we get confirmation from Janusz soon regarding to OMAP1 with dmaengine
so we can plan on how to move forward.

-- 
P?ter
