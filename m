From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 13 May 2013 09:32:05 +0800
Subject: [PATCH 0/3] ARM: imx: make mxs_restart() work for DT boot
Message-ID: <1368408728-12264-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The mxs_restart() currently only works for non-DT platforms.  And per
Russell's comment, it's not going to work reliably, because the restart
routine could be called in atomic context while mxs_restart() is calling
clk_prepare() there.

The series fixes above potential problem by moving clk_prepare() into
initialization function mxc_arch_reset_init() and only keeping atomic
part clk_enable() in mxs_restart().

Then a DT variant initialization function imx_arch_reset_init() is
added, so that DT platforms can use mxs_restart() as well after invoking
the initialization function.

Shawn Guo (3):
  ARM: imx: include <asm/io.h> in hardware.h
  ARM: imx: move clk_prepare() out from mxs_restart()
  ARM: imx: create imx_arch_reset_init() for DT boot

 arch/arm/mach-imx/common.h     |    1 +
 arch/arm/mach-imx/hardware.h   |    1 +
 arch/arm/mach-imx/imx25-dt.c   |    2 ++
 arch/arm/mach-imx/imx27-dt.c   |    2 ++
 arch/arm/mach-imx/imx31-dt.c   |    2 ++
 arch/arm/mach-imx/imx51-dt.c   |    2 ++
 arch/arm/mach-imx/mach-imx53.c |    3 +++
 arch/arm/mach-imx/mm-imx1.c    |    2 +-
 arch/arm/mach-imx/mm-imx21.c   |    2 +-
 arch/arm/mach-imx/mm-imx25.c   |    2 +-
 arch/arm/mach-imx/mm-imx27.c   |    2 +-
 arch/arm/mach-imx/mm-imx3.c    |    4 ++--
 arch/arm/mach-imx/mm-imx5.c    |    3 +--
 arch/arm/mach-imx/system.c     |   47 +++++++++++++++++++++++++++++++---------
 14 files changed, 57 insertions(+), 18 deletions(-)

-- 
1.7.9.5
