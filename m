From: peterz@infradead.org (Peter Zijlstra)
Date: Wed, 20 Apr 2011 10:34:25 +0200
Subject: Lockdep question.
In-Reply-To: <BANLkTi=PF6zx0yc1UOUDEgAyN2XV8+eG=A@mail.gmail.com>
References: <BANLkTi=PF6zx0yc1UOUDEgAyN2XV8+eG=A@mail.gmail.com>
Message-ID: <1303288465.8345.46.camel@twins>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2011-04-20 at 03:15 -0500, Andrei Warkentin wrote:
> Hi Peter, Hi Ingo, (and LAKML)
> 
> I was playing around with a 2.6.36 kernel on an ARM board, and decided
> to turn on lockdep.

Well, that's a truly ancient kernel you got there ;-)

> Am I interpreting this correctly?
> 
> The global interrupt controller code arch/arm/common/gic.c, uses spin_lock and
> spin_unlock (not spin_lock_irqsave and spin_unlock_irqrestore). I
> suppose this is because the interrupts are guaranteed to be off anyway
> - either

1)

> because the routines are used on an actual interrupt, where the GIC
> ensures no more interrupts would be delivered, or

2)

> because of an actual spin_lock_irqsave
> done in kernel/irq/manage.c:disable_irq_nosync:disable_irq_nosync().
> 
> Is this failure because lockdep thinks the GIC irq_controller_lock
> could be taken in both interrupt and non-interrupt context (since it
> isn't aware of the guarantee enforced by the GIC interrupt path)?

What its saying is that it was used from within IRQ context through that
GIC interrupt path (so that works) but also used outside of IRQ context
with IRQs enabled, invalidating your claim 2 above, see the backtrace:

> 
> =================================
> [ INFO: inconsistent lock state ]
> 2.6.36.3-g0a066c9-dirty #17
> ---------------------------------
> inconsistent {IN-HARDIRQ-W} -> {HARDIRQ-ON-W} usage.
> swapper/1 [HC0[0]:SC0[0]:HE1:SE1] takes:
>  (irq_controller_lock){?.....}, at: [<c019f2f4>] gic_mask_irq+0x1c/0x78
> {IN-HARDIRQ-W} state was registered at:
>   [<c01fe1d8>] __lock_acquire+0x6ec/0x9ec
>   [<c01fe538>] lock_acquire+0x60/0x74
>   [<c0576c4c>] _raw_spin_lock+0x50/0x88
>   [<c019f2f4>] gic_mask_irq+0x1c/0x78
>   [<c01a1a50>] tegra_mask+0xc/0x18
>   [<c0215618>] handle_level_irq+0x40/0x144
>   [<c019408c>] asm_do_IRQ+0x8c/0xcc
>   [<c0194bf0>] __irq_svc+0x50/0xec
>   [<c01d037c>] vprintk+0x41c/0x4a8
>   [<c0573748>] printk+0x1c/0x28
>   [<c0012d50>] lockdep_info+0x24/0xa4
>   [<c0008c20>] start_kernel+0x208/0x308
>   [<00008080>] 0x8080
> irq event stamp: 196724
> hardirqs last  enabled at (196724): [<c0577908>] _raw_spin_unlock_irqrestore+0x3c/0x6c
> hardirqs last disabled at (196723): [<c0576dcc>] _raw_spin_lock_irqsave+0x1c/0x9c
> softirqs last  enabled at (195681): [<c01d55b0>] irq_exit+0x58/0xbc
> softirqs last disabled at (195668): [<c01d55b0>] irq_exit+0x58/0xbc
> 
> other info that might help us debug this:
> no locks held by swapper/1.
> 
> stack backtrace:
> [<c019a79c>] (unwind_backtrace+0x0/0xf0) from [<c01fab8c>] (mark_lock+0x5a4/0x7d8)
> [<c01fab8c>] (mark_lock+0x5a4/0x7d8) from [<c01fe264>] (__lock_acquire+0x778/0x9ec)
> [<c01fe264>] (__lock_acquire+0x778/0x9ec) from [<c01fe538>] (lock_acquire+0x60/0x74)
> [<c01fe538>] (lock_acquire+0x60/0x74) from [<c0576c4c>] (_raw_spin_lock+0x50/0x88)
> [<c0576c4c>] (_raw_spin_lock+0x50/0x88) from [<c019f2f4>] (gic_mask_irq+0x1c/0x78)
> [<c019f2f4>] (gic_mask_irq+0x1c/0x78) from [<c01a1a50>] (tegra_mask+0xc/0x18)
> [<c01a1a50>] (tegra_mask+0xc/0x18) from [<c000ebd4>] (tegra_cpuidle_init+0xac/0x300)
> [<c000ebd4>] (tegra_cpuidle_init+0xac/0x300) from [<c01945c4>] (do_one_initcall+0xd0/0x1a8)
> [<c01945c4>] (do_one_initcall+0xd0/0x1a8) from [<c0008708>] (kernel_init+0x14c/0x210)
> [<c0008708>] (kernel_init+0x14c/0x210) from [<c0195c88>] (kernel_thread_exit+0x0/0x8)

Now, no 2.6.36 tree near me includes tegra_cpuidle_init, so I bet you've
got funky patches on top. Anyway see if that code path also includes the
whole irqsave desc->lock stuff.
