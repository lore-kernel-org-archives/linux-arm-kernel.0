From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon,  1 Oct 2012 23:12:03 +0200
Subject: [PATCH V2 0/3] Add clock framework for armada 370/XP
Message-ID: <1349125926-16144-1-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Mike,

My first version didn't get many attention, so I guess it's too late
for 3.7! ;) I should have ping you earlier about this series. This
time was not lost, by using the cpu clock with SMP I found a bug and
fixed it. And I also improved the spelling and removed unnecessary
small piece of code thanks to the feed back of Andrew Lunn.

The purpose of this patch set is to add support for clock framework
for Armada 370 and Armada XP SoCs. All the support is done under the
directory drivers/clk/mvebu/ as the support for other mvebu SoCs was
in mind during the writing of the code.

Two kinds of clocks are added:

- The CPU clocks are only for Armada XP (which si multi-core)

- The core clocks are clocks which have their rate fixed during
  reset.

This patch set is based on the clk-3.7 branch of Mike Turquette as it
use the patch "clk: add of_clk_src_onecell_get() support" from Shawn
Guo.

Many thanks to Thomas Petazzoni and Sebastian Hesselbarth for their
review and feedback. The device tree bindings were really improved
with the advices of Sebastian.

Changelog:
V1 -> V2:

- Improved the spelling and the wording of the documentation and the
  1st commit log
- Removed the "end_of_list" name which are unused here.
- Fix the cpu clock by using of_clk_src_onecell_get in the same way it
  was used for the core clocks

Regards,

Gregory CLEMENT (3):
  clk: mvebu: add armada-370-xp specific clocks
  clk: armada-370-xp: add support for clock framework
  clocksource: time-armada-370-xp converted to clk framework

 .../devicetree/bindings/clock/mvebu-core-clock.txt |   40 +++
 .../devicetree/bindings/clock/mvebu-cpu-clock.txt  |   21 ++
 arch/arm/boot/dts/armada-370-db.dts                |    4 -
 arch/arm/boot/dts/armada-370-xp.dtsi               |    1 +
 arch/arm/boot/dts/armada-370.dtsi                  |   12 +
 arch/arm/boot/dts/armada-xp.dtsi                   |   48 +++
 arch/arm/mach-mvebu/Kconfig                        |    5 +
 arch/arm/mach-mvebu/armada-370-xp.c                |    8 +-
 arch/arm/mach-mvebu/common.h                       |    1 +
 drivers/clk/Makefile                               |    1 +
 drivers/clk/mvebu/Makefile                         |    2 +
 drivers/clk/mvebu/clk-core.c                       |  312 ++++++++++++++++++++
 drivers/clk/mvebu/clk-core.h                       |   19 ++
 drivers/clk/mvebu/clk-cpu.c                        |  155 ++++++++++
 drivers/clk/mvebu/clk-cpu.h                        |   19 ++
 drivers/clk/mvebu/clk.c                            |   36 +++
 drivers/clocksource/time-armada-370-xp.c           |   11 +-
 17 files changed, 685 insertions(+), 10 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/mvebu-core-clock.txt
 create mode 100644 Documentation/devicetree/bindings/clock/mvebu-cpu-clock.txt
 create mode 100644 drivers/clk/mvebu/Makefile
 create mode 100644 drivers/clk/mvebu/clk-core.c
 create mode 100644 drivers/clk/mvebu/clk-core.h
 create mode 100644 drivers/clk/mvebu/clk-cpu.c
 create mode 100644 drivers/clk/mvebu/clk-cpu.h
 create mode 100644 drivers/clk/mvebu/clk.c

-- 
1.7.9.5
