From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Tue, 10 Dec 2013 11:41:34 -0300
Subject: [PATCH v5 0/3] Introduce atomic MMIO register modify
Message-ID: <1386686497-20335-1-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After this patchset stalled for several months, I'm picking where
we left. The last conclusion [1] was that instead of doing the arch-generic
from scratch, we'd start by implementing the API in ARM only.

In other words, this is basically a resend of v3, with some of the typos fixed
and using raw spinlocks.

[1] http://www.spinics.net/lists/arm-kernel/msg271773.html

The patch that adds the atomic-modify API is PATCH 1. The other two are sent
as usage examples.

Changes from v4:
* Returned to the ARM-specific implementation for this API. The arch-generic
  can be added later.

Changes from v3:
* Implemented an arch-generic atomic_io_modify(), as suggested by Baruch
  and Catalin.

* Add an ARM-specific variant, using relaxed R/W as Will suggested.

* Replaced spin_locks by raw_spin_locks, to protect the registers
  even on RT.

* Fixed two stupid typos.

Changes from v2:
* As suggested by Will Deacon, dropped the iowmb() barrier
  and use relaxed variants instead. See Will's explanation for
  details: http://www.spinics.net/lists/arm-kernel/msg268775.html

* Use spin_{}_irqsave/restore to allow irq-context usage
  also suggested by Will Deacon.

* Re-worked the API semantics as proposed by Russell King.

Changes from v1:
* Added an io barrier iowmb() as suggested by Will Deacon,
  to ensure the writel gets completed before the spin_unlock().

If nobody has objections, I'll add patch 1/3 to ARM's tracking system
as usual.

Thanks!

Ezequiel Garcia (3):
  ARM: Introduce atomic MMIO modify
  clocksource: orion: Use atomic access for shared registers
  watchdog: orion: Use atomic access for shared registers

 arch/arm/include/asm/io.h        |  6 ++++++
 arch/arm/kernel/io.c             | 35 +++++++++++++++++++++++++++++++++++
 drivers/clocksource/time-orion.c | 28 ++++++++++------------------
 drivers/watchdog/orion_wdt.c     |  8 ++------
 4 files changed, 53 insertions(+), 24 deletions(-)

-- 
1.8.1.5
