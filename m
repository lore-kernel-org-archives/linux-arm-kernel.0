From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Wed, 2 Dec 2015 14:29:33 +0200
Subject: [RFC v02 00/15] dmaengine: New 'universal' API for requesting
 channel
In-Reply-To: <3124382.EhiMyQGKTA@wuerfel>
References: <1448891145-10766-1-git-send-email-peter.ujfalusi@ti.com>
 <20151201165954.GA1696@localhost> <3124382.EhiMyQGKTA@wuerfel>
Message-ID: <565EE42D.2030705@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/01/2015 10:17 PM, Arnd Bergmann wrote:
> On Tuesday 01 December 2015 22:29:54 Vinod Koul wrote:
>> On Mon, Nov 30, 2015 at 03:45:30PM +0200, Peter Ujfalusi wrote:
>>> channel via DT, ACPI or in case if the kernel booted in non DT/ACPI mode
>>> it will use a filter lookup table and retrieves the needed information from
>>> the dma_filter_map provided by the DMA drivers.
>>
>> That sounds right, for the third case would the arch, driver or someone else
>> configure this?
> 
> The typical case is for the configuration to be defined in arch or platform
> code and passed down to the dmaengine driver.
> 
> I just noticed that the text above (and probably the code too) should
> be changed so we always fall back to this. There are cases where the
> platform is booted with DT in principle, but the DMA engine does not
> (yet) use DT and still wants to be converted. I think we can easily
> handle that case by always trying this if the other methods fail.

Yes, it was intentional actually to not fall back to legacy lookup. With the
dma_request_slave_channel_compat() I have had cases when the DT binding was
not correct - or actually when trying to get deferred working that the code
would fall back to legacy mode and it got me a channel which is not usable.
I did not know that we have platforms booting in DT but the dma binding is not
working so it uses other method to get channel.
I think, if we allow the fall back within dma_request_chan() it would not
cause the same issue as the dma_request_slave_channel_compat() did as long as
we are not providing the lookup table on DT booted cases when the DMA binding
is working correctly.
Let me see the flow, but I think it is doable.

-- 
P?ter
