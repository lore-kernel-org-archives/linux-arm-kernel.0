From: richardcochran@gmail.com (Richard Cochran)
Date: Mon, 15 Oct 2012 21:48:06 +0200
Subject: [PATCH V2 0/7] support the cpts found on am335x devices
Message-ID: <cover.1350329726.git.richardcochran@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series, based on linux-3.7-rc1 plus the fixes I posted
today, adds support for the Common Platform Time Sync (CPTS) found on
the popular BeagleBone. The code enables hardware time stamping and a
PTP Hardware Clock.

Changes in V2
   - Now uses device tree
   - Actually works with vanilla kernel

This work has been tested using the linuxptp PTP stack, and it seems
to be working quite well. One limitation of the hardware is that not
possible to adjust the clock frequency. Even without with this
capability, the driver will be still be useful for 802.1AS
applications, since they typically use a free running clock.

There is one open issue with this driver which will hopefully soon be
resolved. Time stamping only works on UDP packets. Although Layer 2 is
supposed to work according to the TRM, I have not yet figured out
how. The UDP only works when setting an undocumented bit, so maybe
someone from TI can fill me in on this.

Thanks,
Richard


Richard Cochran (7):
  cpsw: rename register banks to match the reference manual
  cpsw: add missing fields to the CPSW_SS register bank.
  cpsw: correct the CPSW_PORT register bank declaration
  cpsw: add a common header file for regsiter declarations
  cpts: introduce time stamping code and a PTP hardware clock.
  cpsw: add a DT field for the cpts offset
  cpsw: use the time stamping capabilities of the cpts

 Documentation/devicetree/bindings/net/cpsw.txt |   11 +-
 arch/arm/boot/dts/am33xx.dtsi                  |    5 +-
 drivers/net/ethernet/ti/Kconfig                |    8 +
 drivers/net/ethernet/ti/Makefile               |    2 +-
 drivers/net/ethernet/ti/cpsw.c                 |   84 ++++-
 drivers/net/ethernet/ti/cpsw_reg.h             |   81 ++++
 drivers/net/ethernet/ti/cpts.c                 |  468 ++++++++++++++++++++++++
 drivers/net/ethernet/ti/cpts.h                 |  148 ++++++++
 include/linux/platform_data/cpsw.h             |    1 +
 9 files changed, 788 insertions(+), 20 deletions(-)
 create mode 100644 drivers/net/ethernet/ti/cpsw_reg.h
 create mode 100644 drivers/net/ethernet/ti/cpts.c
 create mode 100644 drivers/net/ethernet/ti/cpts.h

-- 
1.7.2.5
