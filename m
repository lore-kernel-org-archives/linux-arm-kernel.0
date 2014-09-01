From: sudeep.holla@arm.com (Sudeep Holla)
Date: Mon, 01 Sep 2014 14:03:55 +0100
Subject: [PATCH] arm: use irq_set_affinity with force=false when migrating
 irqs
In-Reply-To: <alpine.DEB.2.10.1409011421450.3333@nanos>
References: <1409571966-18343-1-git-send-email-sudeep.holla@arm.com>
 <20140901115057.GH30401@n2100.arm.linux.org.uk>
 <alpine.DEB.2.10.1409011421450.3333@nanos>
Message-ID: <54046EBB.8020707@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 01/09/14 13:56, Thomas Gleixner wrote:
> On Mon, 1 Sep 2014, Russell King - ARM Linux wrote:
>> On Mon, Sep 01, 2014 at 12:46:06PM +0100, Sudeep Holla wrote:
>>> From: Sudeep Holla <sudeep.holla@arm.com>
>>>
>>> Commit 01f8fa4f01d8("genirq: Allow forcing cpu affinity of interrupts")
>>> enabled the forced irq_set_affinity which previously refused to route an
>>> interrupt to an offline cpu.
>>>
>>> Commit ffde1de64012("irqchip: Gic: Support forced affinity setting")
>>> implements this force logic and disables the cpu online check for GIC
>>> interrupt controller.
>>>
>>> When __cpu_disable calls migrate_irqs, it disables the current cpu in
>>> cpu_online_mask and uses forced irq_set_affinity to migrate the IRQs
>>> away from the cpu but passes affinity mask with the cpu being offlined
>>> also included in it.
>>>
>>> If irq_set_affinity is called with force=true in a cpu hotplug path,
>>> the caller must ensure that the cpu being offlined is not present in the
>>> affinity mask or it may be selected as the target CPU, leading to the
>>> interrupt not being migrated.
>>>
>>> This patch fixes the issue by calling irq_set_affinity with force=false
>>> so that cpu_online_mask is checked while setting the affinity in the
>>> cpu hotplug path.
>>>
>>> Tested on TC2 hotpluging CPU0 in and out. Without this patch the system
>>> locks up as the IRQs are not migrated away from CPU0.
>>>
>>> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
>>> Cc: Russell King <linux@arm.linux.org.uk>
>>> Cc: Thomas Gleixner <tglx@linutronix.de>
>>> Cc: Mark Rutland <mark.rutland@arm.com>
>>> Cc: <stable@vger.kernel.org> # 3.10.x
>>> ---
>>>   arch/arm/kernel/irq.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> Hi Russell,
>>>
>>> If you or tglx has no objections to this patch, I will put it
>>> in your patch tracker.
>>
>> Post discussion, I have no objections - except to the above comment.  Let
>> me rewrite it in a programming language, and maybe you can spot what's
>> wrong:
>>
>> 	if (russell_has_no_objection(patch) || tglx_has_no_objection(patch))
>> 		submit_patch_to_tracker(patch);
>>
>> Personally, I'd like to see tglx's ack on this first.
>
> Acked-by: Thomas Gleixner <tglx@linutronix.de>
>

Thanks Thomas.

> I'm just not too happy about the changelog. It's confusing at
> best:
>
>     Call irq_set_affinity() with argument force = false
>
>     Reason: IRQ Core and GIC was changed to force set affinity.
>     	
>     	   If called from hotplug code, then the caller must ensure
>     	   that the cpu being offlined is not present in the mask
>
>     Therefor call it with force = false	
>
> That does not make sense. You change something which preceded the
> forced affinity mechanism by 3+ years and completely miss to explain
> why it got there in the first place and never should have been.
>

Agreed, I missed that. I will change the commit log as specified by
you below.

Regards,
Sudeep

> What about somthing like the following:
>
> Since commit 1dbfa187dad ("ARM: irq migration: force migration off CPU
> going down") the ARM interrupt migration code on cpu offline calls
> irqchip.irq_set_affinity() with the argument force=true. At the point
> of this change the argument had no effect because it was not used by
> any interrupt chip driver and there was no semantics defined.
>
> This changed with commit 01f8fa4f01d8 ("genirq: Allow forcing cpu
> affinity of interrupts") which made the force argument useful to route
> interrupts to not yet online cpus without checking the target cpu
> against the cpu online mask. The following commit ffde1de64012
> ("irqchip: gic: Support forced affinity setting") implemented this for
> the GIC interrupt chip.
>
> As a consequence the ARM cpu offline irq migration fails if CPU0 is
> offlined, because CPU0 is still set in the affinity mask and the
> validataion against cpu online mask is skipped to the force argument
> being true. The following first_cpu(mask) selection always selects
> CPU0 as the target.
>
> Solve the issue by calling irq_set_affinity() with force=false from
> the CPU offline irq migration code so the GIC driver validates the
> affinity mask against CPU online mask and therefor removes CPU0 from
> the possible target candidates.
>
>
