From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Sun, 09 Nov 2014 09:18:10 -0300
Subject: [PATCH 0/7] Armada 375/38x perf support, and a bonus irqchip
 driver simplification
In-Reply-To: <20141109104150.03044ee0@free-electrons.com>
References: <1413985427-20918-1-git-send-email-ezequiel.garcia@free-electrons.com>	<20141109052348.GT3698@titan.lakedaemon.net>
 <20141109104150.03044ee0@free-electrons.com>
Message-ID: <545F5B82.5090004@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/09/2014 06:41 AM, Thomas Petazzoni wrote:
> Jason, Ezequiel,
> 
> On Sun, 9 Nov 2014 00:23:48 -0500, Jason Cooper wrote:
>> On Wed, Oct 22, 2014 at 10:43:40AM -0300, Ezequiel Garcia wrote:
>>> This patchset enables support for perf hardware events, by enabling the PMU
>>> interrupts in the irqchip driver.
>>>
>>> While doing this, we noticed the driver could use some cleaning to simplify
>>> the overly complex implementation of the .map(), .unmask() and .mask()
>>> functions.
>>>
>>> The first three patches are the result of this cleaning effort, while the
>>> rest of the series is the Perf support for Armada 375 and Armada 38x SoCs.
>>>
>>> The series is based on v3.18-rc1.
>>>
>>> Ezequiel Garcia (7):
>>>   irqchip: armada-370-xp: Simplify interrupt map, mask and unmask
>>>   irqchip: armada-370-xp: Initialize per cpu registers when CONFIG_SMP=N
>>>   irqchip: armada-370-xp: Introduce a is_percpu_irq() helper for
>>>     readability
>>>   irqchip: armada-370-xp: Enable Performance Counter interrupts
>>
>> Patches 1 to 4 tentatively applied to irqchip/mvebu.  Things have been
>> quiet, so let's get it in next for some more test coverage.
> 

Jason, please consider *only* patch 1 for inclusion, as long as we
have Gregory's Ack on it. I don't want to break the irqchip driver
because of a clean-up! On the other side, if such weird handling
is needed, we need find why and document it.

> Ezequiel, are these patches really the version we want to see merged? I
> think you're working on a different implementation that demultiplex the
> coherency fabric events interrupt.
> 

Indeed, I never managed to get Perf counter overflow events interrupt on
both CPUs, so this is on hold for now (as I explained here
http://www.spinics.net/lists/arm-kernel/msg373929.html).

Let me fetch that and save you a click :)

"""
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
"""

-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
