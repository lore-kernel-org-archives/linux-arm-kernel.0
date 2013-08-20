From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Tue, 20 Aug 2013 13:48:24 -0300
Subject: [PATCH v2 0/3] Introduce atomic MMIO register clear-set
Message-ID: <1377017307-23201-1-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here's the v2 for the introduction of a generic thread-safe clear-set
register access.

Following the v1, I've added a proper barrier to ensure proper ordering,
between the writel and the spin_unlock.

It's worth noticing a different approach has been proposed (several times)
for getting thread-safe register access, through the use of regmap_update_bits
(just as it's done in mfd/syscon).

However, as noted in [1], such solution has been rejected (several times)
for two reasons:

  * It's way more heavy-weight than necessary
  * It cannot be used in very early scenarios,
    such as a clocksource initialization.

Using this API it's possible -for instance- to add support for Armada 370/XP
in the orion_wdt driver. That work is ready, and it's been hold until we
decide a proper solution for shared-register access.

[1] http://www.spinics.net/lists/arm-kernel/msg266494.html

Ezequiel Garcia (3):
  ARM: Introduce atomic MMIO clear/set
  clocksource: orion: Use atomic access for shared registers
  watchdog: orion: Use atomic access for shared registers

 arch/arm/include/asm/io.h        |  5 +++++
 arch/arm/kernel/io.c             | 13 +++++++++++++
 drivers/clocksource/time-orion.c |  9 ++-------
 drivers/watchdog/orion_wdt.c     |  8 ++------
 4 files changed, 22 insertions(+), 13 deletions(-)

-- 
1.8.1.5
