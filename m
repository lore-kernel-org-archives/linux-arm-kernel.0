From: majun258@huawei.com (majun (F))
Date: Wed, 31 Aug 2016 14:35:42 +0800
Subject: [PATCH] generic: Add the exception case checking routine for ppi
 interrupt
In-Reply-To: <20160830112113.GE1223@leverpostej>
References: <1472530639-21616-1-git-send-email-majun258@huawei.com>
 <57C548D0.3090700@arm.com> <57C5617B.6080801@huawei.com>
 <57C568F8.20802@arm.com> <20160830112113.GE1223@leverpostej>
Message-ID: <57C67ABE.908@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc & Mark:

? 2016/8/30 19:21, Mark Rutland ??:
> On Tue, Aug 30, 2016 at 12:07:36PM +0100, Marc Zyngier wrote:
>> +Mark
>> On 30/08/16 11:35, majun (F) wrote:
>>> ? 2016/8/30 16:50, Marc Zyngier ??:
>>>> On 30/08/16 05:17, MaJun wrote:
>>>>> From: Ma Jun <majun258@huawei.com>
>>>>>
>>>>> During system booting, if the interrupt which has no action registered
>>>>> is triggered, it would cause system panic when try to access the
>>>>> action member.
>>>>
>>>> And why would that interrupt be enabled? If you enable a PPI before
>>>> registering a handler, you're doing something wrong.
>>>
>>> Actually,the problem described above happened during the capture
>>> kernel booting.
>>>
>>> In my system, sometimes there is a pending physical timer
>>> interrupt(30) when the first kernel panic and the status is kept
>>> until the capture kernel booting.
>>
>> And that's perfectly fine. The interrupt can be pending forever, as it
>> shouldn't get enabled.
>>
>>> So, this interrupt will be handled during capture kernel booting.
>>
>> Why? Who enables it?
>>
>>> Becasue we use virt timer interrupt but not physical timer interrupt
>>> in capture kernel, the interrupt 30 has no action handler.
>>
>> Again: who enables this interrupt? Whichever driver enables it should be
>> fixed.
> 
> I'm also at a loss.
> 
> In this case, arch_timer_uses_ppi must be VIRT_PPI. So in
> arch_timer_register(), we'll only request_percpu_irq the virt PPI.
> arch_timer_has_nonsecure_ppi() will be false, given arch_timer_uses_ppi
> is VIRT_PPI, so in arch_timer_starting_cpu() we'll only
> enable_percpu_irq() the virt PPI.
> 
> We don't fiddle with arch_timer_uses_ppi after calling
> arch_timer_register(). So I can't see how we could enable another IRQ in
> this case.
> 
> Looking at the driver in virt/kvm/arm/arch_timer.c, we only enable what
> we've succesfully requested, so it doesnt' seem like there's an issue
> there.
> 
>>From a quick look at teh GIC driver, it looks like we reset PPIs
> correctly, so it doesn't look like we have a "latent enable".
> 

I just checked the status of irq 30 during capture kernel booting.

The irq 30 status is: mask, pending after arch_timer_starting_cpu() called.
Because irq 30 triggered only 1 time during capture kernel booting,
I think this problem maybe happened in the case like:
1:irq 30 triggered, but not acked by cpu yet.
2:local_irq_disable() called
3:system reboot -->capture kernel booting
4:local_irq_enable()
5:irq 30 acked by CPU.

Is this case possible?

Thanks
MaJun

> Thanks,
> Mark.
> 
> .
> 
