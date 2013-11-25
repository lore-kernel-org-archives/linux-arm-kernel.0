From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 25 Nov 2013 09:37:40 +0000
Subject: Some question about GIC v1 setting
In-Reply-To: <CANudz+uoJSrM91anu5PpOqQt5gpXBEQeVaqdx25veQ=PL_aP+w@mail.gmail.com>
References: <CANudz+sg6MiUZaTELF4G=NMfwj--K9j10JrYh1cm2VAjfvq6MA@mail.gmail.com>
 <20131115165939.GO16735@n2100.arm.linux.org.uk>
 <CANudz+uO7s=GdFz64oxFEQefAB=EguUo1NP17AT+3Ft+wK8nNQ@mail.gmail.com>
 <9ab50cfbe03ffd667566808166b04573@www.loen.fr>
 <CANudz+uoJSrM91anu5PpOqQt5gpXBEQeVaqdx25veQ=PL_aP+w@mail.gmail.com>
Message-ID: <52931A64.2030804@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23/11/13 09:12, loody wrote:
> hi Marc:
> 
> 2013/11/16 Marc Zyngier <marc.zyngier@arm.com>:
>> On 2013-11-16 07:23, loody wrote:
>>>
>>> hi Russel:
>>>
>>> 2013/11/16 Russell King - ARM Linux <linux@arm.linux.org.uk>:
>>>>
>>>> On Sat, Nov 16, 2013 at 12:55:11AM +0800, loody wrote:
>>>>>
>>>>> hi all:
>>>>> I use arm cortex A9 smp with GIC v1 system.
>>>>> And my kernel is 3.8.13.
>>>>>
>>>>> I have some questions:
>>>>> 1.  From GIc v1 spec, we can modify irq priority.
>>>>>      (ICDIPRn, Interrupt Priority Rigisters)
>>>>>      how could we do that in kernel? Did kernel provide any API of Irq
>>>>> to reach that goal?
>>>>
>>>>
>>>> No.  It's pointless.  The kernel doesn't support interrupting one IRQ
>>>> while another is already in progress.
>>>
>>> in so far kernel, there are impossible
>>> 1. dynamically  change irq priority setting in GIC through kernel API
>>> 2. get higher interrupt priority when first time register requtest_irq
>>
>>
>> As Russell said, this is because Linux only models a single interrupt
>> priority.
>> The net result is that all interrupts must have the same priority.
> 
> There is some audio device on my embedded system, and they need more
> higher interrupt such that we may not easily hearing audio
> disconnection when system busy.
> 
> isn't any method to let those interrupt get higher priority?

Are you sure your audio drops are due to interrupt latency, and not just
DMA underruns because another driver is taking too long to handle its
own interrupts?

Interrupt priorities are not a valid solution to that kind of problem in
Linux, and you need to look at the root cause of your issue.

>>
>>
>>>>
>>>>> 2. From Gic V1 spec, we can assign 1 irq to multi-core.
>>>>>      (ICDIPTRn, Interrupt Processor Targets Registers)
>>>>>      Is there similar API in kernel to let 1 irq possibility to be
>>>>> handled by multi-cores?
>>>>
>>>>
>>>> No.  All that does is lead to cores being woken up and racing on locks,
>>>> and then causing IRQs to be spuriously marked as false (because there's
>>>> nothing for the handlers to do on the cores which lost out).
>>>
>>> In Gic spec, if 1 core service the irq, other cores will read invalid
>>> #1023 if accidentally they are waken up by GIC.
>>>
>>> Why that will let cores racing on locks?
>>>
>>> if accidentally waken up by GIC, and cores read #1023, cores can
>>> return back immediately.
>>
>>
>> Hence wasting a lot of time and energy on all the other cores.
>> The question is: why do you want to do that?
> We found some interrupt seems cannot be serviced in time.
> Since GIC spec mentioned about supporting multi-core handing
> interrupt, but we see only 1 core handle all irq after kernel boot up.
> So I send a mail to check whether arm kernel support multi-core handle irq.

You can always redirect an interrupt to another CPU. Just write a
cpumask to /proc/irq/[irqnr]/smp_affinity. This will cause the GIC
distributor to be programmed with another CPU as a target.

See if that improves your issue, but my gut feeling is that you would
simply paper over other issues.

	M.
-- 
Jazz is not dead. It just smells funny...
