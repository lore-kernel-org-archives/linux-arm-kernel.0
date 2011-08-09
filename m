From: grant.likely@secretlab.ca (Grant Likely)
Date: Tue, 9 Aug 2011 11:23:45 -0600
Subject: How to handle named resources with DT?
In-Reply-To: <4E4166F0.9050401@ti.com>
References: <4E40FC88.5090403@ti.com>
	<20110809162907.GA630@manju-WNB7PBC4801-0006>
	<4E4166F0.9050401@ti.com>
Message-ID: <CACxGe6tbEW1EZhqXy78EZVM_sQLH0Qbr7QOzbgbsKBRn1FtVrg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 9, 2011 at 10:57 AM, Cousson, Benoit <b-cousson@ti.com> wrote:
> Hi Manju,
>
> On 8/9/2011 6:29 PM, G, Manjunath Kondaiah wrote:
>>
>> Hi Benoit,
>>
>> On Tue, Aug 09, 2011 at 11:23:20AM +0200, Cousson, Benoit wrote:
>>>
>>> Hi Grant,
>>>
>>> Trying to bind hwmod informations with DT, I'm facing a little
>>> limitation.
>>> A bunch of drivers are using the platform_get_resource_byname, so
>>> the name for the resource is needed.
>>>
>>> The name is used so far for IORESOURCE_MEM, IORESOURCE_IRQ and
>>> IORESOURCE_DMA types of resources.
>>
>> IORESOURCE_MEM and IORESOURCE_IRQ's are fetched from dt blob and
>> it will be part of pdev.
>
> Yes, but without the proper name in the resource structure. It will be then
> impossible to use the platform_get_resource_byname function that is
> currently used by a bunch of drivers.

There is no analogous mechanism for _byname in the device tree.  The
DT binding for a device must explicitly state what order the register
ranges are in.  The driver will need to be adapted.

>
>> For IORESOURCE_DMA, you can have property
>> "dma-channel" in dtsi file and fetch dma-channel in driver probe
>> through "of_property_read_u32()" api.
>
> That will not be enough to get the name. So maybe something like:
> ? ? ? ?dmas = <12>, "rx_req", <13>, "tx_req";
> will be doable.
> The issue is that the name is optional so managing the multiple entries
> might be tricky.

DMA channels will never show up in the resource structure anyway.  The
common code only takes care of translating IRQ and register ranges.
For DMA you'll need a binding for the dma channels.  You can either
make them explicitly ordered, or use different property names for each
of the dma channels.

>
> BTW, it's strange that a default support does not exist for dma request (and
> not channel).
> The mechanism is similar to irq line, and quite standard to many SoC AFAIK.
> Or maybe I missed it.

DMA channels haven't historically had the same global scope that irq
numbers have.  There hasn't been a pressing need up to now to have
common infrastructure, though it is probably a good idea to define a
common binding.

>> BTW, this is not required for omap since dt-hwmod binding will fetch
>> pdev pointer from hwmod database and it will be used "as is" without
>> any modification which inturn does not break any existing pm
>> functionality.
>
> Well for the moment... but I have some long term plan as well:-)
>
> Thanks,
> Benoit
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>



-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
