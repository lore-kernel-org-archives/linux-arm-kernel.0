From: b-cousson@ti.com (Cousson, Benoit)
Date: Tue, 9 Aug 2011 18:57:20 +0200
Subject: How to handle named resources with DT?
In-Reply-To: <20110809162907.GA630@manju-WNB7PBC4801-0006>
References: <4E40FC88.5090403@ti.com>
	<20110809162907.GA630@manju-WNB7PBC4801-0006>
Message-ID: <4E4166F0.9050401@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Manju,

On 8/9/2011 6:29 PM, G, Manjunath Kondaiah wrote:
> Hi Benoit,
>
> On Tue, Aug 09, 2011 at 11:23:20AM +0200, Cousson, Benoit wrote:
>> Hi Grant,
>>
>> Trying to bind hwmod informations with DT, I'm facing a little limitation.
>> A bunch of drivers are using the platform_get_resource_byname, so
>> the name for the resource is needed.
>>
>> The name is used so far for IORESOURCE_MEM, IORESOURCE_IRQ and
>> IORESOURCE_DMA types of resources.
>
> IORESOURCE_MEM and IORESOURCE_IRQ's are fetched from dt blob and
> it will be part of pdev.

Yes, but without the proper name in the resource structure. It will be 
then impossible to use the platform_get_resource_byname function that is 
currently used by a bunch of drivers.

> For IORESOURCE_DMA, you can have property
> "dma-channel" in dtsi file and fetch dma-channel in driver probe
> through "of_property_read_u32()" api.

That will not be enough to get the name. So maybe something like:
	dmas = <12>, "rx_req", <13>, "tx_req";
will be doable.
The issue is that the name is optional so managing the multiple entries 
might be tricky.

BTW, it's strange that a default support does not exist for dma request 
(and not channel).
The mechanism is similar to irq line, and quite standard to many SoC 
AFAIK. Or maybe I missed it.

> BTW, this is not required for omap since dt-hwmod binding will fetch
> pdev pointer from hwmod database and it will be used "as is" without
> any modification which inturn does not break any existing pm
> functionality.

Well for the moment... but I have some long term plan as well:-)

Thanks,
Benoit
