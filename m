From: majun258@huawei.com (majun (F))
Date: Thu, 1 Sep 2016 16:15:50 +0800
Subject: [PATCH] generic: Add the exception case checking routine for ppi
 interrupt
In-Reply-To: <57C696DA.4090301@arm.com>
References: <1472530639-21616-1-git-send-email-majun258@huawei.com>
 <57C548D0.3090700@arm.com> <57C5617B.6080801@huawei.com>
 <57C568F8.20802@arm.com> <20160830112113.GE1223@leverpostej>
 <57C67ABE.908@huawei.com> <57C696DA.4090301@arm.com>
Message-ID: <57C7E3B6.1040605@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



? 2016/8/31 16:35, Marc Zyngier ??:
> On 31/08/16 07:35, majun (F) wrote:
[...]
>>>
>>
>> I just checked the status of irq 30 during capture kernel booting.
>>
>> The irq 30 status is: mask, pending after arch_timer_starting_cpu() called.
>> Because irq 30 triggered only 1 time during capture kernel booting,
>> I think this problem maybe happened in the case like:
>> 1:irq 30 triggered, but not acked by cpu yet.
>> 2:local_irq_disable() called
>> 3:system reboot -->capture kernel booting
>> 4:local_irq_enable()
>> 5:irq 30 acked by CPU.
>>
>> Is this case possible?
> 
> I can't see how, because you've missed:
> 
> 3b: All PPIs are disabled as each CPU comes up
> 
> So for (5) to occur, I can only see two possibilities:
> (a) either something else is enabling the timer PPI

I checked the whole process, the irq 30 alway keeping disabled.

> (b) your GIC doesn't correctly retire a pending PPI that is being disabled

According to our hardware guy said, GIC in our system has problem in this case.
Usually, when we mask irq 30, the interrupt which in pending status but not acked by cpu
should be released/cleared by hardware, but actually, we did't do like this in our system.

So, this conclusion just same as you assumption.

Do you have any suggestion or workaround for this problem?

Thanks!
Majun

> 
> I'm discounting (b) because I can't see how the system would work
> otherwise, so (a) must be happening somehow.
> 


> Thanks,
> 
> 	M.
> 
