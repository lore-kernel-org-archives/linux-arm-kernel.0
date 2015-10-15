From: jay.xu@rock-chips.com (Jianqun Xu)
Date: Thu, 15 Oct 2015 18:47:26 +0800
Subject: [PATCH v6 10/10] ASoC: rockchip_i2s: modify DMA max burst to 1
In-Reply-To: <561F6990.7080809@metafoo.de>
References: <1444872865-2169-1-git-send-email-shawn.lin@rock-chips.com>
 <1444873008-2589-1-git-send-email-shawn.lin@rock-chips.com>
 <561F6990.7080809@metafoo.de>
Message-ID: <561F843E.8040803@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2015?10?15? 16:53, Lars-Peter Clausen ??:
> On 10/15/2015 03:36 AM, Shawn Lin wrote:
> [...]
>> +
>> +	if (snd_dmaengine_pcm_get_caps(&pdev->dev, &dma_caps) == 0) {
>> +		if (dma_caps.max_burst > 4) {
>> +			i2s->playback_dma_data.maxburst = 4;
>> +			i2s->capture_dma_data.maxburst = 4;
>> +		} else {
>> +			i2s->playback_dma_data.maxburst = 1;
>> +			i2s->capture_dma_data.maxburst = 1;
> So this is what this is all about? I though you might have to program some
> FIFO threshold registers in the peripheral itself.
>
> But it seems all this does is to read the maximum burst length from the DMA
> controller only to tell the DMA controller that this is the maximum burst
> length it should use. That seems rather unnecessary.
>
> The maxburst field of the dma_data indicates the maximum burst length that
> the audio peripheral can handle. Typically this is the number of samples the
> audio FIFO can receive without overflowing after sending the DMA request
> signal. Since as the name suggests this is the maximum burst size the DMA
> controller is free to choose a burst size smaller than this when writing
> data to the peripheral.
>
> So in your case instead of introducing all these facilities to query the
> maximum burst size it should be OK to simply reduce the burst size in the
> DMA controller itself when it gets a request with a burst size larger than
> it can handle, or is there a reason why this is not possible?
Agree with Lars, it's better to fix on DMA driver side since issue 
caused by dma-controller instead of i2s controller
>
> - Lars
>
>
>

-- 
Jianqun Xu | Software engineer | 18750760928
