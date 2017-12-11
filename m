From: yixun.lan@amlogic.com (Yixun Lan)
Date: Mon, 11 Dec 2017 22:13:42 +0800
Subject: [PATCH v7 0/6] add clk controller driver for Meson-AXG SoC
Message-ID: <20171211141348.22048-1-yixun.lan@amlogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add driver for the clk controller which found in Meson AXG SoC

  Note, we deliberately create a seperate source file for the Meson AXG
series, instead of sharing code with previous GXBB/GXL - the file axg.c
It would help us maintaining the code more easily.

Changes since v6 [6]:
 - move the spinlock' change patch as first as the dependency
 - drop unnecessary flag CLK_GET_RATE_NOCACHE, CLK_SET_RATE_NO_REPARENT
 - drop useless comments
 - fix checkpatch issue, over 80 characters 

Changes since v5 [5]:
 - add Rob's Ack for patch 2, add Neil's Ack for patch 3
 - include spinlock' name change patch, patch 4
 - include uart_ao clock DTS patch

Changes since v4 [4]:
 - use devm_ioremap instead of devm_ioremap_resource
 - rename DT node using generic name 'bus'

Changes since v3 [3]:
 - separate dt-bindings header file
 - adjust license note as standard way
 - replace of_iomap with platform/devm API
 - add Rob's Ack to Patch 1,4

Changes since v2 [2]:
 - drop register offset calculation
 - update dt-bindings for new compatible variant

Changes since v1 [1]:
 - rework register definion, use '(offset << 2)' to better match
   the description from data sheet
 - drop "#include dt-bindings/clock/gxbb-aoclkc.h" from dts
 - rebase code to v4.15-rc1

[6]
  http://lists.infradead.org/pipermail/linux-amlogic/2017-December/005721.html
  http://lists.infradead.org/pipermail/linux-amlogic/2017-December/005722.html
  http://lists.infradead.org/pipermail/linux-amlogic/2017-December/005723.html
  http://lists.infradead.org/pipermail/linux-amlogic/2017-December/005724.html
  http://lists.infradead.org/pipermail/linux-amlogic/2017-December/005725.html
  http://lists.infradead.org/pipermail/linux-amlogic/2017-December/005726.html
  http://lists.infradead.org/pipermail/linux-amlogic/2017-December/005727.html
 
[5]
  http://lists.infradead.org/pipermail/linux-amlogic/2017-December/005655.html
  http://lists.infradead.org/pipermail/linux-amlogic/2017-December/005656.html
  http://lists.infradead.org/pipermail/linux-amlogic/2017-December/005657.html
  http://lists.infradead.org/pipermail/linux-amlogic/2017-December/005658.html
  http://lists.infradead.org/pipermail/linux-amlogic/2017-December/005659.html

[4]
  http://lists.infradead.org/pipermail/linux-amlogic/2017-November/005522.html
  http://lists.infradead.org/pipermail/linux-amlogic/2017-November/005525.html
  http://lists.infradead.org/pipermail/linux-amlogic/2017-November/005526.html

[3]
  http://lists.infradead.org/pipermail/linux-amlogic/2017-November/005487.html
  http://lists.infradead.org/pipermail/linux-amlogic/2017-November/005488.html
  http://lists.infradead.org/pipermail/linux-amlogic/2017-November/005489.html
  http://lists.infradead.org/pipermail/linux-amlogic/2017-November/005490.html

[2]
  http://lists.infradead.org/pipermail/linux-amlogic/2017-November/005468.html
  http://lists.infradead.org/pipermail/linux-amlogic/2017-November/005469.html
  http://lists.infradead.org/pipermail/linux-amlogic/2017-November/005470.html

[1] 
  http://lists.infradead.org/pipermail/linux-amlogic/2017-November/005239.html
  http://lists.infradead.org/pipermail/linux-amlogic/2017-November/005240.html
  http://lists.infradead.org/pipermail/linux-amlogic/2017-November/005241.html

Qiufang Dai (3):
  clk: meson-axg: add clocks dt-bindings required header
  clk: meson-axg: add clock controller drivers
  arm64: dts: meson-axg: add clock DT info for Meson AXG SoC

Yixun Lan (3):
  clk: meson: make the spinlock naming more specific
  dt-bindings: clock: add compatible variant for the Meson-AXG
  arm64: dts: meson-axg: switch uart_ao clock to CLK81

 .../bindings/clock/amlogic,gxbb-clkc.txt           |   7 +-
 arch/arm64/Kconfig.platforms                       |   1 +
 arch/arm64/boot/dts/amlogic/meson-axg-s400.dts     |   2 +
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi         |  19 +-
 drivers/clk/meson/Kconfig                          |   8 +
 drivers/clk/meson/Makefile                         |   1 +
 drivers/clk/meson/axg.c                            | 936 +++++++++++++++++++++
 drivers/clk/meson/axg.h                            | 126 +++
 drivers/clk/meson/clkc.h                           |   2 +-
 drivers/clk/meson/gxbb.c                           | 112 +--
 drivers/clk/meson/meson8b.c                        |  24 +-
 include/dt-bindings/clock/axg-clkc.h               |  71 ++
 12 files changed, 1234 insertions(+), 75 deletions(-)
 create mode 100644 drivers/clk/meson/axg.c
 create mode 100644 drivers/clk/meson/axg.h
 create mode 100644 include/dt-bindings/clock/axg-clkc.h

-- 
2.15.1
