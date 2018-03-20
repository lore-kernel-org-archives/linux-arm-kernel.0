From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 20 Mar 2018 16:06:41 +0000
Subject: Failed to boot ARM64 boards for recent linux-next
In-Reply-To: <cbc89d68-ba41-1f6a-4ab2-4c9647b48f75@huawei.com>
References: <dae4b3b8-3da4-4a86-ac4a-0631802fa546@rock-chips.com>
 <077cecdd-7982-dd33-454f-e38cc571366c@arm.com>
 <9cff515e-fcb9-a1c0-329b-a18c3bed0071@rock-chips.com>
 <fe56e7e3-50dd-88de-ce61-f3cbcc1f572b@rock-chips.com>
 <5AB0DEB2.4000803@rock-chips.com>
 <e603186e-b9e8-c7d5-b98a-f5bcce94f7d5@arm.com>
 <cbc89d68-ba41-1f6a-4ab2-4c9647b48f75@huawei.com>
Message-ID: <d18d6f27-7270-d2d7-58b9-3bf16ffe6b0a@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi John,

On 20/03/18 15:52, John Garry wrote:
> On 20/03/2018 13:34, Marc Zyngier wrote:
>> On 20/03/18 10:13, JeffyChen wrote:
>>> Hi Shawn,
>>>
>>> On 03/20/2018 05:39 PM, Shawn Lin wrote:
>>>>
>>>>
>>>> Also another patch warns a lot when booting the kernel. Is there
>>>> anything else I could do to let it go? Seems I am using broken
>>>> dts for requesting IRQ_TYPE_NONE there?
>>>
>>> could be:
>>> https://github.com/torvalds/linux/blob/master/drivers/irqchip/irq-gic-v3.c#L1145
>>>
>>> 		struct irq_fwspec ppi_fwspec = {
>>> 			.fwnode		= gic_data.fwnode,
>>> 			.param_count	= 3,
>>> 			.param		= {
>>> 				[0]	= 1,
>>> 				[1]	= i,
>>> 				[2]	= IRQ_TYPE_NONE, <--
>>> 			},
>>> 		};
>>>
>>> 		irq = irq_create_fwspec_mapping(&ppi_fwspec);
>>
>> Probably is. Caught at my own game, fun! ;-)
>>
>> Turning that NONE into LEVEL will work, as there is no known PPIs
>> configured as edge (specially in a partitioned system), but the general
>> case isn't pretty. I'll queue a workaround for now, and will look at
>> addressing the more general issue.
>>
> 
> JFYI, reverting the original patch mentioned by Shawn resolved the boot 
> hang I was seeing on my Huawei D03. My D05 was fine without the revert.

I guess your D05 doesn't set SCR_EL3.FIQ, meaning that no Group-0
interrupts can reach the firmware. Hopefully it doesn't need them.

Would you mind testing the last patch I posted earlier today[1]?

Thanks,

	M.

[1] https://www.spinics.net/lists/arm-kernel/msg642440.html
-- 
Jazz is not dead. It just smells funny...
