From: jic23@kernel.org (Jonathan Cameron)
Date: Sun, 23 Jun 2013 18:33:10 +0100
Subject: [PATCHv2 1/3] iio: Add Nuvoton NAU7802 ADC driver
In-Reply-To: <51C6FE00.8010900@metafoo.de>
References: <1371754675-12242-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1371754675-12242-2-git-send-email-alexandre.belloni@free-electrons.com>
 <51C590B5.2060308@kernel.org> <51C5923D.6030609@metafoo.de>
 <51C5A1AF.3070404@free-electrons.com> <51C5A499.5050509@metafoo.de>
 <51C5A68F.3000300@free-electrons.com> <51C6FE00.8010900@metafoo.de>
Message-ID: <51C73156.7040807@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/23/2013 02:54 PM, Lars-Peter Clausen wrote:
> On 06/22/2013 03:28 PM, Alexandre Belloni wrote:
>> On 22/06/2013 15:20, Lars-Peter Clausen wrote:
>>> On 06/22/2013 03:07 PM, Alexandre Belloni wrote:
>>>> On 22/06/2013 14:02, Lars-Peter Clausen wrote:
>>>>> On 06/22/2013 01:55 PM, Jonathan Cameron wrote:
>>>>>> On 06/20/2013 07:57 PM, Alexandre Belloni wrote:
>>>>>>> The Nuvoton NAU7802 ADC is a 24-bit 2-channels I2C ADC, with adjustable
>>>>>>> gain and sampling rates.
>>>>>>>
>>>>>> Sorry, somewhat low on time today so only a quick review.
>>>>>>
>>>>>> 1) Missing userspace ABI documentation.  Also, perhaps min_conversions is
>>>>>>    a little vague?  Not that I have a better idea!
>>>>> I really don't like the name min_conversions either. Isn't this effectively
>>>>> a decimation filter?
>>>> Yeah, it could be seen like that but it is only relevant and only
>>>> happens when switching between channels. I'm open to any ideas.
>>>>
>>> I see. Is there anything about this in the datasheet on how many conversions
>>> you usually need? Is this really something you need to change at runtime or
>>> does moving this to platform data work?
>>>
>>>
>>
>> There is actually nothing in the datasheet. The default value (6
>> conversions) was found experimentally. What I did was saturating the ADC
>> with the higher value on one channel and the lower value on the other
>> one and I tried to find when reading both channel sequentially was
>> resulting in a correct value.
>>
>> You may not need to change it at runtime. And that value mainly depend
>> on the precision versus speed balance you want to achieve. If you know
>> that the values on both channels will not be to far apart, then you may
>> not need to wait at all.
>>
>> Would you think that is something I should hide in the DT ? Or maybe I
>> can drop that knob for now and see if it is needed in the future.
>>
> 
> It is always a good idea to be conservative when introducing new ABI, so if
> you think we can get away with hardcoding this in the driver I think that's
> a good idea.
> 
I agree entirely.  We can always make it controllable later as long
as we keep the default the same as the value you hard code in now.
