From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 05 Dec 2013 09:59:16 -0700
Subject: [PATCH V3] dma: add channel request API that supports deferred
 probe
In-Reply-To: <CAPcyv4hG_ttwACNBWrSdGC8EZpKM=v+Q5opUdLj+R9UUhJd=hA@mail.gmail.com>
References: <1385416039-3170-1-git-send-email-swarren@wwwdotorg.org>	<1385474368.1871.6.camel@smile>	<5294CE5C.1090901@wwwdotorg.org>
 <CAPcyv4hG_ttwACNBWrSdGC8EZpKM=v+Q5opUdLj+R9UUhJd=hA@mail.gmail.com>
Message-ID: <52A0B0E4.7000204@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/26/2013 09:44 AM, Dan Williams wrote:
> On Tue, Nov 26, 2013 at 8:37 AM, Stephen Warren <swarren@wwwdotorg.org> wrote:
>> On 11/26/2013 06:59 AM, Shevchenko, Andriy wrote:
>>> On Mon, 2013-11-25 at 14:47 -0700, Stephen Warren wrote:
>>>> From: Stephen Warren <swarren@nvidia.com>
>>>>
>>>> dma_request_slave_channel() simply returns NULL whenever DMA channel
>>>> lookup fails. Lookup could fail for two distinct reasons:
>>>>
>>>> a) No DMA specification exists for the channel name.
>>>>    This includes situations where no DMA specifications exist at all, or
>>>>    other general lookup problems.
>>>>
>>>> b) A DMA specification does exist, yet the driver for that channel is not
>>>>    yet registered.
>>>>
>>>> Case (b) should trigger deferred probe in client drivers. However, since
>>>> they have no way to differentiate the two situations, it cannot.
>>>>
>>>> Implement new function dma_request_slave_channel_or_err(), which performs
>>>> identically to dma_request_slave_channel(), except that it returns an
>>>> error-pointer rather than NULL, which allows callers to detect when
>>>> deferred probe should occur.
>>>>
>>>> Eventually, all drivers should be converted to this new API, the old API
>>>> removed, and the new API renamed to the more desirable name. This patch
>>>> doesn't convert the existing API and all drivers in one go, since some
>>>> drivers call dma_request_slave_channel() then dma_request_channel() if
>>>> that fails. That would require either modifying dma_request_channel() in
>>>> the same way, or adding extra error-handling code to all affected
>>>> drivers, and there are close to 100 drivers using the other API, rather
>>>> than just the 15-20 or so that use dma_request_slave_channel(), which
>>>> might be tenable in a single patch.
>>>>
>>>> acpi_dma_request_slave_chan_by_name() doesn't currently implement
>>>> deferred probe. It should, but this will be addressed later.
...
>> OK, I've fixed that up locally. I assume it's not worth a repost just
>> for that change, although I will repost if the DMA maintainers want to
>> create the topic branches rather than me, but there's been no word on
>> that yet.
> 
> That might be best and Vinod should be back.  Vinod do you want to
> queue this one up to a topic branch so that the arm-soc tree can pull
> it?

Vinod, V4 of this patch addressed Dan's final minor comments on this
patch. Does it look OK to you? If you could apply it to a topic
branch[1] soon, that would be extremely helpful; I'm waiting for this
patch (and also "dma: add dma_get_any_slave_channel(), for use in
of_xlate()") in order to apply a lot of others.

[1] see notes I posted in the patch:

This patch is a dependency for:
* A series that reworks many of the Tegra drivers.
* A series that enhances ASoC's dmaengine code to support deferred
  probe.

As such, it needs to go into a topic branch on its own, based directly
on 3.13-rc1. If the DMA maintainers ack the patches I'm happy to create
this topic branch myself and send a pull request to the DMA tree. Or the
patches can be applied to a topic branch by the DMA maintainers and I
will merge their topic branch into the Tegra rework branch that I
mentioned.

Thanks.
