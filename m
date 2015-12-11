From: tony@atomide.com (Tony Lindgren)
Date: Thu, 10 Dec 2015 16:03:08 -0800
Subject: [GIT PULL 1/2] omap fixes for 81xx for v4.5 merge window
Message-ID: <pull-1449792144-865487>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 29f5b34ca1a191c2cf4f6c8c12f4dec56e8d3bc1:

  arm: omap2+: add missing HWMOD_NO_IDLEST in 81xx hwmod data (2015-11-25 10:54:22 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.5/81xx-fixes-signed

for you to fetch changes up to d893656e61040f3ff7b5f72a986052a348f3c94e:

  ARM: OMAP2+: Remove useless check for legacy booting for dm814x (2015-12-09 16:53:46 -0800)

----------------------------------------------------------------
Fixes for ti81xx for v4.5 merge window. We have hp t410 already booting
in mainline kernel with it's bootloader configured clocks.  However,
trying to boot dm814x-evm uncovered all kind of issues with the timer
clock. To keep t410 booting, these issues need to be fixed in a specific
order and this branch contains both device tree and code changes.

To summarize the changes, we had missing ranges for clocks to probe,
missing aliase for clocks, wrong registers for divder clocks, and bad
address for the control module. All these went unnoticed earlier as
things worked without errors by luck and I did not pay much attention
to them until I got hold of a dm814x-evm and I noticed it did not boot.

As these are fixes for features that never worked, these can wait for
v4.5 merge window no problem.

----------------------------------------------------------------
Tony Lindgren (9):
      ARM: dts: Fix dm814x entries for pllss and prcm
      clk: ti: Add few dm814x clock aliases
      ARM: OMAP2+: Add DPPLS clock manager for dm814x
      ARM: dts: Fix some mux and divider clocks to get dm814x-evm booting
      ARM: OMAP2+: Fix timer entries for dm814x
      ARM: dts: Fix dm8148 control modules ranges
      ARM: dts: Fix dm814x pinctrl address and mask
      ARM: OMAP2+: Enable GPIO for dm814x
      ARM: OMAP2+: Remove useless check for legacy booting for dm814x

 arch/arm/boot/dts/dm814x-clocks.dtsi       | 109 +++++++++++++++++++++--------
 arch/arm/boot/dts/dm814x.dtsi              |  33 ++++++---
 arch/arm/mach-omap2/io.c                   |   3 +-
 arch/arm/mach-omap2/omap_hwmod_81xx_data.c |  12 ++--
 arch/arm/mach-omap2/prm_common.c           |   6 ++
 drivers/clk/ti/clk-814x.c                  |   4 ++
 include/linux/clk/ti.h                     |   1 +
 7 files changed, 122 insertions(+), 46 deletions(-)
