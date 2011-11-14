From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 14 Nov 2011 15:23:09 +0100
Subject: [PATCH 2/3] ARM: AT91: IIO: Add AT91 ADC driver.
In-Reply-To: <201111141237.08346.marek.vasut@gmail.com>
References: <1321265193-15817-1-git-send-email-maxime.ripard@free-electrons.com>
 <1321265193-15817-3-git-send-email-maxime.ripard@free-electrons.com>
 <201111141237.08346.marek.vasut@gmail.com>
Message-ID: <4EC1244D.3030302@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

On 14/11/2011 12:37, Marek Vasut wrote:
>> +	idev->num_channels = bitmap_weight(&(pdata->channels_used),
> 
> Do you need the parenthesis here ?

No. I just find it clearer this way, but it's all about cosmetic.

>> +					   pdata->num_channels);
>> +	chan_array = kcalloc(idev->num_channels, sizeof(struct iio_chan_spec),
>> +			     GFP_KERNEL);
>> +
>> +	if (chan_array == NULL)
>> +		return -ENOMEM;
>> +
>> +	for_each_set_bit(bit, &(pdata->channels_used), pdata->num_channels) {
>> +		struct iio_chan_spec *chan = chan_array + idx;
>> +		chan->type = IIO_VOLTAGE;
>> +		chan->indexed = 1;
>> +		chan->channel = bit;
>> +		chan->scan_type.sign = 'u';
>> +		chan->scan_type.realbits = 10;
>> +		chan->info_mask = IIO_CHAN_INFO_SCALE_SHARED_BIT;
>> +		++idx;
> 
> idx++ ... why the preincrement?
> 
> Besides, can't you use "bit" as the index instead?

Nope. bit is the index in the pdata->channel_used array, while idx is
the index in the chan_array array. And since these two don't have the
same length, I need these two variables.


-- 
Maxime Ripard, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
