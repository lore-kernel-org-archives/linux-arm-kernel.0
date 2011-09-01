From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 1 Sep 2011 13:47:52 +0100
Subject: [PATCH 00/11] Add L2 cache cleaning to generic CPU suspend
Message-ID: <20110901124752.GE29729@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some systems (such as OMAP) preserve the L2 cache across a suspend/
resume cycle.  This means they do not perform L2 cache maintanence
in their suspend finisher function.

However, the side effect is that the saved CPU state is not readable
by the resume code because it is sitting in the L2 cache.

This patch series adds L2 cache cleaning to the generic CPU suspend/
resume support code, making it possible to use this on systems with
L2 cache enabled without having to clean/invalidate the entire L2
cache.

We also add a separate page table, allocated at boot time, for the
resume process to use so we don't have to fiddle about with tweaking
entries in the current processes page table.  Moreover, the current
processes page table may be in use by another CPU in the system if
these paths are used from cpuidle or hotplug, so changing the page
table is technically unsound.

Overall, this makes it possible for OMAP4 systems to use this code.

The first four patches in this set are already merged into Linus' tree
as bug fixes, and are included here for completeness given that the
kernel.org infrastructure is currently offline.

This has (so far) only been tested on OMAP4.  Further testing on OMAP3
and Assabet will follow.
