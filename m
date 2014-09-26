From: heiko@sntech.de (Heiko Stuebner)
Date: Fri, 26 Sep 2014 20:53:03 +0200
Subject: [PATCH v4 0/8] ARM: rockchip: add cpuclk handling - clock-tree part
Message-ID: <1411757591-16142-1-git-send-email-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series implements cpu frequency-scaling for Rockchip SoCs.
The whole handling of the armclk frequency changes and therefore
the implementention is very similar to the recent series for
Samsung SoCs from Thomas Abraham.

Tested on a
- rk3066 Marsboard
- rk3188 Radxa Rock
- rk3288 Evaluation board

This is the part that would go through the clock tree and the patches
are build against current clk-next.

-------
On the arm-soc side we would need the ARMCLK id in an exported branch
from the clk tree so that the devicetree changes can use this new id.
But as 3.17 is supposed to be released this weekend, the devicetree
parts will maybe have to wait for 3.18-rc1 in any case.
-------

The series also is split, as clk-next and the arm-soc parts have diverged
so much, that it's not possible to create one series against one tree
and stay sane.

changes since v3:
- address more comments from Doug Anderson:
  main change setting the dividers in the post_rate callback
- use __initdata for the rate tables
  While it could use __initconst the current code causes a section
  type conflict with something else, so this could possibly be
  solved at a later time
changes since v2:
- add patch removing the pll clk-notifier
- in cpuclk do parent change and alt_div setting in one go
changes since v1:
- address comments received concerning smaller issues
- split series into two, one for clk-next and one for arm-soc


Doug Anderson (1):
  clk: rockchip: change pll rate without a clk-notifier

Heiko Stuebner (6):
  clk: rockchip: fix rk3066 pll status register location
  clk: rockchip: reparent aclk_cpu_pre to the gpll
  clk: rockchip: make tightly bound armclk child-clocks read-only
  clk: rockchip: add new clock-type for the cpuclk
  clk: rockchip: add binding id for ARMCLK
  clk: rockchip: switch to using the new cpuclk type for armclk

Jianqun (1):
  clk: rockchip: fix rk3288 pll status register location

 drivers/clk/rockchip/Makefile                 |   1 +
 drivers/clk/rockchip/clk-cpu.c                | 329 ++++++++++++++++++++++++++
 drivers/clk/rockchip/clk-pll.c                |  63 +----
 drivers/clk/rockchip/clk-rk3188.c             | 161 +++++++++++--
 drivers/clk/rockchip/clk-rk3288.c             |  93 +++++++-
 drivers/clk/rockchip/clk.c                    |  20 ++
 drivers/clk/rockchip/clk.h                    |  36 +++
 include/dt-bindings/clock/rk3188-cru-common.h |   1 +
 include/dt-bindings/clock/rk3288-cru.h        |   1 +
 9 files changed, 627 insertions(+), 78 deletions(-)
 create mode 100644 drivers/clk/rockchip/clk-cpu.c

-- 
2.1.0
