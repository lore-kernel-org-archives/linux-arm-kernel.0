From: eric@eukrea.com (=?windows-1252?Q?Eric_B=E9nard?=)
Date: Sun, 03 Oct 2010 17:25:31 +0200
Subject: I.MX35 GPIO IRQ + Preempt -> Oops
In-Reply-To: <20101003114103.GC32736@n2100.arm.linux.org.uk>
References: <4CA739B4.1020506@eukrea.com>
	<20101003114103.GC32736@n2100.arm.linux.org.uk>
Message-ID: <4CA8A06B.3070103@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

Le 03/10/2010 13:41, Russell King - ARM Linux a ?crit :
> The common theme here looks like instruction cache corruption in
> default_idle() - iow, the CPU isn't executing the code which is in
> memory.
>
thanks for the analysis.
This problem seems to be related to the ARM11 bug described in page 4 of 
this PDF :
http://cache.freescale.com/files/dsp/doc/errata/IMX35CE.pdf?fpsp=1

ENGcm09472 ARM: WFI and interrupt problems

Description:
There are two issues:
? The behavior of the FIQ signal to the ARM11 core can cause a problem 
when exiting WFI mode. The FIQ signal toggles after being initially 
asserted, which, as ARM has confirmed, is unexpected behavior to the 
ARM11 core. ARM has stated that this is not a fully validated case
for their cores. This behavior occurs when core clocks continue to run 
and, along with particular caching and alignment schemes, can result in 
a corrupted cache line following a prefetch, as well as unexpected 
behavior in code. Also, the core can execute an instruction immediately
following the WFI instruction before servicing the FIQ. This behavior of 
FIQ is caused by the design of the interrupt controller in the 
synchronization circuit.
? The same extra pulse on the FIQ signal can cause the core to execute 
instructions immediately following the WFI, before entering the ISR. If 
an ISR executes too quickly, the FIQ/IRQ may not clear by the time the 
core returns to main code, and may enter ISR two or more times for the
same interrupt. This situation should only happen if the execution time 
of the code in the ISR that follows the initial write to the peripheral 
to clear the FIQ/IRQ, can execute in fewer than 25 hclk (AHB clock) cycles.

Projected Impact:
The first issue can result in a corrupted cache line following a 
prefetch, and thus unexpected behavior; the second issue can result in 
unexpected behavior of ISR execution.

Work Around:
The WFI routine should change the clocking mode to a 1:1 (ARM:AHB) 
ratio. This must be ensured by following the programming with dummy 
reads. On wake-up, the clocks can then be changed back to the original 
ratio.
This completely prevents the toggle on the interrupt line, and this code 
can now be located in a
cacheable region.
EXAMPLE:
mov r0, #0
ldr r1, =<clock_control_BASE>
ldr r2, [r1, #OFFSET]
orr r3, r2, #1TO1MODE
str r3, [r1, #OFFSET]
... // Delay while switch to 1:1 occurs
mcr p15, 0, r0, c7, c0, 4 //WFI
str r2, [r1, #OFFSET]
bx lr

Projected Solution:
No fix scheduled.

Eric
