From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 19 Sep 2011 17:37:41 +0100
Subject: [PATCH 0/7] Add L2 cache cleaning to generic CPU suspend
Message-ID: <20110919163741.GE16591@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a re-post of the previous patch series, but with an additional
TLB flush to ensure that hte global TLB entry in the page tables is
flushed out.  This is a flush of all TLB entries, but it could probably
be more targetted if we need to.

Original cover mail follows:

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
