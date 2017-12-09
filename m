From: david@lechnology.com (David Lechner)
Date: Fri,  8 Dec 2017 19:43:46 -0600
Subject: [PATCH v2 0/5] ARM: davinci: convert to common clock framework
Message-ID: <1512783831-19487-1-git-send-email-david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series takes the first steps towards moving mach-davinci to the common
clock framework.

Basically, this series does some cleanup and rearranging to get things
ready for the conversion. Then in "ARM: davinci: convert to common clock
framework" we actually make the conversion. This is done by just creating
a thin layer around the existing mach clock code.

There is certainly more to be done to make full use of the common clock
framework, but this seems like the smallest logical set of patches to get
CONFIG_COMMON_CLK switched on. Otherwise, I think we would end up with a
series of 20+ patches that would be harder to review.

I have tested this on LEGO MINDSTORMS EV3 (TI AM1808), so I am confident
that I haven't broken anything (too badly) in da850. But, I don't have
other hardware to test.

v2 changes:
* Dropped "ARM: davinci: clean up map_io functions" - will resend as separate
  patch series
* Reworked remaining patches so that there is less shuffling around


David Lechner (5):
  ARM: davinci: move davinci_clk_init() to init_time
  ARM: davinci: don't use static clk_lookup
  ARM: davinci: make davinci_clk_reset() static
  ARM: davinci: convert to common clock framework
  ARM: davinci: remove clock debugfs

 arch/arm/Kconfig                            |   2 +-
 arch/arm/mach-davinci/board-da830-evm.c     |   2 +-
 arch/arm/mach-davinci/board-da850-evm.c     |   2 +-
 arch/arm/mach-davinci/board-dm355-evm.c     |   2 +-
 arch/arm/mach-davinci/board-dm355-leopard.c |   2 +-
 arch/arm/mach-davinci/board-dm365-evm.c     |   2 +-
 arch/arm/mach-davinci/board-dm644x-evm.c    |   2 +-
 arch/arm/mach-davinci/board-dm646x-evm.c    |  11 +-
 arch/arm/mach-davinci/board-mityomapl138.c  |   2 +-
 arch/arm/mach-davinci/board-neuros-osd2.c   |   2 +-
 arch/arm/mach-davinci/board-omapl138-hawk.c |   2 +-
 arch/arm/mach-davinci/board-sffsdr.c        |   2 +-
 arch/arm/mach-davinci/clock.c               | 299 +++++++++-------------------
 arch/arm/mach-davinci/clock.h               |  48 +++--
 arch/arm/mach-davinci/da830.c               | 215 ++++++++++----------
 arch/arm/mach-davinci/da850.c               | 290 ++++++++++++++-------------
 arch/arm/mach-davinci/da8xx-dt.c            |   2 +-
 arch/arm/mach-davinci/davinci.h             |   4 +
 arch/arm/mach-davinci/devices-da8xx.c       |   9 +-
 arch/arm/mach-davinci/dm355.c               | 182 ++++++++---------
 arch/arm/mach-davinci/dm365.c               | 240 +++++++++++-----------
 arch/arm/mach-davinci/dm644x.c              | 162 +++++++--------
 arch/arm/mach-davinci/dm646x.c              | 177 ++++++++--------
 arch/arm/mach-davinci/include/mach/clock.h  |   3 -
 arch/arm/mach-davinci/include/mach/common.h |   1 -
 arch/arm/mach-davinci/include/mach/da8xx.h  |   3 +
 arch/arm/mach-davinci/usb-da8xx.c           |  57 +++---
 27 files changed, 820 insertions(+), 905 deletions(-)

-- 
2.7.4
