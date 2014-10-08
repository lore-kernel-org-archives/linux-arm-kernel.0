From: lanchon@gmail.com (Lanchon)
Date: Wed, 08 Oct 2014 05:19:19 -0300
Subject: FP register corruption in Exynos 4210 (Cortex-A9)
In-Reply-To: <20141007221515.GY5182@n2100.arm.linux.org.uk>
References: <54345FA7.9030606@gmail.com>
 <20141007221515.GY5182@n2100.arm.linux.org.uk>
Message-ID: <5434F387.804@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 10/07/2014 07:44 PM, Russell King - ARM Linux wrote:
> On Tue, Oct 07, 2014 at 07:35:14PM -0300, Lanchon wrote:
>>> I hope this helps; I didn't answer your specific questions because it
>>> seemed I would just end up repeating what I've said above.
>>>
>> actually no, answers to my very specific questions would help me
>> understand this: if we had a close-source driver (ISR or kernel thread)
>> that touched the FPU, how would the kernel react?
> I already covered this.  It would corrupt the VFP state, thereby
> corrupting the VFP state which userspace sees.
>
> Hence why I said:
>
> 	Which means that the kernel itself must /never/ make use of floating
> 	point itself - if it does, it /will/ corrupt the user state in the way
> 	               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 	you are seeing.
> 	^^^^^^^^^^^^^^^
>
> How can I make that more clear?

no, actually you did not answer my questions. you stated that the end 
result would be corruption of user FP state, which i already know. i am 
inquiring as to *how* the process of corruption comes about exactly, not 
the end result.

knowing exactly how corruption can happen and how it cannot would help 
me decide where to look for the offending code.

for instance, you say that if an ISR uses the FPU it would corrupt user 
FP state. fine, but it is not that simple. what if the FPU was disabled 
at the time of interrupt? (ie: lazy restore did not yet happen in this 
time-slice.) then the ISR FPU instruction would trap, not corrupt 
immediately. would the kernel recognize the trap was generated in ISR 
code and panic, or just blindly restore the FP context of the 
interrupted thread? if the former is true, then i can discount ISRs as 
sources of corruptions because i am not seeing panics, so there is no 
point in instrumenting ISRs. if the latter is true, ok fine... but what 
if the interrupted thread was a kernel thread? where would the restored 
FP context come from?

answering these questions require both knowledge of the architecture of 
the linux kernel and of cortex-A, and i know neither of them, which is 
why i am asking in this list.


a plausible answer (which i am making up out of the blue) would be:

"each cpu is always working in the context of a 'current' or 'executing' 
userland process (which may be the idle process), with the MMU 
configured to its virtual address space and all, even when the cpu is 
executing a kernel thread. the FPU state and handling is not affected by 
user/kernel mode switches, only by userland context switches. this means 
that if a kernel thread executes FP instructions, the kernel will trap 
if the FPU is disabled and happily restore the context of the current 
userland process of the CPU for the kernel thread to corrupt next, never 
noticing that the trap originated in kernel mode.

also the arm architecture will not disable the FPU on interrupt 
processing, and the kernel will not disable the FPU prior to dispatching 
the interrupt to the registered drivers. so the same thing would happen 
in an ISR, even if the ISR is interrupting a kernel thread."

another plausible answer would be:

"the kernel always disables the FPU on scheduling a kernel thread. the 
cost of fiddling with this is low compared to the safety it provides. if 
triggered, the FPU trap will notice that the CPU is in kernel mode and 
panic, failing fast. there are no special rules applying to interrupts: 
if an ISR issues FP instructions they will be handled as if they had 
been issued in the interrupted thread (kernel: panic; user: lazy restore 
and/or execution)."

yet another:

"the FPU is effectively disabled on interrupt processing by the arm 
architecture. while running in interrupt mode, and independent of the 
FPU enable status, all FP instructions will trap to a different FPU 
vector which will cause the kernel to panic."


any and all of these hypothetical details would help me determine where 
*not* to look for the cause of the problem, where and what type of 
instrumentation is worth trying, etc. a simple "state would be 
corrupted" sentence does not give me any useful information that helps 
me find the source of the problem, but understanding the process of 
corruption might. (disregarding the fact that this is probably a 
hardware bug, maybe a cache coherence problem or something of the sort, 
and there might be no error in the code at all.)

this is why i will close this email with a copy my questions for 
context. maybe someone can provide the answer for some.

thanks again, and in advance to anyone who can help.

regards,
lanchon


--------------------------


Kernel threads (such as the worker thread of a threaded interrupt) 
should guard FPU access in between 'kernel_XXX_begin'/'kernel_XXX_end' 
calls (which our kernels do not implement). But what if it did not?

1) What is the FPU enable state while executing a kernel thread in ARM 
arch? Which of these answers is correct?

1a) the FPU is always disabled in kernel threads.
1b) the FPU might be enabled or disabled in a kernel thread, depending 
on the FPU enable state of the userland context that executed before 
and/or some other factors.

2) What would happen if a kernel thread executed an FPU instruction 
without the kernel_XXX_begin'/'kernel_XXX_end' guards in ARM arch and 
the FPU was disabled at the time?

2a) In the FPU trap the kernel would always detect the issue and panic 
or oops or something.
2b) In the FPU trap the kernel might enable the FPU, load the FPU 
context of some userland process and resume the kernel thread.

Of course an ISR should not touch the FPU at all. But what if it did?

3) What would happen if an ISR executed an FPU instruction in ARM arch 
and the FPU was disabled in the context that was interrupted:

3a) In the FPU trap the kernel would always detect the issue and panic 
or oops or something.
3b) In the FPU trap the kernel would react as if the interrupted context 
executed the FPU instruction: If the interrupted context was user mode, 
it would restore the userland process' FP context into the FPU. If the 
interrupted context was kernel mode, it would react as per the answer to 
question 2) above.

4) What would happen if an ISR executed an FPU instruction in ARM arch 
and the FPU was enabled in the context that was interrupted:

4a) The processor would disable the FPU on ISR entry automatically and 
thus the system would behave as described in the answer to question 3) 
above.
4b) If the driver uses the standard kernel interrupt dispatch 
architecture, the kernel would disable the FPU before dispatching the 
interrupt to the driver ISR, and so the system would also behave as 
described in 3).
4c) The FPU instruction would execute. There is no fail-fast or 
detection of this kind of violation by the kernel.


Of course every pointer, idea, or suspicion that might seem relevant to 
the case is welcome.
