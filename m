From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 22 Jul 2011 09:12:44 +0100
Subject: [PATCH 0/4] Fix CPU hotplug IRQ migration
In-Reply-To: <4E290C05.7020209@ti.com>
References: <20110721151413.GD28942@n2100.arm.linux.org.uk>
	<4E290C05.7020209@ti.com>
Message-ID: <20110722081244.GA21416@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 22, 2011 at 11:05:01AM +0530, Santosh Shilimkar wrote:
> + Colin,
>
> On 7/21/2011 8:44 PM, Russell King - ARM Linux wrote:
>> This series fixes a bunch of issues with IRQ migration:
>>
>> 1. Preventing affinity changes causing IRQs to be directed to off-line CPUs.
>> 2. Preventing oopses with non-GIC interrupt controllers.
>> 3. Preventing per-CPU IRQs being candidates for migration.
>> 4. Removing the abuse of irqdesc's node member.
>>
>> This prevents crashes on OMAP4430 SDP when non-default IRQ affinity
>> settings are used and a CPU which owns some IRQs is offlined.
>>
> Firstly thanks for fixing the IRQ migration and affinity issues
> with hotplug code. Colin found the hotplug irq affinity issue
> last week.
>
> Colin quoted ..
> ----------------------------------
> The irq affinity mask is not kept up to date by the ARM irq
> code.  In particular, migrate_one_irq is not called when
> the irq node does not match the cpu going offline, and
> when it is called, it doesn't update the irq affinity
> mask before calling the irq chip's set_affinity function.
> This causes the use of the affinity mask in the mask
> and unmask functions to be unreliable, possibly unmasking
> an interrupt on a cpu that is offline.
> ----------------------------------

I don't have a copy of that message... where was it posted?

> Need to check if this series addresses above issue as well.

It does not, and it is wrong to change the affinity mask of the interrupt
due to a CPU going offline.  Think about it.

If you offline CPU0, which migrates all IRQs to CPU1.  You then update
the affinity mask to exclude CPU0.  Now you online CPU0, and offline CPU1.
You now get a pile of kernel messages about breaking the _apparant_ users
affinity settings for the interrupts, because you have to move them off
CPU1 which is the only CPU they are now affine to.

The affinity mask is a policy setting from userspace.  It is not an
absolute setting which the kernel must keep updated.

And actually you _can't_ tell what CPU the interrupt is routed to from
the affinity mask - the affinity mask gives a hint as to which CPU_s_
(plural) are permitted to receive the interrupt.  The fact we choose -
at the moment - the first CPU to route stuff to from the masks is merely
an implementation detail which must not be relied upon.

So, Colin is wrong on the affinity mask issue.  The correct behaviour
is that the affinity at any point is the set of CPUs in the current
affinity mask _and_ the CPU online mask.  If that is an empty set, then
any online CPU will be chosen to handle the interrupt.

>> With this patch set applied, there is no reason core code can't handle
>> CPU0 being offlined - on OMAP4, the only remaining issue is CPU0
>> being woken from WFI and falsely passing the non-spurious wake-up test.
> There is one as commented in other thread. The Secure code runs only
> on CPU0 so if you offline the CPU0, all the secure services are not
> available.

Secure code is called on CPU1 too, so I don't think your statement is
accurate.  Eg:

	omap_modify_auxcoreboot0(0x0, 0x200)

	omap_read_auxcoreboot0()

both result in calling secure code on CPU1.
