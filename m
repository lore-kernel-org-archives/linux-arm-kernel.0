From: m-karicheri2@ti.com (Murali Karicheri)
Date: Tue, 13 Oct 2015 14:45:40 -0400
Subject: [PATCH v3 0/3] soc: ti: knav_qmss: enable accumulator queue support
Message-ID: <1444761943-726-1-git-send-email-m-karicheri2@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series enable accumulator queue support for K2 SoCs. Accumulator
queues are a type of qmss queue that is monitored by the PDSP firmware and
accumulated. Host is interrupted by PDSP firmware when packets become
available in a ring buffer shared between the host and PDSP.

There was an issue raised when merging the original patch set at
 (1) https://lkml.org/lkml/2015/9/4/681
	[PATCH v1 1/2] soc: ti: display firmware file name as part of boot log
 (2) https://lkml.org/lkml/2015/9/4/680
	[PATCH v1 2/2] ARM: dts: keystone: enable accumulator channels

This series fixes the issues raised against v2. Maintainer, could you please
apply this series to v4.4 next please.

Change Log
==========
v3
	- Added Arnd's Acked-by against 2/4
	- 1/4 modified not to touch the DT documentation per Rob's comment.
	- Removed DTS update from the series. Will send the same as a separate
	  patch
v2
	- Remove the firmware filename from DT and add it to the driver.
	  Use a name ks2_qmss_pdsp_acc48.bin. The idea is this can be a
	  soft link pointing to the real firmware file in file system.

	- Move the description of the driver design from DT document to one
	  under Documentation/arm/keystone/knav-qmss.txt. Update the this
	  document with location of acc firmware available under
	  linux-firmware.git.

Additionally added accumulator queue support optional so that lack of
firmware in the file system will not cause other queue types not available
due to driver probe failure.


Murali Karicheri (3):
  Documentation: dt: soc: Add description for knav qmss driver
  soc: ti: add firmware file name as part of the driver
  soc: ti: qmss: make acc queue support optional in the driver

 Documentation/arm/keystone/knav-qmss.txt           | 56 ++++++++++++++++++
 .../bindings/soc/ti/keystone-navigator-qmss.txt    |  1 -
 drivers/soc/ti/knav_qmss.h                         |  3 +-
 drivers/soc/ti/knav_qmss_acc.c                     | 10 +++-
 drivers/soc/ti/knav_qmss_queue.c                   | 67 ++++++++++++++--------
 5 files changed, 109 insertions(+), 28 deletions(-)
 create mode 100644 Documentation/arm/keystone/knav-qmss.txt

-- 
1.9.1
