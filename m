From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Fri, 31 Oct 2014 13:23:05 -0300
Subject: [PATCH 5/7] ARM: mvebu: Enable Performance Monitor Unit on Armada
 375 SoC
In-Reply-To: <20141023131840.GA14404@leverpostej>
References: <1413985427-20918-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1413985427-20918-6-git-send-email-ezequiel.garcia@free-electrons.com>
 <20141022140421.GL22642@leverpostej> <54482CCA.9010002@free-electrons.com>
 <20141023111411.0d4c4a11@free-electrons.com>
 <5448EBBF.2060000@free-electrons.com>
 <20141023140731.5401aac3@free-electrons.com>
 <20141023131840.GA14404@leverpostej>
Message-ID: <5453B769.2080601@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/23/2014 10:18 AM, Mark Rutland wrote:
> On Thu, Oct 23, 2014 at 01:07:31PM +0100, Thomas Petazzoni wrote:
>> Dear Ezequiel Garcia,
>>
>> On Thu, 23 Oct 2014 08:51:27 -0300, Ezequiel Garcia wrote:
>>
>>>> On Wed, 22 Oct 2014 19:16:42 -0300, Ezequiel Garcia wrote:
>>>>
>>>>> The <mpic 3> is a per CPU interrupt.
>>>>>
>>>>> Actually, the interrupt contains more than just PMU events, it contains
>>>>> a summary of several CPU events: Perf counters for each CPU, Power
>>>>> management interrupts for each CPU, L2 cache interrupt, among others.
>>>>
>>>> This is kind of a side discussion but if this <mpic 3> interrupts does
>>>> much more than PMU events, then we should implement a separate irqchip
>>>> driver for this, to "demultiplex" the events notified by this interrupt.
>>>
>>> Oh, I didn't realize this was possible.
>>
>> The only trick is that it can't be a separate DT node, because the
>> registers that contains the mask/cause informations for the events
>> notified by <mpic 3> belongs to the MPIC registers area.
>>
>> Not sure how to handle that, maybe Mark will have some suggestions.
> 
> I'm not sure I follow why you would need a separate irqchip driver. Why
> can't this live in the existing mpic driver?
> 

I've tried to add a demux interrupt controller for the CPU summary interrupts
to be able to hook to the proper interrupt. This was doable without much
pain [1].

However, due to the way the Performance counter overflow IRQ is exposed, it 
doesn't seem to meet perf's PMU irq handling requirement.

For per CPU interrupts, perf requests the interrupt and expects to get an
interrupt on each CPU, with the counter overflow event for that CPU.

This is not the case for the CPU Summary interrupt. This *is* a per CPU
interrupt, but there is a separate interrupt line for each CPU:

CPU summary per CPU interrupt 0, for the Perf counter on CPU0
CPU summary per CPU interrupt 1, for the Perf counter on CPU1

So, I thought about exposing the interrupt as a shared one and
use interrupts 0 and 1, triggering interrupts on CPU0 with the
counter overflow for CPU0 and CPU1. This doesn't work either, as
the perf code expects to set the interrupt affinity to route
each shared interrupt to the appropriate CPU.

I'm not sure how can I set the interrupt affinity for the demux controller,
being a chained interrupt controller.

At this point, due to the SoC weirdness in exposing the PMU IRQ, I'm 
starting to think we will have to live with software events for this SoC,
but I'd love to be proved wrong.

[1] http://sprunge.us/MfVN
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141031/0a53de45/attachment.sig>
