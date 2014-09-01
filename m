From: shawn.guo@freescale.com (Shawn Guo)
Date: Mon, 1 Sep 2014 16:13:59 +0800
Subject: [PATCH v2 0/5] ARM: imx6: add BYPASS support for PLLs
Message-ID: <1409559244-22483-1-git-send-email-shawn.guo@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Motivated by an ESAI audio use case on imx6q-sabreauto board, where an
on-board oscillator provides master clock to ESAI controller via path
anatop CLK pad --> PLL_AUDIO --> ESAI.  This is not possible with the
current clock driver implementation, where clock source of PLLs is
hard-coded to be OSC24M.

The patch series adds the missing anaclk related clocks and implements
BYPASS support for i.MX6 clock drivers per Figure 10-3. Primary Clock
Generation in IMX6DQRM.

Changes since v1 (RFC):
 - Combine the exclusive gate patch series with this one
 - Add patches for imx6sl and imx6sx PLL BYPASS support

Shawn Guo (5):
  ARM: imx: add an exclusive gate clock type
  ARM: imx6q: add BYPASS support for PLL clocks
  ARM: imx6sl: add BYPASS support for PLL clocks
  ARM: imx6sx: add BYPASS support for PLL clocks
  ARM: imx: remove ENABLE and BYPASS bits from clk-pllv3 driver

 arch/arm/mach-imx/Makefile                |  3 +-
 arch/arm/mach-imx/clk-gate-exclusive.c    | 94 +++++++++++++++++++++++++++++++
 arch/arm/mach-imx/clk-imx6q.c             | 67 ++++++++++++++++++----
 arch/arm/mach-imx/clk-imx6sl.c            | 69 ++++++++++++++++++++---
 arch/arm/mach-imx/clk-imx6sx.c            | 63 ++++++++++++++++++---
 arch/arm/mach-imx/clk-pllv3.c             | 37 ------------
 arch/arm/mach-imx/clk.h                   |  3 +
 include/dt-bindings/clock/imx6qdl-clock.h | 27 ++++++++-
 include/dt-bindings/clock/imx6sl-clock.h  | 27 ++++++++-
 include/dt-bindings/clock/imx6sx-clock.h  | 25 +++++++-
 10 files changed, 347 insertions(+), 68 deletions(-)
 create mode 100644 arch/arm/mach-imx/clk-gate-exclusive.c

-- 
1.9.1
