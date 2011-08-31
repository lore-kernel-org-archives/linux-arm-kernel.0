From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 31 Aug 2011 20:04:48 +0100
Subject: [PATCH] arm: gic: fix gic_set_affinity
In-Reply-To: <1314802086-26133-1-git-send-email-tom.leiming@gmail.com>
References: <1314802086-26133-1-git-send-email-tom.leiming@gmail.com>
Message-ID: <20110831190448.GA29729@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 31, 2011 at 10:48:06PM +0800, tom.leiming at gmail.com wrote:
> Current gic_set_affinity doesn't support to route irq to all cpu,
> so fix it.

That is correct - we don't support routing an IRQ to _all_ CPUs because
that's silly - by doing so you end up with a galloping hurd problem.  As
soon as such an interrupt is triggered, it will be delivered to all CPUs,
and all CPUs will be woken up.  All CPUs will then enter the kernel, and
one will win the spinlock race.  The remainder will spin on the lock while
the winner sorts out what to do.

That is inefficient and needlessly causes other CPUs to wake up.  The
point of the current code is that we route IRQs to exactly one CPU at a
time to avoid that problem.

> Also remove the unnecessary check for 'cpu' since cpu_online_mask
> is already ADDed to produce correct one.

Not everywhere - take a look at migrate_one_irq() in arch/arm/kernel/irq.c,
where we want to change the current routing but without actually changing
the user set affinity.
