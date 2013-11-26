From: dan.j.williams@intel.com (Dan Williams)
Date: Tue, 26 Nov 2013 08:44:48 -0800
Subject: [PATCH V3] dma: add channel request API that supports deferred
 probe
In-Reply-To: <5294CE5C.1090901@wwwdotorg.org>
References: <1385416039-3170-1-git-send-email-swarren@wwwdotorg.org>
 <1385474368.1871.6.camel@smile> <5294CE5C.1090901@wwwdotorg.org>
Message-ID: <CAPcyv4hG_ttwACNBWrSdGC8EZpKM=v+Q5opUdLj+R9UUhJd=hA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 26, 2013 at 8:37 AM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> On 11/26/2013 06:59 AM, Shevchenko, Andriy wrote:
>> On Mon, 2013-11-25 at 14:47 -0700, Stephen Warren wrote:
>>> From: Stephen Warren <swarren@nvidia.com>
>>>
>>> dma_request_slave_channel() simply returns NULL whenever DMA channel
>>> lookup fails. Lookup could fail for two distinct reasons:
>>>
>>> a) No DMA specification exists for the channel name.
>>>    This includes situations where no DMA specifications exist at all, or
>>>    other general lookup problems.
>>>
>>> b) A DMA specification does exist, yet the driver for that channel is not
>>>    yet registered.
>>>
>>> Case (b) should trigger deferred probe in client drivers. However, since
>>> they have no way to differentiate the two situations, it cannot.
>>>
>>> Implement new function dma_request_slave_channel_or_err(), which performs
>>> identically to dma_request_slave_channel(), except that it returns an
>>> error-pointer rather than NULL, which allows callers to detect when
>>> deferred probe should occur.
>>>
>>> Eventually, all drivers should be converted to this new API, the old API
>>> removed, and the new API renamed to the more desirable name. This patch
>>> doesn't convert the existing API and all drivers in one go, since some
>>> drivers call dma_request_slave_channel() then dma_request_channel() if
>>> that fails. That would require either modifying dma_request_channel() in
>>> the same way, or adding extra error-handling code to all affected
>>> drivers, and there are close to 100 drivers using the other API, rather
>>> than just the 15-20 or so that use dma_request_slave_channel(), which
>>> might be tenable in a single patch.
>>>
>>> acpi_dma_request_slave_chan_by_name() doesn't currently implement
>>> deferred probe. It should, but this will be addressed later.
>>
>> Couple of comments below.
>>
>> []
>>
>>> --- a/drivers/dma/of-dma.c
>>> +++ b/drivers/dma/of-dma.c
>>
>> []
>>
>>> @@ -152,17 +152,18 @@ struct dma_chan *of_dma_request_slave_channel(struct device_node *np,
>>>      struct of_dma           *ofdma;
>>>      struct dma_chan         *chan;
>>>      int                     count, i;
>>> +    int                     ret_no_channel = -ENODEV;
>>
>> Could we re-use chan for the error as well?
>
> No, because that gets over-written each time ofdma->of_dma_xlate() is
> called, and that could fail and cause the result not to be returned, and
> then we would have lost any -EPROBE_DEFERRED value that was stored there
> to be returned in the nothing-found case.
>
>>> @@ -174,8 +175,10 @@ struct dma_chan *of_dma_request_slave_channel(struct device_node *np,
>>>
>>>              if (ofdma)
>>
>> if (ofdma) {
>> ...
>>
>>>                      chan = ofdma->of_dma_xlate(&dma_spec, ofdma);
>>> -            else
>>> +            else {
>>
>> } else {
>>
>> to keep style.
>
> OK, I've fixed that up locally. I assume it's not worth a repost just
> for that change, although I will repost if the DMA maintainers want to
> create the topic branches rather than me, but there's been no word on
> that yet.

That might be best and Vinod should be back.  Vinod do you want to
queue this one up to a topic branch so that the arm-soc tree can pull
it?
