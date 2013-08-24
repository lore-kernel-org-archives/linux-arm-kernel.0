From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Sat, 24 Aug 2013 12:35:28 -0300
Subject: [PATCH v4 0/4] Introduce atomic MMIO modify
Message-ID: <1377358532-23802-1-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset introduces an atomic MMIO modify API.
The motivation for adding this is to allow cheap, infrastructure-less,
thread-safe access to an MMIO region, even in very early scenarios.

The chosen mask/set semantic (proposed by Russell King) is clean and flexible
enough and matches the regmap_update_bits() prototype. Consistency is good.

This series adds a simple arch-generic implementation in a new lib/atomicio.c
file. On top of that it implements an ARM-optimized variant following Will
Deacon's suggestions, that take advantage of ARM relaxed read/write functions.

Finally, just to show a few usage for this function, last two patches show
how this would solve one of the current shared-registers issues.

Since this 4th version is no longer ARM-specific but kernel-wide, and perhaps
new reviewers might jump in, please read the previous discussion on why this
is needed and why we cannot use a regmap API.

v1: https://lkml.org/lkml/2013/8/10/75
v2: http://comments.gmane.org/gmane.linux.ports.arm.kernel/261879
v3: http://www.spinics.net/lists/arm-kernel/msg269263.html

Thoughts?

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

Ezequiel Garcia (4):
  lib: Introduce atomic MMIO modify
  ARM: Add atomic_io_modify optimized routines
  clocksource: orion: Use atomic access for shared registers
  watchdog: orion: Use atomic access for shared registers

 arch/arm/include/asm/io.h        |  4 ++++
 arch/arm/kernel/io.c             | 29 +++++++++++++++++++++++++++++
 drivers/clocksource/time-orion.c | 29 +++++++++++------------------
 drivers/watchdog/orion_wdt.c     |  8 ++------
 include/linux/io.h               |  5 +++++
 lib/Makefile                     |  2 +-
 lib/atomicio.c                   | 27 +++++++++++++++++++++++++++
 7 files changed, 79 insertions(+), 25 deletions(-)
 create mode 100644 lib/atomicio.c

-- 
1.8.1.5
