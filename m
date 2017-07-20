From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Thu, 20 Jul 2017 11:17:10 +0100
Subject: [PATCH v5 00/19] coresight: Support for ARM Coresight SoC-600
Message-ID: <1500545849-23724-1-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds support for ARM Coresight SoC-600 IP, which implements
Coresight V3 architecture. It also does some clean up of the replicator
driver namings used in the driver to prevent confusions to the user.

The SoC-600 comes with an improved TMC which supports new features,
including Save-Restore, Software FIFO2 mode (for streaming the trace
data over functional I/O like USB/PCI), and other changes AXICTL settings.

This series supports Save-Restore feature of the new ETR by reusing
the driver to perform additional setups required in case we are dealing
with an IP which supports it. Towards this we keep track of the
capabilities of the given TMC ETR. Some of the features are advertised
via DEVID register (address width, scatter gather support), while some
are not (save-restore). So we attach a static capability mask with the
device PID for the unadvertised features and detect the rest at device
probe. The driver now detects the AXI address width if advertised via
DEVID.

Tested on Juno (with Coresight SoC 400) and an FPGA based system
for SoC 600.

Applies on Mathieu's coresight/next tree

Changes since V4:
 - Rebased to coresight/next to avoid conflicts
 - Added a new set of macros for plain register access, no functional
   changes. (Patch 7)

Changes since V3:
 - Rebased to v4.13-rc1
 - Rename AxCACHE => AXCACHE, suggested by Mathieu
 - Fix checkpatch warnings against space in comments.
 - Remove device initialisation message for replicator.
 - Add Reviewed-by tags for the DTS changes.

Suzuki K Poulose (19):
  coresight replicator: Cleanup programmable replicator naming
  arm64: juno: dts: Use the new coresight replicator string
  arm: qcom-msm8974: dts: Update coresight replicator
  arm64: qcom-msm8916: dts: Update coresight replicator
  coresight: Extend the PIDR mask to cover relevant bits in PIDR2
  coresight: Add support for reading 64bit registers
  coresight: Use the new helper for defining registers
  coresight tmc: Add helpers for accessing 64bit registers
  coresight tmc: Expose DBA and AXICTL
  coresight replicator: Expose replicator management registers
  coresight tmc: Handle configuration types properly
  coresight tmc etr: Add capabilitiy information
  coresight tmc: Detect support for scatter gather
  coresight tmc etr: Detect address width at runtime
  coresight tmc etr: Cleanup AXICTL register handling
  coresigh tmc etr: Setup AXI cache encoding for read transfers
  coresight tmc: Support for save-restore in ETR
  coresight tmc: Add support for Coresight SoC 600 TMC
  coresight: Add support for Coresight SoC 600 components

 .../devicetree/bindings/arm/coresight.txt          |   4 +-
 arch/arm/boot/dts/qcom-msm8974.dtsi                |   2 +-
 arch/arm64/boot/dts/arm/juno-base.dtsi             |   2 +-
 arch/arm64/boot/dts/qcom/msm8916.dtsi              |   2 +-
 drivers/hwtracing/coresight/Kconfig                |  10 +-
 drivers/hwtracing/coresight/Makefile               |   2 +-
 .../coresight/coresight-dynamic-replicator.c       | 222 +++++++++++++++++++++
 drivers/hwtracing/coresight/coresight-etb10.c      |  26 +--
 .../hwtracing/coresight/coresight-etm3x-sysfs.c    |  26 +--
 drivers/hwtracing/coresight/coresight-etm3x.c      |  24 +--
 .../hwtracing/coresight/coresight-etm4x-sysfs.c    |  24 +--
 drivers/hwtracing/coresight/coresight-funnel.c     |   9 +-
 drivers/hwtracing/coresight/coresight-priv.h       |  37 +++-
 .../coresight/coresight-replicator-qcom.c          | 196 ------------------
 drivers/hwtracing/coresight/coresight-stm.c        |  38 ++--
 drivers/hwtracing/coresight/coresight-tmc-etf.c    |   8 +-
 drivers/hwtracing/coresight/coresight-tmc-etr.c    |  37 ++--
 drivers/hwtracing/coresight/coresight-tmc.c        | 110 +++++++---
 drivers/hwtracing/coresight/coresight-tmc.h        |  86 +++++++-
 drivers/hwtracing/coresight/coresight-tpiu.c       |   9 +-
 20 files changed, 548 insertions(+), 326 deletions(-)
 create mode 100644 drivers/hwtracing/coresight/coresight-dynamic-replicator.c
 delete mode 100644 drivers/hwtracing/coresight/coresight-replicator-qcom.c

-- 
2.7.5
