From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Mon, 24 Feb 2014 16:38:00 -0500
Subject: [PATCH 4/4] ARM: keystone: Use dma-ranges for dma_pfn_offset
 configuration
In-Reply-To: <5593544.ET3nngKczF@wuerfel>
References: <1393275235-1087-1-git-send-email-santosh.shilimkar@ti.com>
 <1393275235-1087-5-git-send-email-santosh.shilimkar@ti.com>
 <5593544.ET3nngKczF@wuerfel>
Message-ID: <530BBBB8.3020607@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 24 February 2014 04:11 PM, Arnd Bergmann wrote:
> On Monday 24 February 2014 15:53:55 Santosh Shilimkar wrote:
>> From: Grygorii Strashko <grygorii.strashko@ti.com>
>>  }
>>  
>> +static unsigned long get_dma_pfn_offset(struct device *dev)
>> +{
>> +	struct device_node *node = of_node_get(dev->of_node);
>> +	const u32 *ranges = NULL;
>> +	int len, naddr, nsize, pna;
>> +	dma_addr_t dma_addr;
>> +	phys_addr_t cpu_addr, size;
>> +	unsigned long dma_pfn_offset = 0;
>> +
>> +	if (!node)
>> +		return 0;
> 
> Hmm, isn't this function the same as of_translate_dma_address()?
> 
> I think we should have the implementation in common code, not hidden
> in the keystone platform, to avoid duplication. If of_translate_dma_address
> doesn't work, what is the problem, and can you fix it there?
> 
Will have a look at it and get back. At least it makes sense to
use/update the common function.

>>  static int keystone_platform_notifier(struct notifier_block *nb,
>>  				      unsigned long event, void *dev)
>>  {
>> +	struct device *_dev = dev;
>> +
>>  	if (event != BUS_NOTIFY_ADD_DEVICE)
>>  		return NOTIFY_DONE;
> 
> Style: it would be nicer to name the local variable 'dev' and the
> argument something else like 'p' or 'data'.
>
Agree. Will update that.
 
> I also wonder if this shouldn't be in ARM architecture wide code
> rather than platform code. Unfortunately it can't be in drivers/base
> since the offset is stored in an ARM specific location.
> 
Notifier callback is in mach code mainly because platform's might have to
do custom things here. Like setting up the coherent masters,
populating the dma_pfn_offset or populating custom dma_ops etc.
As such the in these callbacks is not much and I see only
couple of machines using it.

Regards,
Santosh
