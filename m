From: jaswinder.singh@linaro.org (Jassi Brar)
Date: Mon, 7 May 2012 22:49:36 +0530
Subject: [PATCH V3 1/2] of: Add generic device tree DMA helpers
In-Reply-To: <4FA7F009.5010003@wwwdotorg.org>
References: <1335820679-28721-1-git-send-email-jon-hunter@ti.com>
 <4FA3F308.6030900@ti.com>
 <CAJe_ZhfFhZVG4gyaaVUgeQedJiSE=zj9nE28XCNH9DkPVgqj=A@mail.gmail.com>
 <201205041923.07620.arnd@arndb.de>
 <CAJe_Zhe8jYd1j=ti6FvqxXL7i5mbgf0jqb-84sFMTeUqyAonpw@mail.gmail.com>
 <4FA7F009.5010003@wwwdotorg.org>
Message-ID: <CAJe_ZheHFP9NZEiZfCvS3LL1k7xamzGq4Oep8gfmPRi6RR7R5Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7 May 2012 21:23, Stephen Warren <swarren@wwwdotorg.org> wrote:
> On 05/05/2012 11:10 AM, Jassi Brar wrote:
>
>> Hmm... there ought to be a way by which a client is handed a random 'token'
>> via its dt node and similarly the dmac informed which channel (and with what
>> capabilities) to allocate should it see a request coming with that token.
>
> I think that's the whole point of the patch.
>
> However, the token needs to be some driver-specific struct, since the
> required information may be more than just a single channel or request
> ID in general.
>
Well, what I call 'token' could just as well be some numerical hash of
what you call 'driver-specific struct'.
And I never thought we could do without h/w specific information,
just that peculiarities lie with the dmac controllers and that's where
the discerning should happen.

Our opinions differ in that, I believe client side shouldn't need to
parse/decode the h/w specific parameters from data gotten via DT
(what I call 'token' and you 'driver-specific struct') - because that is
the key to having common client drivers working with different dma
controllers. And yes, I don't think we could find a future proof generic
and simple enough representation of dma resource specification in a
DT node :)

Instead, I suggest we encode the finer details of each channel-request
in node of the dma controller matched against the 'token' assigned
to the respective clients. That encoding("channel_id") would be dma
controller specific and if we also manage to contain it within fixed number
of bytes we could also have common helpers for fetching it, though
it still would need to be decoded by dmac controller driver - which I think
we can't do without, considering the variety of dma floating around.


>> That way dmac and client drivers using DT could do away with the filter_fn.
>>
>> Roughly speaking (I am not very well versed with DT syntax)
>>
>> Client Node:-
>>
>> mmc1: mmc at 13002000 {
>> ? ? ? ? ...
>> ? ? ? ? dma_tx = <891> ? //some platform-wide unique value
>> ? ? ? ? dma_rx = <927> ? //some platform-wide unique value
>> ? ? ? ? ...
>> ?};
>
> I believe we specifically don't want to introduce any global concept of
> DMA channel ID, either within the kernel, or at the device tree level.
>
I don't think these tokens have to be global.
They just need to be common for .dts that define client and dmac nodes
- which would usually be the same file. They just have to be unique across
all dma clients on a given machine.
