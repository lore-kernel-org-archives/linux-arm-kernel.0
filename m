From: lars@metafoo.de (Lars-Peter Clausen)
Date: Sun, 26 Jan 2014 18:41:31 +0100
Subject: [PATCH v2] dma: Add Xilinx AXI Video Direct Memory Access Engine
 driver support
In-Reply-To: <20140126140318.GE10628@intel.com>
References: <1390409565-4200-1-git-send-email-sthokal@xilinx.com>
 <1390409565-4200-2-git-send-email-sthokal@xilinx.com>
 <52E0FC22.8060903@metafoo.de> <1390484317.7619.81.camel@smile>
 <52E11E39.6090901@metafoo.de> <1390485637.7619.88.camel@smile>
 <52E12224.9060506@metafoo.de> <20140126140318.GE10628@intel.com>
Message-ID: <52E548CB.3060105@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/26/2014 03:03 PM, Vinod Koul wrote:
> On Thu, Jan 23, 2014 at 03:07:32PM +0100, Lars-Peter Clausen wrote:
>> On 01/23/2014 03:00 PM, Andy Shevchenko wrote:
>>> On Thu, 2014-01-23 at 14:50 +0100, Lars-Peter Clausen wrote:
>>>> On 01/23/2014 02:38 PM, Shevchenko, Andriy wrote:
>>>>> On Thu, 2014-01-23 at 12:25 +0100, Lars-Peter Clausen wrote:
>>>>>> On 01/22/2014 05:52 PM, Srikanth Thokala wrote:
>>>>>
>>>>> [...]
>>>>>
>>>>>>> +	/* Request the interrupt */
>>>>>>> +	chan->irq = irq_of_parse_and_map(node, 0);
>>>>>>> +	err = devm_request_irq(xdev->dev, chan->irq, xilinx_vdma_irq_handler,
>>>>>>> +			       IRQF_SHARED, "xilinx-vdma-controller", chan);
>>>>>>
>>>>>> This is a clasic example of where to not use devm_request_irq. 'chan' is
>>>>>> accessed in the interrupt handler, but if you use devm_request_irq 'chan'
>>>>>> will be freed before the interrupt handler has been released, which means
>>>>>> there is now a race condition where the interrupt handler can access already
>>>>>> freed memory.ta
>>>>>
>>>>> Could you elaborate this case? As far as I understood managed resources
>>>>> are a kind of stack pile. In this case you have no such condition. Where
>>>>> am I wrong?
>>>>
>>>> The stacked stuff is only ran after the remove() function. Which means that
>>>> you call dma_async_device_unregister() before the interrupt handler is
>>>> freed. Another issue with the interrupt handler is a bit hidden. The driver
>>>> does not call tasklet_kill in the remove function. Which it should though to
>>>> make sure that the tasklet does not race against the freeing of the memory.
>>>> And in order to make sure that the tasklet is not rescheduled you need to
>>>> free the irq before killing the tasklet, since the interrupt handler
>>>> schedules the tasklet.
>>>
>>> So, you mean devm_request_irq() will race in any DMA driver?
>>
>> Most likely yes. devm_request_irq() is race condition prone for the majority
>> of device driver. You have to be really careful if you want to use it.
>>
>>>
>>> I think the proper solution is to disable all device work in
>>> the .remove() and devm will care about resources.
>>
>> As long as the interrupt handler is registered it can be called, the only
>> proper solution is to make sure that the order in which resources are torn
>> down is correct.
> Wouldn't it work if we register the irq last in the probe. That wil ensure on
> success the channel is always valid.

Yes, but only if the irq is not device managed. All device managed resources
will be freed after the remove function has been called. Which is to late in
our case since we make sure that the tasklet is not running in the remove
function.

- Lars
