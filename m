From: narmstrong@baylibre.com (Neil Armstrong)
Date: Mon, 31 Jul 2017 14:42:33 +0200
Subject: [PATCH v3 0/4] clk: meson: gxbb-aoclk: Add CEC 32k clock
Message-ID: <1501504957-19476-1-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to support the standalone CEC Controller on the Amlogic SoCs,
a specific CEC 32K clock must be handled in the AO domain.

The CEC 32K AO Clock is a dual divider with dual counter to provide a more
precise 32768Hz clock for the CEC subsystem from the external xtal.

The AO clocks management registers are spread among the AO register space,
so this patch also adds management of these registers mappings then uses them
for the CEC 32K AO clock management.

This patchset :
 - updates the bindings accordingly
 - switch driver to new bindings
 - adds the CEC 32k clock
 - adds the clock binding entry

The DT Update will be sent in another patchset.

Changes since v2 at [2] :
 - fix round_rate invalid handling
 - enhance set_rate code thanks to Chris Moore
 - add more explicit comments thanks to Martin

Changes since v1 at [1] :
 - move bindings to parent syscon node and move clkc to subnode
 - switch aoclkc to use regmap only register access
 - introduce aoclk-regmap-gate for this purpose until regmap clocks are generic

[1] https://lkml.kernel.org/r/1499336663-23875-1-git-send-email-narmstrong at baylibre.com
[2] https://lkml.kernel.org/r/1501235589-318-1-git-send-email-narmstrong at baylibre.com

Neil Armstrong (4):
  dt-bindings: clock: amlogic,gxbb-aoclkc: Update bindings
  clk: meson: gxbb-aoclk: Switch to regmap for register access
  dt-bindings: clock: gxbb-aoclk: Add CEC 32k clock
  clk: meson: gxbb-aoclk: Add CEC 32k clock

 .../bindings/clock/amlogic,gxbb-aoclkc.txt         |  22 ++-
 drivers/clk/meson/Makefile                         |   2 +-
 drivers/clk/meson/gxbb-aoclk-32k.c                 | 194 +++++++++++++++++++++
 drivers/clk/meson/gxbb-aoclk-regmap.c              |  46 +++++
 drivers/clk/meson/gxbb-aoclk.c                     |  65 ++++---
 drivers/clk/meson/gxbb-aoclk.h                     |  42 +++++
 include/dt-bindings/clock/gxbb-aoclkc.h            |   1 +
 7 files changed, 342 insertions(+), 30 deletions(-)
 create mode 100644 drivers/clk/meson/gxbb-aoclk-32k.c
 create mode 100644 drivers/clk/meson/gxbb-aoclk-regmap.c
 create mode 100644 drivers/clk/meson/gxbb-aoclk.h

-- 
1.9.1
