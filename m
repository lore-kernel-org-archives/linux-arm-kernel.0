From: jic23@kernel.org (Jonathan Cameron)
Date: Fri, 04 Nov 2011 16:40:01 +0000
Subject: [PATCH 2/3] ARM: AT91: IIO: Add AT91 ADC driver.
In-Reply-To: <4EB412F9.8060404@free-electrons.com>
References: <1319041134-19712-1-git-send-email-maxime.ripard@free-electrons.com>
	<1320315070-1700-1-git-send-email-maxime.ripard@free-electrons.com>
	<1320315070-1700-3-git-send-email-maxime.ripard@free-electrons.com>
	<4EB3BE00.3080001@jic23.retrosnub.co.uk>
	<4EB412F9.8060404@free-electrons.com>
Message-ID: <4EB41561.6020505@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

...
>>> +		if(pdata->channels_used[i]) {
>>> +			struct iio_chan_spec *chan = st->channels + idx;
>>> +			chan->type = IIO_VOLTAGE;
>>> +			chan->indexed = 1;
>>> +			chan->channel = i;
>>> +			chan->scan_type.sign = 's';
>>> +			chan->scan_type.realbits = 10;
>>> +			chan->scan_type.storagebits = 32;
>> That is pretty inefficient storage!  If we do implement buffering
>> on this, given mass reads don't look to be quicker, we'll just
>> munge it down to 16 bits.
> 
> Well, I thought that storage bits was here to represent how the hardware
> stored the values. Since these values are stored on 10 bits alone in a
> 32 bits register, I thought that these were the right values, but we can
> definitely lower the storagebits to 16 here.
> 
It's actually the storage in a buffer if we use one. scan_type doesn't
actually need defining at all if we have no buffered support (it's not
used by the core).  Clearly if buffering is used, 32 bits 'might' give
us slightly fewer copies, but at the cost of double the memory usage.
It would take some pretty impressive benchmark figures to convince that
it was worth the space.
>>> +		goto error_ret;
>>> +	}
>>> +
>>> +	idev = iio_allocate_device(sizeof(struct at91adc_state));
>> sizeof(*st) is a little neater?
> 
> Well, I find sizeof(struct at91adc_state) clearer, but ok.
I don't care so stick with it if you prefer!
