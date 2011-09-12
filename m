From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Mon, 12 Sep 2011 19:46:55 +0300
Subject: [PATCH 00/10] hwspinlock-next
Message-ID: <1315846025-11453-1-git-send-email-ohad@wizery.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series includes a new u8500 hwspinlock driver from Mathieu,
a core fix from Juan and several other cleanups/fixes
(some of which were reported by Arnd while reviewing Mathieu's
driver).

Maybe the most notable core change is the move to registering
a bank of hwspinlocks in a single API call, rather than the
existing approach which required drivers to register each
hwspinlock separately.

That also allowed eliminating 3 per-lock struct members
(dev and ops, which are now maintained per-bank, and id, which
is completely removed, and instead, derived from the array index
of the hwspinlock struct).

The result is ~20% code reduction in the hwspinlock drivers and
a smaller memory footprint.

Juan Gutierrez (1):
  hwspinlock/core: use a mutex to protect the radix tree

Mathieu J. Poirier (1):
  hwspinlock/u8500: add hwspinlock driver

Ohad Ben-Cohen (8):
  hwspinlock/core: simplify Kconfig
  hwspinlock/core: simplify 'owner' handling
  hwspinlock/omap: simplify allocation scheme
  hwspinlock/core/omap: fix id issues on multiple hwspinlock devices
  hwspinlock/core: remove stubs for register/unregister
  hwspinlock/core: register a bank of hwspinlocks in a single API call
  hwspinlock/omap: omap_hwspinlock_remove should be __devexit
  hwspinlock: add MAINTAINERS entries

 Documentation/hwspinlock.txt             |   74 +++++++-----
 MAINTAINERS                              |   15 +++
 arch/arm/mach-omap2/hwspinlock.c         |    8 +-
 drivers/hwspinlock/Kconfig               |   27 +++--
 drivers/hwspinlock/Makefile              |    2 +
 drivers/hwspinlock/hwspinlock_core.c     |  204 +++++++++++++++++++-----------
 drivers/hwspinlock/hwspinlock_internal.h |   40 ++++--
 drivers/hwspinlock/omap_hwspinlock.c     |  127 +++++++------------
 drivers/hwspinlock/u8500_hsem.c          |  198 +++++++++++++++++++++++++++++
 include/linux/hwspinlock.h               |   46 +++++--
 10 files changed, 516 insertions(+), 225 deletions(-)
 create mode 100644 drivers/hwspinlock/u8500_hsem.c

-- 
1.7.4.1
