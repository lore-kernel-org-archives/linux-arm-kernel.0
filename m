From: jon-hunter@ti.com (Jon Hunter)
Date: Thu, 26 Jul 2012 12:43:31 -0500
Subject: [PATCH V3 1/2] of: Add generic device tree DMA helpers
In-Reply-To: <1343284960.1726.8978.camel@vkoul-udesk3>
References: <1335820679-28721-1-git-send-email-jon-hunter@ti.com>
 <201207171924.33756.arnd@arndb.de> <1342756850.1726.74.camel@vkoul-udesk3>
 <201207200839.24259.arnd@arndb.de> <1342777047.1726.435.camel@vkoul-udesk3>
 <500EF27F.6050905@ti.com> <1343284960.1726.8978.camel@vkoul-udesk3>
Message-ID: <501181C3.1020301@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 07/26/2012 01:42 AM, Vinod Koul wrote:
> On Tue, 2012-07-24 at 14:07 -0500, Jon Hunter wrote:
>> Hi Vinod,
>>>>>> Required property:
>>>>>>     dmas: list of one or more dma specifiers, each consisting of
>>>>>>      - phandle pointing to dma controller node
>>>>>>      - flags word, a bit map that can hold these flags
>>>>>>        * 0x00000001 channel can be used for transfer from device
>>>>>>        * 0x00000002 channel can be user for transfer to device
>>>>>
>>>>> Is this for identifying which channel is for TX and RX? If not I am not
>>>>> sure I understood it well
>>>>
>>>> Yes, but we can potentially add more flags here.
>>>>
>>>> The argument we had when coming up with this was roughly:
>>>>
>>>> * we need to identify which specifiers are referring to the same
>>>>   conceptual channel and can be used as alternatives
>>>> * this could be done just using the dma-names property, but making
>>>>   dma-names mandatory adds complexity for everyone.
>>>> * Most devices have just one or two channels, and if they have two,
>>>>   there is usually one input and one output.
>>>>
>>>> => if the common dmaengine code can find out whether a channel is
>>>>   input or output without looking at the dmac driver specific configuration,
>>>>   we don't need to add dma-names in most cases, but just let the client
>>>>   driver ask for "give me a channel with these flags".
>>> No we don't export the direction of the channel and usually channel can
>>> be configured either way.
>>
>> So yes I can see that a channel itself could be configured to support a
>> given direction, but when we ask for a channel via dma_request_channel()
>> we are going to get a channel that matches the criteria we pass using
>> the filter parameter. So here the thinking was that "flags" is a filter
>> parameter that the user could specify and one example being direction
>> but it could be something else too.
> Yes that can be done, but I am leaning towards clients not have to do
> anything :) DMAEngine needs to know mapping and when
> dma_request_channel() is called it _always_ gives you the right channel.

Ok, so are you proposing to remove the filter function and parameter
from the dma_request_channel()?

> Maybe for slave case we need to create dma_request_slave_channel() which
> has additional arguments for dmaengine to do the filtering.

Ok, so what is not clear to me is if you envision that
dma_request_slave_channel() is using a mapping table based look-up or
the DT scheme or both.

As Arnd highlighted the DT convention is to store the DMA info in each
of the device nodes and not store in a global mapping table which
conflicts with having a mapping table approach for non-DT usage. So I am
still not sure how you envision this function working for both the
non-DT and DT use-cases.

Jon
