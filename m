From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 07 May 2012 09:53:45 -0600
Subject: [PATCH V3 1/2] of: Add generic device tree DMA helpers
In-Reply-To: <CAJe_Zhe8jYd1j=ti6FvqxXL7i5mbgf0jqb-84sFMTeUqyAonpw@mail.gmail.com>
References: <1335820679-28721-1-git-send-email-jon-hunter@ti.com>
 <4FA3F308.6030900@ti.com>
 <CAJe_ZhfFhZVG4gyaaVUgeQedJiSE=zj9nE28XCNH9DkPVgqj=A@mail.gmail.com>
 <201205041923.07620.arnd@arndb.de>
 <CAJe_Zhe8jYd1j=ti6FvqxXL7i5mbgf0jqb-84sFMTeUqyAonpw@mail.gmail.com>
Message-ID: <4FA7F009.5010003@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/05/2012 11:10 AM, Jassi Brar wrote:
> On 5 May 2012 00:53, Arnd Bergmann <arnd@arndb.de> wrote:
>> On Friday 04 May 2012, Jassi Brar wrote:
>>> I see this requires a client driver to specify a particular req_line on a
>>> particular dma controller. I am not sure if this is most optimal.
>>>
>>> I think such client->req_line map should be provided to the dmac controller
>>> driver via its dt node in some format. The dmac driver could then populate
>>> a dma_chan, or similar, only for that req_line and not for the unused one
>>> which otherwise could also have served the same client.
>>>
>>> Ideally the I2C driver should simply ask, say, a channel for TX and another
>>> for RX, everything else should already be setup via dmac's dt nodes.
>>
>> If I understand you correctly, you think we can generalize the dma-request
>> data in a way that we don't need to pass a specific dma engine phandle.
>> I very much doubt this is possible, given how different the requirements
>> are for each of the engines we support. You really need to pass a specific
>> phandle so that we can find the code that can interpret the data in a
>> meaningful way.
>>
> Hmm... there ought to be a way by which a client is handed a random 'token'
> via its dt node and similarly the dmac informed which channel (and with what
> capabilities) to allocate should it see a request coming with that token.

I think that's the whole point of the patch.

However, the token needs to be some driver-specific struct, since the
required information may be more than just a single channel or request
ID in general.

> That way dmac and client drivers using DT could do away with the filter_fn.
> 
> Roughly speaking (I am not very well versed with DT syntax)
> 
> Client Node:-
> 
> mmc1: mmc at 13002000 {
>         ...
>         dma_tx = <891>   //some platform-wide unique value
>         dma_rx = <927>   //some platform-wide unique value
>         ...
>  };

I believe we specifically don't want to introduce any global concept of
DMA channel ID, either within the kernel, or at the device tree level.

While we do have global interrupt and GPIO IDs within the kernel, this
has caused problems, I think primarily due to the need to manage this
unified namespace and allocate a single global ID for a bunch of
different ranges of controller-specific IDs.

Within device tree, everything is always represented as an ID
relative-to or within a particular controller, so it's easy to namespace
things separately.
