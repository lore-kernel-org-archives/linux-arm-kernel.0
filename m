From: david@lechnology.com (David Lechner)
Date: Fri,  1 Dec 2017 20:34:08 -0600
Subject: [PATCH v1 0/6] ARM: davinci: convert to common clock framework
Message-ID: <1512182054-17410-1-git-send-email-david@lechnology.com>
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

David Lechner (6):
  ARM: davinci: clean up map_io functions
  ARM: davinci: move davinci_clk_init() to init_time
  ARM: davinci: don't use static clk_lookup
  ARM: davinci: make davinci_clk_reset() static
  ARM: davinci: convert to common clock framework
  ARM: davinci: remove clock debugfs

 arch/arm/Kconfig                            |   2 +-
 arch/arm/mach-davinci/board-da830-evm.c     |   9 +-
 arch/arm/mach-davinci/board-da850-evm.c     |   9 +-
 arch/arm/mach-davinci/board-dm355-evm.c     |   9 +-
 arch/arm/mach-davinci/board-dm355-leopard.c |   9 +-
 arch/arm/mach-davinci/board-dm365-evm.c     |   9 +-
 arch/arm/mach-davinci/board-dm644x-evm.c    |  10 +-
 arch/arm/mach-davinci/board-dm646x-evm.c    |  18 +-
 arch/arm/mach-davinci/board-mityomapl138.c  |   9 +-
 arch/arm/mach-davinci/board-neuros-osd2.c   |   9 +-
 arch/arm/mach-davinci/board-omapl138-hawk.c |   9 +-
 arch/arm/mach-davinci/board-sffsdr.c        |   9 +-
 arch/arm/mach-davinci/clock.c               | 299 +++++++++-------------------
 arch/arm/mach-davinci/clock.h               |  48 +++--
 arch/arm/mach-davinci/da830.c               | 217 ++++++++++----------
 arch/arm/mach-davinci/da850.c               | 292 +++++++++++++--------------
 arch/arm/mach-davinci/da8xx-dt.c            |   4 +-
 arch/arm/mach-davinci/davinci.h             |  12 +-
 arch/arm/mach-davinci/devices-da8xx.c       |   9 +-
 arch/arm/mach-davinci/dm355.c               | 184 ++++++++---------
 arch/arm/mach-davinci/dm365.c               | 242 +++++++++++-----------
 arch/arm/mach-davinci/dm644x.c              | 164 +++++++--------
 arch/arm/mach-davinci/dm646x.c              | 180 +++++++++--------
 arch/arm/mach-davinci/include/mach/clock.h  |   3 -
 arch/arm/mach-davinci/include/mach/common.h |   1 -
 arch/arm/mach-davinci/include/mach/da8xx.h  |   7 +-
 arch/arm/mach-davinci/time.c                |   1 -
 arch/arm/mach-davinci/usb-da8xx.c           |  57 +++---
 28 files changed, 841 insertions(+), 990 deletions(-)

-- 
2.7.4
