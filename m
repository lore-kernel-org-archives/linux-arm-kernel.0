From: will.deacon@arm.com (Will Deacon)
Date: Thu, 24 Nov 2011 16:13:37 +0000
Subject: cpu_pm breaks 3.2 boot on platforms with cascading GICs
Message-ID: <20111124161336.GB22031@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Colin,

Commit 254056f3 ("ARM: gic: Use cpu pm notifiers to save gic state") adds
cpu_pm notifier support to the GIC. The problem is that you register a notifier
for each GIC registered via gic_init, so on a platform with cascading GICs the
notifier is registered multiple times.

The fun part about this is that the way the notifier chain is constructed
you end up with the GIC notifier pointing to itself as the next node, so you
get a cycle in the chain. The next poor subsystem that tries to register a
notifier (in my case, VFP) gets stuck in notifier_chain_register because the
loop:

	while ((*nl) != NULL) {
		if (n->priority > (*nl)->priority)
			break;
		nl = &((*nl)->next);
	}

will never exit!

I'm not sure how you want to handle this. Clearly you should only register one
notifier for the GIC, but it does need to handle the cascading situation
properly.

This affects current mainline, so we need a solution for 3.2.

Will
