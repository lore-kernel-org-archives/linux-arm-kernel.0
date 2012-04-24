From: viresh.kumar@st.com (Viresh Kumar)
Date: Tue, 24 Apr 2012 12:20:28 +0530
Subject: [PATCH V3 0/8] SPEAr: Move to common clock framework
Message-ID: <cover.1335249846.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mike,

You can apply all these patches as they don't have any dependency left (leaving
the ones included here) and will now apply cleanly over linux-next.

SPEAr now supports common clock framework. This patchset contains changes
related to this.

V2->V3:
- Created spear/clk.c for common routines
- Fixed #ifndef,#ifdef,#endif name in spear/clk.h
- Included dependency patches, so that Mike can apply these patches

V1->V2:
- Removed first seven commits as they are directly picked by Mike into his next.
- Moved SPEAr clock support to drivers/clk/spear/ from arch/arm/
- Fixed error handling issues in spear clk drivers
- Rearranged patches to get git bisect working

Russell King (1):
  CLKDEV: Add helper routines to allocate and add clkdevs for given
    struct clk *

Sascha Hauer (1):
  clk: add a fixed factor clock

Viresh Kumar (6):
  SPEAr: clk: Add VCO-PLL Synthesizer clock
  SPEAr: clk: Add Auxiliary Synthesizer clock
  SPEAr: clk: Add Fractional Synthesizer clock
  SPEAr: clk: Add General Purpose Timer Synthesizer clock
  SPEAr: Call clk_prepare() before calling clk_enable
  SPEAr: Switch to common clock framework

 MAINTAINERS                                     |    4 +-
 arch/arm/Kconfig                                |    1 +
 arch/arm/mach-spear3xx/Makefile                 |    2 +-
 arch/arm/mach-spear3xx/clock.c                  |  892 --------------------
 arch/arm/mach-spear3xx/include/mach/generic.h   |    4 +-
 arch/arm/mach-spear3xx/include/mach/misc_regs.h |    2 +
 arch/arm/mach-spear3xx/include/mach/spear.h     |   13 +
 arch/arm/mach-spear3xx/spear300.c               |    1 -
 arch/arm/mach-spear3xx/spear310.c               |    1 -
 arch/arm/mach-spear3xx/spear320.c               |   12 +-
 arch/arm/mach-spear3xx/spear3xx.c               |    2 +
 arch/arm/mach-spear6xx/Makefile                 |    2 +-
 arch/arm/mach-spear6xx/clock.c                  |  789 ------------------
 arch/arm/mach-spear6xx/include/mach/misc_regs.h |    2 +
 arch/arm/mach-spear6xx/spear6xx.c               |    5 +-
 arch/arm/plat-spear/Makefile                    |    2 +-
 arch/arm/plat-spear/clock.c                     | 1005 -----------------------
 arch/arm/plat-spear/include/plat/clock.h        |  249 ------
 arch/arm/plat-spear/time.c                      |    8 +-
 drivers/clk/Makefile                            |    5 +-
 drivers/clk/clk-fixed-factor.c                  |   94 +++
 drivers/clk/clkdev.c                            |   64 ++-
 drivers/clk/spear/Makefile                      |    8 +
 drivers/clk/spear/clk-aux-synth.c               |  189 +++++
 drivers/clk/spear/clk-frac-synth.c              |  156 ++++
 drivers/clk/spear/clk-gpt-synth.c               |  145 ++++
 drivers/clk/spear/clk-vco-pll.c                 |  346 ++++++++
 drivers/clk/spear/clk.c                         |   36 +
 drivers/clk/spear/clk.h                         |  133 +++
 drivers/clk/spear/spear3xx_clock.c              |  612 ++++++++++++++
 drivers/clk/spear/spear6xx_clock.c              |  342 ++++++++
 include/linux/clk-private.h                     |   20 +
 include/linux/clk-provider.h                    |   23 +
 include/linux/clkdev.h                          |    3 +
 34 files changed, 2210 insertions(+), 2962 deletions(-)
 delete mode 100644 arch/arm/mach-spear3xx/clock.c
 delete mode 100644 arch/arm/mach-spear6xx/clock.c
 delete mode 100644 arch/arm/plat-spear/clock.c
 delete mode 100644 arch/arm/plat-spear/include/plat/clock.h
 create mode 100644 drivers/clk/clk-fixed-factor.c
 create mode 100644 drivers/clk/spear/Makefile
 create mode 100644 drivers/clk/spear/clk-aux-synth.c
 create mode 100644 drivers/clk/spear/clk-frac-synth.c
 create mode 100644 drivers/clk/spear/clk-gpt-synth.c
 create mode 100644 drivers/clk/spear/clk-vco-pll.c
 create mode 100644 drivers/clk/spear/clk.c
 create mode 100644 drivers/clk/spear/clk.h
 create mode 100644 drivers/clk/spear/spear3xx_clock.c
 create mode 100644 drivers/clk/spear/spear6xx_clock.c

-- 
1.7.9
