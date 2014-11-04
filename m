From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Tue, 04 Nov 2014 12:11:58 -0300
Subject: [PATCH 1/7] irqchip: armada-370-xp: Simplify interrupt map, mask
 and unmask
In-Reply-To: <5453BAA7.1040804@free-electrons.com>
References: <1413985427-20918-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1413985427-20918-2-git-send-email-ezequiel.garcia@free-electrons.com>
 <5453BAA7.1040804@free-electrons.com>
Message-ID: <5458ECBE.2020202@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Gregory,

On 10/31/2014 01:36 PM, Gregory CLEMENT wrote:
> On 22/10/2014 15:43, Ezequiel Garcia wrote:
>> The map, mask and unmask is unnecessarily complicated, with a different
>> implementation for shared and per CPU interrupts. The current code does
>> the following:
>>
>> At probe time, all interrupts are disabled and masked on all CPUs.
>>
>> Shared interrupts:
>>
>>  * When the interrupt is mapped(), it gets disabled and unmasked on the
>>    calling CPU.
>>
>>  * When the interrupt is unmasked(), masked(), it gets enabled and
>>    disabled.
>>
>> Per CPU interrupts:
>>
>>  * When the interrupt is mapped, it gets masked on the calling CPU and
>>    enabled.
>>
>>  * When the interrupt is unmasked(), masked(), it gets unmasked and masked,
>>    on the calling CPU.
>>
>> This commit simplifies this code, with a much simpler implementation, common
>> to shared and per CPU interrupts.
>>
>>  * When the interrupt is mapped, it's enabled.
>>
>>  * When the interrupt is unmasked(), masked(), it gets unmasked and masked,
>>    on the calling CPU.
> 
> By doing this you change the behavior of the irqchip. Before this patch, masking
> a shared interrupt was masking it on all the CPUs in the same time whereas with this
> change it will mask the interrupt only on the calling CPU. It worth checking it is
> the expected behavior.
> 

The kernel will always mask/unmask on the appropriate CPU, so I don't see any
issues with this.

> Moreover I wonder how it is supposed to work with the irq affinity. Let say that the
> irq was enabled on the CPU0,

If you mean enabled as in irq_enable(irq_desc), then let's keep in mind that
currently that calls .irq_unmask.

> then there is irq_unmask call on CPU1, then the irq would be enabled on both CPUs.
> It will modify the irq affinity and moreover it will also lead
> to an invalidate state with the MPIC because we can't manage an interrupt on more than
> one CPU.
> 
> From the point of the view of the armada_370_xp_irq driver there are potential bug, but
> maybe the use case I described can't happen. Could you check it?
> 

In this irqchip driver, shared interrupts are handled via handle_level_irq(),
which masks() and unmasks() the interrupt. In other words, it's always done
in the same CPU. I guess this is the most frequent mask/unmask operation.

On the other side, if a driver calls enable_irq() on one CPU and then
enable_irq() on the other CPU, that's exactly what will happen. Although the
smp_affinity setting will prevent an interrupt from being dispatched to more
than one CPU.

I really don't see an issue with this patch, but I think it needs as much
discussion and as much testing as possible. This piece of code is rather
critical, and is working just fine, so I'd like to have an excellent 
reason before changing any of it.

-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141104/c426c5f7/attachment.sig>
