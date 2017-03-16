From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Thu, 16 Mar 2017 09:30:27 +0100
Subject: [PATCH 0/7] memory: atmel-ebi: Add PM ops
Message-ID: <1489653034-17777-1-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This patchset adds a ->resume() hook to the EBI driver, but a few more
changes were required in order to easily implement this PM hook.

Patches 1 to 5 are just cleanup patches to simplify the EBI driver.
Patch 6 is fixing a bug in the EBI driver. Note that this bug has no
consequences until we start implementing the ->resume() hook.
And finally, patch 7 is implementing ->resume() so that the SMC config
is correctly restored when resuming the system.

This patchset depends on [1] which is removing the unused pata_at91
driver, which in turn prevents us from patching it before dropping
the old SMC macro definitions in patch 4.

Regards,

Boris

[1]http://lkml.iu.edu/hypermail/linux/kernel/1702.2/00990.html

Changes since v1:
- move helper functions in a C file
- check if tdf is at least ATMEL_SMC_MODE_TDF_MIN

Boris Brezillon (7):
  mfd: syscon: atmel-smc: Add new helpers to ease SMC regs manipulation
  memory: atmel-ebi: Simplify SMC config code
  memory: atmel-ebi: Stop using reg_field objects for simple things
  mfd: syscon: atmel-smc: Remove unused helpers/macros
  memory: atmel-ebi: Change naming scheme
  memory: atmel-ebi: Add missing ->numcs assignment
  memory: atmel-ebi: Add PM ops

 drivers/memory/Kconfig               |   1 +
 drivers/memory/atmel-ebi.c           | 584 ++++++++++++-----------------------
 drivers/mfd/Kconfig                  |   4 +
 drivers/mfd/Makefile                 |   1 +
 drivers/mfd/atmel-smc.c              | 314 +++++++++++++++++++
 include/linux/mfd/syscon/atmel-smc.h | 237 ++++++--------
 6 files changed, 606 insertions(+), 535 deletions(-)
 create mode 100644 drivers/mfd/atmel-smc.c

-- 
2.7.4
