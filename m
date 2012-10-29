From: richardcochran@gmail.com (Richard Cochran)
Date: Mon, 29 Oct 2012 19:45:10 +0100
Subject: [PATCH net-next V3 00/10] Support the CPTS as a PTP Hardware Clock
Message-ID: <cover.1351535536.git.richardcochran@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series adds support for the Common Platform Time Sync
(CPTS) found on TI SoCs such as the am335x (like the popular
BeagleBone) and the dm814x. The patch series enables hardware time
stamping and a PTP Hardware Clock.

* Changes in V3
  - Performs clock frequency adjustment in software
  - Move the HWTSTAMP ioctl into the CPSW code
  - Handle the two different CPSW versions

This work has been tested using the linuxptp PTP stack, and it seems
to be working quite well. Using the CPSW Ethernet ports (and the CPTS)
is not yet possible in mainline Linux due to missing device tree
support. However, this support is expected to appear in v3.8 in the
form of the following patches.

   http://www.spinics.net/lists/arm-kernel/msg203749.html

This third version of the patch series incorporates ideas taken from  
Mugunthan's driver, namely the CPSW versioning support and keeping the
HWTSTAMP ioctl within the CPSW code.

   http://thread.gmane.org/gmane.linux.network/246082

The first patch adds multicast MAC support to the CPSW. Patches two
and three are cleanups to bring the code more in line with the TRM.
Patches four and five add CPSW versioning support. The sixth patch add
the new CPTS code, and patches seven through nine add device tree
support for CPTS variables. The last patch hooks the CPSW to the CPTS
and adds HWTSTAMP support into the CPSW.

Thanks,
Richard

Mugunthan V N (1):
  drivers: net: ethernet: cpsw: add multicast address to ALE table

Richard Cochran (9):
  cpsw: rename register banks to match the reference manual
  cpsw: add missing fields to the CPSW_SS register bank.
  cpsw: remember the silicon version
  cpsw: support both silicon versions
  cpts: introduce time stamping code and a PTP hardware clock.
  cpsw: add a DT field for the cpts offset
  cpsw: add a DT field for the active time stamping port
  cpts: specify the input clock frequency via DT
  cpsw: support the HWTSTAMP ioctl and the CPTS

 Documentation/devicetree/bindings/net/cpsw.txt |   20 +-
 drivers/net/ethernet/ti/Kconfig                |    8 +
 drivers/net/ethernet/ti/Makefile               |    2 +-
 drivers/net/ethernet/ti/cpsw.c                 |  373 +++++++++++++++++++--
 drivers/net/ethernet/ti/cpsw_ale.c             |   31 ++-
 drivers/net/ethernet/ti/cpsw_ale.h             |    1 +
 drivers/net/ethernet/ti/cpts.c                 |  427 ++++++++++++++++++++++++
 drivers/net/ethernet/ti/cpts.h                 |  146 ++++++++
 include/linux/platform_data/cpsw.h             |    4 +
 9 files changed, 979 insertions(+), 33 deletions(-)
 create mode 100644 drivers/net/ethernet/ti/cpts.c
 create mode 100644 drivers/net/ethernet/ti/cpts.h

-- 
1.7.2.5
