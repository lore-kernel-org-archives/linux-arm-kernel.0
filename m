From: jarkko.nikula@linux.intel.com (Jarkko Nikula)
Date: Tue, 17 Jan 2017 15:11:46 +0200
Subject: [PATCH v2 2/3] spi: pxa2xx: Prepare for edge-triggered interrupts
In-Reply-To: <bfebbcbc-3d02-137b-72c0-7664900fe279@siemens.com>
References: <cover.1484592296.git.jan.kiszka@siemens.com>
 <cover.1484592296.git.jan.kiszka@siemens.com>
 <7b15a0910a3ad861fd32161c72559bafa7b71e29.1484592296.git.jan.kiszka@siemens.com>
 <87vatedsn1.fsf@belgarion.home>
 <bfebbcbc-3d02-137b-72c0-7664900fe279@siemens.com>
Message-ID: <d6d9079e-f671-139e-42d8-75158ac9ee17@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/17/2017 10:10 AM, Jan Kiszka wrote:
> On 2017-01-17 08:58, Robert Jarzmik wrote:
>> Jan Kiszka <jan.kiszka@siemens.com> writes:
>>
>>> When using the a device with edge-triggered interrupts, such as MSIs,
>>> the interrupt handler has to ensure that there is a point in time during
>>> its execution where all interrupts sources are silent so that a new
>>> event can trigger a new interrupt again.
>>>
>>> This is achieved here by looping over SSSR evaluation. We need to take
>>> into account that SSCR1 may be changed by the transfer handler, thus we
>>> need to redo the mask calculation, at least regarding the volatile
>>> interrupt enable bit (TIE).
>>
>> I'd like moreover to add a question here.
>>
>> In pxa architecture, SPI interrupts are already edge-triggered, and it's working
>> well. The interrupt source disabling is not disabled, but the interrupt
>> controller doesn't trigger an interrupt anymore (as it is masked), yet it marks
>> it as pending if an interrupt arrives while the interrupt handler is running.
>>
>> All of this is handled by the interrupt core. My question is why for Intel MSI's
>> is it necessary to make a change in the driver instead or relying on the
>> interrupt core as for the pxa ?
>
> If someone was using this driver with edge-triggered interrupt sources
> so far, it was probably slower hardware and some luck (I've seen this
> when driving fast-clocked devices vs. slower ones - only the latter
> exposed the bug). Or that hardware did some temporary masking at
> interrupt controller level while the handler was running. But that is
> also not by design. It's the driver's task to ensure that all interrupt
> sources are addressed once when returning from an edge-triggered
> handler, and that is missing in this one.
>
Are you seeing actual problem here or adding loop just in case? Is it 
really so that PCI bridge doesn't generate another MSI interrupt if SPI 
controller has interrupt pending when handler returns? I don't know but 
I would expect irq line between SPI controller and PCI bridge is still 
level sensitive even PCI bridge issues MSIs to the CPU.

-- 
Jarkko
