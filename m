From: zhongjiang@huawei.com (zhong jiang)
Date: Thu, 16 Aug 2018 18:18:44 +0800
Subject: [PATCH] arm/mach-at91/pm: Do not double put the device node
In-Reply-To: <59e252e6-6027-9f52-9ee8-8d0bd32659d2@microchip.com>
References: <1534211696-4221-1-git-send-email-zhongjiang@huawei.com>
 <20180814125954.GM943@piout.net>
 <59e252e6-6027-9f52-9ee8-8d0bd32659d2@microchip.com>
Message-ID: <5B754F84.3070502@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2018/8/16 17:32, Claudiu Beznea wrote:
> Hi Alexandre,
>
> On 14.08.2018 15:59, Alexandre Belloni wrote:
>> On 14/08/2018 09:54:56+0800, zhong jiang wrote:
>>> Device node iterators put the previous value of the index variable,
>>> so an explicit put causes a double put.
>>>
>> While for_each_matching_node_and_match will get and put the node
>> properly, there is also a call to of_find_device_by_node that will get a
>> reference to the node.
>>
> Looking through of_find_device_by_node() it seems that a put_device() on the
> struct device member of the returned struct platform_device has to be called
> instead of of_node_put().
>
> of_find_device_by_node() calls bus_find_device():
>
> dev = bus_find_device(&platform_bus_type, NULL, np, of_dev_node_match); 
>
> the match function, of_dev_node_match(), is just as follows:
>
> static int of_dev_node_match(struct device *dev, void *data)                    
> {                                                                               
>         return dev->of_node == data;                                            
> }                                                                               
>
> but bus_find_device() takes a reference to the struct device returned in case it
> founds a match, via get_device():
>
> struct device *bus_find_device(struct bus_type *bus,                            
>                                struct device *start, void *data,                
>                                int (*match)(struct device *dev,
> 			       void*data))    
> {                                                                               
>         struct klist_iter i;                                                    
>         struct device *dev;                                                     
>                                                                                 
>         if (!bus || !bus->p)                                                    
>                 return NULL;                                                    
>                                                                                 
>         klist_iter_init_node(&bus->p->klist_devices, &i,                        
>                              (start ? &start->p->knode_bus : NULL));            
>         while ((dev = next_device(&i)))                                         
>                 if (match(dev, data) && get_device(dev))                        
>                         break;                                                  
>         klist_iter_exit(&i);                                                    
>         return dev;                                                             
> }                                                                               
>
> So, I think a put_device(&pdev->dev) has to be called in at91_pm_config_ws()
> instead of of_node_put(np). My bad!
Yes, you're right. Thanks, Claudiu. I will repost in v2.

Sincerely,
zhong jiang
> Thank you,
> Claudiu Beznea
>
>>> I detect the issue with the help of Coccinelle.
>>>
>>> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
>>> ---
>>>  arch/arm/mach-at91/pm.c | 5 +----
>>>  1 file changed, 1 insertion(+), 4 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
>>> index 32fae4d..a5ec35f 100644
>>> --- a/arch/arm/mach-at91/pm.c
>>> +++ b/arch/arm/mach-at91/pm.c
>>> @@ -143,15 +143,12 @@ static int at91_pm_config_ws(unsigned int pm_mode, bool set)
>>>  
>>>  			/* Check if enabled on SHDWC. */
>>>  			if (wsi->shdwc_mr_bit && !(val & wsi->shdwc_mr_bit))
>>> -				goto put_node;
>>> +				continue;
>>>  
>>>  			mode |= wsi->pmc_fsmr_bit;
>>>  			if (wsi->set_polarity)
>>>  				polarity |= wsi->pmc_fsmr_bit;
>>>  		}
>>> -
>>> -put_node:
>>> -		of_node_put(np);
>>>  	}
>>>  
>>>  	if (mode) {
>>> -- 
>>> 1.7.12.4
>>>
> .
>
