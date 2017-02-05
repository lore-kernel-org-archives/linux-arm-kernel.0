From: flatmax@flatmax.org (Matt Flax)
Date: Sun, 5 Feb 2017 12:26:31 +1100
Subject: [alsa-devel] [PATCH] ASoC: bcm2835: Increase channels_max to 8
In-Reply-To: <20170204154944.timxhmmibc4kngly@sirena.org.uk>
References: <1485992264-9058-1-git-send-email-flatmax@flatmax.org>
 <20170204154944.timxhmmibc4kngly@sirena.org.uk>
Message-ID: <a7f5de09-b07b-638d-466f-525e68ebf0f9@flatmax.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 05/02/17 02:49, Mark Brown wrote:
> On Thu, Feb 02, 2017 at 10:37:44AM +1100, Matt Flax wrote:
>
>>   	switch (params_channels(params)) {
>>   	case 2:
>> +	case 8:
>>   		format = BCM2835_I2S_CH1(format) | BCM2835_I2S_CH2(format);
>>   		format |= BCM2835_I2S_CH1(BCM2835_I2S_CHPOS(ch1pos));
>>   		format |= BCM2835_I2S_CH2(BCM2835_I2S_CHPOS(ch2pos));
> I can't understand how this works.  We're programming the hardware in an
> identical fashion for both channel counts, that means that what we're
> sending will be indistinguishable from a garbled stereo stream.  How
> does this produce working clocks or manage to sync up reliably with
> external clocks?
>
I am not surprised it is confusing, to my knowledge this is the first 
time that someone has demonstrated this type of I2S signalling.

I will attempt to explain why nothing is garbled by talking about what 
the BCM2835 silicon does.

In this case BCM2835 is a clock slave and not concerned with generating 
the I2S clocks, only receiving - think of all clocks and synchrony being 
generated/managed in hardware on the sound card.

In short the BCM2835 silicon is only concerned with shifting bits into 
two hardware registers which (after DMA) are interpreted by ALSA 
according to the specified channel count.

Let me be a little more explicit. Regarding the BCM2835 I2S silicon :
The BCM2835 I2S silicon is concerned with shifting data from I2S bit 
streams into hardware registers. The BCM2835 is only concerned with the 
word format for the hardware registers. The BCM2835 silicon doesn't care 
about channel count. This is why we use format=* in this part of the  
bcm2835-i2s.c driver. Specifically we are concerned with the protocol's 
word format (e.g. BCM2835_I2S_CH1(format)) and the location of the word 
onset in the bit stream (e.g. BCM2835_I2S_CHPOS(ch1pos)).

This is (to my knowledge) the first time someone has tried this concept 
and proven that it is successful and robust. My gut feeling is that it 
will work will most/all silicon. In my opinion it is a little 
evolution/revolution in I2S signalling.

Personally, I think it would be better if the code read as follows :

    // if the channel count is even
    if ( fmod((float)params_channels(params)) != 1 ) {
           format = BCM2835_I2S_CH1(format) | BCM2835_I2S_CH2(format);
           format |= BCM2835_I2S_CH1(BCM2835_I2S_CHPOS(ch1pos));
           format |= BCM2835_I2S_CH2(BCM2835_I2S_CHPOS(ch2pos));
   } else
         return -EINVAL;

I would even prefer to get rid of the channel count guard as strictly 
speaking the format of the I2S bit stream has nothing to do with the 
channel count !

thanks
Matt
