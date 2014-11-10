From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 10 Nov 2014 18:09:31 +0100
Subject: [PATCH 1/7] irqchip: armada-370-xp: Simplify interrupt map, mask
 and unmask
In-Reply-To: <5458ECBE.2020202@free-electrons.com>
References: <1413985427-20918-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1413985427-20918-2-git-send-email-ezequiel.garcia@free-electrons.com>
 <5453BAA7.1040804@free-electrons.com> <5458ECBE.2020202@free-electrons.com>
Message-ID: <5460F14B.7060702@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ezequiel,

On 04/11/2014 16:11, Ezequiel Garcia wrote:
> Hi Gregory,
> 
> On 10/31/2014 01:36 PM, Gregory CLEMENT wrote:
>> On 22/10/2014 15:43, Ezequiel Garcia wrote:
>>> The map, mask and unmask is unnecessarily complicated, with a different
>>> implementation for shared and per CPU interrupts. The current code does
>>> the following:
>>>
>>> At probe time, all interrupts are disabled and masked on all CPUs.
>>>
>>> Shared interrupts:
>>>
>>>  * When the interrupt is mapped(), it gets disabled and unmasked on the
>>>    calling CPU.
>>>
>>>  * When the interrupt is unmasked(), masked(), it gets enabled and
>>>    disabled.
>>>
>>> Per CPU interrupts:
>>>
>>>  * When the interrupt is mapped, it gets masked on the calling CPU and
>>>    enabled.
>>>
>>>  * When the interrupt is unmasked(), masked(), it gets unmasked and masked,
>>>    on the calling CPU.
>>>
>>> This commit simplifies this code, with a much simpler implementation, common
>>> to shared and per CPU interrupts.
>>>
>>>  * When the interrupt is mapped, it's enabled.
>>>
>>>  * When the interrupt is unmasked(), masked(), it gets unmasked and masked,
>>>    on the calling CPU.
>>
>> By doing this you change the behavior of the irqchip. Before this patch, masking
>> a shared interrupt was masking it on all the CPUs in the same time whereas with this
>> change it will mask the interrupt only on the calling CPU. It worth checking it is
>> the expected behavior.
>>
> 
> The kernel will always mask/unmask on the appropriate CPU, so I don't see any
> issues with this.
> 
>> Moreover I wonder how it is supposed to work with the irq affinity. Let say that the
>> irq was enabled on the CPU0,
> 
> If you mean enabled as in irq_enable(irq_desc), then let's keep in mind that
> currently that calls .irq_unmask.
> 
>> then there is irq_unmask call on CPU1, then the irq would be enabled on both CPUs.
>> It will modify the irq affinity and moreover it will also lead
>> to an invalidate state with the MPIC because we can't manage an interrupt on more than
>> one CPU.
>>
>> From the point of the view of the armada_370_xp_irq driver there are potential bug, but
>> maybe the use case I described can't happen. Could you check it?
>>
> 
> In this irqchip driver, shared interrupts are handled via handle_level_irq(),
> which masks() and unmasks() the interrupt. In other words, it's always done
> in the same CPU. I guess this is the most frequent mask/unmask operation.
> 
> On the other side, if a driver calls enable_irq() on one CPU and then
> enable_irq() on the other CPU, that's exactly what will happen. Although the
> smp_affinity setting will prevent an interrupt from being dispatched to more
> than one CPU.
> 
> I really don't see an issue with this patch, but I think it needs as much
> discussion and as much testing as possible. This piece of code is rather
> critical, and is working just fine, so I'd like to have an excellent 
> reason before changing any of it.

We already talked about it on IRC but I write it agin o let the other people know
our status on this subject.

If a driver call irq_enable() then this functions will call irq_enable() and as we didn't
implement a .enbale() operation, it will call our only unmask() function.

So if the IRQ was unmasked on a CPU and a driver call an irq_enable() from an other CPU then
we will end up with the IRQ enabled on 2 different CPUs. It is a problem for 2 reasons:
- our hardware don't handle a IRQ enable on more than one CPU
- it will modify the affinity at the hardware level because a new CPU will be able to
receive an irq whereas we setup the affinity on only one CPU.

By only using the mask and unmask registers we will need to handle the affinity by
software instead of using the hardware. I agree that the current code is not trivial,
but adding more comment instead of removing this capability should be better.


Thanks,

Gregory







-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
