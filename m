From: flatmax@flatmax.org (Matt Flax)
Date: Sun, 5 Feb 2017 21:55:29 +1100
Subject: [alsa-devel] [PATCH] ASoC: bcm2835: Increase channels_max to 8
In-Reply-To: <6d2a00ef-edb0-1c70-8303-26a92bf05ef5@koalo.de>
References: <1485992264-9058-1-git-send-email-flatmax@flatmax.org>
 <20170204154944.timxhmmibc4kngly@sirena.org.uk>
 <a7f5de09-b07b-638d-466f-525e68ebf0f9@flatmax.org>
 <6d2a00ef-edb0-1c70-8303-26a92bf05ef5@koalo.de>
Message-ID: <915098a8-2486-e648-c54d-34077954113e@flatmax.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 05/02/17 21:20, Florian Kauer wrote:
> Hi Matt,
> great to hear from your work!
> However, I have to disappoint you, it is not the first time someone 
> has done this. Actually, I have done the same thing in 2014 and 
> mentioned it at my talk at the Linux Audio Conference. However, I have 
> not upstreamed it because I thought it is too special ;-)
> http://lac.linuxaudio.org/2014/video.php?id=4 at 16:28
>
Florian, it is an honour to be following in your footsteps ! Nice video 
- nice specs/response on the Jamberry too.

> The problem is that it highly depends on the codec you connect if the 
> timing matches. Actually the official I2S bus specification does only 
> support two channels. Everything else is some special thing anyway.
>
> The question is: Should the driver be open to accept "special things" 
> even if the hardware does not "officially" support it?
> Upside: It enables more applications.
> Downside: If you select an arbitrary 8 channel codec and this driver 
> you do not get any error message, but it might or might not work.
>
> I would tend to accepting the patch because everyone who writes a 
> board driver should check the compatibility anyway and otherwise we 
> would block a working application.
>
Thank you for voting in support of the patch ! It is a pretty safe patch 
because it does very little to change the functionality of the i2s 
driver you originally wrote.

I agree with your statement, "everyone who writes a board driver should 
check the compatibility" in fact I would go further. I would say the 
designers of the audio hardware should ensure that their solution is 
reliable and works with the particular SoC they are targeting (in this 
case the BCM2835).
The Audio Injector Octo (http://audioinjector.net) is certainly well 
tested with the BCM2835 silicon (both Pi2 and Pi3 versions).

thanks
Matt

> Greetings,
> Florian
>
> On 05.02.2017 02:26, Matt Flax wrote:
>>
>>
>> On 05/02/17 02:49, Mark Brown wrote:
>>> On Thu, Feb 02, 2017 at 10:37:44AM +1100, Matt Flax wrote:
>>>
>>>>       switch (params_channels(params)) {
>>>>       case 2:
>>>> +    case 8:
>>>>           format = BCM2835_I2S_CH1(format) | BCM2835_I2S_CH2(format);
>>>>           format |= BCM2835_I2S_CH1(BCM2835_I2S_CHPOS(ch1pos));
>>>>           format |= BCM2835_I2S_CH2(BCM2835_I2S_CHPOS(ch2pos));
>>> I can't understand how this works.  We're programming the hardware 
>>> in an
>>> identical fashion for both channel counts, that means that what we're
>>> sending will be indistinguishable from a garbled stereo stream.  How
>>> does this produce working clocks or manage to sync up reliably with
>>> external clocks?
>>>
>> I am not surprised it is confusing, to my knowledge this is the first
>> time that someone has demonstrated this type of I2S signalling.
>>
>> I will attempt to explain why nothing is garbled by talking about what
>> the BCM2835 silicon does.
>>
>> In this case BCM2835 is a clock slave and not concerned with generating
>> the I2S clocks, only receiving - think of all clocks and synchrony being
>> generated/managed in hardware on the sound card.
>>
>> In short the BCM2835 silicon is only concerned with shifting bits into
>> two hardware registers which (after DMA) are interpreted by ALSA
>> according to the specified channel count.
>>
>> Let me be a little more explicit. Regarding the BCM2835 I2S silicon :
>> The BCM2835 I2S silicon is concerned with shifting data from I2S bit
>> streams into hardware registers. The BCM2835 is only concerned with the
>> word format for the hardware registers. The BCM2835 silicon doesn't care
>> about channel count. This is why we use format=* in this part of the
>> bcm2835-i2s.c driver. Specifically we are concerned with the protocol's
>> word format (e.g. BCM2835_I2S_CH1(format)) and the location of the word
>> onset in the bit stream (e.g. BCM2835_I2S_CHPOS(ch1pos)).
>>
>> This is (to my knowledge) the first time someone has tried this concept
>> and proven that it is successful and robust. My gut feeling is that it
>> will work will most/all silicon. In my opinion it is a little
>> evolution/revolution in I2S signalling.
>>
>> Personally, I think it would be better if the code read as follows :
>>
>>    // if the channel count is even
>>    if ( fmod((float)params_channels(params)) != 1 ) {
>>           format = BCM2835_I2S_CH1(format) | BCM2835_I2S_CH2(format);
>>           format |= BCM2835_I2S_CH1(BCM2835_I2S_CHPOS(ch1pos));
>>           format |= BCM2835_I2S_CH2(BCM2835_I2S_CHPOS(ch2pos));
>>   } else
>>         return -EINVAL;
>>
>> I would even prefer to get rid of the channel count guard as strictly
>> speaking the format of the I2S bit stream has nothing to do with the
>> channel count !
>>
>> thanks
>> Matt
