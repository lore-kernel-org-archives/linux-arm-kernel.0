From: sudeep.holla@arm.com (Sudeep Holla)
Date: Mon, 01 Sep 2014 13:18:49 +0100
Subject: [PATCH] arm: use irq_set_affinity with force=false when migrating
 irqs
In-Reply-To: <20140901115057.GH30401@n2100.arm.linux.org.uk>
References: <1409571966-18343-1-git-send-email-sudeep.holla@arm.com>
 <20140901115057.GH30401@n2100.arm.linux.org.uk>
Message-ID: <54046429.5060902@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 01/09/14 12:50, Russell King - ARM Linux wrote:
> On Mon, Sep 01, 2014 at 12:46:06PM +0100, Sudeep Holla wrote:
>> From: Sudeep Holla <sudeep.holla@arm.com>
>>
>> Commit 01f8fa4f01d8("genirq: Allow forcing cpu affinity of interrupts")
>> enabled the forced irq_set_affinity which previously refused to route an
>> interrupt to an offline cpu.
>>
>> Commit ffde1de64012("irqchip: Gic: Support forced affinity setting")
>> implements this force logic and disables the cpu online check for GIC
>> interrupt controller.
>>
>> When __cpu_disable calls migrate_irqs, it disables the current cpu in
>> cpu_online_mask and uses forced irq_set_affinity to migrate the IRQs
>> away from the cpu but passes affinity mask with the cpu being offlined
>> also included in it.
>>
>> If irq_set_affinity is called with force=true in a cpu hotplug path,
>> the caller must ensure that the cpu being offlined is not present in the
>> affinity mask or it may be selected as the target CPU, leading to the
>> interrupt not being migrated.
>>
>> This patch fixes the issue by calling irq_set_affinity with force=false
>> so that cpu_online_mask is checked while setting the affinity in the
>> cpu hotplug path.
>>
>> Tested on TC2 hotpluging CPU0 in and out. Without this patch the system
>> locks up as the IRQs are not migrated away from CPU0.
>>
>> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
>> Cc: Russell King <linux@arm.linux.org.uk>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: <stable@vger.kernel.org> # 3.10.x
>> ---
>>   arch/arm/kernel/irq.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> Hi Russell,
>>
>> If you or tglx has no objections to this patch, I will put it
>> in your patch tracker.
>
> Post discussion, I have no objections - except to the above comment.  Let
> me rewrite it in a programming language, and maybe you can spot what's
> wrong:
>
> 	if (russell_has_no_objection(patch) || tglx_has_no_objection(patch))
> 		submit_patch_to_tracker(patch);
>
> Personally, I'd like to see tglx's ack on this first.

Understood, I will wait for ack from tglx.

Regards,
Sudeep
