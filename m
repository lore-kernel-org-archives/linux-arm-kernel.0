From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 19 Feb 2016 11:49:43 +0000
Subject: A gic problem about eoi
In-Reply-To: <56C6B895.6070400@huawei.com>
References: <56C5500A.2060104@huawei.com> <20160218090033.289de1c3@arm.com>
 <56C6B895.6070400@huawei.com>
Message-ID: <56C70157.8010505@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19/02/16 06:39, Yang Yingliang wrote:
> 
> 
> On 2016/2/18 17:00, Marc Zyngier wrote:
>> On Thu, 18 Feb 2016 13:00:58 +0800
>> Yang Yingliang <yangyingliang@huawei.com> wrote:
>>
>> Hi Yang,
>>
>>> Hi, Marc
>>>
>>> We found if hardware clear pending and active status is slower than
>>> software handling, the new sgi will be merged because of hardware
>>> status. The new sgi will be lost.
>>>
>>> If we add a dsb instruction after gic_write_eoir(), it can avoid this
>>> case happening.
>>>
>>> Is it a right way to add a dsb instruction after gic_write_eoir()
>>> in current gic driver code ?
>>
>> I suspect your problem is not so much the EOI, but that the read of
>> ICC_IAR1_EL1 doesn't propagate the Ack quickly enough, leading to the
>> transition from pending to active to still be in flux when the interrupt
>> is EOIed. This is where a DSB is required (and was missing until very
>> recently).
>>
>> Does 1a1ebd5 ("irqchip/gic-v3: Make sure read from ICC_IAR1_EL1 is
>> visible on redestributor") solve your problem?
> 
> I tested this patch, it can solve the problem.
> 
> Will this patch queue to stable ?

Yes - It may not directly apply to older versions, but it is pretty
trivial to backport.

Thanks for testing,

	M.
-- 
Jazz is not dead. It just smells funny...
