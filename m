From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Mon, 12 Jun 2017 15:36:39 +0100
Subject: [PATCH 00/12] coresight: Support for ARM Coresight SoC-600
Message-ID: <1497278211-5001-1-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds support for ARM Coresight SoC-600 IP, which implements
Coresight V3 architecture. It also does some clean up of the replicator
driver namings used in the driver to prevent confusions to the user.

The SoC-600 comes with an improved TMC which supports new features,
including Save-Restore and Software FIFO2 mode (for streaming the trace
data over functional I/O like USB/PCI).
This series only supports Save-Restore feature of the new ETR by reusing
the driver to perform additional setups required in case we are dealing
with an IP which supports it. Towards this, we add a capability
description to the IP listings to make it easier.

Patches 1-8 contains general cleanups, introduction of some helper
routines.
Patch 9 introduces the capability tracking for TMCs.
Patch 10 adds the support for Save-Restore feature in ETR.
Patch 11 adds support for the Coresight SoC 600 TMC
Patch 12 adds the support for other components in SoC 600.

Tested on Juno (with Coresight SoC 400) and an FPGA based system
for SoC 600.

Suzuki K Poulose (12):
  coresight replicator: Cleanup programmable replicator naming
  arm64: dts: juno: Use the new coresight replicator string
  coresight: Extend the PIDR mask to cover relevant bits in PIDR2
  coresight: Add support for reading 64bit registers
  coresight tmc: Add helpers for accessing 64bit registers
  coresight tmc: Expose DBA and AXICTL
  coresight replicator: Expose replicator management registers
  coresight tmc: Handle configuration types properly
  coresight tmc: Add capability information
  coresight tmc: Support for save-restore in ETR
  coresight tmc: Add support for Coresight SoC 600 TMC
  coresight: Add support for Coresight SoC 600 components

 .../devicetree/bindings/arm/coresight.txt          |  4 +-
 arch/arm64/boot/dts/arm/juno-base.dtsi             |  2 +-
 drivers/hwtracing/coresight/Kconfig                | 10 ++--
 drivers/hwtracing/coresight/Makefile               |  2 +-
 drivers/hwtracing/coresight/coresight-funnel.c     |  9 +++-
 drivers/hwtracing/coresight/coresight-priv.h       | 35 +++++++++++--
 .../coresight/coresight-replicator-qcom.c          | 33 ++++++++++--
 drivers/hwtracing/coresight/coresight-stm.c        |  8 +--
 drivers/hwtracing/coresight/coresight-tmc-etf.c    |  8 +--
 drivers/hwtracing/coresight/coresight-tmc-etr.c    | 21 ++++++--
 drivers/hwtracing/coresight/coresight-tmc.c        | 58 ++++++++++++++++++----
 drivers/hwtracing/coresight/coresight-tmc.h        | 53 ++++++++++++++++++++
 drivers/hwtracing/coresight/coresight-tpiu.c       |  9 +++-
 13 files changed, 210 insertions(+), 42 deletions(-)

-- 
2.7.4
