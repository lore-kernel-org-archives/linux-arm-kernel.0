From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Sat, 09 Jul 2011 17:10:50 -0700
Subject: [PATCH 03/17] ARM: gic: Use cpu pm notifiers to save gic state
In-Reply-To: <20110709230544.GP4812@n2100.arm.linux.org.uk>
References: <1310053830-23779-1-git-send-email-lorenzo.pieralisi@arm.com>
	<1310053830-23779-4-git-send-email-lorenzo.pieralisi@arm.com>
	<20110709102100.GJ4812@n2100.arm.linux.org.uk>
	<CAMbhsRTFfv1q0po5CDtRfRBN5pABaKm3C0OR4U9yHmRJiFUOtw@mail.gmail.com>
	<20110709223315.GO4812@n2100.arm.linux.org.uk>
	<CAMbhsRR0XCJ3-6DznCAmEk1AywpFhr70-1mH=cy9YBpZa978pw@mail.gmail.com>
	<20110709230544.GP4812@n2100.arm.linux.org.uk>
Message-ID: <4E18EE0A.7070609@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7/9/2011 4:05 PM, Russell King - ARM Linux wrote:
> On Sat, Jul 09, 2011 at 04:01:19PM -0700, Colin Cross wrote:
>> On Sat, Jul 9, 2011 at 3:33 PM, Russell King - ARM Linux
>> <linux@arm.linux.org.uk>  wrote:
>>> On Sat, Jul 09, 2011 at 03:10:56PM -0700, Colin Cross wrote:
>>>> This is necessary for cpuidle states that lose the GIC registers, not
>>>> just suspend, because the GIC is in the cpu's power domain.  We could
>>>> avoid saving and restoring all the GIC registers in suspend and idle
>>>> by reusing the initialization functions, and then having the core irq
>>>> code call the unmask, set_type, and set_affinity functions on each irq
>>>> to reconfigure it, but that will be very inefficient - it will convert
>>>> each register write in the restore functions to a read-modify-write
>>>> per interrupt in that register.  Santosh is already complaining that
>>>> this commong GIC restore code will be slower than the automatic DMA to
>>>> restore the GIC registers that OMAP4 supports.
>>>
>>> Well, we need to come up with something sensible - a way of doing this
>>> which doesn't require every interrupt controller driver (of which we as
>>> an architecture have many) to have lots of support added.
>>>
>>> If the current way is inefficient and is noticably so, then let's talk
>>> to Thomas about finding a way around that - maybe having the generic
>>> code make one suspend/resume callback per irq gc chip rather than doing
>>> it per-IRQ.  We can then reuse the same paths for suspend/resume as for
>>> idle state saving.
>>>
>>
>> Are you referring to moving the gic driver to be gc chip?  Otherwise,
>> I don't understand your suggestion - how is callback per chip any
>> different than what this patch implements?  It just gets it's
>> notification through a cpu_pm notifier, which works in idle and
>> suspend, instead of a syscore op like the gc driver does.
>>
>> This patch does save and restore some registers that are never
>> modified after init, so they don't need to be saved.
>
> The point is that we should aim to get to the point where, if an
> interrupt controller supports PM, then it supports _all_ PM out the
> box and doesn't require additional code for cpu idle PM vs system
> suspend PM.
>
> In other words, all we should need to do is provide genirq with a
> couple of functions for 'save state' and 'restore state'.
Agreed.
But how generic irq code will know about when the interrupt controller
looses it's context without notifiers. This still depend on the SOC 
power domain partitions and hence platform code
At least for the GIC case, it seems depends on the CPU cluster low
power state.

Regards
Santosh
