From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Fri, 23 Aug 2013 07:24:02 -0300
Subject: [PATCH v3 0/3] Introduce atomic MMIO register modify
Message-ID: <1377253445-2842-1-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After some discussion about the API semantic and implementation,
here's a new version, re-working both:

The semantic has been changed, and the new one is considered cleaner
(although slighlty less intuitive). In addition, it matches the
regmap_update_bits() prototype, which should appear nicely consistent
to our beloved users.

Following Will Deacon's suggestions, I reworked the implementation
mainly to reduce the performance penalty. See the previous discussion,
or the changelog (below) for details.

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

Russell: If nobody has any objections, I'll add patch 1/3 to the
tracking system.

Thanks!

Ezequiel Garcia (3):
  ARM: Introduce atomic MMIO modify
  clocksource: orion: Use atomic access for shared registers
  watchdog: orion: Use atomic access for shared registers

 arch/arm/include/asm/io.h        |  6 ++++++
 arch/arm/kernel/io.c             | 29 +++++++++++++++++++++++++++++
 drivers/clocksource/time-orion.c | 28 ++++++++++------------------
 drivers/watchdog/orion_wdt.c     |  8 ++------
 4 files changed, 47 insertions(+), 24 deletions(-)

-- 
1.8.1.5
