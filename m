From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Sat, 10 Aug 2013 09:42:59 -0300
Subject: [PATCH 0/3] Introduce atomic MMIO register clear-set
Message-ID: <1376138582-7550-1-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Following a suggestion from Sebastian Hesselbarth and Russell King
here's some work to introduce a generic thread-safe clear-set register
access.

The original motivation for this comes from the need to access the same
register from a clocksource driver and a watchdog driver as we find
in Kirkwood, Armada 370/XP SoCs.

Since this sort of design is expected to appear in other platforms,
instead of exporting platform-specific {mvebu,orion}_clear_set() functions
for the thread-safe access, this patchset implements a system-wide API.

Although this is placed in arm/kernel/io.c, there's nothing
ARM-specific in the API and should probably me moved somewhere else.

Suggestions on where to put it are appreciated.

Using this API it's possible -for instance- to add support for Armada 370/XP
in the orion_wdt driver. That work is ready, and it's been hold until we
decide a proper solution for shared-register access.

Based in v3.11-rc4.

Ezequiel Garcia (3):
  ARM: Introduce atomic MMIO clear/set
  clocksource: orion: Use atomic access for shared registers
  watchdog: orion: Use atomic access for shared registers

 arch/arm/include/asm/io.h        |  5 +++++
 arch/arm/kernel/io.c             | 24 ++++++++++++++++++++++++
 drivers/clocksource/time-orion.c |  9 ++-------
 drivers/watchdog/orion_wdt.c     |  8 ++------
 4 files changed, 33 insertions(+), 13 deletions(-)

-- 
1.8.1.5
