From: vz@mleia.com (Vladimir Zapolskiy)
Date: Mon, 26 Sep 2016 03:03:39 +0300
Subject: [PATCH v2 0/4] ARM: imx31: clock initialization fixes
Message-ID: <1474848223-19728-1-git-send-email-vz@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The change is tested on qemu kzm target and mx31lite board, while both
targets don't have DTS in upstream, I had to write simple DTS files for
them, because the proposed change is for i.MX31 targets with OF support.

i.MX31/OF/clock initialization seems to be broken currently, if
the series is not applied I can not get a working clock source during
early boot stage on a board with DTB supplied.

Changes from v1 to v2, thanks to Uwe and Stephen for review:
* added one more new fix in imx31.dtsi which moves CCM device node
  to AIPS2 bus,
* included to the series a fix of CCM interrupts in imx31.dtsi,
  the change was sent as a separate patch, the change is included
  to avoid a patch application dependency,
* as suggested by Uwe reworded one of the commits removing "stack
  corruption" mentioning, the overwritten value is passed in a register,
* as suggested by Uwe squashed clk-imx31.c and imx31-dt.c changes
  to avoid a runtime problem if only one of two patches are applied

Vladimir Zapolskiy (4):
  ARM: dts: imx31: fix clock control module interrupts description
  ARM: dts: imx31: move CCM device node to AIPS2 bus devices
  clk: imx31: fix rewritten input argument of mx31_clocks_init()
  ARM: clk: imx31: properly init clocks for machines with DT

 .../devicetree/bindings/clock/imx31-clock.txt      |  2 +-
 arch/arm/boot/dts/imx31.dtsi                       | 14 +++---
 arch/arm/mach-imx/common.h                         |  1 -
 arch/arm/mach-imx/imx31-dt.c                       |  6 ---
 drivers/clk/imx/clk-imx31.c                        | 52 +++++++++++-----------
 5 files changed, 34 insertions(+), 41 deletions(-)

-- 
2.8.1
