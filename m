From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Mon, 25 Jun 2018 12:22:07 +0100
Subject: [PATCH v2 0/6] coresight: Coresight Address Translation Unit support
Message-ID: <20180625112213.23492-1-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for the Coresight Address Translation Unit (CATU), which
provides improved scatter-gather functionality for TMC-ETR. The CATU
performs address translation for ETR based on a page table, which
contains address of 4KB sized data pages, but uses a different
format from that of the TMC-ETR SG table. The page table format is
described in the code. See patch

 "coresight: catu: Add support for scatter gather tables"

The CATU devices do not appear on the "software" path for given
trace session, to leave the management of the device to the driving
TMC-ETR, depending on the mode of the buffer. Towards this we
introduce a new class of coresight device_type, helper devices.
These helper devices are managed by the master devices. The
build-path operation takes care of making sure that any helper
device associated with a device is turned on.

Applies on Mathieu's coresight/next tree.

This series is, part 2 of the split of the series [0].

Changes since v1:
 - Rename the variables in CATU page table populate for better
   readability.
 - Fix broken commit description.
 - Fix the order of "wait for ready" & "disable hw" in catu_disable_hw.

Changes since [0] :
 - Remove "restore" buf support and trim down the page table
   populate code to get rid of "range" updates.
 - Do not create a circular table by default.
 - Fix style issues
 - Set DMA mask for CATU based on the address width.
 - Rename :
	coresight_prepare_device => coresight_grab_device
	coresight_release_device => coresight_drop_device
   to avoid confusing with coresight_device_release().

[0] - TMC ETR perf support
 - http://lists.infradead.org/pipermail/linux-arm-kernel/2018-May/574875.html

Suzuki K Poulose (6):
  coresight: Cleanup device subtype struct
  coresight: Add helper device type
  coresight: Introduce support for Coresight Address Translation Unit
  dts: bindings: Document device tree binding for CATU
  coresight: catu: Add support for scatter gather tables
  coresight: catu: Plug in CATU as a backend for ETR buffer

 .../devicetree/bindings/arm/coresight.txt          |  53 ++
 drivers/hwtracing/coresight/Kconfig                |  11 +
 drivers/hwtracing/coresight/Makefile               |   1 +
 drivers/hwtracing/coresight/coresight-catu.c       | 577 +++++++++++++++++++++
 drivers/hwtracing/coresight/coresight-catu.h       | 120 +++++
 drivers/hwtracing/coresight/coresight-tmc-etr.c    |  71 ++-
 drivers/hwtracing/coresight/coresight-tmc.h        |   3 +
 drivers/hwtracing/coresight/coresight.c            |  43 +-
 include/linux/coresight.h                          |  46 +-
 9 files changed, 911 insertions(+), 14 deletions(-)
 create mode 100644 drivers/hwtracing/coresight/coresight-catu.c
 create mode 100644 drivers/hwtracing/coresight/coresight-catu.h

-- 
2.9.5
