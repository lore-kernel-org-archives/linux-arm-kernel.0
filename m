From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue,  4 Jun 2013 12:25:26 -0700
Subject: [PATCH 00/12] Convert MSM to common clock framework
Message-ID: <1370373938-32417-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset moves the existing MSM clock code and affected drivers to the
common clock framework. A prerequisite of moving to the common clock
framework is to use clk_prepare() and clk_enable() so the first
few patches migrate drivers to that call (clk_prepare() is a no-op on MSM
right now). It also removes some custom clock APIs that MSM provides
and finally moves the proc_comm clock code to the common struct clk.

This patch series will be used as the foundation of the MSM 8660/8960
clock code that I plan to send out after this series.

Stephen Boyd (12):
  msm_serial: Convert to clk_prepare/unprepare
  msm_serial: Use devm_clk_get() and properly return errors
  usb: otg: msm: Convert to clk_prepare/unprepare
  msm_sdcc: Convert to clk_prepare/unprepare
  msm: iommu: Convert to clk_prepare/unprepare
  msm: iommu: Use clk_set_rate() instead of clk_set_min_rate()
  ARM: msm: Remove custom clk_set_flags() API
  ARM: msm: Remove custom clk_set_{max,min}_rate() API
  ARM: msm: Remove clock-7x30.h include file
  ARM: msm: Prepare clk_get() users in mach-msm for clock-pcom driver
  ARM: msm: Make proc_comm clock control into a platform driver
  ARM: msm: Migrate to common clock framework

 arch/arm/Kconfig                       |   2 +-
 arch/arm/mach-msm/Makefile             |  10 +-
 arch/arm/mach-msm/board-halibut.c      |   2 +-
 arch/arm/mach-msm/board-msm7x30.c      |   2 +-
 arch/arm/mach-msm/board-qsd8x50.c      |   2 +-
 arch/arm/mach-msm/board-trout-panel.c  |  19 ++--
 arch/arm/mach-msm/board-trout.c        |   3 +-
 arch/arm/mach-msm/clock-7x30.h         | 155 ------------------------------
 arch/arm/mach-msm/clock-debug.c        | 130 --------------------------
 arch/arm/mach-msm/clock-pcom.c         | 149 ++++++++++++++++++-----------
 arch/arm/mach-msm/clock-pcom.h         |  31 +++---
 arch/arm/mach-msm/clock.c              | 166 +--------------------------------
 arch/arm/mach-msm/clock.h              |  51 +++-------
 arch/arm/mach-msm/devices-msm7x00.c    |  12 ++-
 arch/arm/mach-msm/devices-msm7x30.c    |  14 ++-
 arch/arm/mach-msm/devices-qsd8x50.c    |  11 ++-
 arch/arm/mach-msm/devices.h            |  15 +--
 arch/arm/mach-msm/dma.c                |   5 +-
 arch/arm/mach-msm/include/mach/board.h |   5 -
 arch/arm/mach-msm/include/mach/clk.h   |   9 --
 drivers/iommu/msm_iommu_dev.c          |  20 ++--
 drivers/mmc/host/msm_sdcc.c            |  14 ++-
 drivers/tty/serial/msm_serial.c        |  35 +++----
 drivers/usb/phy/phy-msm-usb.c          |  38 ++++----
 24 files changed, 241 insertions(+), 659 deletions(-)
 delete mode 100644 arch/arm/mach-msm/clock-7x30.h
 delete mode 100644 arch/arm/mach-msm/clock-debug.c

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
