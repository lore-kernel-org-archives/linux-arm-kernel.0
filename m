From: sunil.kovvuri@gmail.com (sunil.kovvuri at gmail.com)
Date: Tue,  4 Sep 2018 17:24:35 +0530
Subject: [PATCH v2 00/15] soc: octeontx2: Add RVU admin function driver
Message-ID: <1536062090-30446-1-git-send-email-sunil.kovvuri@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sunil Goutham <sgoutham@marvell.com>

Resource virtualization unit (RVU) on Marvell's OcteonTX2 SOC supports
multiple PCIe SRIOV physical functions (PFs) and virtual functions (VFs).
PF0 is called administrative / admin function (AF) and has privilege access
to registers to provision different RVU functional blocks to each of
PF/VF.

This admin function (AF) driver acts as a configuration / administrative
software which provisions functional blocks to a PF/VF on demand for them
to work as one of the following
 - A basic network controller (i.e NIC).
 - NIC with packet filtering, shaping and scheduling capabilities.
 - A crypto device.
 - A combination of above etc.

PF/VFs communicate with admin function via a shared memory region.
This patch series adds logic for the following
 - RVU AF driver with functional blocks provisioning support
 - Mailbox infrastructure for communication between AF and PFs.
 - CGX driver which provides information about physcial network
   interfaces which AF processes and forwards required info to
   PF/VF drivers.

This is the first set of patches out of 70 odd patches.

Note: This driver neither receives any data nor processes it i.e no I/O,
      just does the hardware configuration.

Changes from v1:
 1 Merged RVU admin function and CGX drivers into a single module
   - Suggested by Arnd Bergmann
 2 Pulled mbox communication APIs into a separate module to remove
   admin function driver dependency in a VM where AF is not attached.
   - Suggested by Arnd Bergmann

Aleksey Makarov (2):
  soc: octeontx2: Add mailbox support infra
  soc: octeontx2: Convert mbox msg id check to a macro

Geetha sowjanya (1):
  soc: octeontx2: Reconfig MSIX base with IOVA

Linu Cherian (3):
  soc: octeontx2: Set RVU PFs to CGX LMACs mapping
  soc: octeontx2: Add support for CGX link management
  soc: octeontx2: Register for CGX lmac events

Sunil Goutham (9):
  soc: octeontx2: Add Marvell OcteonTX2 RVU AF driver
  soc: octeontx2: Reset all RVU blocks
  soc: octeontx2: Gather RVU blocks HW info
  soc: octeontx2: Add mailbox IRQ and msg handlers
  soc: octeontx2: Scan blocks for LFs provisioned to PF/VF
  soc: octeontx2: Add RVU block LF provisioning support
  soc: octeontx2: Configure block LF's MSIX vector offset
  soc: octeontx2: Add Marvell OcteonTX2 CGX driver
  MAINTAINERS: Add entry for Marvell OcteonTX2 Admin Function driver

 MAINTAINERS                                |   10 +
 drivers/soc/Kconfig                        |    1 +
 drivers/soc/Makefile                       |    1 +
 drivers/soc/marvell/Kconfig                |   18 +
 drivers/soc/marvell/Makefile               |    2 +
 drivers/soc/marvell/octeontx2/Makefile     |   10 +
 drivers/soc/marvell/octeontx2/cgx.c        |  517 +++++++++
 drivers/soc/marvell/octeontx2/cgx.h        |   65 ++
 drivers/soc/marvell/octeontx2/cgx_fw_if.h  |  225 ++++
 drivers/soc/marvell/octeontx2/mbox.c       |  303 +++++
 drivers/soc/marvell/octeontx2/mbox.h       |  211 ++++
 drivers/soc/marvell/octeontx2/rvu.c        | 1637 ++++++++++++++++++++++++++++
 drivers/soc/marvell/octeontx2/rvu.h        |  158 +++
 drivers/soc/marvell/octeontx2/rvu_cgx.c    |  194 ++++
 drivers/soc/marvell/octeontx2/rvu_reg.h    |  442 ++++++++
 drivers/soc/marvell/octeontx2/rvu_struct.h |   78 ++
 16 files changed, 3872 insertions(+)
 create mode 100644 drivers/soc/marvell/Kconfig
 create mode 100644 drivers/soc/marvell/Makefile
 create mode 100644 drivers/soc/marvell/octeontx2/Makefile
 create mode 100644 drivers/soc/marvell/octeontx2/cgx.c
 create mode 100644 drivers/soc/marvell/octeontx2/cgx.h
 create mode 100644 drivers/soc/marvell/octeontx2/cgx_fw_if.h
 create mode 100644 drivers/soc/marvell/octeontx2/mbox.c
 create mode 100644 drivers/soc/marvell/octeontx2/mbox.h
 create mode 100644 drivers/soc/marvell/octeontx2/rvu.c
 create mode 100644 drivers/soc/marvell/octeontx2/rvu.h
 create mode 100644 drivers/soc/marvell/octeontx2/rvu_cgx.c
 create mode 100644 drivers/soc/marvell/octeontx2/rvu_reg.h
 create mode 100644 drivers/soc/marvell/octeontx2/rvu_struct.h

-- 
2.7.4
