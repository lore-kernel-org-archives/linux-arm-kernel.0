From: preeti@linux.vnet.ibm.com (Preeti U Murthy)
Date: Mon, 09 Dec 2013 20:56:45 +0530
Subject: questions of cpuidle
In-Reply-To: <52A5C846.30308@linaro.org>
References: <52A5C846.30308@linaro.org>
Message-ID: <52A5E135.2020500@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alex,

On 12/09/2013 07:10 PM, Alex Shi wrote:
> 
> Sorry for a idiot of cpuidle.
> 
> I just find few cpu set TIMER_STOP on cpuidle, like omap4 and big.Little
> driver. Does that mean other ARM cpu or x86 cpu can get the timer
> interrupt in cpuidle?

There could be. Its only in some architectures and certain processors in
them that in a deep idle state(note that this happens only in a *deep*
idle state, *not* every idle state), the local timers stop as a side
effect and hence the CPUs can't get timer interrupts.

> 
> If the timer stopped during cpuidle, does that means at least one cpu
> cann't get into deep c-state since system need a cpu to wake up other
> deep c-state cpu? Or sth I missed?

Every CPU can get into a deep idle state since its possible to wake them
up using external interrupts. These CPUs do not necessarily need an IPI
to wake them up, any external interrupt will do. But for convenience,
instead of waking them all up using some external timer, we wake up only
one CPU or a few CPUs using an external timer and these CPUs inturn send
IPIs to the other CPUs in deep idle state since IPIs are a more
convenient way of sending interrupts to CPUs.

That is precisely the use of the broadcast timer. *Every* CPU can go
into deep idle state since they can be woken up by any external
interrupt, In case of architectures where there is an external clock
device, this external timer interrupt wakes up one CPU and it sends IPIs
to the other CPUs.

> 
> If the cpu stopped the interrupt during deep c-state and without
> monitor/mwait support, which kind of ipi can wake the cpu? I mean like a
> x86 cpu, APIC stopped in c3 mode, but actually ipi send via apic bus. So
> I don't know which ipi work?
> 

As far as my understanding goes, an external interrupt sent via the apic
bus wakes up a core in deep idle state first, meaning powers on the core
and hence the local apic. It does not yet acknowledge the interrupt,
meaning it cannot invoke the interrupt handler immediately.
   After the core goes through some initialization steps after wakeup,
it will be in a position to acknowledge the external interrupt and
service it accordingly.

Ideally the interrupt handler of this external interrupt should be that
of the local timer itself since it was meant to act on the behalf of the
local timer interrupt.

Thanks

Regards
Preeti U Murthy
