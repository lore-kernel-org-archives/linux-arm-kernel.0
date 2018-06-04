From: yangbo.lu@nxp.com (Yangbo Lu)
Date: Mon,  4 Jun 2018 15:08:27 +0800
Subject: [PATCH 00/10] Support DPAA PTP clock and timestamping
Message-ID: <20180604070837.19265-1-yangbo.lu@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset is to support DPAA FMAN PTP clock and HW timestamping.
- The patch #1 to patch #5 are to support DPAA FMAN 1588 timer in
  ptp_qoriq driver.
- The patch #6 to patch #10 are to add HW timestamping support in
  DPAA ethernet driver.

Yangbo Lu (10):
  fsl/fman: share the event interrupt
  ptp: support DPAA FMan 1588 timer in ptp_qoriq
  dt-binding: ptp_qoriq: add DPAA FMan support
  powerpc/mpc85xx: move ptp timer out of fman in dts
  arm64: dts: fsl: move ptp timer out of fman
  fsl/fman: add set_tstamp interface
  fsl/fman_port: support getting timestamp field
  fsl/fman: define frame description command UPD
  dpaa_eth: add support for hardware timestamping
  dpaa_eth: add the get_ts_info interface for ethtool

 Documentation/devicetree/bindings/net/fsl-fman.txt |   25 +----
 .../devicetree/bindings/ptp/ptp-qoriq.txt          |   15 ++-
 arch/arm64/boot/dts/freescale/qoriq-fman3-0.dtsi   |   14 ++-
 arch/powerpc/boot/dts/fsl/qoriq-fman-0.dtsi        |   14 ++-
 arch/powerpc/boot/dts/fsl/qoriq-fman-1.dtsi        |   14 ++-
 arch/powerpc/boot/dts/fsl/qoriq-fman3-0.dtsi       |   14 ++-
 arch/powerpc/boot/dts/fsl/qoriq-fman3-1.dtsi       |   14 ++-
 arch/powerpc/boot/dts/fsl/qoriq-fman3l-0.dtsi      |   14 ++-
 drivers/net/ethernet/freescale/dpaa/Kconfig        |   12 ++
 drivers/net/ethernet/freescale/dpaa/dpaa_eth.c     |  119 +++++++++++++++++++-
 drivers/net/ethernet/freescale/dpaa/dpaa_eth.h     |    5 +
 drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c |   44 +++++++
 drivers/net/ethernet/freescale/fman/fman.c         |    3 +-
 drivers/net/ethernet/freescale/fman/fman.h         |    1 +
 drivers/net/ethernet/freescale/fman/fman_dtsec.c   |   27 +++++
 drivers/net/ethernet/freescale/fman/fman_dtsec.h   |    1 +
 drivers/net/ethernet/freescale/fman/fman_memac.c   |    5 +
 drivers/net/ethernet/freescale/fman/fman_memac.h   |    1 +
 drivers/net/ethernet/freescale/fman/fman_port.c    |   12 ++
 drivers/net/ethernet/freescale/fman/fman_port.h    |    3 +
 drivers/net/ethernet/freescale/fman/fman_tgec.c    |   21 ++++
 drivers/net/ethernet/freescale/fman/fman_tgec.h    |    1 +
 drivers/net/ethernet/freescale/fman/mac.c          |    3 +
 drivers/net/ethernet/freescale/fman/mac.h          |    1 +
 drivers/ptp/Kconfig                                |    2 +-
 drivers/ptp/ptp_qoriq.c                            |  104 +++++++++++------
 include/linux/fsl/ptp_qoriq.h                      |   38 +++++-
 27 files changed, 414 insertions(+), 113 deletions(-)
