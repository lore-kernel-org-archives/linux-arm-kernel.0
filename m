From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 21 Jul 2011 16:14:13 +0100
Subject: [PATCH 0/4] Fix CPU hotplug IRQ migration
Message-ID: <20110721151413.GD28942@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series fixes a bunch of issues with IRQ migration:

1. Preventing affinity changes causing IRQs to be directed to off-line CPUs.
2. Preventing oopses with non-GIC interrupt controllers.
3. Preventing per-CPU IRQs being candidates for migration.
4. Removing the abuse of irqdesc's node member.

This prevents crashes on OMAP4430 SDP when non-default IRQ affinity
settings are used and a CPU which owns some IRQs is offlined.

With this patch set applied, there is no reason core code can't handle
CPU0 being offlined - on OMAP4, the only remaining issue is CPU0
being woken from WFI and falsely passing the non-spurious wake-up test.
