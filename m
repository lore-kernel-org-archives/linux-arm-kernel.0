From: yixun.lan@amlogic.com (Yixun Lan)
Date: Sun, 8 Apr 2018 11:19:31 +0800
Subject: [PATCH v4 0/7] clk: meson-axg: Add AO Cloclk and Reset driver
Message-ID: <20180408031938.153474-1-yixun.lan@amlogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

  This patch try to add AO clock and Reset driver for Amlogic's
Meson-AXG SoC.
  Please note that patch 7 need to wait for the DTS changes[3] merged
into mainline first, otherwise it will break the serial console.

 patch 1: factor the common code into a dedicated file
 patch 3-5: add the aoclk driver for AXG SoC
 patch 6-7: drop unnecessary clock flags

changes since v3 at [4]: 
 - add 'const' contraint to the read-only data
 - switch to devm_of_clk_add_hw_provider API
 - check return value of devm_reset_controller_register

changes since v2 at [2]: 
 - rework meson_aoclkc_probe() which leverage the of_match_data
 - merge patch 5-6 into this series
 - seperate DTS patch, will send to Kevin Hilman independently
 
changes since v1 at [0]: 
 - rebase to clk-meson's branch 'next/drivers' [1]
 - fix license, update to BSD-3-Clause
 - drop un-used include header file

[0] https://lkml.kernel.org/r/20180209070026.193879-1-yixun.lan at amlogic.com
[1] git://github.com/BayLibre/clk-meson.git branch: next-drivers
[2] https://lkml.kernel.org/r/20180323143816.200573-1-yixun.lan at amlogic.com
[3] https://lkml.kernel.org/r/20180326081809.49493-4-yixun.lan at amlogic.com
[4] https://lkml.kernel.org/r/20180328025050.221585-1-yixun.lan at amlogic.com


Qiufang Dai (1):
  clk: meson-axg: Add AO Clock and Reset controller driver

Yixun Lan (6):
  clk: meson: aoclk: refactor common code into dedicated file
  clk: meson: migrate to devm_of_clk_add_hw_provider API
  dt-bindings: clock: axg-aoclkc: New binding for Meson-AXG SoC
  dt-bindings: clock: reset: Add AXG AO Clock and Reset Bindings
  clk: meson: drop CLK_SET_RATE_PARENT flag
  clk: meson: drop CLK_IGNORE_UNUSED flag

 .../bindings/clock/amlogic,gxbb-aoclkc.txt         |   1 +
 drivers/clk/meson/Makefile                         |   4 +-
 drivers/clk/meson/axg-aoclk.c                      | 163 +++++++++++++++++++++
 drivers/clk/meson/axg-aoclk.h                      |  31 ++++
 drivers/clk/meson/gxbb-aoclk.c                     |  92 ++++--------
 drivers/clk/meson/gxbb-aoclk.h                     |   7 +
 drivers/clk/meson/meson-aoclk.c                    |  83 +++++++++++
 drivers/clk/meson/meson-aoclk.h                    |  35 +++++
 include/dt-bindings/clock/axg-aoclkc.h             |  26 ++++
 include/dt-bindings/reset/axg-aoclkc.h             |  20 +++
 10 files changed, 399 insertions(+), 63 deletions(-)
 create mode 100644 drivers/clk/meson/axg-aoclk.c
 create mode 100644 drivers/clk/meson/axg-aoclk.h
 create mode 100644 drivers/clk/meson/meson-aoclk.c
 create mode 100644 drivers/clk/meson/meson-aoclk.h
 create mode 100644 include/dt-bindings/clock/axg-aoclkc.h
 create mode 100644 include/dt-bindings/reset/axg-aoclkc.h

-- 
2.15.1
