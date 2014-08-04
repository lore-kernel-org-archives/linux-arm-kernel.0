From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 04 Aug 2014 11:00:38 +0100
Subject: [PATCH 02/15] ARM: pass IRQ domain to the core IRQ handler
In-Reply-To: <20140802075118.GV30282@n2100.arm.linux.org.uk> (Russell King's
 message of "Sat, 2 Aug 2014 08:51:18 +0100")
References: <1404825038-547-1-git-send-email-marc.zyngier@arm.com>
 <1404825038-547-3-git-send-email-marc.zyngier@arm.com>
 <20140802075118.GV30282@n2100.arm.linux.org.uk>
Message-ID: <87k36oh8vt.fsf@approximate.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Sat, Aug 02 2014 at  8:51:18 am BST, Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> On Tue, Jul 08, 2014 at 02:10:25PM +0100, Marc Zyngier wrote:
>> Calling irq_find_mapping from outside a irq_{enter,exit} section is
>> unsafe and produces ugly messages if CONFIG_PROVE_RCU is enabled:
>> If coming from the idle state, the rcu_read_lock call in irq_find_mapping
>> will generate an an unpleasant warning.
>> 
>> A solution is to add a new handle_domain_irq entry point into
>> the arm code that the interrupt controller code can call.
>> This new function takes an irq_domain, and calls into irq_find_domain
>> inside the irq_{enter,exit} block.
>> 
>> Interrupt controllers can then be updated to use the new mechanism.
>
> I merged this last night, and this says it all...
>
> Subject: rmk build: 244 warnings 49 failures (rmk/v3.16-rc3-70-gc1ed1df)
>
> arch/arm/kernel/irq.c:81:3: error: implicit declaration of function 'irq_find_mapping' [-Werror=implicit-function-declaration]
>
> So I'm dropping it.

Ouch. Sorry about that. Seems like I only tested this with a config that
has CONFIG_IRQ_DOMAIN set. I'll respin in after the merge window.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny.
