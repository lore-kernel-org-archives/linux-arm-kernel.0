From: marc.zyngier@arm.com (Marc Zyngier)
Date: Sun, 12 Jun 2016 11:12:40 +0100
Subject: [PATCH v3 1/2] clocksource/arm_arch_timer: Force per-CPU
 interrupt to be level-triggered
In-Reply-To: <CANe6Qb_sx8_rRHZG1PR=A+cgxqYTzreZ0rD01X-gtEDb=h1cVQ@mail.gmail.com>
References: <1465235791-7064-1-git-send-email-marc.zyngier@arm.com>
 <1465235791-7064-2-git-send-email-marc.zyngier@arm.com>
 <5759DB58.5070906@gmail.com> <20160610082952.4f20d732@arm.com>
 <575AFB4A.3030508@gmail.com> <20160611104100.7475689e@arm.com>
 <CANe6Qb_sx8_rRHZG1PR=A+cgxqYTzreZ0rD01X-gtEDb=h1cVQ@mail.gmail.com>
Message-ID: <20160612111240.7dc99322@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 11 Jun 2016 13:02:44 +0100
Ben Dooks <bjdooks@googlemail.com> wrote:

> out of interest, do you have a list of what the problems are?

The trigger configuration for per-cpu interrupts silently fails
(because set_irq_type cannot deal with them). Which means we're relying
on whatever configuration the firmware has left in there. Also, the
kernel defaults to considering the interrupt as edge.

What saves most platforms so far is that they are using a GIC:
1) Most GIC implementations have their PPI configuration as RO, which
   means that we can't get it wrong.
2) If using a fasteoi handler, there is no significant difference in the
   flow between edge and level (we're relying on the HW dealing with it,
   so (1) is critical).

If your GIC allows PPI configuration to be written and firmware gets it
wrong, you'll miss interrupts. If you don't have a GIC, all bets are
off.

I've queued a number of patches to solve this, which I hope to send to
tglx tomorrow (after looking at this weekend test run).

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny.
