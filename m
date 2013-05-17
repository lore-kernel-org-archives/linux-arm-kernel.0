From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 17 May 2013 12:50:33 +0100
Subject: ARM Cortex-A7 support in Linux
In-Reply-To: <20130517114827.GI23112@mudshark.cambridge.arm.com>
References: <A1A6EA40F8503D48BB002B42BD65974E295341@039-SN2MPN1-012.039d.mgd.msft.net>
 <f6c9d2b0d52d63efa95f780b172690ef@localhost>
 <20130517105500.GE18614@n2100.arm.linux.org.uk>
 <20130517113622.GH23112@mudshark.cambridge.arm.com>
 <51961793.1000107@arm.com>
 <20130517114827.GI23112@mudshark.cambridge.arm.com>
Message-ID: <51961989.7020409@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/05/13 12:48, Will Deacon wrote:
> On Fri, May 17, 2013 at 12:42:11PM +0100, Marc Zyngier wrote:
>> On 17/05/13 12:36, Will Deacon wrote:
>>> On Fri, May 17, 2013 at 11:55:00AM +0100, Russell King - ARM Linux wrote:
>>>> On Fri, May 17, 2013 at 12:47:45PM +0200, Marc Zyngier wrote:
>>>>> It depends which feature you're after. Linux supports the GIC
>>>>> virtualization extensions with KVM, for example. But we don't make any use
>>>>> of other things like priorities, split deactivation/priority drop...
>>>>
>>>> Not that we could make use of priorities anymore as all interrupt handlers
>>>> are now run with IRQs disabled; an IRQ handler can't be interrupted by a
>>>> higher priority IRQ coming in.
>>>>
>>>> Part of the solution to that is to go back to the original philosophy of
>>>> IRQ handling in Linux - do the least possible amount of work in the IRQ
>>>> and move the heavier stuff off into soft-IRQ context.  Unfortunately,
>>>> many drivers are no longer written like that, and just do a great amount
>>>> of time consuming work in their IRQ handler.
>>>
>>> We could also consider using interrupt priorities to have a fake NMI (I
>>> think PPC does this for some cores), which is useful for profiling and
>>> watchdogs, especially now that FIQ is often stolen by the secure world.
>>>
>>> I remember dismissing this in the past because I thought it would increase
>>> our GIC distributor accesses, but I don't remember why.
>>
>> I think it would rather require to write to the interrupt priority mask
>> register (GIC_PMR) in the CPU interface. The cost is probably the same,
>> actually (probably quite high, given how often we enable/disable
>> interrupts).
> 
> In terms of the hardware, maybe, but the distributor requires a lock and
> will also trap to the hypervisor if accessed from a guest.
> 
> However, since the GIC_PMR is in the CPU interface then that should be fine.

Absolutely. I was just thinking of the respective costs of a device
write vs setting the I bit in CPSR.

	M.
-- 
Jazz is not dead. It just smells funny...
