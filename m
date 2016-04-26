From: lars@metafoo.de (Lars-Peter Clausen)
Date: Tue, 26 Apr 2016 10:47:05 +0200
Subject: [alsa-devel] [PATCH 3/3] ASoC: bcm2835: Register also as PCM
 device
In-Reply-To: <20160425171515.GA10952@camel2.lan>
References: <1461591580-7565-1-git-send-email-kernel@martin.sperl.org>
 <1461591580-7565-3-git-send-email-kernel@martin.sperl.org>
 <571E218A.7050508@metafoo.de> <20160425171515.GA10952@camel2.lan>
Message-ID: <571F2B09.1000107@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>> +	.periods_min		= 2,
>>> +	.periods_max		= 255,
>>> +	.buffer_bytes_max	= 128 * PAGE_SIZE,
>>> +};
>>> +
>>> +static const struct snd_dmaengine_pcm_config bcm2835_dmaengine_pcm_config = {
>>> +	.prepare_slave_config = snd_dmaengine_pcm_prepare_slave_config,
>>> +	.pcm_hardware = &bcm2835_pcm_hardware,
>>> +	.prealloc_buffer_size = 256 * PAGE_SIZE,
>>> +};
>>
>> The generic dmaengine PCM driver auto-discovers these things, no need to
>> provide them. The code is OK as it is.
> 
> With the auto-discover code we loose the S16_LE format.
> 
> If I understood the code in dmaengine_pcm_set_runtime_hwparams
> correctly, this is because the DMA controller doesn't support
> 16bit transfers (only multiples of 32bit are allowed).
> 
> But since the I2S driver needs exactly 2 channels S16_LE actually
> works fine (one 32bit transfer per frame).
> 
> Do you know of a better way to get S16_LE support? It could well
> be that I missed something important...

With your patch we should just get an error when trying to configure a
stream with 16-bit samples since when setting up the DMA controller the
generic code will still choose a 16-bit device port size and this will be
rejected by the DMA controller.

When you look at peripherals that have DMA support there are basically two
types.

Type A expect that each write (same applies for read) to the memory mapped
FIFO corresponds to exactly one sample. So if the sample width is 16-bit a
16-bit write is done, if the sample width is 32-bit a 32-bit write is done.
In this case it is up to the DMA controller to fragment the byte stream into
individual samples.

Type B on the other hand has a fixed port width (usually the bus size) and
expects that each write to the memory mapped FIFO uses the port width. It
then internally unpacks the data into the sample data. E.g. if the FIFO is
32-bit wide and the sample width is 16-bit it will unpack the 32-bit entry
into two samples.

Currently the generic code only supports type A. It would be great if you
could add support for type B to support the BCM2835 I2S controller properly.

- Lars
