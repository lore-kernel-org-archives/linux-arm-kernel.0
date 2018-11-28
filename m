From: rrichter@cavium.com (Robert Richter)
Date: Wed, 28 Nov 2018 14:43:02 +0000
Subject: [PATCH v2 00/10] irqdomain, gic-v3-its: Implement late irq domain
 initialization
Message-ID: <20181128144240.28727-1-rrichter@cavium.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series is a rework of the gic-v3-its initialization. It is
in preparation of a further series that uses CMA memory allocation for
ITS tables. For this the CMA framework must be available and thus ITS
needs to be initialized after the arch_initcalls. This requires two
major reworks.

First we must remove all irq domain init order dependencies (patches
#1-#5), second the ITS initialization must be split into an early
probe and a later init part (patches #6-#10).

Patch #1 introduces a new interface to request an irq domain, see the
patch description for details. In patches #2-#5 all ITS related irq
domains are converted to use the new interface. There are no order
dependencies for parent and client irq domain initialization anymore
which allows us to initialize all ITS irq domains in the same initcall
(moving to the later subsys_initcall). Note that I do not have fsl
hardware available, the code should work, but is only carefully
reviewed and compile tested, please test on that hardware.

The remaining patches #6-#10 are an incremental rework of the ITS
initialization, basically splitting probe and init (patch #7) and
separating it from gic-v3 code (patch #8). Patches #9 and #10 change
initcall levels for various drivers.

Patches have been tested with Cavium ThunderX and ThunderX2. I have an
implementation of CMA ITS table allocation on top of this series
available, I will send out patches for this in a couple of days.

v2:
 * fix check for domain match in irq_domain_handle_requests()
 * add comment that describes this check in irq_domain_handle_
   requests()

Robert Richter (10):
  irqdomain: Add interface to request an irq domain
  irqchip/gic-v3-its-platform-msi: Remove domain init order dependencies
  irqchip/irq-gic-v3-its-pci-msi: Remove domain init order dependencies
  irqchip/irq-gic-v3-its-fsl-mc-msi: Remove domain init order
    dependencies
  fsl-mc/dprc-driver: Remove domain init order dependencies
  irqchip/gic-v3-its: Initialize its nodes in probe order
  irqchip/gic-v3-its: Split probing from its node initialization
  irqchip/gic-v3-its: Decouple its initialization from gic
  irqchip/gic-v3-its: Initialize its nodes later
  irqchip/gic-v3-its: Initialize MSIs with subsys_initcalls

 drivers/bus/fsl-mc/dprc-driver.c              |  41 +++++++
 drivers/bus/fsl-mc/fsl-mc-msi.c               |   6 +-
 drivers/irqchip/irq-gic-v3-its-fsl-mc-msi.c   |  49 +++++---
 drivers/irqchip/irq-gic-v3-its-pci-msi.c      |  68 ++++++-----
 drivers/irqchip/irq-gic-v3-its-platform-msi.c |  56 +++++++--
 drivers/irqchip/irq-gic-v3-its.c              | 160 ++++++++++++++++---------
 drivers/irqchip/irq-gic-v3.c                  |  12 +-
 include/linux/cpuhotplug.h                    |   1 +
 include/linux/irqchip/arm-gic-v3.h            |   5 +-
 include/linux/irqdomain.h                     |  15 +++
 kernel/irq/irqdomain.c                        | 163 ++++++++++++++++++++++++++
 11 files changed, 446 insertions(+), 130 deletions(-)

-- 
2.11.0
